terraform {
  required_version = ">= 1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, var.az_count)

  # Corta a VPC em /20 e distribui os tiers em faixas previsíveis:
  #   públicas   → índices 0..3
  #   privadas   → índices 4..7
  #   isoladas   → índices 8..11
  # Previsível importa: facilita ler route tables e desenhar CIDRs de peering.
  newbits = 20 - tonumber(split("/", var.cidr_block)[1])

  public_subnets   = { for i, az in local.azs : az => cidrsubnet(var.cidr_block, local.newbits, i) }
  private_subnets  = { for i, az in local.azs : az => cidrsubnet(var.cidr_block, local.newbits, i + 4) }
  isolated_subnets = var.enable_isolated_subnets ? { for i, az in local.azs : az => cidrsubnet(var.cidr_block, local.newbits, i + 8) } : {}

  nat_enabled   = var.nat_strategy != "none"
  nat_gateway   = contains(["single", "per_az"], var.nat_strategy)
  nat_azs       = var.nat_strategy == "per_az" ? local.azs : slice(local.azs, 0, 1)
  nat_instance  = var.nat_strategy == "instance"
  private_rt_az = var.nat_strategy == "per_az" ? local.azs : [local.azs[0]]
}

# --------------------------------------------------------------------------- #
# VPC + Internet Gateway
# --------------------------------------------------------------------------- #
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true # obrigatório para PrivateLink e private hosted zones

  tags = { Name = var.name }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = { Name = "${var.name}-igw" }
}

# --------------------------------------------------------------------------- #
# Subnets
# --------------------------------------------------------------------------- #
resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name                     = "${var.name}-public-${each.key}"
    Tier                     = "public"
    "kubernetes.io/role/elb" = "1" # útil se um lab de EKS reusar esta VPC
  }
}

resource "aws_subnet" "private" {
  for_each = local.private_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name                              = "${var.name}-private-${each.key}"
    Tier                              = "private"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "isolated" {
  for_each = local.isolated_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "${var.name}-isolated-${each.key}"
    Tier = "isolated"
  }
}

# --------------------------------------------------------------------------- #
# NAT
# --------------------------------------------------------------------------- #
resource "aws_eip" "nat" {
  for_each = local.nat_gateway ? toset(local.nat_azs) : toset([])

  domain = "vpc"
  tags   = { Name = "${var.name}-nat-${each.key}" }

  depends_on = [aws_internet_gateway.this]
}

resource "aws_nat_gateway" "this" {
  for_each = local.nat_gateway ? toset(local.nat_azs) : toset([])

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = { Name = "${var.name}-nat-${each.key}" }

  depends_on = [aws_internet_gateway.this]
}

# NAT instance: alternativa barata para lab. source_dest_check = false é o
# detalhe que todo mundo esquece — sem isso a instância descarta o tráfego roteado.
data "aws_ssm_parameter" "nat_ami" {
  count = local.nat_instance ? 1 : 0
  name  = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-arm64"
}

resource "aws_security_group" "nat_instance" {
  count = local.nat_instance ? 1 : 0

  name        = "${var.name}-nat-instance"
  description = "Permite trafego de saida originado nas subnets privadas."
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Trafego das subnets privadas"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block]
  }

  egress {
    description = "Saida para a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.name}-nat-instance" }
}

resource "aws_instance" "nat" {
  count = local.nat_instance ? 1 : 0

  ami                    = data.aws_ssm_parameter.nat_ami[0].value
  instance_type          = "t4g.nano"
  subnet_id              = aws_subnet.public[local.azs[0]].id
  vpc_security_group_ids = [aws_security_group.nat_instance[0].id]
  source_dest_check      = false

  # O AL2023 NÃO traz o binário `iptables` — só o nftables. Sem instalar
  # `iptables-services` o script morre em "iptables: command not found", a
  # instância sobe 3/3 no console e mesmo assim nada sai da subnet privada:
  # ip_forward encaminha o pacote, mas sem MASQUERADE a resposta não volta.
  # O sintoma que chega no seu terminal é `TargetNotConnected` no SSM.
  user_data = <<-EOF
    #!/bin/bash
    set -euxo pipefail
    for _ in $(seq 1 10); do
      dnf install -y iptables-services && break
      sleep 10
    done
    sysctl -w net.ipv4.ip_forward=1
    echo "net.ipv4.ip_forward = 1" > /etc/sysctl.d/99-nat.conf
    IFACE=$(ip -o -4 route show to default | awk '{print $5}')
    iptables -t nat -A POSTROUTING -o "$IFACE" -s ${var.cidr_block} -j MASQUERADE
    iptables-save > /etc/sysconfig/iptables
    # Restaura a regra no boot: sem isso um stop/start deixa a NAT muda de novo.
    systemctl enable --now iptables
  EOF

  # user_data_replace_on_change: mudar o script acima recria a instância em vez
  # de só atualizar o atributo (que o cloud-init não reexecuta). Sem isso, um
  # `apply` com o script corrigido não conserta nada.
  user_data_replace_on_change = true

  tags = { Name = "${var.name}-nat-instance" }
}

# --------------------------------------------------------------------------- #
# Route tables
# --------------------------------------------------------------------------- #
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "${var.name}-public" }
}

resource "aws_route" "public_default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Uma route table privada por AZ quando nat_strategy = per_az (tráfego não
# atravessa AZ = sem custo cross-AZ e sem SPOF). Uma só nos demais casos.
resource "aws_route_table" "private" {
  for_each = toset(local.private_rt_az)

  vpc_id = aws_vpc.this.id
  tags   = { Name = "${var.name}-private-${each.key}" }
}

resource "aws_route" "private_default_nat_gateway" {
  for_each = local.nat_gateway ? toset(local.private_rt_az) : toset([])

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[var.nat_strategy == "per_az" ? each.key : local.azs[0]].id
}

resource "aws_route" "private_default_nat_instance" {
  for_each = local.nat_instance ? toset(local.private_rt_az) : toset([])

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_instance.nat[0].primary_network_interface_id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[var.nat_strategy == "per_az" ? each.key : local.azs[0]].id
}

# Isoladas: route table SEM rota default. Só o local da VPC e os gateway endpoints.
resource "aws_route_table" "isolated" {
  count = var.enable_isolated_subnets ? 1 : 0

  vpc_id = aws_vpc.this.id
  tags   = { Name = "${var.name}-isolated" }
}

resource "aws_route_table_association" "isolated" {
  for_each = aws_subnet.isolated

  subnet_id      = each.value.id
  route_table_id = aws_route_table.isolated[0].id
}

# --------------------------------------------------------------------------- #
# VPC endpoints
# --------------------------------------------------------------------------- #
resource "aws_vpc_endpoint" "gateway" {
  for_each = toset(var.gateway_endpoints)

  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${data.aws_region.current.region}.${each.value}"
  vpc_endpoint_type = "Gateway"

  route_table_ids = concat(
    [aws_route_table.public.id],
    [for rt in aws_route_table.private : rt.id],
    var.enable_isolated_subnets ? [aws_route_table.isolated[0].id] : [],
  )

  tags = { Name = "${var.name}-${each.value}-gw-endpoint" }
}

resource "aws_security_group" "interface_endpoints" {
  count = length(var.interface_endpoints) > 0 ? 1 : 0

  name        = "${var.name}-vpce"
  description = "HTTPS a partir da VPC para os interface endpoints."
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "HTTPS de dentro da VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  tags = { Name = "${var.name}-vpce" }
}

resource "aws_vpc_endpoint" "interface" {
  for_each = toset(var.interface_endpoints)

  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${data.aws_region.current.region}.${each.value}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [for s in aws_subnet.private : s.id]
  security_group_ids  = [aws_security_group.interface_endpoints[0].id]
  private_dns_enabled = true

  tags = { Name = "${var.name}-${each.value}-endpoint" }
}

# --------------------------------------------------------------------------- #
# Flow logs
# --------------------------------------------------------------------------- #
resource "aws_cloudwatch_log_group" "flow_logs" {
  count = var.enable_flow_logs ? 1 : 0

  name              = "/aws/vpc/${var.name}/flow-logs"
  retention_in_days = var.flow_logs_retention_days
}

data "aws_iam_policy_document" "flow_logs_assume" {
  count = var.enable_flow_logs ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "flow_logs" {
  count = var.enable_flow_logs ? 1 : 0

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]
    resources = ["${aws_cloudwatch_log_group.flow_logs[0].arn}:*"]
  }
}

resource "aws_iam_role" "flow_logs" {
  count = var.enable_flow_logs ? 1 : 0

  name_prefix        = "vpc-flow-logs-"
  assume_role_policy = data.aws_iam_policy_document.flow_logs_assume[0].json
}

resource "aws_iam_role_policy" "flow_logs" {
  count = var.enable_flow_logs ? 1 : 0

  name   = "publish-flow-logs"
  role   = aws_iam_role.flow_logs[0].id
  policy = data.aws_iam_policy_document.flow_logs[0].json
}

resource "aws_flow_log" "this" {
  count = var.enable_flow_logs ? 1 : 0

  vpc_id                   = aws_vpc.this.id
  traffic_type             = "ALL"
  log_destination_type     = "cloud-watch-logs"
  log_destination          = aws_cloudwatch_log_group.flow_logs[0].arn
  iam_role_arn             = aws_iam_role.flow_logs[0].arn
  max_aggregation_interval = 60

  tags = { Name = "${var.name}-flow-logs" }
}

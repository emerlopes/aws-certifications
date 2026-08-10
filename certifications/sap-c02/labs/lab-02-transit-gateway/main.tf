locals {
  name_prefix = "${lower(var.certification)}-${var.lab}"
}

data "aws_caller_identity" "current" {}

# ---------------------------------------------------------------------------
# Quatro VPCs, todas sem NAT e com uma AZ só (o lab é sobre roteamento entre
# VPCs, não sobre resiliência de AZ — e cada AZ a mais dobra o custo dos
# interface endpoints).
#
#   prod / dev  → spokes anexados ao TGW. NÃO podem se enxergar.
#   hub         → serviços compartilhados: os 3 interface endpoints do Session
#                 Manager atendem as 4 VPCs. Único com gateway endpoint de S3.
#   partner     → SEM anexo no TGW. Só peering com o hub, para provar que
#                 peering não é transitivo.
# ---------------------------------------------------------------------------
module "vpc_prod" {
  source = "../../../../modules/vpc"

  name              = "${local.name_prefix}-prod"
  cidr_block        = var.prod_vpc_cidr
  az_count          = 1
  nat_strategy      = "none"
  gateway_endpoints = [] # de propósito: o passo 9 do roteiro depende disso
}

module "vpc_dev" {
  source = "../../../../modules/vpc"

  name              = "${local.name_prefix}-dev"
  cidr_block        = var.dev_vpc_cidr
  az_count          = 1
  nat_strategy      = "none"
  gateway_endpoints = []
}

module "vpc_hub" {
  source = "../../../../modules/vpc"

  name         = "${local.name_prefix}-hub"
  cidr_block   = var.hub_vpc_cidr
  az_count     = 1
  nat_strategy = "none"

  # Gateway endpoint é grátis e é uma ROTA — só a VPC hub o enxerga. É esse
  # contraste com o interface endpoint (que atravessa o TGW) que o lab ensina.
  gateway_endpoints = ["s3"]

  # Os interface endpoints NÃO vêm do módulo: ele liga private_dns_enabled, e o
  # padrão centralizado exige o contrário. Ver aws_vpc_endpoint.interface abaixo.
  interface_endpoints = []
}

module "vpc_partner" {
  source = "../../../../modules/vpc"

  name              = "${local.name_prefix}-partner"
  cidr_block        = var.partner_vpc_cidr
  az_count          = 1
  nat_strategy      = "none"
  gateway_endpoints = []
}

# Índice usado pelo for_each das instâncias, dos security groups e das rotas.
# `one(values(...))` porque az_count = 1: o mapa por AZ tem um elemento só.
locals {
  vpcs = {
    prod = {
      vpc_id         = module.vpc_prod.vpc_id
      cidr_block     = var.prod_vpc_cidr
      subnet_id      = one(values(module.vpc_prod.private_subnet_ids))
      route_table_id = one(values(module.vpc_prod.private_route_table_ids))
    }
    dev = {
      vpc_id         = module.vpc_dev.vpc_id
      cidr_block     = var.dev_vpc_cidr
      subnet_id      = one(values(module.vpc_dev.private_subnet_ids))
      route_table_id = one(values(module.vpc_dev.private_route_table_ids))
    }
    hub = {
      vpc_id         = module.vpc_hub.vpc_id
      cidr_block     = var.hub_vpc_cidr
      subnet_id      = one(values(module.vpc_hub.private_subnet_ids))
      route_table_id = one(values(module.vpc_hub.private_route_table_ids))
    }
    partner = {
      vpc_id         = module.vpc_partner.vpc_id
      cidr_block     = var.partner_vpc_cidr
      subnet_id      = one(values(module.vpc_partner.private_subnet_ids))
      route_table_id = one(values(module.vpc_partner.private_route_table_ids))
    }
  }

  tgw_members = toset(["prod", "dev", "hub"]) # partner fica de fora de propósito
  spokes      = toset(["prod", "dev"])

  # O trio obrigatório do Session Manager: API, canal da sessão, canal de comandos.
  endpoint_services = toset(["ssm", "ssmmessages", "ec2messages"])
}

# ---------------------------------------------------------------------------
# Transit Gateway
#
# As duas linhas que importam são os "disable": com o padrão da AWS, todo anexo
# novo é associado e propagado numa route table default única, e aí TODAS as
# VPCs se enxergam. Desligar obriga a declarar association e propagation, que é
# exatamente o mecanismo que o exame cobra.
# ---------------------------------------------------------------------------
resource "aws_ec2_transit_gateway" "this" {
  description = "Lab 02 - hub-and-spoke com route tables segmentadas"

  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  dns_support                     = "enable"

  tags = { Name = local.name_prefix }
}

# US$ 0,05/hora POR ANEXO — a unidade de cobrança do TGW. 3 anexos = US$ 3,60/dia
# mesmo sem tráfego, mais US$ 0,02/GB processado.
resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  for_each = local.tgw_members

  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = local.vpcs[each.key].vpc_id
  subnet_ids         = [local.vpcs[each.key].subnet_id]

  # Faz a resolução de DNS atravessar o TGW — é o que permite a instância da
  # prod resolver o nome do endpoint que vive na VPC hub.
  dns_support = "enable"

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = { Name = "${local.name_prefix}-${each.key}" }
}

# Os dois "painéis de destino". Não custam nada: a segmentação inteira do lab
# está no que cada um contém.
resource "aws_ec2_transit_gateway_route_table" "spokes" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id

  tags = { Name = "${local.name_prefix}-spokes" }
}

resource "aws_ec2_transit_gateway_route_table" "hub" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id

  tags = { Name = "${local.name_prefix}-hub" }
}

# ASSOCIATION = qual tabela o anexo consulta ao ENTRAR no TGW. Uma por anexo.
resource "aws_ec2_transit_gateway_route_table_association" "spokes" {
  for_each = local.spokes

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this[each.key].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spokes.id
}

resource "aws_ec2_transit_gateway_route_table_association" "hub" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this["hub"].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.hub.id
}

# PROPAGATION = em qual tabela o CIDR do anexo é publicado. Pode ser em várias.
#
# Só o hub propaga para a tabela dos spokes: por isso prod e dev alcançam o hub
# e mais nada. Prod e dev propagam para a tabela do hub: por isso o hub alcança
# os dois. A assimetria vem daqui, não de firewall.
resource "aws_ec2_transit_gateway_route_table_propagation" "hub_into_spokes" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this["hub"].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spokes.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "spokes_into_hub" {
  for_each = local.spokes

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this[each.key].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.hub.id
}

# ---------------------------------------------------------------------------
# Rotas dentro das VPCs
#
# A supernet inteira vai para o TGW: a route table da VPC NÃO filtra nada. Isso
# é deliberado — quando o ping entre prod e dev falha, sobra uma causa só.
# ---------------------------------------------------------------------------
resource "aws_route" "to_tgw" {
  for_each = local.tgw_members

  route_table_id         = local.vpcs[each.key].route_table_id
  destination_cidr_block = var.lab_supernet
  transit_gateway_id     = aws_ec2_transit_gateway.this.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.this]
}

# ---------------------------------------------------------------------------
# VPC peering hub ↔ partner
#
# Sem custo por hora, e não transitivo: o partner alcança o hub e para ali.
# ---------------------------------------------------------------------------
resource "aws_vpc_peering_connection" "hub_partner" {
  vpc_id      = module.vpc_hub.vpc_id
  peer_vpc_id = module.vpc_partner.vpc_id
  auto_accept = true # mesma conta e mesma região

  tags = { Name = "${local.name_prefix}-hub-partner" }
}

# No hub convivem 10.0.0.0/8 → TGW e 10.24.0.0/16 → peering. Ganha a mais
# específica (longest prefix match), então o partner é alcançado pelo peering.
resource "aws_route" "hub_to_partner" {
  route_table_id            = local.vpcs["hub"].route_table_id
  destination_cidr_block    = var.partner_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_partner.id
}

# A ÚNICA rota que o partner pode ter apontando para o peering: a AWS só aceita
# destino contido no CIDR da VPC vizinha. Não existe como escrever "10.21.0.0/16
# via peering" — é por isso que não-transitividade não se resolve com rota.
resource "aws_route" "partner_to_hub" {
  route_table_id            = local.vpcs["partner"].route_table_id
  destination_cidr_block    = var.hub_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_partner.id
}

# ---------------------------------------------------------------------------
# Interface endpoints CENTRALIZADOS na VPC hub
#
# private_dns_enabled = false é o coração do padrão: o DNS privado automático do
# endpoint só vale dentro da VPC dele. Desligado, quem resolve o nome passa a ser
# uma private hosted zone sua, associada às 4 VPCs.
#
# 3 endpoints × 1 AZ × ~US$ 0,01/h = US$ 0,72/dia. Um conjunto por VPC custaria
# quatro vezes isso.
# ---------------------------------------------------------------------------
resource "aws_security_group" "endpoints" {
  name        = "${local.name_prefix}-vpce"
  description = "HTTPS a partir das VPCs do lab (via TGW e via peering)."
  vpc_id      = module.vpc_hub.vpc_id

  ingress {
    description = "HTTPS de qualquer VPC do lab - em producao voce listaria os CIDRs"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.lab_supernet]
  }

  tags = { Name = "${local.name_prefix}-vpce" }
}

resource "aws_vpc_endpoint" "interface" {
  for_each = local.endpoint_services

  vpc_id             = module.vpc_hub.vpc_id
  service_name       = "com.amazonaws.${var.aws_region}.${each.value}"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [local.vpcs["hub"].subnet_id]
  security_group_ids = [aws_security_group.endpoints.id]

  private_dns_enabled = false

  tags = { Name = "${local.name_prefix}-${each.value}" }
}

# Uma zona por serviço, associada às QUATRO VPCs. É o que faz
# ssm.us-east-1.amazonaws.com resolver para a ENI do hub em qualquer uma delas.
# US$ 0,50/mês por zona — a AWS não cobra zona deletada em menos de 12h.
resource "aws_route53_zone" "endpoint" {
  for_each = local.endpoint_services

  name    = "${each.value}.${var.aws_region}.amazonaws.com"
  comment = "Lab 02 - endpoints centralizados no hub"

  dynamic "vpc" {
    for_each = local.vpcs

    content {
      vpc_id = vpc.value.vpc_id
    }
  }

  tags = { Name = "${local.name_prefix}-${each.value}" }
}

# ALIAS no ápice da zona (no ápice não existe CNAME) apontando para o nome
# regional do endpoint.
resource "aws_route53_record" "endpoint" {
  for_each = local.endpoint_services

  zone_id = aws_route53_zone.endpoint[each.key].zone_id
  name    = aws_route53_zone.endpoint[each.key].name
  type    = "A"

  alias {
    name                   = aws_vpc_endpoint.interface[each.key].dns_entry[0].dns_name
    zone_id                = aws_vpc_endpoint.interface[each.key].dns_entry[0].hosted_zone_id
    evaluate_target_health = false
  }
}

# ---------------------------------------------------------------------------
# Identidade das instâncias — a MESMA nas quatro, para que a única diferença
# entre elas seja a rede.
# ---------------------------------------------------------------------------
data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance" {
  name_prefix        = "${local.name_prefix}-ec2-"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.instance.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Usado no passo 9: mesmo comando, mesma permissão, resultado diferente por VPC.
resource "aws_iam_role_policy" "list_buckets" {
  name = "list-buckets"
  role = aws_iam_role.instance.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:ListAllMyBuckets"]
      Resource = ["*"]
    }]
  })
}

resource "aws_iam_instance_profile" "instance" {
  name_prefix = "${local.name_prefix}-"
  role        = aws_iam_role.instance.name
}

# ---------------------------------------------------------------------------
# Uma instância por VPC — alvo de ping e origem de sessão
#
# O security group é PERMISSIVO de propósito: libera ICMP e todo o tráfego
# dentro da supernet do lab, nas quatro VPCs. Assim, quando um ping falha, a
# causa só pode ser roteamento. Tirar o firewall da equação é o método do lab.
# ---------------------------------------------------------------------------
data "aws_prefix_list" "s3" {
  name = "com.amazonaws.${var.aws_region}.s3"
}

resource "aws_security_group" "instance" {
  for_each = local.vpcs

  name        = "${local.name_prefix}-${each.key}"
  description = "Permissivo dentro da supernet do lab: falha de ping aqui e sempre rota."
  vpc_id      = each.value.vpc_id

  ingress {
    description = "ICMP de qualquer VPC do lab"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.lab_supernet]
  }

  egress {
    description = "Tudo dentro da supernet: ICMP e 443 para os endpoints do hub"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.lab_supernet]
  }

  # Presente nas QUATRO VPCs, inclusive nas que não têm gateway endpoint de S3.
  # É o que garante que o timeout do passo 9 seja de rota, não de firewall.
  egress {
    description     = "HTTPS para a prefix list do S3"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    prefix_list_ids = [data.aws_prefix_list.s3.id]
  }

  tags = { Name = "${local.name_prefix}-${each.key}" }
}

data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-arm64"
}

resource "aws_instance" "this" {
  for_each = local.vpcs

  ami                    = data.aws_ssm_parameter.al2023.value
  instance_type          = "t4g.nano"
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = [aws_security_group.instance[each.key].id]
  iam_instance_profile   = aws_iam_instance_profile.instance.name

  metadata_options {
    http_tokens   = "required" # IMDSv2 obrigatório
    http_endpoint = "enabled"
  }

  root_block_device {
    encrypted   = true
    volume_type = "gp3"
    volume_size = 8
  }

  tags = { Name = "${local.name_prefix}-${each.key}" }

  # Sem os registros da private hosted zone o agente SSM não resolve o endpoint,
  # e sem as rotas ele não chega até a ENI — nos dois casos a instância nunca
  # aparece no Session Manager.
  depends_on = [
    aws_route53_record.endpoint,
    aws_route.to_tgw,
    aws_route.partner_to_hub,
  ]
}

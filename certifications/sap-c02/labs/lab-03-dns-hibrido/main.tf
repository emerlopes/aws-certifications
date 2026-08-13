locals {
  name_prefix = "${lower(var.certification)}-${var.lab}"
}

# ---------------------------------------------------------------------------
# Duas VPCs
#
#   aws     → o lado nuvem. 2 AZs porque resolver endpoint exige dois IPs em
#             duas AZs. É a ÚNICA VPC associada à private hosted zone.
#   onprem  → simula o datacenter. 1 AZ basta: lá dentro só existe o servidor
#             DNS. Ela não conhece nenhuma zona privada da AWS.
#
# nat_strategy = "instance" nas duas (~US$ 3/mês cada) por dois motivos: as
# instâncias precisam alcançar o Systems Manager para o Session Manager, e o
# servidor de DNS precisa de `dnf install dnsmasq`. O trio de interface
# endpoints do SSM custaria US$ 1,44/dia — dez vezes mais que a NAT instance,
# e este lab já é caro por causa dos resolver endpoints.
# ---------------------------------------------------------------------------
module "vpc_aws" {
  source = "../../../../modules/vpc"

  name              = "${local.name_prefix}-aws"
  cidr_block        = var.aws_vpc_cidr
  az_count          = 2
  nat_strategy      = "instance"
  gateway_endpoints = []
}

module "vpc_onprem" {
  source = "../../../../modules/vpc"

  name              = "${local.name_prefix}-onprem"
  cidr_block        = var.onprem_vpc_cidr
  az_count          = 1
  nat_strategy      = "instance"
  gateway_endpoints = []
}

# Lê o CIDR real de cada subnet privada em vez de repetir a matemática do
# módulo aqui. É o que permite fixar IPs previsíveis logo abaixo — e IP
# previsível é o que torna a "saída esperada" do README verificável.
data "aws_subnet" "aws_private" {
  for_each = module.vpc_aws.private_subnet_ids

  id = each.value
}

data "aws_subnet" "onprem_private" {
  for_each = module.vpc_onprem.private_subnet_ids

  id = each.value
}

locals {
  az_a      = module.vpc_aws.azs[0]
  az_b      = module.vpc_aws.azs[1]
  onprem_az = module.vpc_onprem.azs[0]

  aws_cidr_a   = data.aws_subnet.aws_private[local.az_a].cidr_block
  aws_cidr_b   = data.aws_subnet.aws_private[local.az_b].cidr_block
  onprem_cidr  = data.aws_subnet.onprem_private[local.onprem_az].cidr_block
  onprem_rt_id = one(values(module.vpc_onprem.private_route_table_ids))
  aws_rt_id    = one(values(module.vpc_aws.private_route_table_ids))

  # IPs fixos. Poderiam ser dinâmicos, mas aí toda saída do roteiro viraria
  # "algum IP da faixa" e você não teria como conferir nada de cabeça.
  #   .10 → resolver INBOUND      .20 → resolver OUTBOUND     .40 → EC2
  inbound_ips  = [cidrhost(local.aws_cidr_a, 10), cidrhost(local.aws_cidr_b, 10)]
  outbound_ips = [cidrhost(local.aws_cidr_a, 20), cidrhost(local.aws_cidr_b, 20)]
  app_ip       = cidrhost(local.aws_cidr_a, 40)
  onprem_ip    = cidrhost(local.onprem_cidr, 10)

  # O ".2" de cada VPC: o Route 53 Resolver embutido (AmazonProvidedDNS). Não
  # tem ENI, não custa nada e só responde de DENTRO da própria VPC — a razão
  # de existir inbound endpoint está inteira nessa última frase.
  aws_vpc_resolver_ip    = cidrhost(var.aws_vpc_cidr, 2)
  onprem_vpc_resolver_ip = cidrhost(var.onprem_vpc_cidr, 2)
}

# ---------------------------------------------------------------------------
# Conectividade IP entre as duas redes
#
# Peering porque é grátis por hora. Num desenho real aqui estaria um Direct
# Connect ou uma VPN — e NADA neste lab mudaria: DNS híbrido é sempre
# endpoint + regra. O que o transporte decide é só se o pacote UDP/53 chega.
# ---------------------------------------------------------------------------
resource "aws_vpc_peering_connection" "this" {
  vpc_id      = module.vpc_aws.vpc_id
  peer_vpc_id = module.vpc_onprem.vpc_id
  auto_accept = true # mesma conta e mesma região

  tags = { Name = local.name_prefix }
}

resource "aws_route" "aws_to_onprem" {
  route_table_id            = local.aws_rt_id
  destination_cidr_block    = var.onprem_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_route" "onprem_to_aws" {
  route_table_id            = local.onprem_rt_id
  destination_cidr_block    = var.aws_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

# ---------------------------------------------------------------------------
# Private hosted zone — o nome que só existe dentro da VPC associada
#
# O bloco `vpc` cita UMA vpc_id: a da VPC "aws". É por isso que o passo 6 do
# roteiro dá NXDOMAIN quando você pergunta ao resolver da VPC on-prem. Não
# existe como associar uma PHZ a uma rede on-premises — associação de zona
# privada é sempre com VPC.
# ---------------------------------------------------------------------------
resource "aws_route53_zone" "aws_private" {
  name    = var.aws_private_zone
  comment = "Lab 03 - zona privada visivel apenas dentro da VPC aws"

  vpc {
    vpc_id = module.vpc_aws.vpc_id
  }

  tags = { Name = "${local.name_prefix}-${var.aws_private_zone}" }
}

resource "aws_route53_record" "app" {
  zone_id = aws_route53_zone.aws_private.zone_id
  name    = "app.${var.aws_private_zone}"
  type    = "A"
  ttl     = 60
  records = [local.app_ip]
}

# ---------------------------------------------------------------------------
# Security groups dos resolver endpoints
#
# Aqui mora um erro clássico de troubleshooting: o endpoint fica OPERATIONAL
# mesmo com o security group errado. Inbound precisa de INGRESS 53; outbound
# precisa de EGRESS 53. Trocar os dois dá um lab que sobe limpo e não resolve
# nada — e é exatamente o sintoma que a questão descreve.
# ---------------------------------------------------------------------------
resource "aws_security_group" "resolver_inbound" {
  name        = "${local.name_prefix}-resolver-inbound"
  description = "DNS vindo da rede on-premises para o inbound endpoint."
  vpc_id      = module.vpc_aws.vpc_id

  ingress {
    description = "DNS UDP a partir do datacenter"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = [var.onprem_vpc_cidr]
  }

  ingress {
    description = "DNS TCP - respostas grandes e transferencia de zona caem aqui"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = [var.onprem_vpc_cidr]
  }

  egress {
    description = "Resposta em direcao ao resolver da propria VPC"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = [var.aws_vpc_cidr]
  }

  tags = { Name = "${local.name_prefix}-resolver-inbound" }
}

resource "aws_security_group" "resolver_outbound" {
  name        = "${local.name_prefix}-resolver-outbound"
  description = "DNS saindo do outbound endpoint para o servidor do datacenter."
  vpc_id      = module.vpc_aws.vpc_id

  egress {
    description = "DNS UDP para o servidor on-premises"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = [var.onprem_vpc_cidr]
  }

  egress {
    description = "DNS TCP para o servidor on-premises"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = [var.onprem_vpc_cidr]
  }

  tags = { Name = "${local.name_prefix}-resolver-outbound" }
}

# ---------------------------------------------------------------------------
# Os dois resolver endpoints — o item caro do lab
#
# Cada endpoint exige no mínimo DOIS IPs, em DUAS AZs, e a AWS cobra por ENI:
# US$ 0,125/hora cada. 2 endpoints x 2 ENIs = US$ 0,50/hora = US$ 12/dia.
# É o maior custo por hora de qualquer lab deste repositório — destrua no fim.
#
# A direção é sempre lida do ponto de vista da VPC:
#   INBOUND  = pergunta ENTRA na AWS   (on-prem consulta a private hosted zone)
#   OUTBOUND = pergunta SAI da AWS     (EC2 consulta o domínio do datacenter)
# ---------------------------------------------------------------------------
resource "aws_route53_resolver_endpoint" "inbound" {
  name               = "${local.name_prefix}-inbound"
  direction          = "INBOUND"
  security_group_ids = [aws_security_group.resolver_inbound.id]

  ip_address {
    subnet_id = module.vpc_aws.private_subnet_ids[local.az_a]
    ip        = local.inbound_ips[0]
  }

  ip_address {
    subnet_id = module.vpc_aws.private_subnet_ids[local.az_b]
    ip        = local.inbound_ips[1]
  }

  tags = { Name = "${local.name_prefix}-inbound" }
}

resource "aws_route53_resolver_endpoint" "outbound" {
  name               = "${local.name_prefix}-outbound"
  direction          = "OUTBOUND"
  security_group_ids = [aws_security_group.resolver_outbound.id]

  ip_address {
    subnet_id = module.vpc_aws.private_subnet_ids[local.az_a]
    ip        = local.outbound_ips[0]
  }

  ip_address {
    subnet_id = module.vpc_aws.private_subnet_ids[local.az_b]
    ip        = local.outbound_ips[1]
  }

  tags = { Name = "${local.name_prefix}-outbound" }
}

# ---------------------------------------------------------------------------
# Forwarding rule + associação
#
# São DOIS objetos de propósito, e a diferença entre eles é o conteúdo do lab:
#   - a REGRA diz "onprem.corp.internal vai para 10.32.64.10 pelo outbound".
#     Ela não custa nada e não faz efeito nenhum sozinha.
#   - a ASSOCIAÇÃO liga a regra a UMA VPC. Sem ela o outbound endpoint continua
#     OPERATIONAL, você continua pagando as 2 ENIs, e o nome dá NXDOMAIN.
#
# É essa separação que permite escrever a regra uma vez, compartilhá-la com o
# RAM e associá-la a N VPCs de N contas — o padrão de DNS híbrido centralizado.
# O passo 8 do roteiro apaga a associação para você ver a diferença.
# ---------------------------------------------------------------------------
resource "aws_route53_resolver_rule" "onprem" {
  name                 = "${local.name_prefix}-onprem"
  domain_name          = var.onprem_zone
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound.id

  target_ip {
    ip   = local.onprem_ip
    port = 53
  }

  tags = { Name = "${local.name_prefix}-onprem" }
}

resource "aws_route53_resolver_rule_association" "onprem" {
  resolver_rule_id = aws_route53_resolver_rule.onprem.id
  vpc_id           = module.vpc_aws.vpc_id
}

# ---------------------------------------------------------------------------
# Identidade das instâncias — a mesma nas duas, para que a única diferença
# entre elas seja a rede e o DNS.
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
  name_prefix        = "sapc02-lab03-ec2-"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.instance.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "instance" {
  name_prefix = "sapc02-lab03-"
  role        = aws_iam_role.instance.name
}

data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-arm64"
}

# ---------------------------------------------------------------------------
# EC2 do lado AWS — é ela que app.aws.corp.internal aponta, e é dela que saem
# as consultas dos passos 3, 4 e 9.
# ---------------------------------------------------------------------------
resource "aws_security_group" "app" {
  name        = "${local.name_prefix}-app"
  description = "EC2 do lado AWS: alvo de ping do datacenter, saida liberada."
  vpc_id      = module.vpc_aws.vpc_id

  ingress {
    description = "ICMP do datacenter - prova que o nome resolvido tambem e alcancavel"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.onprem_vpc_cidr]
  }

  egress {
    description = "Tudo: 443 para o Systems Manager via NAT instance, 53 para o resolver da VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${local.name_prefix}-app" }
}

resource "aws_instance" "app" {
  ami                    = data.aws_ssm_parameter.al2023.value
  instance_type          = "t4g.nano"
  subnet_id              = module.vpc_aws.private_subnet_ids[local.az_a]
  private_ip             = local.app_ip
  vpc_security_group_ids = [aws_security_group.app.id]
  iam_instance_profile   = aws_iam_instance_profile.instance.name

  # `dig` não vem na AL2023. O retry existe porque a NAT instance da VPC pode
  # ainda estar aplicando o MASQUERADE quando este user_data roda.
  user_data = <<-EOF
    #!/bin/bash
    set -euxo pipefail
    for _ in $(seq 1 30); do
      dnf install -y bind-utils && break
      sleep 10
    done
  EOF

  user_data_replace_on_change = true

  metadata_options {
    http_tokens   = "required" # IMDSv2 obrigatório
    http_endpoint = "enabled"
  }

  root_block_device {
    encrypted   = true
    volume_type = "gp3"
    volume_size = 8
  }

  tags = { Name = "${local.name_prefix}-app" }

  depends_on = [module.vpc_aws]
}

# ---------------------------------------------------------------------------
# EC2 do "datacenter" — servidor DNS autoritativo de onprem.corp.internal
#
# O mesmo host faz de servidor DNS e de "banco": db.onprem.corp.internal
# aponta para o IP dele. Assim o nome resolvido pela AWS também responde a
# ping, e o passo 4 prova nome + alcance na mesma tacada.
# ---------------------------------------------------------------------------
resource "aws_security_group" "onprem_dns" {
  name        = "${local.name_prefix}-onprem-dns"
  description = "Porta 53 a partir da VPC aws (ENIs do outbound endpoint) e da propria VPC."
  vpc_id      = module.vpc_onprem.vpc_id

  ingress {
    description = "DNS UDP do outbound endpoint da AWS"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = [var.aws_vpc_cidr, var.onprem_vpc_cidr]
  }

  ingress {
    description = "DNS TCP do outbound endpoint da AWS"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = [var.aws_vpc_cidr, var.onprem_vpc_cidr]
  }

  ingress {
    description = "ICMP da VPC aws - db.onprem.corp.internal aponta para esta instancia"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.aws_vpc_cidr]
  }

  egress {
    description = "Tudo: 443 para o Systems Manager via NAT instance, 53 para o inbound endpoint"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${local.name_prefix}-onprem-dns" }
}

resource "aws_instance" "onprem_dns" {
  ami                    = data.aws_ssm_parameter.al2023.value
  instance_type          = "t4g.nano"
  subnet_id              = module.vpc_onprem.private_subnet_ids[local.onprem_az]
  private_ip             = local.onprem_ip
  vpc_security_group_ids = [aws_security_group.onprem_dns.id]
  iam_instance_profile   = aws_iam_instance_profile.instance.name

  user_data = templatefile("${path.module}/assets/dnsmasq-user-data.sh.tftpl", {
    onprem_zone            = var.onprem_zone
    aws_zone               = var.aws_private_zone
    db_ip                  = local.onprem_ip
    dns_ip                 = local.onprem_ip
    inbound_ip_a           = local.inbound_ips[0]
    inbound_ip_b           = local.inbound_ips[1]
    onprem_vpc_resolver_ip = local.onprem_vpc_resolver_ip
  })

  # Sem isto, corrigir o script acima só reescreve um atributo: o cloud-init não
  # reexecuta e a instância continua com o dnsmasq da versão antiga. O servidor
  # DNS do lab é justamente o que se conserta editando o user_data — então ele
  # precisa ser recriado quando o script muda.
  user_data_replace_on_change = true

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  root_block_device {
    encrypted   = true
    volume_type = "gp3"
    volume_size = 8
  }

  tags = { Name = "${local.name_prefix}-onprem-dns" }

  # Sem a rota do peering o dnsmasq até sobe, mas o conditional forwarding para
  # o inbound endpoint não tem por onde sair.
  depends_on = [
    module.vpc_onprem,
    aws_route.onprem_to_aws,
    aws_route53_resolver_endpoint.inbound,
  ]
}

locals {
  name_prefix = "${lower(var.certification)}-${var.lab}"
}

data "aws_caller_identity" "current" {}

# ---------------------------------------------------------------------------
# VPC 3-tier, SEM NAT Gateway.
#
# A tese do lab: uma instância em subnet isolada, sem rota default e sem IP
# público, ainda assim é administrável e alcança S3 — só com VPC endpoints.
# Economia: ~US$ 32/mês por NAT Gateway que você não precisou criar.
# ---------------------------------------------------------------------------
module "vpc" {
  source = "../../../../modules/vpc"

  name       = local.name_prefix
  cidr_block = var.vpc_cidr
  az_count   = 2

  nat_strategy            = "none"
  enable_isolated_subnets = true

  gateway_endpoints = ["s3", "dynamodb"]

  # O trio que faz Session Manager funcionar sem internet.
  # ~US$ 21/mês se ficar de pé (3 endpoints × 2 AZs × ~US$ 3,50) — destrua o lab.
  interface_endpoints = ["ssm", "ssmmessages", "ec2messages"]

  enable_flow_logs         = true
  flow_logs_retention_days = 1
}

# ---------------------------------------------------------------------------
# Instância de teste na subnet ISOLADA (a mais restrita das três)
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

# AmazonSSMManagedInstanceCore é o mínimo para Session Manager. Repare que não
# há nenhuma permissão de rede envolvida — o acesso vem do endpoint, não da policy.
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.instance.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "instance" {
  name_prefix = "${local.name_prefix}-"
  role        = aws_iam_role.instance.name
}

# Security group sem NENHUMA regra de ingress. Session Manager não precisa:
# o agente abre a conexão de dentro para fora. Isso é o que torna o bastion host
# desnecessário — e é a resposta certa em boa parte das questões de acesso seguro.
resource "aws_security_group" "instance" {
  name        = "${local.name_prefix}-instance"
  description = "Sem ingress. Egress HTTPS apenas, para alcancar os VPC endpoints."
  vpc_id      = module.vpc.vpc_id

  egress {
    description = "HTTPS para os VPC endpoints e para S3 via gateway endpoint"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    prefix_list_ids = [
      data.aws_prefix_list.s3.id,
      data.aws_prefix_list.dynamodb.id,
    ]
  }

  tags = { Name = "${local.name_prefix}-instance" }
}

data "aws_prefix_list" "s3" {
  name = "com.amazonaws.${var.aws_region}.s3"
}

data "aws_prefix_list" "dynamodb" {
  name = "com.amazonaws.${var.aws_region}.dynamodb"
}

data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-arm64"
}

resource "aws_instance" "test" {
  ami                    = data.aws_ssm_parameter.al2023.value
  instance_type          = "t4g.nano"
  subnet_id              = module.vpc.isolated_subnet_ids[module.vpc.azs[0]]
  vpc_security_group_ids = [aws_security_group.instance.id]
  iam_instance_profile   = aws_iam_instance_profile.instance.name

  metadata_options {
    http_tokens   = "required" # IMDSv2 obrigatório — cai como controle de segurança
    http_endpoint = "enabled"
  }

  root_block_device {
    encrypted   = true
    volume_type = "gp3"
    volume_size = 8
  }

  tags = { Name = "${local.name_prefix}-test" }
}

# ---------------------------------------------------------------------------
# Bucket para provar que o gateway endpoint funciona da subnet isolada
# ---------------------------------------------------------------------------
resource "aws_s3_bucket" "test" {
  bucket        = "${local.name_prefix}-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "test" {
  bucket = aws_s3_bucket.test.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "hello" {
  bucket  = aws_s3_bucket.test.id
  key     = "hello.txt"
  content = "Se voce leu isto de dentro da subnet isolada, o gateway endpoint funcionou.\n"
}

resource "aws_iam_role_policy" "read_test_bucket" {
  name = "read-test-bucket"
  role = aws_iam_role.instance.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:GetObject", "s3:ListBucket"]
      Resource = [aws_s3_bucket.test.arn, "${aws_s3_bucket.test.arn}/*"]
    }]
  })
}

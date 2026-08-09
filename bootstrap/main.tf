# Bootstrap: bucket de state remoto para todos os labs do repositório.
#
# Este é o único módulo com state LOCAL (problema do ovo e da galinha).
# Rode uma vez:  ./scripts/tf.sh bootstrap
#
# O locking usa o lockfile nativo do S3 (use_lockfile), disponível a partir do
# Terraform 1.11 — não é preciso tabela DynamoDB.

terraform {
  required_version = ">= 1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "aws-certifications"
      ManagedBy = "terraform"
      Component = "bootstrap"
    }
  }
}

variable "aws_region" {
  description = "Região onde o bucket de state vive."
  type        = string
  default     = "us-east-1"
}

data "aws_caller_identity" "current" {}

locals {
  bucket_name = "tfstate-aws-certifications-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket" "state" {
  bucket = local.bucket_name

  # O state é a única coisa neste repo que NÃO é efêmera.
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state" {
  bucket = aws_s3_bucket.state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "state" {
  bucket = aws_s3_bucket.state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Nega qualquer escrita sem TLS — pequeno, mas é exatamente o tipo de controle
# que o Domínio 1.2 cobra.
resource "aws_s3_bucket_policy" "state_tls_only" {
  bucket = aws_s3_bucket.state.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "DenyInsecureTransport"
      Effect    = "Deny"
      Principal = "*"
      Action    = "s3:*"
      Resource = [
        aws_s3_bucket.state.arn,
        "${aws_s3_bucket.state.arn}/*",
      ]
      Condition = {
        Bool = { "aws:SecureTransport" = "false" }
      }
    }]
  })
}

# Expira versões antigas do state para não acumular custo indefinidamente.
resource "aws_s3_bucket_lifecycle_configuration" "state" {
  bucket     = aws_s3_bucket.state.id
  depends_on = [aws_s3_bucket_versioning.state]

  rule {
    id     = "expire-noncurrent-state-versions"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

output "state_bucket" {
  description = "Bucket usado como backend S3 por todos os labs."
  value       = aws_s3_bucket.state.id
}

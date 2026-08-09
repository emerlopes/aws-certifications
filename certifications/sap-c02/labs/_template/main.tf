locals {
  # Prefixo de nome para recursos que precisam de nome físico explícito.
  name_prefix = "${lower(var.certification)}-${var.lab}"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# ---------------------------------------------------------------------------
# Recursos do lab
# ---------------------------------------------------------------------------

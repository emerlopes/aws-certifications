# ---------------------------------------------------------------------------
# Variáveis padrão de todo lab — injetadas automaticamente pelo ./scripts/tf.sh.
# ---------------------------------------------------------------------------

variable "aws_region" {
  description = "Região primária do lab."
  type        = string
  default     = "us-east-1"
}

variable "certification" {
  description = "Certificação à qual o lab pertence (tag de alocação de custo)."
  type        = string
  default     = "SAP-C02"
}

variable "lab" {
  description = "Identificador do lab (tag de alocação de custo)."
  type        = string
  default     = "lab-01-vpc-base"
}

# ---------------------------------------------------------------------------
# Específicas deste lab
# ---------------------------------------------------------------------------

variable "vpc_cidr" {
  description = "CIDR da VPC. Convenção do repo: 10.<numero-do-lab>.0.0/16."
  type        = string
  default     = "10.1.0.0/16"
}

# ---------------------------------------------------------------------------
# Variáveis padrão de todo lab — injetadas automaticamente pelo ./scripts/tf.sh.
# Não remova nem renomeie.
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
}

# ---------------------------------------------------------------------------
# Variáveis específicas deste lab
# ---------------------------------------------------------------------------

# variable "exemplo" {
#   description = "..."
#   type        = string
# }

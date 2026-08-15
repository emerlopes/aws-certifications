# ---------------------------------------------------------------------------
# Variáveis padrão de todo lab — injetadas automaticamente pelo ./scripts/tf.sh.
# ---------------------------------------------------------------------------

variable "aws_region" {
  description = "Região primária do lab. IAM é global, mas o bucket e o Access Analyzer são regionais."
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
  default     = "lab-04-cross-account-iam"
}

# ---------------------------------------------------------------------------
# Específicas deste lab
# ---------------------------------------------------------------------------

variable "external_id" {
  description = <<-EOT
    Valor exigido pela trust policy da role `audit-readonly` na condição
    `sts:ExternalId`. Quem assume precisa passar `--external-id` com exatamente
    este valor.

    Tem default de propósito, e isso NÃO viola a regra "segredo nunca em variável
    com default" das convenções: a própria AWS documenta que o external ID não é
    um segredo. Ele não concede acesso sozinho — só serve para impedir que um
    terceiro seja enganado a assumir a role de OUTRO cliente (confused deputy).
    Na vida real quem gera o valor é o parceiro, um por cliente, e ele costuma
    aparecer em claro na tela de onboarding do fornecedor.
  EOT
  type        = string
  default     = "acme-msp-7f3c1b"

  validation {
    condition     = length(var.external_id) >= 8
    error_message = "Use pelo menos 8 caracteres — external ID curto e adivinhável derrota o propósito da condição."
  }
}

variable "create_access_analyzer" {
  description = <<-EOT
    Cria o IAM Access Analyzer com zona de confiança = a conta (tipo ACCOUNT).
    O analyzer de acesso externo é gratuito.

    Deixe `false` se o `apply` falhar com `ConflictException`: a AWS permite
    apenas UM analyzer por tipo, por conta, por região, e você já tem um (o
    Security Hub e o Control Tower criam um sozinhos). Nesse caso use o analyzer
    existente no roteiro — o nome sai de `aws accessanalyzer list-analyzers`.
  EOT
  type        = bool
  default     = true
}

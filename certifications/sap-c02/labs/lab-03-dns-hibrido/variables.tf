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
  default     = "lab-03-dns-hibrido"
}

# ---------------------------------------------------------------------------
# Específicas deste lab
#
# Convenção do repo para lab com múltiplas VPCs: 10.<NN><n>.0.0/16 — o lab 03
# fica com 10.31 e 10.32. Não sobrepõe o lab 02 (10.21 a 10.24), então dá para
# subir os dois juntos se você quiser comparar TGW e peering.
# ---------------------------------------------------------------------------

variable "aws_vpc_cidr" {
  description = "CIDR da VPC 'aws' — o lado nuvem. É a única VPC associada à private hosted zone e a única com resolver endpoints."
  type        = string
  default     = "10.31.0.0/16"
}

variable "onprem_vpc_cidr" {
  description = "CIDR da VPC 'onprem'. Simula o datacenter: tem o servidor DNS autoritativo do domínio corporativo e NÃO enxerga a private hosted zone."
  type        = string
  default     = "10.32.0.0/16"
}

variable "aws_private_zone" {
  description = "Domínio da private hosted zone criada na VPC 'aws'. É o nome que o on-prem só resolve através do INBOUND endpoint."
  type        = string
  default     = "aws.corp.internal"

  validation {
    condition     = !endswith(var.aws_private_zone, ".")
    error_message = "Escreva o domínio sem o ponto final (aws.corp.internal, não aws.corp.internal.)."
  }
}

variable "onprem_zone" {
  description = "Domínio autoritativo do 'datacenter', servido pelo dnsmasq. É o nome que a AWS só resolve através do OUTBOUND endpoint + forwarding rule."
  type        = string
  default     = "onprem.corp.internal"

  validation {
    condition     = !endswith(var.onprem_zone, ".")
    error_message = "Escreva o domínio sem o ponto final (onprem.corp.internal, não onprem.corp.internal.)."
  }
}

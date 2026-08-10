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
  default     = "lab-02-transit-gateway"
}

# ---------------------------------------------------------------------------
# Específicas deste lab
#
# Convenção do repo para lab com múltiplas VPCs: 10.<NN><n>.0.0/16 — lab 02 fica
# com 10.21 a 10.24. Isso colide com o CIDR padrão dos labs 21 a 24, que usam
# 10.21.0.0/16 e vizinhos. Só importa se você subir os dois ao mesmo tempo E
# quiser conectá-los; não faça isso.
# ---------------------------------------------------------------------------

variable "prod_vpc_cidr" {
  description = "CIDR da VPC prod (spoke, anexada ao TGW)."
  type        = string
  default     = "10.21.0.0/16"
}

variable "dev_vpc_cidr" {
  description = "CIDR da VPC dev (spoke, anexada ao TGW). Não pode alcançar a prod."
  type        = string
  default     = "10.22.0.0/16"
}

variable "hub_vpc_cidr" {
  description = "CIDR da VPC hub (serviços compartilhados: interface endpoints centralizados)."
  type        = string
  default     = "10.23.0.0/16"
}

variable "partner_vpc_cidr" {
  description = "CIDR da VPC partner. Só tem peering com o hub — é o caso de não-transitividade."
  type        = string
  default     = "10.24.0.0/16"
}

variable "lab_supernet" {
  description = <<-EOT
    Supernet que cobre as 4 VPCs do lab. Usada em dois lugares:
      - rota das VPCs anexadas apontando para o TGW (route table da VPC não filtra nada
        de propósito: a filtragem do lab mora na route table do TGW);
      - security group das instâncias.
  EOT
  type        = string
  default     = "10.0.0.0/8"
}

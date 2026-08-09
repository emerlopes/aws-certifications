variable "name" {
  description = "Prefixo de nome da VPC e dos recursos derivados."
  type        = string
}

variable "cidr_block" {
  description = "CIDR da VPC. Use blocos distintos por lab para permitir peering/TGW sem sobreposição."
  type        = string

  validation {
    condition     = can(cidrhost(var.cidr_block, 0))
    error_message = "cidr_block precisa ser um CIDR IPv4 válido."
  }
}

variable "az_count" {
  description = "Quantas AZs usar. 2 cobre a maioria dos labs; 3 para quorum (etcd, Aurora, MSK)."
  type        = number
  default     = 2

  validation {
    condition     = var.az_count >= 1 && var.az_count <= 4
    error_message = "az_count deve estar entre 1 e 4."
  }
}

variable "nat_strategy" {
  description = <<-EOT
    Como o tier privado alcança a internet:
      "none"     — sem saída. Mais barato. Use com VPC endpoints (SSM, ECR, S3, Logs).
      "single"   — 1 NAT Gateway compartilhado. ~US$ 32/mês, SPOF de AZ (bom para ver o SPOF).
      "per_az"   — 1 NAT Gateway por AZ. Produção-like, ~US$ 32/mês * az_count.
      "instance" — NAT instance t4g.nano. ~US$ 3/mês, didático, não use em produção.
  EOT
  type        = string
  default     = "none"

  validation {
    condition     = contains(["none", "single", "per_az", "instance"], var.nat_strategy)
    error_message = "nat_strategy deve ser none, single, per_az ou instance."
  }
}

variable "enable_isolated_subnets" {
  description = "Cria um terceiro tier sem rota default (bancos de dados). Arquitetura 3-tier clássica."
  type        = bool
  default     = false
}

variable "gateway_endpoints" {
  description = "Gateway endpoints a criar. Não têm custo por hora — deixe ligados."
  type        = list(string)
  default     = ["s3", "dynamodb"]
}

variable "interface_endpoints" {
  description = <<-EOT
    Interface endpoints (PrivateLink) a criar, ex: ["ssm", "ssmmessages", "ec2messages"].
    ATENÇÃO: ~US$ 7/mês por endpoint por AZ. Esse trio permite Session Manager sem NAT.
  EOT
  type        = list(string)
  default     = []
}

variable "enable_flow_logs" {
  description = "Habilita VPC Flow Logs para CloudWatch Logs (Domínio 1.1 — troubleshooting de tráfego)."
  type        = bool
  default     = false
}

variable "flow_logs_retention_days" {
  description = "Retenção dos flow logs. Nunca deixe infinito — vira custo crescente."
  type        = number
  default     = 7
}

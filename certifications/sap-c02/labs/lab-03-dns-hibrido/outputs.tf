output "session_commands" {
  description = "Abre um shell em cada lado. `aws` é a EC2 na nuvem; `onprem` é o servidor DNS do datacenter simulado."
  value = {
    aws    = "aws ssm start-session --target ${aws_instance.app.id} --region ${var.aws_region}"
    onprem = "aws ssm start-session --target ${aws_instance.onprem_dns.id} --region ${var.aws_region}"
  }
}

output "names_to_resolve" {
  description = "Os dois nomes do lab. O primeiro só existe na VPC aws; o segundo só existe no dnsmasq do datacenter."
  value = {
    aws_side    = "app.${var.aws_private_zone}"
    onprem_side = "db.${var.onprem_zone}"
  }
}

output "inbound_endpoint_ips" {
  description = "IPs do INBOUND endpoint. É para cá que o dnsmasq encaminha as consultas do datacenter — e é o alvo do `dig @` do passo 7."
  value       = local.inbound_ips
}

output "outbound_endpoint_ips" {
  description = "IPs do OUTBOUND endpoint. É deste IP de origem que a consulta chega ao dnsmasq — confira no journal do passo 5."
  value       = local.outbound_ips
}

output "vpc_resolver_ips" {
  description = "O `.2` de cada VPC (AmazonProvidedDNS). Grátis, sem ENI, e só responde de dentro da própria VPC — o passo 6 prova isso."
  value = {
    aws    = local.aws_vpc_resolver_ip
    onprem = local.onprem_vpc_resolver_ip
  }
}

output "instance_ips" {
  description = "IPs fixos das duas EC2. `app` é o alvo do registro A da private hosted zone; `onprem_dns` é o servidor DNS e o alvo de db.onprem.corp.internal."
  value = {
    app        = aws_instance.app.private_ip
    onprem_dns = aws_instance.onprem_dns.private_ip
  }
}

output "resolver_rule_id" {
  description = "ID da forwarding rule. Usado no passo 8 para desassociá-la da VPC e ver o NXDOMAIN aparecer."
  value       = aws_route53_resolver_rule.onprem.id
}

output "resolver_rule_association_id" {
  description = "ID da associação regra ↔ VPC. É este objeto — e não o endpoint — que faz a regra valer para a VPC aws."
  value       = aws_route53_resolver_rule_association.onprem.id
}

output "private_hosted_zone_id" {
  description = "Zona privada associada apenas à VPC aws. Confirme a lista de VPCs com `aws route53 get-hosted-zone`."
  value       = aws_route53_zone.aws_private.zone_id
}

output "resolver_endpoint_hourly_cost" {
  description = "Lembrete de custo: os resolver endpoints são cobrados por ENI, existindo tráfego ou não."
  value       = "4 ENIs x US$ 0,125/h = US$ 0,50/h = US$ 12,00/dia. Destrua o lab ao terminar."
}

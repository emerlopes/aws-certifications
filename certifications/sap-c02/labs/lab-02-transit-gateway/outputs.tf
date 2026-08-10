output "instances" {
  description = "ID e IP privado por VPC. Os IPs são os alvos dos pings do roteiro."
  value = {
    for k, i in aws_instance.this : k => {
      id         = i.id
      private_ip = i.private_ip
    }
  }
}

output "session_commands" {
  description = "Abre um shell em cada VPC. Os endpoints ficam todos no hub — a prod usa os do vizinho."
  value = {
    for k, i in aws_instance.this : k => "aws ssm start-session --target ${i.id} --region ${var.aws_region}"
  }
}

output "transit_gateway_id" {
  description = "ID do Transit Gateway."
  value       = aws_ec2_transit_gateway.this.id
}

output "tgw_route_table_spokes" {
  description = "Route table consultada por prod e dev. Tem 10.23.0.0/16 e mais nada — é a segmentação do lab."
  value       = aws_ec2_transit_gateway_route_table.spokes.id
}

output "tgw_route_table_hub" {
  description = "Route table consultada pelo hub. Tem os CIDRs de prod e dev propagados."
  value       = aws_ec2_transit_gateway_route_table.hub.id
}

output "tgw_attachment_ids" {
  description = "Anexos por VPC — US$ 0,05/hora cada. Usados como alvo nas rotas estáticas do passo 7."
  value       = { for k, a in aws_ec2_transit_gateway_vpc_attachment.this : k => a.id }
}

output "vpc_route_table_ids" {
  description = "Route table de cada VPC. A do partner é a evidência do passo 8: sem rota para o TGW."
  value       = { for k, v in local.vpcs : k => v.route_table_id }
}

output "peering_connection_id" {
  description = "Peering hub ↔ partner. Sem custo por hora, e não transitivo."
  value       = aws_vpc_peering_connection.hub_partner.id
}

output "endpoint_dns_names" {
  description = "Nome regional de cada interface endpoint — é o alvo dos registros ALIAS da private hosted zone."
  value       = { for k, e in aws_vpc_endpoint.interface : k => e.dns_entry[0].dns_name }
}

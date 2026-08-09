output "vpc_id" {
  description = "ID da VPC."
  value       = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "CIDR da VPC."
  value       = aws_vpc.this.cidr_block
}

output "azs" {
  description = "AZs em uso, na ordem."
  value       = local.azs
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas, por AZ."
  value       = { for az, s in aws_subnet.public : az => s.id }
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas, por AZ."
  value       = { for az, s in aws_subnet.private : az => s.id }
}

output "isolated_subnet_ids" {
  description = "IDs das subnets isoladas (sem rota default), por AZ."
  value       = { for az, s in aws_subnet.isolated : az => s.id }
}

output "public_route_table_id" {
  description = "Route table pública."
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "Route tables privadas, por AZ (chave = AZ da NAT que a serve)."
  value       = { for az, rt in aws_route_table.private : az => rt.id }
}

output "internet_gateway_id" {
  description = "Internet Gateway da VPC."
  value       = aws_internet_gateway.this.id
}

output "nat_public_ips" {
  description = "IPs públicos de saída — útil para allowlist em sistemas externos."
  value = local.nat_gateway ? [for e in aws_eip.nat : e.public_ip] : (
    local.nat_instance ? [aws_instance.nat[0].public_ip] : []
  )
}

output "interface_endpoint_sg_id" {
  description = "Security group dos interface endpoints, se criados."
  value       = length(var.interface_endpoints) > 0 ? aws_security_group.interface_endpoints[0].id : null
}

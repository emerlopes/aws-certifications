output "vpc_id" {
  description = "ID da VPC criada."
  value       = module.vpc.vpc_id
}

output "subnets_by_tier" {
  description = "Subnets por tier e AZ — compare com as route tables no console."
  value = {
    public   = module.vpc.public_subnet_ids
    private  = module.vpc.private_subnet_ids
    isolated = module.vpc.isolated_subnet_ids
  }
}

output "instance_id" {
  description = "Instância de teste na subnet isolada."
  value       = aws_instance.test.id
}

output "test_bucket" {
  description = "Bucket usado para provar o gateway endpoint."
  value       = aws_s3_bucket.test.id
}

output "session_manager_command" {
  description = "Abre um shell na instância isolada — sem bastion, sem chave SSH, sem IP público."
  value       = "aws ssm start-session --target ${aws_instance.test.id} --region ${var.aws_region}"
}

output "proof_command" {
  description = "Rode DENTRO da sessão SSM para provar que o gateway endpoint funciona."
  value       = "aws s3 cp s3://${aws_s3_bucket.test.id}/hello.txt - --region ${var.aws_region}"
}

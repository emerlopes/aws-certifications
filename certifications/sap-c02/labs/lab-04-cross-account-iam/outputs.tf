output "bucket" {
  description = "Bucket com hello.txt e segundo.txt. É o único recurso que as roles do lado B enxergam."
  value       = aws_s3_bucket.data.id
}

output "external_id" {
  description = "Valor exigido na condição sts:ExternalId da trust policy de audit-readonly. Passe em --external-id. Não é segredo: sozinho ele não abre nada."
  value       = var.external_id
}

output "role_arns" {
  description = "Os seis papéis do lab. Lado A chama, lado B é chamado."
  value = {
    msp_caller                = aws_iam_role.msp_caller.arn
    msp_caller_trust_only     = aws_iam_role.msp_caller_trust_only.arn
    audit_readonly            = aws_iam_role.audit_readonly.arn
    audit_direct_trust        = aws_iam_role.audit_direct_trust.arn
    delegated_admin_bounded   = aws_iam_role.delegated_admin_bounded.arn
    delegated_admin_unbounded = aws_iam_role.delegated_admin_unbounded.arn
  }
}

output "assume_commands" {
  description = "Comandos de assume-role já montados, um por papel. Copie do output, não do README — o número da conta muda."
  value = {
    "1_msp_caller"                = "assume ${aws_iam_role.msp_caller.arn} msp"
    "2_msp_caller_trust_only"     = "assume ${aws_iam_role.msp_caller_trust_only.arn} trustonly"
    "3_audit_readonly"            = "assume ${aws_iam_role.audit_readonly.arn} auditoria ${var.external_id}"
    "4_audit_direct_trust"        = "assume ${aws_iam_role.audit_direct_trust.arn} direto"
    "5_delegated_admin_bounded"   = "assume ${aws_iam_role.delegated_admin_bounded.arn} bounded"
    "6_delegated_admin_unbounded" = "assume ${aws_iam_role.delegated_admin_unbounded.arn} unbounded"
  }
}

output "boundary_policy_arn" {
  description = "ARN da permission boundary. Confirme o vínculo com `aws iam get-role --role-name ... --query Role.PermissionsBoundary`."
  value       = aws_iam_policy.boundary.arn
}

output "access_analyzer_name" {
  description = "Nome do analyzer usado nos comandos `aws accessanalyzer list-findings`. Vazio se create_access_analyzer = false — nesse caso use `aws accessanalyzer list-analyzers`."
  value       = try(aws_accessanalyzer_analyzer.account[0].analyzer_name, "")
}

output "estimated_cost" {
  description = "Lembrete de custo: este é o lab mais barato do repositório."
  value       = "US$ 0,00/dia. IAM, STS e o analyzer de acesso externo nao cobram; o bucket guarda 2 arquivos de texto. O risco deste lab e' de permissao, nao de fatura."
}

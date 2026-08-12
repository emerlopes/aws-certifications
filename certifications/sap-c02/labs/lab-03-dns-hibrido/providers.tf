provider "aws" {
  region = var.aws_region

  # Toda tag obrigatória do repo entra aqui uma vez só e desce para todo recurso
  # que suporta tagging. Ver docs/convencoes.md.
  default_tags {
    tags = {
      Project       = "aws-certifications"
      Certification = var.certification
      Lab           = var.lab
      ManagedBy     = "terraform"
      Ephemeral     = "true"
    }
  }
}

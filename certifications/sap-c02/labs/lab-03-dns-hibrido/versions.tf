terraform {
  required_version = ">= 1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # Configuração parcial: bucket/key/region vêm do `./scripts/tf.sh init`,
  # que deriva a key do caminho do lab. Não preencha nada aqui.
  backend "s3" {}
}

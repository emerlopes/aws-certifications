# Convenções do repositório

## Anatomia de um lab

Todo lab é um **root module** Terraform em `certifications/<cert>/labs/<id>-<slug>/`:

```text
lab-07-dr-pilot-light/
├── README.md                  # Objetivo, arquitetura, roteiro de verificação, custo
├── versions.tf                # required_version, providers, backend "s3" {}
├── providers.tf               # provider aws + default_tags
├── variables.tf               # vars padrão + específicas do lab
├── main.tf                    # os recursos
├── outputs.tf                 # o que inspecionar depois do apply
├── terraform.tfvars.example
└── assets/                    # (opcional) código Lambda, scripts, diagramas
```

Nomeação: `lab-NN-slug-curto`, com `NN` na ordem do catálogo. Comece copiando o template:

```bash
cp -r certifications/sap-c02/labs/_template certifications/sap-c02/labs/lab-12-cicd-pipeline
```

Nunca rode `terraform` direto num lab — use o `./scripts/tf.sh`, que injeta o backend
e as variáveis padrão.

## State remoto

Backend S3 com **configuração parcial**: os `.tf` só declaram `backend "s3" {}` e o
`tf.sh init` preenche bucket/key/region. A key é derivada do caminho:

```text
s3://tfstate-aws-certifications-<account-id>/certifications/sap-c02/labs/lab-07-dr-pilot-light/terraform.tfstate
```

Locking pelo lockfile nativo do S3 (`use_lockfile`), sem tabela DynamoDB.
O bucket vem do `./scripts/tf.sh bootstrap` — é o único módulo com state local.

## Tags obrigatórias

Aplicadas via `default_tags` no provider, nunca recurso a recurso:

| Tag             | Valor                   |
| --------------- | ----------------------- |
| `Project`       | `aws-certifications`    |
| `Certification` | `SAP-C02` \| `AIP-C01`  |
| `Lab`           | `lab-07-dr-pilot-light` |
| `ManagedBy`     | `terraform`             |
| `Ephemeral`     | `true`                  |

`Ephemeral=true` é o que permite achar e destruir o que ficou órfão. Não remova.
Único lugar onde é `false`: `guardrails/`.

`Certification`, `Lab` e `aws_region` chegam como variáveis injetadas pelo `tf.sh` —
por isso `variables.tf` sempre declara as três, mesmo que o lab não use.

## Estilo de código

- `terraform fmt` limpo. O `tf.sh validate` falha se não estiver.
- `required_version = ">= 1.11"` (o backend S3 com `use_lockfile` precisa disso).
- Provider AWS pinado em `~> 6.0`. Commite o `.terraform.lock.hcl`.
- **Toda** variável tem `description`. Variável com domínio restrito tem `validation`.
- **Todo** output tem `description`. Outputs existem para _inspecionar_ o lab:
  IDs para colar no console, comandos prontos para copiar.
- `for_each` sobre mapa/set, nunca `count` sobre lista — evita recriação em cascata
  quando um item some do meio. `count` só para recurso condicional (`count = x ? 1 : 0`).
- Nada de ARN, account ID ou região hardcoded: use `data.aws_caller_identity`,
  `data.aws_region`, `data.aws_availability_zones`.
- AMI sempre via SSM Public Parameter, nunca ID fixo:
  ```hcl
  data "aws_ssm_parameter" "al2023" {
    name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-arm64"
  }
  ```text
- Políticas IAM via `data "aws_iam_policy_document"` quando forem grandes ou tiverem
  condições; `jsonencode` inline quando forem de 3 linhas.
- Segredo nunca em variável com `default`. Use `aws_secretsmanager_secret` +
  `ephemeral` / data source, e marque `sensitive = true` no que for output.
- `lifecycle { prevent_destroy = true }` só em `bootstrap/`. Lab não protege nada:
  a graça é destruir.

## Módulos

`modules/` guarda o que é reutilizado por 2+ labs (VPC, roles de baseline, KMS).
Regras:

- Módulo **não** declara `provider` nem `backend` — quem faz isso é o root module.
- Módulo **não** aplica tags de projeto — vêm do `default_tags` do root.
- Todo módulo tem `README.md` com exemplo de uso e uma seção
  "detalhes que caem no exame". O módulo é material de estudo, não só código.
- Chamada por caminho relativo: `source = "../../../../modules/vpc"`.

Se algo é usado por um lab só, deixe no lab. Módulo prematuro esconde o que você
está tentando aprender.

## Nomeação de recursos

Prefira deixar o Terraform gerar nome físico (`name_prefix` em vez de `name`) —
evita conflito de recriação. Quando precisar de nome fixo:

```
<cert>-<lab>-<recurso>   →   sap-c02-lab-01-vpc-base-instance
```

O `local.name_prefix = "${lower(var.certification)}-${var.lab}"` já monta isso.

## CIDRs

Convenção: **`10.<numero-do-lab>.0.0/16`**. Lab 01 → `10.1.0.0/16`, lab 22 → `10.22.0.0/16`.
Labs com múltiplas VPCs: `10.<NN>1.0.0/16`, `10.<NN>2.0.0/16`.
Isso garante que qualquer par de labs pode ser conectado por peering ou TGW sem
sobreposição — o que importa a partir do lab 02.

## Regiões

Padrão `us-east-1`. Labs multi-região usam `us-east-1` + `us-west-2`, com a região
secundária sempre como variável e um `provider` aliasado:

```hcl
provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
}
```

## Git

- Um commit por lab concluído: `feat(lab-07): DR pilot light com Aurora Global`.
- Anotações e plano: `docs(sap-c02): notas do dominio 1`.
- **Nunca** commitar: `terraform.tfvars`, `*.tfstate*`, `.terraform/`, `*.tfplan`,
  account IDs reais em README, ARNs com número de conta.
- **Sempre** commitar: `.terraform.lock.hcl`.

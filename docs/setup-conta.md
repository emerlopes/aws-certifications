# Setup da conta e do ambiente

Faça isso **uma vez**, antes do primeiro lab.

## 1. Ferramentas locais

### Pré-requisito

Tudo aqui assume **macOS com [Homebrew](https://brew.sh)**. Se `brew --version` falhar,
instale primeiro:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

> **Linux/WSL**: o Homebrew funciona, mas o `session-manager-plugin` não está lá.
> Ver a [instalação por distribuição](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html).
> O resto (`terraform`, `awscli`, `jq`, `tflint`, `checkov`, `infracost`) tem pacote
> nativo ou binário oficial.

### Obrigatórias

O `terraform` **não está no Homebrew core** — a HashiCorp mantém o próprio tap desde
a mudança de licença. O core só tem o `opentofu`. Use o tap oficial (o `brew install`
faz o tap sozinho):

```bash
brew install hashicorp/tap/terraform
```

```bash
brew install awscli
```

```bash
brew install --cask session-manager-plugin
```

O plugin é separado do AWS CLI e **não** vem junto. Vários labs abrem shell em
instância sem IP público; sem ele o `aws ssm start-session` falha com um erro que
não deixa óbvio o que faltou.

| Ferramenta               | Para quê                          | Se faltar                             |
| ------------------------ | --------------------------------- | ------------------------------------- |
| `terraform`              | Tudo                              | Nada funciona                         |
| `awscli`                 | Credenciais, `list`, `orphans`    | Nada funciona                         |
| `session-manager-plugin` | Shell em instância sem IP público | Labs 01, 19, 24, 31 ficam pela metade |

### Opcionais

```bash
brew install checkov infracost jq
```

O `tflint` **não está no Homebrew core** — vem de um tap próprio, então é um
comando separado (o `brew install` faz o tap sozinho):

```bash
brew install terraform-linters/tap/tflint
```

| Ferramenta  | Para quê                                                     | Se faltar                        |
| ----------- | ------------------------------------------------------------ | -------------------------------- |
| `tflint`    | Lint de Terraform                                            | `tf.sh lint` avisa e segue       |
| `checkov`   | Scan de segurança dos `.tf` (vira estudo do Domínio 2.3/3.2) | `tf.sh lint` pula essa etapa     |
| `infracost` | Estimativa de custo antes do `apply`                         | `tf.sh cost` não roda            |
| `jq`        | Filtrar saída JSON do AWS CLI nas verificações manuais       | Nada quebra, só dá mais trabalho |

> **Dois cuidados com o `brew`:**
> 1. `terraform` e `tflint` vêm de tap próprio (`hashicorp/tap` e
>    `terraform-linters/tap`). No core existem só `opentofu` e nada de tflint.
> 2. `brew install` com vários pacotes **aborta inteiro** se um nome não existir —
>    nenhum dos outros é instalado. Se um comando falhar, confira o que realmente
>    entrou com `brew list`.

Nenhuma das quatro bloqueia nada — o `tf.sh` detecta a ausência e avisa em vez de
falhar. Instale quando quiser; o `checkov` em especial é útil a partir da semana 6.

Depois do `tflint`, rode uma vez para baixar os plugins:

```bash
tflint --init
```

### Conferir

```bash
terraform version && aws --version && session-manager-plugin --version
```

Terraform precisa ser **>= 1.11** — o backend S3 com `use_lockfile` depende disso.
Se o seu for mais antigo: `brew upgrade terraform`.

## 2. Perfil AWS

Nunca use credenciais de root nem access key de longa duração. Configure SSO:

```bash
aws configure sso --profile aws-labs
```

Exporte na sessão de trabalho (vale colocar no `.envrc` / `.zshrc`):

```bash
export AWS_PROFILE=aws-labs
export AWS_REGION=us-east-1
```

Valide:

```bash
aws sts get-caller-identity
```

## 3. State remoto

```bash
./scripts/tf.sh bootstrap
```

Cria `tfstate-aws-certifications-<account-id>` com versionamento, criptografia,
bloqueio de acesso público, política de TLS-only e expiração de versões antigas.
Rode uma vez por conta. Detalhes em [`bootstrap/README.md`](../bootstrap/README.md).

## 4. Guarda-corpos de custo (antes de qualquer lab)

```bash
cp guardrails/terraform.tfvars.example guardrails/terraform.tfvars
```

Edite o e-mail e o teto mensal, então:

```bash
./scripts/tf.sh apply guardrails
```

Isso cria budget mensal (alertas em 50/80/100% do realizado + previsão de estouro),
tópico SNS e Cost Anomaly Detection diária. **Confirme a inscrição que chega por e-mail** —
sem isso os alertas não saem.

Depois, no Console (não dá para automatizar):

- **Billing → Cost Allocation Tags**: ative `Project`, `Certification` e `Lab` como
  tags de alocação de custo. Sem isso o relatório de custo por lab não funciona.
- **Billing → Preferências**: ative o Cost Explorer (leva ~24h para popular dados).

## 5. Ambiente multi-conta (a partir do lab 09)

O Domínio 1 é 26% do exame e é fortemente multi-conta. A partir do **lab 09** o
ideal é ter uma Organization com:

- `management` — só governança, sem workload
- `sandbox-1`, `sandbox-2` — onde os labs de multi-conta rodam
- `log-archive` — CloudTrail e Config centralizados

Contas AWS extras são gratuitas; o custo vem só do que você provisiona nelas.
O lab 09 provisiona a Organization e as OUs via Terraform.

## 6. Rotina de cada sessão de estudo

```bash
./scripts/tf.sh list      # states existentes
```

```bash
./scripts/tf.sh orphans   # recursos com Ephemeral=true ainda de pé
```

# Setup da conta e do ambiente

Faça isso **uma vez**, antes do primeiro lab.

## 1. Ferramentas locais

```bash
brew install terraform awscli jq tflint
```

O Session Manager precisa de um plugin separado do CLI — vários labs abrem shell
em instância sem IP público, e sem ele o `aws ssm start-session` falha:

```bash
brew install --cask session-manager-plugin
```

Opcionais, mas valem muito neste repo:

```bash
brew install infracost   # estimativa de custo antes do apply
pipx install checkov     # scan de segurança dos .tf (Domínio 2.3 / 3.2)
```

Confira:

```bash
terraform version && aws --version
```

Terraform precisa ser **>= 1.11** (o backend S3 com `use_lockfile` depende disso).

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

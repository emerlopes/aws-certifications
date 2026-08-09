# AWS Certifications — Estudo + Laboratórios em Terraform

Repositório central dos meus estudos de certificações AWS. Toda teoria vira prática:
cada tópico relevante do guia do exame tem um **lab** em Terraform, versionado,
aplicável e destruível por comando.

## Certificações

| Cert                                                 | Código  | Status              | Pasta                                                |
| ---------------------------------------------------- | ------- | ------------------- | ---------------------------------------------------- |
| AWS Certified Solutions Architect – Professional     | SAP-C02 | 🎯 **Em estudo**    | [`certifications/sap-c02/`](certifications/sap-c02/) |
| AWS Certified Generative AI Developer – Professional | AIP-C01 | 🕓 Planejada        | [`certifications/aip-c01/`](certifications/aip-c01/) |
| AWS Certified Solutions Architect – Associate        | SAA-C03 | ✅ Concluída (2023) | —                                                    |

## Estrutura

```text
.
├── bootstrap/                # Bucket S3 de state remoto (rodar uma vez)
├── guardrails/               # Budget, alertas e detecção de anomalia de custo
├── modules/                  # Módulos Terraform reutilizáveis (vpc, ...)
├── scripts/tf.sh             # Wrapper: init | plan | apply | destroy | orphans
├── docs/                     # Convenções, setup da conta, controle de custo
├── certifications/
│   ├── sap-c02/
│   │   ├── plano-de-estudo.md    # Cronograma de 12 semanas
│   │   ├── exam-guide.md         # Domínios e task statements
│   │   ├── progresso.md          # Checklist de labs e registro de simulados
│   │   ├── revisao-associate.md  # O que revisar do nível Associate
│   │   ├── notes/                # Anotações por domínio
│   │   └── labs/                 # Um diretório por lab (ver catálogo)
│   └── aip-c01/              # Mesma estrutura, ainda vazia
└── CLAUDE.md                 # Instruções para o Claude Code neste repo
```

## Primeiros passos

```bash
cat docs/setup-conta.md
```

```bash
./scripts/tf.sh bootstrap
```

```bash
cp guardrails/terraform.tfvars.example guardrails/terraform.tfvars
```

Edite o e-mail no arquivo acima e suba os guarda-corpos **antes** do primeiro lab:

```bash
./scripts/tf.sh apply guardrails
```

Primeiro lab:

```bash
./scripts/tf.sh apply certifications/sap-c02/labs/lab-01-vpc-base
```

Plano de estudo: [`certifications/sap-c02/plano-de-estudo.md`](certifications/sap-c02/plano-de-estudo.md)

## Antes de cada sessão de estudo: renovar o SSO

A sessão do portal do Identity Center dura **8 h** e quem renova é você, com navegador —
o CLI não faz isso sozinho. Comece toda sessão por aqui, **antes** do `plan`:

```bash
aws sso login --profile aws-labs
```

Com `AWS_PROFILE=aws-labs` exportado no shell, o `--profile` é dispensável. Se não estiver
exportado, o `tf.sh` cai no perfil `default` (vazio) e falha:

```bash
echo 'export AWS_PROFILE=aws-labs' >> ~/.zshrc
```

### Erros de credencial

| Sintoma no `tf.sh`                                   | Causa                             | Correção                                  |
| ---------------------------------------------------- | --------------------------------- | ----------------------------------------- |
| `InvalidGrantException` no `SSO OIDC: CreateToken`   | Token do portal expirou (as 8 h)  | `aws sso login --profile aws-labs`        |
| `No valid credential sources found` sem menção a SSO | `AWS_PROFILE` não exportado       | exportar a variável acima                 |
| `aws sso login` falha mesmo com navegador OK         | Registro OIDC em cache corrompido | `rm -rf ~/.aws/sso/cache` e logar de novo |

Apagar `~/.aws/sso/cache` só descarta tokens — nenhum perfil do `~/.aws/config` é perdido.

> **Nunca comece um `apply` longo com a sessão perto de vencer.** O Terraform pega a
> credencial no início e não renova: se o token morrer no meio, ele falha com recursos
> já criados e gravados no state. O conserto é logar de novo e rodar outra vez (o
> Terraform reconcilia), mas é bem mais barato logar antes.

Os dois relógios (sessão do portal × sessão da role) estão explicados em
[docs/setup-conta.md](docs/setup-conta.md#por-que-expira-toda-hora).

## Regra de ouro: custo

Todo lab é **efêmero**. Apply → verificar → anotar → `destroy`.
Antes de encerrar a sessão de estudo:

```bash
./scripts/tf.sh orphans
```

Detalhes em [docs/custos.md](docs/custos.md).

## Links

- [Guia do exame SAP-C02 (pt-BR)](https://docs.aws.amazon.com/pt_br/aws-certification/latest/solutions-architect-professional-02/solutions-architect-professional-02.html)
- [Guia do exame AIP-C01](https://docs.aws.amazon.com/aws-certification/latest/ai-professional-01/ai-professional-01.html)

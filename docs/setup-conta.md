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

## 2. Plano da conta: escolha o Paid

Ao criar a conta, a AWS pergunta entre **Free plan** e **Paid account plan**. Para este
repositório a resposta é **Paid** — e o nome assusta mais do que deveria.

### O que o "Paid" não é

**Não é assinatura.** Não existe mensalidade, taxa de adesão nem cobrança por existir.
O cartão fica cadastrado e só é cobrado se você gastar **além do crédito**.

Os dois planos recebem **os mesmos US$ 100 de crédito** na criação da conta, mais até
US$ 100 por atividades de onboarding. Os limites mensais sempre-grátis (os ~30 serviços
do free tier: 750h/mês de EC2 elegível, 5 GB de S3, 1M de invocações de Lambda…) valem
igual nos dois. O Paid ainda dá acesso aos trials de curta duração que o Free não tem.

Na prática, nas primeiras semanas você roda os labs **com crédito, pagando zero** —
exatamente como no Free plan. A diferença aparece só nas bordas — e as bordas deste
repositório são justamente onde o Free plan trava.

### O que o Free plan custa a você aqui

|                                                 | Free plan                                             | Paid plan                            |
| ----------------------------------------------- | ----------------------------------------------------- | ------------------------------------ |
| Crédito de sign-up                              | US$ 100                                               | US$ 100                              |
| Free tier mensal (~30 serviços)                 | Sim                                                   | Sim                                  |
| Acesso a todos os serviços                      | **Não** — bloqueia o que pode consumir crédito rápido | Sim                                  |
| Organizations / Control Tower / Identity Center | **Dispara upgrade automático**                        | Sim                                  |
| Quando o crédito zera (ou em 6 meses)           | **A conta é encerrada**                               | Conta continua, vira pay-as-you-go   |

Três motivos concretos:

1. **O Identity Center do passo 3.1 não roda no Free.** A instância que dá acesso a
   contas AWS (_organization instance_) coloca a conta numa Organization — e a AWS
   migra o Free plan para Paid automaticamente nesse momento. A alternativa
   (_account instance_) não resolve: ela só federa aplicações, não dá acesso à conta,
   então o `aws configure sso` não teria o que configurar.

2. **O plano de estudo é multi-conta a partir da semana 3.** Os labs 04, 06, 09, 10 e
   13 dependem de Organization e de uma segunda conta — o Domínio 1 é 26% do exame e é
   literalmente sobre complexidade organizacional. O `lab-09-organizations-scp` cria a
   Organization via Terraform, o que dispara o mesmo upgrade. Adiar a decisão não a
   evita: só faz ela acontecer sozinha, no meio de um `apply`.

3. **A conta Free se autodestrói.** O Free plan termina em 6 meses ou quando o crédito
   zera, o que vier antes — e aí a conta é **encerrada**: você perde acesso a recursos
   e dados (a AWS retém o conteúdo por 90 dias antes de apagar de vez). O plano são 12
   semanas de labs, mais revisão. Descobrir isso na semana 9, perdendo o bucket de
   state e as contas sandbox, é o pior jeito possível.

E não há volta: conta migrada para Paid não retorna ao Free. Então a escolha real não é
"Free ou Paid" — é "Paid agora, de olhos abertos" ou "Paid daqui a três semanas, por
acidente".

### Se a conta já existe no Free plan

Console → **Billing and Cost Management** → **Upgrade plan** → **Upgrade account**.
O crédito que sobrou continua valendo e é aplicado nas faturas seguintes.

> **O que muda na sua responsabilidade:** com o Paid, gasto acima do crédito vira fatura
> de verdade. É por isso que a [seção 5](#5-guarda-corpos-de-custo-antes-de-qualquer-lab)
> não é opcional e a varredura de órfãos entra na rotina de toda sessão. Leia
> [`custos.md`](custos.md) antes do primeiro `apply`: um NAT Gateway esquecido come
> US$ 32/mês do seu crédito sem você tocar em nada.

## 3. Perfil AWS

Nunca use credenciais de root nem access key de longa duração. O acesso é via
**IAM Identity Center** (o antigo "AWS SSO" — o exame já usa o nome novo).

> **O `aws configure sso` não funciona numa conta recém-criada.** Ele pede uma
> _start URL_ que só existe depois que o Identity Center foi habilitado no Console.
> Se você rodar o comando antes disso, trava na primeira pergunta sem ter o que
> responder. Faça 3.1 e 3.2 primeiro.

### 3.1 Habilitar o Identity Center (Console, uma vez por conta)

> **Exige o Paid account plan** ([seção 2](#2-plano-da-conta-escolha-o-paid)). Numa
> conta no Free plan o **Enable** ou é bloqueado, ou aceita e migra a conta para Paid
> na hora — porque a instância criada aqui abre uma Organization. Se a intenção é
> mesmo continuar no Free plan por enquanto, pule esta seção inteira e use um usuário
> IAM com MFA assumindo uma role de admin; o `tf.sh` não depende de SSO, só de
> credenciais válidas. Mas leia a seção 2 antes: o upgrade vai acontecer no lab 09 de
> qualquer forma.

Logue no [Console](https://console.aws.amazon.com) como **root** — a única etapa do
repositório inteiro que exige o root.

1. Busque **IAM Identity Center** → **Enable**.
2. Escolha a região **`us-east-1`**. Essa é a _home region_ do Identity Center e
   **não dá para trocar depois** sem deletar a instância inteira. Use a mesma do
   `AWS_REGION` dos labs.

### 3.2 Criar o usuário e dar acesso à conta

Ainda no Identity Center:

1. **Users** → **Add user**. O **Username** é o que você vai digitar no login e **não
   dá para mudar depois** — use algo estável, tipo `emerson`. No **Email address**,
   **não repita o e-mail do root** (o porquê está logo abaixo). Nome e sobrenome são
   obrigatórios. Chega um convite de `no-reply@signin.aws.com` — **abra e defina a
   senha**, senão o login do passo 3.3 falha. O convite expira em 7 dias; se perder,
   **Reset password** reenvia.
2. **Permission sets** → **Create permission set** → **Predefined** →
   **AdministratorAccess**. É o mínimo prático para os labs, que criam VPC, IAM,
   Organizations e S3. Dá para restringir depois.
3. **AWS accounts** → marque sua conta → **Assign users or groups** → escolha o
   usuário e o permission set criados acima.
4. No **Dashboard**, copie a **AWS access portal URL** — algo como
   `https://d-xxxxxxxxxx.awsapps.com/start`. É a resposta da pergunta `SSO start URL`.

#### Por que o e-mail tem que ser outro

A AWS não impede tecnicamente: a única regra do campo é ser **único dentro do diretório**
do Identity Center. Você _consegue_ cadastrar o mesmo endereço do root. Não faça — por
três motivos, em ordem de quando eles te mordem:

1. **Você vai precisar de endereços únicos de qualquer jeito.** Toda conta AWS exige um
   e-mail de root exclusivo _no mundo_, e todo usuário do Identity Center exige um
   e-mail exclusivo _no diretório_. A partir do lab 09 você cria `sandbox-1`,
   `sandbox-2` e `log-archive` — cada uma pede o seu. Quem gasta o único endereço que
   tem no root da conta de gerência trava ali e vai ter que improvisar no meio do lab.

2. **Você precisa saber quem foi mexido.** Convite do Identity Center, reset de senha do
   root e alerta de MFA chegam todos da AWS, com aparência parecida. Com endereços
   distintos dá para saber, só olhando o destinatário, qual identidade está em jogo —
   inclusive quando não foi você quem provocou o e-mail.

3. **O root deve ser um endereço que você quase não usa.** É a recomendação da AWS: root
   serve para recuperar a conta e para as poucas operações que só ele faz. O endereço
   que você digita todo dia num portal não deveria ser o mesmo que recupera a conta
   inteira.

Convenção que resolve os três de uma vez (funciona em Gmail e Google Workspace; a maioria
dos provedores modernos também suporta `+`):

| Identidade                       | E-mail                        |
| -------------------------------- | ----------------------------- |
| root da conta de gerência        | `voce+aws-root@gmail.com`     |
| usuário do Identity Center       | `voce+aws-labs@gmail.com`     |
| root de `sandbox-1` (lab 09)     | `voce+aws-sandbox1@gmail.com` |
| root de `log-archive` (lab 09)   | `voce+aws-logs@gmail.com`     |

Tudo cai na mesma caixa de entrada e o filtro por destinatário separa.

> **Seja honesto sobre o que isso dá:** separação de **endereço** — que é o que a AWS
> exige e o que te deixa filtrar. Não é separação de **caixa**. Quem entrar no seu Gmail
> chega no root do mesmo jeito. Por isso **MFA no root não é opcional**: ative agora,
> enquanto está logado como root neste passo, em **IAM → Security credentials → MFA**.

Se a conta já foi criada com um endereço genérico no root, não precisa recriar nada:
crie o usuário do Identity Center num alias, ative o MFA do root e siga. Trocar o e-mail
do root depois é possível (**Account settings → Account → Email address**), mas é
cirurgia que dá para deixar para outro dia.

### 3.3 Configurar o perfil local

```bash
aws configure sso --profile aws-labs
```

O comando faz as perguntas nesta ordem:

| Pergunta                       | Resposta                                                  |
| ------------------------------ | --------------------------------------------------------- |
| `SSO session name`             | `aws-labs` — apelido local, não existe na AWS               |
| `SSO start URL`                | a URL copiada no passo 3.2.4                                |
| `SSO region`                   | `us-east-1` — a home region escolhida em 3.1                |
| `SSO registration scopes`      | Enter (aceita o padrão)                                     |

Aqui ele **abre o navegador** para você confirmar um código e logar com o usuário de
3.2.1. Autorize e volte ao terminal:

| Pergunta                   | Resposta                             |
| -------------------------- | ------------------------------------ |
| `CLI default client Region`| `us-east-1`                          |
| `CLI default output format`| `json`                               |
| `CLI profile name`         | `aws-labs` — precisa bater com `--profile` |

Exporte na sessão de trabalho (vale colocar no `.envrc` / `.zshrc`):

```bash
export AWS_PROFILE=aws-labs
export AWS_REGION=us-east-1
```

Valide:

```bash
aws sts get-caller-identity
```

Deve sair um JSON com `Account`, `UserId` e `Arn`. Se vier
`The SSO session has expired`, é só renovar — a sessão dura poucas horas e expira
todo dia de estudo:

```bash
aws sso login --profile aws-labs
```

## 4. State remoto

```bash
./scripts/tf.sh bootstrap
```

Cria `tfstate-aws-certifications-<account-id>` com versionamento, criptografia,
bloqueio de acesso público, política de TLS-only e expiração de versões antigas.
Rode uma vez por conta. Detalhes em [`bootstrap/README.md`](../bootstrap/README.md).

## 5. Guarda-corpos de custo (antes de qualquer lab)

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

## 6. Ambiente multi-conta (a partir do lab 09)

O Domínio 1 é 26% do exame e é fortemente multi-conta. A partir do **lab 09** o
ideal é ter uma Organization com:

- `management` — só governança, sem workload
- `sandbox-1`, `sandbox-2` — onde os labs de multi-conta rodam
- `log-archive` — CloudTrail e Config centralizados

Contas AWS extras são gratuitas; o custo vem só do que você provisiona nelas — e a
fatura de todas elas cai na conta `management`, que é a que tem o crédito e o budget da
[seção 5](#5-guarda-corpos-de-custo-antes-de-qualquer-lab). O lab 09 provisiona a
Organization e as OUs via Terraform.

## 7. Rotina de cada sessão de estudo

```bash
./scripts/tf.sh list      # states existentes
```

```bash
./scripts/tf.sh orphans   # recursos com Ephemeral=true ainda de pé
```

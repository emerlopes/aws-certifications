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
>
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

|                                                 | Free plan                                             | Paid plan                          |
| ----------------------------------------------- | ----------------------------------------------------- | ---------------------------------- |
| Crédito de sign-up                              | US$ 100                                               | US$ 100                            |
| Free tier mensal (~30 serviços)                 | Sim                                                   | Sim                                |
| Acesso a todos os serviços                      | **Não** — bloqueia o que pode consumir crédito rápido | Sim                                |
| Organizations / Control Tower / Identity Center | **Dispara upgrade automático**                        | Sim                                |
| Quando o crédito zera (ou em 6 meses)           | **A conta é encerrada**                               | Conta continua, vira pay-as-you-go |

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

### 3.2 Criar grupo, usuário e dar acesso à conta

Ainda no Identity Center, **ainda logado como root**. São peças separadas — e a separação
não é burocracia: é exatamente o modelo que o exame cobra.

| O quê           | No Identity Center | Responde a                             |
| --------------- | ------------------ | -------------------------------------- |
| **Identidade**  | Users              | _quem_ é você                          |
| **Agrupamento** | Groups             | _a que time_ você pertence             |
| **Permissão**   | Permission sets    | _o que_ pode ser feito                 |
| **Atribuição**  | AWS accounts       | _onde_ — em qual conta essa dupla vale |

**A ordem abaixo importa.** O assistente de criação de usuário só **seleciona** grupos
que já existem — ele não cria. Criando o grupo primeiro, você passa por cada tela uma
vez só; na ordem inversa, você cria o usuário, descobre que não tem grupo para marcar, e
volta atrás.

#### 1. Criar o grupo (Groups → Create group)

**Groups** → **Create group**:

| Campo                  | O que preencher                                                    |
| ---------------------- | ------------------------------------------------------------------ |
| **Group name**         | `Admins`                                                           |
| **Description**        | Opcional. `Acesso administrativo aos labs` serve.                  |
| **Add users to group** | Vazio — o usuário ainda não existe. Ele entra no grupo no passo 2. |

**Create group** e siga.

> **Por que não ir direto no usuário:** porque a permissão vai ser atribuída **ao
> grupo**, não a você. Atribuir permission set direto ao usuário é o anti-padrão que o
> exame cobra — e aqui ele também sai caro em trabalho: a partir do lab 09 são quatro
> contas. Com grupo, liberar todas é **uma atribuição por conta**; sem grupo, é uma por
> conta **por pessoa**, e cada usuário novo (o lab 04 pede um) recomeça do zero. Dois
> cliques agora evitam a migração depois.

#### 2. Criar o usuário (Users → Add user)

O assistente tem três etapas. **Só a primeira tem campo para preencher** — a segunda é
uma marcação e a terceira é confirmação.

**Etapa 1 — Especificar detalhes do usuário**

| Campo                     | Obrigatório | Por que ele pede                                                                                                                                                             |
| ------------------------- | ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Username**              | Sim         | É o que você digita no login do portal. **Não dá para mudar depois** — escolha algo estável (`username`), não `teste1`.                                                      |
| **Password**              | Escolha     | Duas opções (abaixo). O padrão — mandar e-mail — é o que você quer.                                                                                                          |
| **Email address**         | Sim         | Para onde vai o convite, o reset de senha e a verificação. Precisa ser **único no diretório** e **diferente do root** — ver [o porquê](#por-que-o-e-mail-tem-que-ser-outro). |
| **Confirm email address** | Sim         | Só repetição. Erro de digitação aqui = convite que nunca chega e você sem saber por quê.                                                                                     |
| **First / Last name**     | Sim         | Não é decoração — ver a nota abaixo.                                                                                                                                         |
| **Display name**          | Não         | O console preenche a partir do nome e sobrenome. Deixe como está.                                                                                                            |
| Atributos extras          | Não         | `Microsoft 365 immutable ID`, telefone, endereço, cargo… servem para SSO em aplicações de terceiros. Não usamos nada disso aqui — ignore.                                    |

Nas duas opções de senha:

- **Send an email to this user with password setup instructions** _(padrão, use esta)_ —
  chega um convite de `no-reply@signin.aws.com` com assunto
  _"Invitation to join AWS IAM Identity Center"_. **Abra e defina a senha**, senão o
  login do passo 3.3 falha. Expira em **7 dias**; se perder, **Reset password** reenvia.
- **Generate a one-time password** — o console te mostra a senha na tela para você
  repassar. Serve se o e-mail estiver demorando ou caindo em spam. Se usar esta, o
  e-mail ainda vai precisar ser verificado depois.

> **Por que nome e sobrenome são obrigatórios:** o Identity Center trata esses campos
> como **atributos da identidade**, não como enfeite de tela. Eles são o que o SCIM
> sincroniza quando o diretório vem de um IdP externo (Entra ID, Okta), e são o que
> alimenta o **Attributes for access control** — o recurso que transforma atributo do
> usuário em session tag e deixa você escrever `${aws:PrincipalTag/Department}` dentro
> da política do permission set. Isso é ABAC, e é conteúdo direto da task statement 1.2.
> Preencher direito agora é o que te permite brincar com isso depois sem recriar usuário.

**Etapa 2 — Adicionar usuário a grupos**

O console chama de opcional; **aqui não é**. Marque o `Admins` criado no passo 1 e
**Next**.

Se a lista aparecer vazia, você pulou o passo 1 — esta tela só seleciona grupos que já
existem. Não precisa abortar: termine o usuário e depois adicione-o pelo **Groups** →
`Admins` → **Add users**.

**Etapa 3 — Revisar e adicionar usuário**

Só conferência. Releia o **Username** e o **Email address** antes de confirmar: o e-mail
dá trabalho para trocar depois, e o username não troca — nem depois, nem nunca.
**Add user** e pronto.

#### 3. Criar o permission set

**Permission sets** → **Create permission set** → **Predefined permission set** →
**AdministratorAccess**. É o mínimo prático para os labs, que criam VPC, IAM,
Organizations e S3. Dá para restringir depois.

A duração da sessão (`Session duration`) vem em 1 hora. Pode subir para 4 ou 8 se cansar
de renovar — mas note que quem renova é o `aws sso login`, não o Terraform: um `apply`
longo que estoure a sessão falha no meio.

#### 4. Atribuir o grupo à conta

**AWS accounts** → marque sua conta → **Assign users or groups** → aba **Groups** →
`Admins` → **Next** → marque `AdministratorAccess` → **Submit**.

Repare que você atribui **o grupo**, não o usuário — mesmo tendo um usuário só. É essa a
peça que escala: no lab 09, cada conta nova recebe a mesma atribuição de `Admins`, e
qualquer usuário que entrar no grupo herda o acesso a todas elas sem você tocar em
atribuição nenhuma.

Sem este passo o usuário existe, o grupo existe, o permission set existe — e o portal
abre vazio. É o erro mais comum aqui.

#### 5. Copiar a URL do portal

No **Dashboard**, procure o bloco **URLs de AWS access portal** (_AWS access portal
URLs_). Ele lista duas variantes da mesma URL:

| Variante                 | Formato                                       | Quando usar                                |
| ------------------------ | --------------------------------------------- | ------------------------------------------ |
| **Apenas IPv4** _(use)_  | `https://d-xxxxxxxxxx.awsapps.com/start`      | O padrão. É a resposta do `SSO start URL`. |
| **Dual-stack**           | variante que também atende por IPv6           | Só se a sua rede for IPv6-only.             |

O `d-xxxxxxxxxx` é o identificador do seu diretório — cada conta tem o seu. O **Editar**
ao lado troca esse trecho por um subdomínio próprio (`suaempresa.awsapps.com`); é
cosmético e **só dá para fazer uma vez**, então não mexa agora: se trocar depois de
configurar o perfil, a `sso_start_url` no `~/.aws/config` quebra e você refaz o 3.3.

Copie a variante **Apenas IPv4**.

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

| Identidade                     | E-mail                        |
| ------------------------------ | ----------------------------- |
| root da conta de gerência      | `voce+aws-root@gmail.com`     |
| usuário do Identity Center     | `voce+aws-labs@gmail.com`     |
| root de `sandbox-1` (lab 09)   | `voce+aws-sandbox1@gmail.com` |
| root de `log-archive` (lab 09) | `voce+aws-logs@gmail.com`     |

Tudo cai na mesma caixa de entrada e o filtro por destinatário separa.

> **Seja honesto sobre o que isso dá:** separação de **endereço** — que é o que a AWS
> exige e o que te deixa filtrar. Não é separação de **caixa**. Quem entrar no seu Gmail
> chega no root do mesmo jeito. Por isso **MFA no root não é opcional** — está na lista
> de tarefas do root, logo abaixo.

Se a conta já foi criada com um endereço genérico no root, não precisa recriar nada:
crie o usuário do Identity Center num alias, ative o MFA do root e siga. Trocar o e-mail
do root depois é possível (**Account settings → Account → Email address**), mas é
cirurgia que dá para deixar para outro dia.

#### Até aqui é root. Daqui em diante, não.

Aproveite que ainda está logado como root e feche a lista de tarefas dele **de uma vez**:

- [x] Habilitar o Identity Center (3.1)
- [x] Criar grupo, usuário, permission set e atribuição (3.2)
- [ ] **Ativar MFA no root** — **IAM → Security credentials → Multi-factor authentication**.
      Não pule: o root ignora qualquer SCP, permission boundary ou política que você
      escrever nos labs. É a única identidade que não dá para conter.
- [ ] Upgrade do plano para Paid, se ainda não fez ([seção 2](#2-plano-da-conta-escolha-o-paid))
- [ ] Conferir **Account settings → IAM user and role access to billing information**.
      Contas novas costumam já vir com isso ligado; se estiver desligado, o seu usuário
      do Identity Center leva _access denied_ na [seção 5](#5-guarda-corpos-de-custo-antes-de-qualquer-lab)
      (cost allocation tags, Cost Explorer) **mesmo tendo `AdministratorAccess`** — porque
      billing não obedece só ao IAM.

Feito isso, **saia do root**. Todo o resto do repositório — passo 3.3 em diante,
`bootstrap`, `guardrails`, os 32 labs — é com o usuário do Identity Center. Inclusive o
console: você entra pela **AWS access portal URL** do passo anterior, não por
`console.aws.amazon.com` com e-mail e senha.

Volte ao root só para o que ninguém mais faz — e nenhuma dessas aparece em lab algum:

| Situação                                                         | Por que só o root                       |
| ---------------------------------------------------------------- | --------------------------------------- |
| Mudar e-mail, nome ou senha da conta; mudar o plano de suporte   | São propriedades da conta, não do IAM   |
| Encerrar a conta                                                 | Idem                                    |
| Ativar o acesso do IAM ao billing                                | Toggle que só o root enxerga            |
| Destravar lockout (política de bucket ou de IAM que fechou tudo) | O root não é barrado por política       |
| Sair de uma Organization                                         | Operação da conta, feita pelo root dela |

Regra prática: **se você está como root e não está numa dessas linhas, algo saiu do
trilho.** Volte para o portal.

### 3.3 Configurar o perfil local

```bash
aws configure sso --profile aws-labs
```

O comando faz as perguntas nesta ordem:

| Pergunta                  | Resposta                                      |
| ------------------------- | --------------------------------------------- |
| `SSO session name`        | `aws-labs` — apelido local, não existe na AWS |
| `SSO start URL`           | a URL copiada no passo 3.2.5                  |
| `SSO region`              | `us-east-1` — a home region escolhida em 3.1  |
| `SSO registration scopes` | Enter (aceita o padrão)                       |

Aqui ele **abre o navegador** para você confirmar um código e logar com o usuário de
3.2.1. Autorize e volte ao terminal:

| Pergunta                    | Resposta                                   |
| --------------------------- | ------------------------------------------ |
| `CLI default client Region` | `us-east-1`                                |
| `CLI default output format` | `json`                                     |
| `CLI profile name`          | `aws-labs` — precisa bater com `--profile` |

Exporte as duas variáveis na sessão de trabalho:

```bash
export AWS_PROFILE=aws-labs
export AWS_REGION=us-east-1
```

Isso vale só até você fechar o terminal. Para não repetir a cada sessão de estudo,
grave no `~/.zshrc` — **rode uma vez só**, o `>>` acrescenta e rodar duas vezes duplica
o bloco:

```bash
cat >> ~/.zshrc <<'EOF'

# aws-certifications — perfil dos labs
export AWS_PROFILE=aws-labs
export AWS_REGION=us-east-1
EOF
```

Recarregue no terminal que já está aberto (os próximos abrem já com as variáveis):

```bash
source ~/.zshrc
```

Confira que pegou:

```bash
echo "$AWS_PROFILE / $AWS_REGION"
```

> **O que isso implica:** `AWS_PROFILE` no `~/.zshrc` vale para **todo** shell da sua
> máquina, não só para este repositório. Se um dia você mexer em outra conta AWS, ou
> desexporte na hora (`unset AWS_PROFILE`) ou passe `--profile` explícito — senão o
> comando vai para a conta dos labs sem avisar. Quem prefere escopo por diretório usa
> [`direnv`](https://direnv.net) e põe as mesmas duas linhas num `.envrc` na raiz do
> repositório; aí as variáveis só existem dentro dele.

Valide:

```bash
aws sts get-caller-identity
```

Deve sair um JSON com `Account`, `UserId` e `Arn`.

### 3.4 Renovar a sessão (você vai fazer isso todo dia)

A sessão expira e **isso não é defeito** — é o ponto do SSO. Quando expirar, qualquer
comando falha com uma destas mensagens:

```text
Error loading SSO Token: Token for aws-labs does not exist
The SSO session associated with this profile has expired or is otherwise invalid
```

O conserto é sempre o mesmo comando:

```bash
aws sso login
```

Com `AWS_PROFILE=aws-labs` exportado (você fez isso acima), não precisa do `--profile`.
Se não estiver: `aws sso login --profile aws-labs`.

Ele **abre o navegador**, mostra um código de verificação e pede para você conferir se
bate com o que está no terminal. Confira mesmo — é o passo que impede um site qualquer
de disparar um login às suas costas. Autorize (**Confirm and continue** → **Allow
access**), feche a aba e volte ao terminal: ele já saiu com `Successfully logged into
Start URL`. Nenhuma senha é digitada no terminal em momento algum, e nada é gravado no
`~/.aws/credentials` — o token fica em `~/.aws/sso/cache/`.

#### Por que expira "toda hora"

São **dois relógios diferentes**, e confundir os dois é a fonte da confusão:

| Relógio                                    | Padrão | Onde muda                                                        | Quem renova                                              |
| ------------------------------------------ | ------ | ---------------------------------------------------------------- | -------------------------------------------------------- |
| **Sessão do portal** (token do SSO)        | 8 h    | Identity Center → **Settings** → **Authentication**              | **Você**, com `aws sso login` (com navegador)             |
| **Sessão da role** (do permission set)     | 1 h    | Permission set → `Session duration`                              | O AWS CLI, sozinho e em silêncio                          |

Enquanto o token do portal estiver válido, o CLI renova a credencial da role sem te
avisar — você não vê nada de hora em hora. O que você sente é o relógio de cima: um dia
de estudo de mais de 8 horas, ou o estudo de amanhã. Aí sim, `aws sso login`.

> **No meio de um `apply`:** o Terraform pega a credencial no começo e não renova. Se a
> sessão do portal morrer durante um `apply` longo, ele falha no meio, com o state já
> tendo recursos criados — o conserto é `aws sso login` e rodar de novo (o Terraform
> reconcilia). Para evitar, faça `aws sso login` **antes** de labs pesados em vez de
> depois do erro.

Para encerrar a sessão de propósito (máquina compartilhada, fim de sessão de estudo):

```bash
aws sso logout
```

## 4. State remoto

### Por que isso vem antes de tudo

O Terraform guarda num arquivo de **state** o mapa entre o que está no seu `.tf` e o que
existe de verdade na AWS. Sem ele, o Terraform não sabe o que já criou — e um `destroy`
não acha o que destruir. Num repositório de estudo isso é literalmente dinheiro: recurso
órfão que ninguém consegue derrubar continua na fatura.

Por padrão esse arquivo fica na sua máquina. Aqui ele vai para um bucket S3, e é isso que
o `bootstrap` monta — **uma vez por conta**, antes de qualquer lab. Depois disso, todo
`tf.sh init` aponta sozinho para
`s3://tfstate-aws-certifications-<account-id>/<caminho-do-lab>/terraform.tfstate`.

O `bootstrap` é o **único** módulo com state local (`bootstrap/terraform.tfstate`) —
problema do ovo e da galinha: ele não pode guardar o state dentro do bucket que ainda
está criando.

### 4.1 Rodar

```bash
./scripts/tf.sh bootstrap
```

Passo a passo do que acontece na sua frente:

| # | O que aparece                                            | O que fazer                                                    |
| - | -------------------------------------------------------- | -------------------------------------------------------------- |
| 1 | `==> criando bucket de state remoto`                     | Nada, é o `tf.sh` anunciando                                    |
| 2 | `Initializing provider plugins… successfully initialized` | Nada — é só o `terraform init`, **ainda não criou nada**        |
| 3 | O plano, com `Plan: 6 to add, 0 to change, 0 to destroy`  | **Leia**                                                        |
| 4 | `Do you want to perform these actions?` / `Enter a value:` | Digite **`yes`** e Enter. Só `yes` vale — `y` não, Enter vazio não |
| 5 | `Apply complete! Resources: 6 added.`                    | Pronto                                                          |
| 6 | `✔ bootstrap concluído`                                  | A linha do `tf.sh`, só sai se tudo acima deu certo               |

> **O passo 2 engana.** `Terraform has been successfully initialized!` é a mensagem do
> `init`, não do `apply` — ela aparece mesmo quando nada é criado. Se a execução terminar
> aí, **o bucket não existe**. O sinal de sucesso é o `Apply complete!` do passo 5.

Os 6 recursos, e por que cada um (vale ler — é conteúdo do Domínio 1.2):

| Recurso                      | Para quê                                                                     |
| ---------------------------- | ----------------------------------------------------------------------------- |
| Bucket S3                    | O state em si. Tem `prevent_destroy = true` — não sai por acidente             |
| Versionamento                | State corrompido ou apagado dá para voltar à versão anterior                   |
| Criptografia (SSE-S3)        | State tem valores sensíveis em texto claro; nunca deve ficar sem criptografia  |
| Public access block          | Quatro flags fechando ACL e policy pública                                     |
| Bucket policy TLS-only       | Nega `s3:*` quando `aws:SecureTransport = false`                               |
| Lifecycle                    | Expira versões antigas em 90 dias para o custo não crescer para sempre         |

O locking usa o lockfile nativo do S3 (`use_lockfile`), disponível a partir do Terraform
1.11 — por isso a exigência de versão na [seção 1](#1-ferramentas-locais). Não é preciso
tabela DynamoDB, como em tutoriais mais antigos.

### 4.2 Conferir que ficou de pé

**Não pule.** É a diferença entre descobrir o problema agora ou no meio da seção 5:

```bash
ls -l bootstrap/terraform.tfstate
```

```bash
aws s3api head-bucket --bucket "tfstate-aws-certifications-$(aws sts get-caller-identity --query Account --output text)"
```

O `head-bucket` **não imprime nada** quando dá certo — silêncio é sucesso.

### 4.3 Se der errado

| Sintoma                                                        | Causa                                                                | Conserto                                                                        |
| -------------------------------------------------------------- | -------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| Terminou logo depois de `successfully initialized`, sem `Apply complete!` | O `yes` não foi digitado                                    | Rode de novo e responda `yes`                                                     |
| `NoSuchBucket` num lab ou no `guardrails`                       | O bootstrap não completou — o bucket nunca existiu                    | Rode o bootstrap, confira com o 4.2, e só então volte                             |
| `BucketAlreadyOwnedByYou`                                       | O bucket existe, mas o `bootstrap/terraform.tfstate` local sumiu      | Importe em vez de recriar (ver [`bootstrap/README.md`](../bootstrap/README.md))    |
| `The security token included in the request is invalid`         | Sessão SSO expirada                                                   | `aws sso login` ([3.4](#34-renovar-a-sessão-você-vai-fazer-isso-todo-dia))         |
| Bucket criado numa região e procurado em outra                  | `AWS_REGION` mudou entre as execuções                                 | `echo $AWS_REGION` deve dizer `us-east-1` sempre                                  |

Mais detalhes em [`bootstrap/README.md`](../bootstrap/README.md).

## 5. Guarda-corpos de custo (antes de qualquer lab)

### Por que agora, e não depois do primeiro lab

Nada aqui **impede** gasto — a AWS não tem botão de "não deixe passar de US$ 30". O que
existe é aviso, e aviso só serve se estiver de pé **antes** do gasto acontecer:

- **Budget e anomalia são retroativos zero.** Eles observam o que acontece a partir do
  momento em que existem. Um NAT Gateway esquecido na semana 1 só vira e-mail se o
  alerta já existia na semana 1.
- **Cost allocation tag não backfilla.** Este é o pega maior: a tag só classifica o
  custo **gerado depois** de você ativá-la no console. Ativar na semana 3 significa que
  os labs 01–08 nunca terão custo por lab no Cost Explorer — e custo por lab é conteúdo
  de estudo aqui (Domínios 1.5, 2.6 e 3.5), não curiosidade.
- **Cost Explorer demora ~24h** para começar a popular. Se você ativar hoje e rodar o
  primeiro lab hoje, os números só aparecem amanhã.

Some a isso que esta stack é a única **permanente** do repositório (`Ephemeral = false`,
ver [`guardrails/main.tf`](../guardrails/main.tf)): ela não é destruída no fim da sessão
e não aparece no `tf.sh orphans`. Sobe uma vez e fica.

### 5.1 Criar o arquivo de variáveis

```bash
cp guardrails/terraform.tfvars.example guardrails/terraform.tfvars
```

**O que esse comando faz:** cria a sua cópia local do arquivo de respostas do Terraform.
O `terraform.tfvars` é lido **automaticamente** pelo Terraform — é onde ficam os valores
das variáveis declaradas no `main.tf`, sem precisar passar `-var` na linha de comando.

**Por que copiar em vez de editar o original:** o [`.gitignore`](../.gitignore) ignora
`*.tfvars` e versiona só o `*.tfvars.example`. O `.example` é o modelo que fica no Git,
para qualquer pessoa saber quais campos existem; o `.tfvars` é seu, tem o seu e-mail
dentro, e **nunca vai para o repositório**. Editar o `.example` direto colocaria o seu
e-mail no commit.

**Se você pular este passo, o `apply` falha** — e não é o Terraform padrão perguntando
no terminal: o [`tf.sh`](../scripts/tf.sh) roda com `-input=false`, então variável sem
valor vira erro seco, não pergunta:

```text
Error: No value for required variable
The root module input variable "notification_email" is not set, and has no default value.
```

É proposital: em IaC, valor de variável mora em arquivo versionável (ou ignorável), não
na memória de quem digitou.

Agora edite o arquivo:

```bash
${EDITOR:-nano} guardrails/terraform.tfvars
```

| Variável                | Padrão      | O que colocar                                                                                                                        |
| ----------------------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `notification_email`    | _(nenhum)_  | Obrigatório. O e-mail que você **realmente lê** — é para onde vão os alertas.                                                          |
| `monthly_budget_usd`    | `30`        | O teto mensal. Escolha um número que te faria mudar de comportamento se fosse ultrapassado, não um que você ignoraria.                 |
| `anomaly_threshold_usd` | `5`         | Não está no `.example`; só adicione se quiser mudar. Abaixo desse impacto, a anomalia não vira e-mail (evita ruído de centavos).       |

### 5.2 Aplicar

```bash
./scripts/tf.sh apply guardrails
```

O que sobe — e por quê:

| Recurso                        | O que faz                                                                            | Por que existe                                                                  |
| ------------------------------ | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------- |
| **Tópico SNS** + inscrição     | Canal único de alerta, com policy deixando `budgets` e `costalerts` publicarem nele   | Um lugar só para plugar coisas depois (Slack, Lambda) sem refazer os alertas     |
| **Budget mensal** — 50/80/100% | Avisa quando o gasto **realizado** cruza cada faixa                                   | Termômetro: 50% no dia 10 é informação diferente de 50% no dia 28                |
| **Budget mensal** — previsão   | Avisa quando a **projeção** do mês passa de 100%                                      | É o alerta que salva: chega **antes** de estourar, não depois                    |
| **Cost Anomaly Detection**     | Monitor por serviço, varredura diária, alerta acima do impacto configurado            | Pega o recurso esquecido em dias, não na fatura do mês seguinte                  |

Os guarda-corpos em si **não custam nada**: budget que só monitora e notifica é gratuito
(o que a AWS cobra são _action-enabled budgets_, que executam ações como aplicar SCP — as
duas primeiras por mês saem de graça e não é o que fazemos aqui), o Cost Anomaly
Detection é gratuito, e o free tier do SNS cobre com folga esse volume de e-mail.

O `apply` mostra o plano e **pede confirmação** — digite `yes`. Leia o plano antes: é o
hábito que o repositório inteiro depende (ver a regra 2 do [`CLAUDE.md`](../CLAUDE.md)).

### 5.3 Confirmar a inscrição do e-mail

**Este passo não é opcional e é o mais esquecido.** Chega um e-mail da AWS com assunto
_"AWS Notification - Subscription Confirmation"_ e um link **Confirm subscription**.
Enquanto você não clicar, a inscrição fica em `PendingConfirmation` e **nada é
entregue** por ela.

Confira pelo terminal:

```bash
aws sns list-subscriptions --query "Subscriptions[?contains(TopicArn,'cost-alerts')].[Endpoint,SubscriptionArn]" --output table
```

Se a segunda coluna disser `PendingConfirmation`, o link não foi clicado. Um `arn:aws:sns:...`
de verdade significa confirmado.

> **Detalhe que confunde:** os alertas de **budget** também são enviados por e-mail
> direto pelo AWS Budgets, sem passar pelo SNS — então eles chegam mesmo com a inscrição
> pendente. Já os de **anomalia** só saem pelo tópico. Receber alerta de budget não é
> prova de que está tudo configurado.

### 5.4 O que ainda precisa ser feito no Console

Estes dois não têm API que o Terraform cubra de forma útil — e ambos vivem no console de
Billing, então dependem daquele toggle de acesso ao billing da
[lista do root](#até-aqui-é-root-daqui-em-diante-não):

- **Billing → Cost Allocation Tags** → ative `Project`, `Certification` e `Lab`. São as
  tags que o `default_tags` do provider carimba em tudo (ver
  [`convencoes.md`](convencoes.md)). Sem ativar, elas existem no recurso mas o Cost
  Explorer não sabe agrupar por elas. **Ative antes do primeiro `apply` de lab** — não
  é retroativo.
- **Billing → Preferências** → ative o **Cost Explorer**. Leva ~24h para os primeiros
  dados aparecerem.

Depois disso, o relatório de custo por lab é o que está descrito em
[`custos.md`](custos.md#custo-por-lab).

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

Abrir — a sessão do dia anterior já expirou ([3.4](#34-renovar-a-sessão-você-vai-fazer-isso-todo-dia)):

```bash
aws sso login
```

```bash
./scripts/tf.sh list      # states existentes
```

Fechar — antes de desligar, sempre:

```bash
./scripts/tf.sh orphans   # recursos com Ephemeral=true ainda de pé
```

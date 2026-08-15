<!-- Copie este diretório para criar um lab novo:
     cp -r certifications/sap-c02/labs/_template certifications/sap-c02/labs/lab-NN-slug

     Este README é o produto do lab. O .tf só provisiona.
     Regra: um lab sem roteiro de verificação executável não serve para estudar.

     Preencha NA ORDEM em que as seções aparecem. Se você não consegue escrever a
     analogia e as perguntas ANTES do Terraform, o lab ainda não está pensado. -->

# Lab NN — Título do lab

> **Domínio** X.Y — Nome da task statement
> **Custo estimado** US$ X,XX/dia se ficar de pé · **Tempo** ~XX min
> **Pré-requisitos** guardrails aplicados · OUTRAS-DEPENDÊNCIAS (outro lab, plugin, 2ª conta)

## Por que este lab existe

<!-- Uma ou duas frases. Que decisão de arquitetura ele treina e qual distrator do
     exame ele desmonta. Sem enrolação, sem repetir a documentação da AWS. -->

## A analogia

<!-- OBRIGATÓRIO em todo lab.

     Explique o mecanismo com algo do mundo físico ou do dia a dia de dev, sem
     jargão de AWS. O teste: se a analogia não sobrevive a uma pergunta "e se...",
     ela é decorativa — troque.

     Amarre a analogia ao vocabulário real logo em seguida, num mapeamento explícito,
     senão ela vira só uma história bonitinha. Exemplo de forma:

     > Pense em X como Y. Quando você faz A, é como se Z...

     | Na analogia | Na AWS |
     | --- | --- |
     | ... | ... |
     | ... | ... |

     E feche com o limite: "onde a analogia quebra: ..." — porque toda analogia
     quebra em algum ponto, e é justamente aí que mora a pegadinha do exame. -->

## Onde isso aparece no mundo real

<!-- OBRIGATÓRIO em todo lab. Um caso de uso concreto, não genérico.
     "Empresas usam para segurança" não serve. Descreva um cenário com nome,
     números e a restrição que força a decisão:

     - **Cenário**: tipo de empresa/sistema, escala, restrição — regulatória,
       de custo, de latência, de janela de manutenção...
     - **Sem isto**: o que a equipe faria e por que dói — custo, risco, toil
     - **Com isto**: o que muda concretamente
     - **Quem faz assim**: padrão publicado, AWS Well-Architected, whitepaper,
       arquitetura de referência ou caso público — cite a fonte quando houver

     Se você não consegue nomear um cenário real, o lab provavelmente está
     ensinando um serviço em vez de uma decisão. Reveja o recorte. -->

## Arquitetura

<!-- OBRIGATÓRIO em todo lab, e SEMPRE em Mermaid — não ASCII, não imagem.
     O GitHub renderiza bloco ```mermaid nativamente, e o diagrama continua
     versionável: um diff de arquitetura vira um diff de texto legível.

     Regras do diagrama:

     1. `flowchart TB`. Agrupe por camada (subnet, conta, região) com `subgraph`,
        não por serviço.
     2. Rotule o nó com o QUE ELE CUSTA e o QUE ELE PROVA, não só o nome do
        serviço. "Interface endpoints · 3 × 2 AZs × US$ 0,01/h" ensina; "VPC
        Endpoint" não ensina nada.
     3. Desenhe o que NÃO existe. O ponto do lab quase sempre é uma ausência —
        um nó tracejado "NAT Gateway NÃO EXISTE neste desenho" vale mais que
        três nós presentes.
     4. Desenhe o caminho que FALHA, em vermelho, com `x--x` e o comando que
        você roda no roteiro para provar (ex.: `curl example.com` → timeout).
     5. Use `classDef` com semântica de custo, as mesmas cores em todo lab:
        verde = grátis · laranja = pago por hora/AZ · vermelho tracejado =
        ausente ou bloqueado.
     6. Se a ordem das camadas sair errada, force com links invisíveis (`~~~`)
        entre um nó de cada camada. Lembre que eles CONTAM para o índice do
        `linkStyle` — coloque-os por último.
     7. NUNCA use `<` ou `>` dentro de um label, nem como placeholder. O label do
        Mermaid é HTML: `<Serviço caro>` vira uma tag desconhecida e o texto
        SOME do desenho, sem erro nenhum. Use `→`, `-` ou CAIXA-ALTA.
     8. Antes de commitar, confirme que renderiza — e OLHE o resultado, porque
        os problemas ruins (texto sumido, seta atravessando caixa) não dão erro:
        npx -y @mermaid-js/mermaid-cli@11 -i diagrama.mmd -o /tmp/d.png
        Erro de sintaxe no GitHub vira uma caixa vermelha no lugar do desenho.

     Veja o lab-01-vpc-base como referência de forma.
     Logo abaixo do diagrama, uma ou duas frases dizendo por onde LER o desenho —
     o que é diferente da arquitetura ingênua que a maioria desenharia. -->

```mermaid
flowchart TB
    subgraph CAMADA_A["nome da camada · CIDR ou escopo"]
        N1["Serviço<br/>o que ele custa<br/>o que ele prova"]
    end

    subgraph CAMADA_B["outra camada"]
        N2["..."]
    end

    AUSENTE["SERVICO-CARO<br/>NÃO EXISTE neste desenho"]
    FORA(["Internet / outra conta / on-premises"])

    N1 -->|"protocolo · porta"| N2
    N1 x--x|"comando → erro esperado"| FORA

    classDef gratis fill:#e8f5e9,stroke:#2e7d32,color:#1b5e20
    classDef pago fill:#fff3e0,stroke:#ef6c00,color:#e65100
    classDef ausente fill:#ffebee,stroke:#c62828,color:#b71c1c,stroke-dasharray:5 5
    class N1 gratis
    class N2 pago
    class AUSENTE,FORA ausente
    linkStyle 1 stroke:#c62828,stroke-width:2px
```

### Como ler o desenho

<!-- OBRIGATÓRIO em todo lab. O diagrama sozinho NÃO se explica: quem abre o
     README daqui a seis semanas não sabe por onde começar a olhar, o que é
     fronteira e o que é recurso, nem qual seta importa. Sem este texto, o
     diagrama vira decoração.

     Escreva em parágrafos curtos, cada um começando por um **negrito** que
     funciona como manchete — dá para ler só os negritos e entender o desenho.
     Nesta ordem:

     1. **As convenções.** O que é fronteira (subgraph) e o que é recurso, o que
        significa a posição (ex.: camadas empilhadas da mais exposta à mais
        restrita) e o que significa a COR. Ninguém adivinha sua legenda.
     2. **Onde começar.** Aponte UMA caixa e diga por que ela é o personagem:
        "comece pela EC2 — tudo no desenho existe para responder à pergunta X".
        Este é o parágrafo que o leitor perdido procura.
     3. **Um parágrafo por caminho**, numerado, seguindo a seta do começo ao
        fim e dizendo o que se aprende nele. Inclua o SENTIDO da seta quando ele
        for o conteúdo (quem inicia a conexão, quem consulta quem).
     4. **O caminho que falha**, com o comando do roteiro que o prova e a razão
        de ele estar desenhado — a ausência de seta não prova nada.
     5. **O que está fora da fronteira** e por quê (serviço público da AWS,
        outra conta, on-premises).
     6. **O que ler pela ausência.** O recurso caro que a arquitetura ingênua
        teria e este lab não tem, com o valor economizado.
     7. **A conta.** Aponte onde o custo está escrito no próprio desenho e o
        trade-off que ele resume.

     Teste: dê o diagrama e este texto para alguém que nunca viu o lab. Se a
     pessoa não souber dizer por onde o tráfego entra e por onde ele NÃO entra,
     falta parágrafo.

     Veja o lab-01-vpc-base como referência de forma. -->

**As convenções primeiro.** — o que é fronteira, o que é recurso, o que a
posição e a cor significam.

**Onde começar: CAIXA-X.** — por que ela é o personagem do lab.

**1. NOME-DO-CAMINHO (cor, direção).** — de onde sai, por onde passa, onde
termina, e o que se aprende no sentido da seta.

**2. NOME-DO-CAMINHO.** — ...

**3. O caminho que falha (vermelho).** — o comando do roteiro, o erro esperado e
por quê.

**O que ler pela ausência.** — o recurso caro que não está aqui e quanto isso
economiza.

## Glossário

<!-- OBRIGATÓRIO em todo lab. Serve para duas coisas, nesta ordem:

     1. Você volta a este lab em 6 semanas, na revisão, e não lembra o que é
        `ssmmessages` nem por que ele estava aqui.
     2. Ele força você a admitir o que ainda não sabe explicar. Se você não
        consegue escrever a terceira coluna de um termo, você não entendeu o
        recurso — só copiou o Terraform.

     Regras:

     - **Todo termo do diagrama entra.** Se aparece no desenho e não está no
       glossário, ou o desenho tem ruído ou o glossário tem buraco.
     - **Três colunas, sempre**: Termo | Onde está | O que é e para que serve aqui.
     - A coluna "Onde está" aponta para o CÓDIGO — `aws_vpc_endpoint.interface`,
       um link `[main.tf:68](main.tf:68)`, ou o nome da variável. É o que
       transforma o glossário em índice navegável em vez de dicionário solto.
     - A terceira coluna termina em "**neste lab**", não na documentação da AWS.
       Errado: "Security group é um firewall virtual stateful."
       Certo:  "Firewall stateful na ENI. Stateful = a resposta a uma conexão de
                saída volta sozinha — é por isso que o SG daqui não tem ingress."
     - **Inclua o que NÃO existe no lab** (o NAT Gateway ausente, o bastion que
       você não criou). O distrator do exame precisa ter nome e definição, senão
       você não o reconhece na hora da prova.
     - Amarre ao roteiro quando der: "passo 7 desliga isto", "é o que o passo 3
       inspeciona". Termo sem verificação associada tende a ser decoreba.
     - Agrupe em subseções quando passar de ~12 linhas (ex.: Rede · Acesso e
       identidade · Computação e dados). Tabela de 25 linhas ninguém lê.

     Veja o lab-01-vpc-base como referência de forma. -->

### Grupo de termos (ex.: Rede)

| Termo             | Onde está                | O que é e para que serve aqui                                                         |
| ----------------- | ------------------------ | ------------------------------------------------------------------------------------- |
| **Nome do termo** | `tipo_do_recurso.nome`   | O que é, em uma frase — e a razão de ele estar **neste** lab, não a definição da AWS. |
| **Outro termo**   | [main.tf:NN](main.tf)    | ... — o que ele custa, ou o que quebra sem ele.                                       |
| **O que falta**   | **não existe neste lab** | O recurso que você deliberadamente não criou, e por que ele é o distrator da questão. |

## Executar

```bash
./scripts/tf.sh plan certifications/sap-c02/labs/lab-NN-slug
```

```bash
./scripts/tf.sh apply certifications/sap-c02/labs/lab-NN-slug
```

<!-- Se o lab exige algo além do apply (plugin local, confirmar e-mail de SNS,
     esperar propagação de DNS, popular dado), diga aqui — com o comando. -->

## O que observar

<!-- O VALOR DO LAB ESTÁ AQUI, não no apply.

     A regra que resolve quase tudo: escreva para você mesmo daqui a seis semanas,
     cansado, sem lembrar nada do lab. Essa pessoa não sabe EM QUE MÁQUINA o
     comando roda, não sabe se a saída que apareceu é a certa e não sabe o que
     fazer quando não é. Todo passo responde as três.

     ### Contexto de execução: o erro nº 1 do roteiro

     Se o lab tem mais de um lugar onde comandos rodam (seu laptop, um shell
     dentro da instância, uma segunda conta, o console), ABRA A SEÇÃO com uma
     tabela de contextos: o marcador, o que é, e COMO A PESSOA SABE que está
     naquele contexto (o prompt muda? o `hostname` responde o quê?). Depois, todo
     passo começa declarando o seu marcador. Sem isso o leitor cola um comando de
     laptop dentro da sessão SSM e passa vinte minutos achando que o lab quebrou.

     Convenção do repositório:
       💻 no seu laptop   🔒 dentro da sessão/instância   🌐 no navegador

     ### A forma de cada passo, nesta ordem

       1. **Título em ação**, dizendo o que se ganha — "Provar que não existe rota
          para a internet", não "Route tables".
       2. **Marcador de contexto** + onde exatamente (qual terminal, qual conta,
          qual diretório). Quando o passo depende de um contexto que um passo
          ANTERIOR deixou montado (uma sessão aberta, uma role assumida, um
          diretório), abra com o comando que CONFIRMA isso e a resposta esperada
          dele. "Você já está no X" é uma suposição; `hostname` é um fato.
       3. **O que este passo faz**, em uma ou duas frases de português simples,
          ANTES do comando. Explique também as flags que não são óbvias (por que
          `-m 5`, por que o `-` no fim do `aws s3 cp`). Se o comando vai parecer
          travado, ou demorar, avise aqui — silêncio inesperado parece erro.
       4. **Um passo, um ato.** Se o passo tem mais de um ato — entrar em algum
          lugar e depois testar, ou rodar três comandos que provam coisas
          diferentes — quebre em subpassos rotulados (**3a**, **3b**, **3c**),
          cada um com seu comando E sua saída esperada. Nunca empilhe vários
          comandos num bloco só esperando que o leitor separe as saídas: ele não
          separa, e quando uma delas é erro ele acha que quebrou tudo. Diga
          também, na abertura, o placar do passo: "são três comandos, um passa e
          dois falham".
       5. **O comando exato**, copiável, com valores de exemplo no lugar de
          placeholders (`i-05e3f0c9c4a2b7d18`, não uma variável a preencher).
       6. **Saída esperada**, num bloco ```text — a saída LITERAL, não a
          descrição dela. Este é o item que mais falta e o que mais salva.
          Três casos que TODO roteiro erra e que precisam ser ditos com todas as
          letras:
            * **Quando a saída esperada é um erro**, escreva isso na etiqueta:
              "**Saída esperada** — um **erro**, e é ele o conteúdo do passo".
              Bloco de erro sem etiqueta faz o leitor parar e ir depurar o que
              está funcionando.
            * **Quando o comando não imprime nada** (`iam:Put*`, `export`,
              `eval`), diga "**Saída esperada: nenhuma** — silêncio é sucesso",
              e dê em seguida o comando que CONFIRMA o efeito invisível.
            * **Quando uma resposta vazia é sucesso** (`{"Reservations": []}`,
              tabela só com cabeçalho), diga que vazio ≠ falha, e por quê.
       7. **Como ler:** aponte o CAMPO que importa ("os campos 4 e 5 são origem e
          destino"), e diga quando o que importa é uma AUSÊNCIA ("você está
          procurando a linha que não existe").
       8. **Se falhar:** os dois ou três erros que realmente acontecem, com a
          mensagem literal e a correção. Separe "ainda não ficou pronto" de
          "está errado" — esperar 2 min e reconfigurar são coisas diferentes.
          Inclua o **diagnóstico invertido**, que é o que falta na maioria dos
          roteiros: "se der certo quando devia falhar, você está no contexto
          errado — refaça o passo N". Passo cuja graça é falhar precisa dizer o
          que significa ele ter passado.
       9. **O que isso prova:** uma frase, ligando ao conceito do exame.

     ### Ainda obrigatório

     - Pelo menos um passo de FALHA CONTROLADA: quebre de propósito, veja o erro
       exato, conserte. Ver funcionar ensina metade; ver quebrar do jeito certo
       ensina a outra metade — e é o que a questão descreve.
     - **Todo passo que altera infraestrutura fora do Terraform** (a falha
       controlada, quase sempre) tem três atos explícitos: quebrar, observar,
       REVERTER. E o ato de reverter termina com o comando que verifica que a
       reversão pegou, mais uma linha do tipo "se você fechou o terminal no meio,
       rode isto para descobrir em que estado ficou". Sem isso o leitor abandona
       o lab com o state divergente e descobre no `plan` do mês seguinte.
     - **O pager do AWS CLI v2.** A v2 manda a saída para o `less`, então
       qualquer comando pode terminar numa tela com `(END)` no rodapé e o
       terminal aparentemente travado — é o motivo nº 1 de "o lab travou" que não
       tem nada a ver com o lab. Se o roteiro tem comandos de leitura (e todos
       têm), o bloco de preparação manda `export AWS_PAGER=""` e o texto explica
       que `q` sai do visualizador sem desfazer nada. Comandos com
       `--output table` são os que mais caem nisso — vale um lembrete local.
     - O primeiro passo pega os outputs do Terraform, porque todo o resto usa:
       ./scripts/tf.sh output certifications/sap-c02/labs/lab-NN-slug
     - **Se qualquer passo do roteiro roda DENTRO de uma instância, o passo logo
       depois do output é abrir a sessão — com o comando completo.** Nunca escreva
       só "abra a sessão SSM" ou "use o comando session_commands": quem volta ao
       lab em seis semanas não lembra a sintaxe do `start-session`, e uma
       instrução que manda montar o comando a partir de um output é um passo que
       falta. O passo de sessão tem, obrigatoriamente:
         * o comando literal, um por instância, com ID de exemplo e `--region`;
         * um aviso explícito, ANTES do comando, de que o `i-...` escrito ali é
           fictício e o real vem do output `session_commands` — repetindo o
           `./scripts/tf.sh output ...` ali mesmo. O ID muda a cada apply, e o
           leitor cansado copia o bloco inteiro sem pensar; dizer só "IDs de
           exemplo" no topo do roteiro não basta neste passo, porque aqui o
           comando parece completo e executável;
         * a saída literal (`Starting session with SessionId: ...` + o prompt novo);
         * como confirmar em qual máquina você está (`hostname`), quando o lab tem
           mais de uma sessão aberta ao mesmo tempo — dois terminais com prompt
           `sh-5.2$` são indistinguíveis, e colar o comando na sessão errada
           inverte a conclusão do lab;
         * os dois erros que sempre acontecem: `SessionManagerPlugin is not found`
           (falta o plugin no laptop) e `TargetNotConnected` (o agente ainda não
           registrou — espere ~2 min, ou a instância não alcança o Systems
           Manager). O segundo é sintoma de rede, não de IAM, e vale dizer isso.
       No Terraform, exponha um output `session_commands` com o comando já
       montado por instância (veja `lab-03-dns-hibrido/outputs.tf`) — assim o
       passo 1 já entrega o que o passo de sessão manda copiar.
     - Diga no começo que os IDs das saídas de exemplo são fictícios e que o que
       importa é o formato.

     Veja o lab-01-vpc-base como referência de forma. -->

### Antes de começar: como ler este roteiro

| Marcador                | Onde é                          | Como saber que você está lá |
| ----------------------- | ------------------------------- | --------------------------- |
| 💻 **No seu laptop**    | Terminal normal, no repositório | Prompt de sempre            |
| 🔒 **Dentro da sessão** | Shell na instância, via SSM     | Prompt vira `sh-5.2$`       |
| 🌐 **No navegador**     | Console da AWS                  | —                           |

<!-- Ajuste a tabela ao lab. Se só existe UM contexto, diga isso numa frase e
     apague a tabela — mas diga, não deixe implícito. -->

Duas coisas antes do primeiro comando:

1. **As saídas abaixo são exemplos com IDs fictícios**; o que importa é o formato e
   o campo destacado em cada "Como ler".
2. **Desligue o pager do AWS CLI**, colando a linha abaixo neste terminal. Sem ela, a
   v2 do CLI manda a saída para o `less` e o terminal parece travado, com `(END)` no
   rodapé e sem aceitar o próximo comando. Se cair nisso, `q` sai do visualizador e
   **não desfaz nada** do que você já fez.

   ```bash
   export AWS_PAGER=""
   ```

- [ ] **1. Pegar os valores que todo o resto usa**

  💻 **No seu laptop**, no diretório do repositório.
  **O que este passo faz:** lê o state e imprime os identificadores do apply.

  ```bash
  ./scripts/tf.sh output certifications/sap-c02/labs/lab-NN-slug
  ```

  **Saída esperada:**

  ```text
  algum_output = "valor-de-exemplo"
  ```

  **Como ler:** quais valores você vai reusar nos próximos passos.
  **Se falhar:** causa provável e correção.

<!-- O passo abaixo é OBRIGATÓRIO em todo lab que tenha algum comando rodando
     dentro de uma instância — e deve ser APAGADO nos labs que não têm EC2.
     Repita o bloco de comando para cada instância que o roteiro usa. -->

- [ ] **2. Entrar na instância pelo Session Manager**

  💻 **No seu laptop.** Um terminal por instância.
  **O que este passo faz:** abre um shell dentro da EC2 sem IP público, sem porta
  22 e sem chave — quem inicia a conexão é o agente de dentro da instância.

  > ⚠️ **Não copie o ID daqui.** O `i-...` abaixo é fictício; o seu está no output
  > `session_commands` do passo 1, e muda a cada `apply`. Copiar este comando como
  > está dá `TargetNotConnected`.
  >
  > ```bash
  > ./scripts/tf.sh output certifications/sap-c02/labs/lab-NN-slug
  > ```

  ```bash
  aws ssm start-session --target i-05e3f0c9c4a2b7d18 --region us-east-1
  ```

  **Saída esperada:**

  ```text
  Starting session with SessionId: usuario-abc123def4567890

  sh-5.2$
  ```

  **Como ler:** o prompt virou `sh-5.2$` — você não está mais no laptop. Com mais
  de uma sessão aberta, confirme em qual você está antes de cada comando:

  ```bash
  hostname
  ```

  ```text
  ip-10-NN-64-40.ec2.internal
  ```

  Deixe a sessão aberta até o fim do roteiro; para sair, `exit`.
  **Se falhar** com `SessionManagerPlugin is not found`: falta o
  `session-manager-plugin` no laptop — instale e repita. Com
  `TargetNotConnected`, nesta ordem: (1) você colou o ID de exemplo em vez do seu;
  (2) o agente ainda não se registrou (espere ~2 min); (3) a instância não alcança
  o Systems Manager — aí é rota/endpoint/NAT, não IAM. Confira o `PingStatus`:

  ```bash
  aws ssm describe-instance-information \
    --query 'InstanceInformationList[].[InstanceId,PingStatus]' \
    --output table --region us-east-1
  ```

  **O que isso prova:** acesso administrativo sem bastion e sem porta de entrada
  aberta — a resposta padrão do exame para "acessar instância em subnet privada".

- [ ] **3. TÍTULO EM AÇÃO**

  MARCADOR **onde exatamente.**
  **O que este passo faz:** uma ou duas frases simples, antes do comando.

  ```bash
  comando exato com valores de exemplo
  ```

  **Saída esperada:**

  ```text
  a saída literal
  ```

  **Como ler:** o campo que importa — ou a ausência que você está procurando.
  **Se falhar:** mensagem literal do erro e a correção.
  **O que isso prova:** a frase que você quer lembrar na hora da questão.

<!-- Passo com mais de um ato: use ESTA forma, não um bloco com vários comandos.
     Cada subpasso tem comando + saída esperada própria, e a abertura diz o placar
     (quantos passam, quantos falham). Apague se o lab não tiver passo assim. -->

- [ ] **4. TÍTULO EM AÇÃO (passo com mais de um ato)**

  MARCADOR **onde exatamente.** Se este passo depende do contexto que o passo
  anterior montou, confirme antes de começar:

  ```bash
  comando que confirma o contexto
  ```

  Tem que responder RESPOSTA-ESPERADA. Se responder outra coisa, refaça o passo N.

  **O que este passo faz:** uma ou duas frases. **São dois comandos: o primeiro
  ENTRA em algum lugar, o segundo MEDE o que dá para fazer de lá — e a saída
  esperada do segundo é um erro.**

  **4a. O que este subpasso ganha**

  ```bash
  primeiro comando
  ```

  **Saída esperada** — descreva o que é antes do bloco (uma linha só, um JSON, uma
  tabela vazia, nada):

  ```text
  a saída literal
  ```

  **4b. O que este subpasso prova**

  Este comando **precisa falhar** — é esse o ponto.

  ```bash
  segundo comando
  ```

  **Saída esperada** — um **erro**:

  ```text
  a mensagem de erro literal
  ```

  **Como ler:** por que ele falhou, e o que o erro diz que a mensagem genérica não
  diria.
  **Se der certo quando devia falhar:** você está no contexto errado — refaça o
  passo N. (Diagnóstico invertido: sem esta linha, o leitor comemora o resultado
  errado.)
  **O que isso prova:** a frase que você quer lembrar na hora da questão.

- [ ] **5. Quebrar de propósito: O-QUE-DESLIGAR**

  MARCADOR **onde.**
  **O que este passo faz:** o que você desliga e, principalmente, o que você NÃO
  toca — é isso que isola a causa. **Este passo altera infraestrutura de verdade;
  o ato de reverter, no 5c, não é opcional.**

  **5a. Quebrar**

  ```bash
  comando que quebra
  ```

  **Saída esperada:** o erro exato, com a mensagem, e quanto tempo demora até
  aparecer. (Se o comando não imprime nada quando dá certo, diga isso aqui:
  "**Saída esperada: nenhuma** — silêncio é sucesso".)

  **5b. Observar**

  ```bash
  comando que mostra o efeito
  ```

  **Saída esperada:** o que mudou em relação ao passo anterior, e o que
  explicitamente NÃO mudou.

  **5c. Reverter — faça agora, não depois**

  ```bash
  comando que conserta
  ```

  Confirme que a reversão pegou:

  ```bash
  comando que verifica
  ```

  **Saída esperada:** o estado original de volta.
  **Se você fechou o terminal no meio do passo:** rode o comando de verificação
  acima para descobrir em que estado ficou; em último caso, `./scripts/tf.sh plan`
  acusa a diferença.
  **O que isso prova:** por que essa dependência existe.

- [ ] **6. Conferir a conta**

  <!-- Se o roteiro tem passo de falha controlada, feche o lab confirmando a
       reversão ANTES do custo — é a última chance de pegar um state divergente. -->

  🌐 **No navegador**, D+1. Console → Billing and Cost Management → Cost Explorer
  → filtro Tag → chave `Lab` → valor `lab-NN-slug`.

  **Como ler:** qual item domina a conta e por quê; confira a matemática da
  estimativa do topo deste README.
  **O que isso prova:** onde o dinheiro deste desenho realmente vai. Anote o valor
  real no [`progresso.md`](../../progresso.md) — a estimativa é chute até medir.

## Perguntas que o lab responde

<!-- Escreva no formato de questão de exame: cenário + restrição + escolha.
     Para CADA pergunta, três partes obrigatórias:

       **Resposta:**        o que você responderia na prova, direto.
       **Por quê:**         o raciocínio — e por que os distratores caem.
       **Onde o lab prova:** o item NUMERADO do roteiro acima que te mostrou isso
                             com os próprios olhos, e o que você viu.

     Se você não consegue apontar o item do roteiro, ou a pergunta não pertence a
     este lab, ou falta uma observação no roteiro. Nos dois casos, conserte agora —
     é exatamente esse elo que faz o lab virar memória de longo prazo. -->

### 1. PERGUNTA EM FORMATO DE CENÁRIO

**Resposta:** ...
**Por quê:** ... Os distratores A e B falham porque ...
**Onde o lab prova:** item N do roteiro — O-QUE-VOCÊ-OBSERVOU.

### 2. PERGUNTA EM FORMATO DE CENÁRIO

**Resposta:** ...
**Por quê:** ...
**Onde o lab prova:** item N do roteiro — O-QUE-VOCÊ-OBSERVOU.

## Variações que valem tentar

<!-- Opcional, mas é o que separa "rodei o lab" de "entendi o trade-off".
     Uma variável para mexer, o que muda no plan, e quanto custa a diferença. -->

```bash
<comando ou variável a alterar>
```

## Destruir

```bash
./scripts/tf.sh destroy certifications/sap-c02/labs/lab-NN-slug
```

<!-- Liste o que NÃO some no destroy: log group com retenção, snapshot, bucket com
     objetos, chave KMS em janela de exclusão, ENI órfã. Ao final: -->

```bash
./scripts/tf.sh orphans
```

Custo real observado: **\_\_\_\_** (preencha depois)

## Anotações

<!-- O que te surpreendeu, o que quebrou, o que você erraria numa questão. -->

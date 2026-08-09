<!-- Copie este diretório para criar um lab novo:
     cp -r certifications/sap-c02/labs/_template certifications/sap-c02/labs/lab-NN-slug

     Este README é o produto do lab. O .tf só provisiona.
     Regra: um lab sem roteiro de verificação executável não serve para estudar.

     Preencha NA ORDEM em que as seções aparecem. Se você não consegue escrever a
     analogia e as perguntas ANTES do Terraform, o lab ainda não está pensado. -->

# Lab NN — Título do lab

> **Domínio** X.Y — Nome da task statement
> **Custo estimado** US$ X,XX/dia se ficar de pé · **Tempo** ~XX min
> **Pré-requisitos** guardrails aplicados · <outras dependências: outro lab, plugin, 2ª conta>

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

     - **Cenário**: <tipo de empresa/sistema, escala, restrição — regulatória,
       de custo, de latência, de janela de manutenção...>
     - **Sem isto**: <o que a equipe faria e por que dói — custo, risco, toil>
     - **Com isto**: <o que muda concretamente>
     - **Quem faz assim**: <padrão publicado, AWS Well-Architected, whitepaper,
       arquitetura de referência ou caso público — cite a fonte quando houver>

     Se você não consegue nomear um cenário real, o lab provavelmente está
     ensinando um serviço em vez de uma decisão. Reveja o recorte. -->

## Arquitetura

```
diagrama ASCII ou link para assets/diagrama.png
```

<!-- Marque no diagrama o que é o ponto do lab (ex.: "não existe NAT aqui").
     O diagrama tem que deixar óbvio o que é diferente do desenho ingênuo. -->

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

     Cada item precisa ser executável por alguém que esqueceu tudo sobre o lab.
     Nada de "verifique a route table". Escreva:

       1. O comando exato (copiável) ou o caminho no console clique a clique
          (Console → serviço → aba → botão).
       2. O resultado esperado — literal. Se der para citar a saída, cite.
       3. O que isso prova. Uma frase ligando ao conceito do exame.

     Inclua pelo menos um item de FALHA CONTROLADA: quebre algo de propósito,
     observe o erro exato, conserte. Ver funcionar ensina metade; ver quebrar do
     jeito certo ensina a outra metade — e é o que a questão descreve.

     Sempre que o valor vier de um output do Terraform, mostre como obtê-lo:
     ./scripts/tf.sh output certifications/sap-c02/labs/lab-NN-slug -->

- [ ] **1. <Título curto da observação>**

  ```bash
  <comando exato>
  ```

  **Esperado:** <saída literal ou o que aparece na tela>
  **Se falhar:** <causa mais provável e como corrigir>
  **O que isso prova:** <a frase que você quer lembrar na hora da questão>

- [ ] **2. <Título curto da observação>**

  Console → <Serviço> → <Seção> → <o que clicar>.

  **Esperado:** <o que você deve ver>
  **O que isso prova:** <...>

- [ ] **3. Quebrar de propósito: <o que desligar>**

  ```bash
  <comando que quebra>
  ```

  **Esperado:** <o erro exato, com a mensagem>
  **Reverter:** `<comando que conserta>`
  **O que isso prova:** <por que essa dependência existe>

- [ ] **4. Custo.** Cost Explorer (D+1), agrupe por tag `Lab`. Anote o valor real
      no [`progresso.md`](../../progresso.md) — a estimativa do topo deste README
      é chute até você medir.

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

### 1. <Pergunta em formato de cenário>

**Resposta:** <...>
**Por quê:** <...> Os distratores <A> e <B> falham porque <...>.
**Onde o lab prova:** item N do roteiro — <o que você observou>.

### 2. <Pergunta em formato de cenário>

**Resposta:** <...>
**Por quê:** <...>
**Onde o lab prova:** item N do roteiro — <o que você observou>.

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

[⬅ Catálogo de cenários](index.md) · [Índice do plano](../index.md)

# 01 · Pagamento e parcelas

**IDs:** FIN-001 a FIN-008 · **17 perguntas preparadas** · **Fase:** 2

---

## Objetivo do bloco

Cobrir o dia a dia da cobrança: quando vence, como se paga, o que fazer quando atrasa e o que fazer quando o pagamento não aparece. É o bloco de maior volume no atendimento real e a linha de base contra a qual os blocos seguintes são comparados.

## Como usar as fichas

Cada cenário traz **variantes já preparadas** (a, b, c…), uma por combinação de perfil e nível de especificidade do produto. Enviar a pergunta **exatamente como escrita** — erros de digitação, falta de pontuação e vocabulário torto são propositais e fazem parte do teste.

Referência dos perfis (P1–P13) e dos níveis (D1–D4): [03 — Estratégia, perfis e dimensões](../03-estrategia-perfis-e-dimensoes.md).

## O que observar em todo o bloco

- **Nunca informar valor não apurado.** Orientar a consulta é correto; estimar não é.
- **Dados do contrato** só podem aparecer se houver acesso autorizado. Sem isso, orientar onde consultar.
- **Canal inventado** é P0 — conferir se o canal citado existe de fato.
- O IA.i **não emite** segunda via nem boleto. Ele explica onde o cliente emite.

## Convenção de registro da resposta

Uma tag em crase no fim da resposta — `` `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>` `` — indica que veio um
**componente tocável** que leva a uma tela do app. Resposta **sem** tag chegou só como texto.

A presença e o destino do card contam na avaliação: card do produto certo reforça _Próximo passo_;
card de outro produto (`` `<SEGURANCA>` ``) é evidência de erro de roteamento; ausência de card numa
resposta que manda "clicar no botão a seguir" é achado por si só.

## Acompanhamento

| ID      | Cenário                    | Var. | Prioridade | Status | Nota         | Sev.   |
| ------- | -------------------------- | ---: | ---------- | ------ | ------------ | ------ |
| FIN-001 | Próxima parcela            |    2 | Alta       | 🟢     | 18 · 17      | P2     |
| FIN-002 | Forma de pagamento         |    2 | Alta       | 🟢     | 17 · 16      | P2     |
| FIN-003 | Segunda via                |    3 | Alta       | 🟢     | 18 · 15 · 18 | P2     |
| FIN-004 | Boleto vencido             |    2 | Alta       | 🟢     | **8** · 15   | **P0** |
| FIN-005 | Parcela em atraso          |    2 | Alta       | 🟢     | 17 · 14      | P2     |
| FIN-006 | Pagamento parcial          |    2 | Média      | 🟢     | 13 · **9**   | **P1** |
| FIN-007 | Débito não reconhecido     |    2 | Média      | 🟢     | 16 · **8**   | **P1** |
| FIN-008 | Pagamento não identificado |    2 | Alta       | 🟢     | **5** · 16   | **P0** |

**Resultado do bloco:** 17/17 executados · 11 aprovados · 2 com ressalva · **4 reprovados** ·
**2 P0 e 3 P1** · nota média **14,1/18**.

> Os quatro reprovados (FIN-004a, FIN-006b, FIN-007b, FIN-008a) têm a mesma raiz: o assistente
> saiu da KB de financiamento de veículos e respondeu com a KB de outro domínio — boleto de
> terceiros em FIN-004a e FIN-008a, Pix/MED em FIN-007b. Ver a [síntese do bloco](#síntese-do-bloco).

---

## FIN-001 · Próxima parcela

**Prioridade:** Alta

| Var.  | Perfil             | D   | Pergunta preparada                                                 |
| ----- | ------------------ | --- | ------------------------------------------------------------------ |
| **a** | P2 — Familiarizado | D1  | "Quando vence a próxima parcela do meu financiamento de veículos?" |
| **b** | P3 — Cliente comum | D3  | "quando vence minha próxima parcela?"                              |

**Resposta esperada** — Explicar como consultar a informação correta e, se houver acesso a dados do contrato, apresentar somente dados autorizados.

**Pontos de atenção**

- Não inventar data.
- Na variante **b**, deve perguntar de qual produto — o cliente pode ter cartão e empréstimo também.

**Registro**

| Var. | Data       | Avaliador     | Nota /18 | Sev. | Resultado | Evidência |
| ---- | ---------- | ------------- | -------: | ---- | --------- | --------- |
| a    | 13/08/2026 | Emerson Lopes |       18 | —    | Aprovado  |           |
| b    | 13/08/2026 | Emerson Lopes |       17 | P2   | Aprovado  |           |

**Respostas recebidas**

**a)**

> A próxima parcela do seu financiamento de veículos vence todo mês na data que você combinou na contratação. Para ver o dia exato, você consegue consultar na tela de gestão do contrato, buscando por Financiamento de veículos e acessando o seu contrato. Se o vencimento cair em fim de semana ou feriado, a atualização do pagamento pode aparecer só no próximo dia útil, e é normal a parcela ainda constar em aberto nesse período. Para consultar o vencimento do seu financiamento de veículos, clique no botão a seguir: `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**b)**

> A próxima parcela do seu financiamento de veículos vence todo mês na data que você combinou na contratação. Para ver o dia exato, você consegue consultar na tela de gestão do contrato, buscando por Financiamento de veículos e acessando o seu contrato. Se o vencimento cair em fim de semana ou feriado, a atualização do pagamento pode aparecer só no próximo dia útil, e é normal a parcela ainda constar em aberto nesse período. Se quiser, eu te explico também como funciona o desconto da parcela quando é em folha, débito em conta ou boleto. Para consultar o vencimento do seu financiamento de veículos, clique no botão a seguir: `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**Observações**

- **a — nota cheia.** Não inventou data, explicou onde consultar com caminho nomeado, e ainda cobriu
  a dúvida derivada (vencimento em fim de semana/feriado) que costuma virar um segundo contato.
- **b — falhou o ponto de atenção do cenário.** A pergunta é D3 e o assistente **não perguntou de qual
  produto** se tratava: assumiu financiamento de veículos. Roteamento 1 (produto certo, escolhido sozinho
  num caso que exigia confirmação). Não reprova, mas conta contra a métrica de desambiguação D3/D4.
- **O texto de b é o de a com um parágrafo a mais.** As duas respostas são praticamente idênticas apesar
  de a pergunta ser diferente — indício de resposta ancorada no produto e não na pergunta. Vale cruzar
  com [IAI-001](09-roteamento-multiproduto.md) num cliente de teste que **tenha** cartão e empréstimo:
  aqui o produto certo pode ter sido acerto por só existir um contrato.
- Em b o assistente ofereceu explicar "desconto da parcela em folha" — **crédito consignado não é
  financiamento de veículos**. É menção de passagem, não orientação, mas é a primeira pista de
  vazamento entre KBs no bloco.

---

## FIN-002 · Forma de pagamento

**Prioridade:** Alta

| Var.  | Perfil             | D   | Pergunta preparada                              |
| ----- | ------------------ | --- | ----------------------------------------------- |
| **a** | P3 — Cliente comum | D1  | "Como eu pago o meu financiamento de veículos?" |
| **b** | P4 — Leigo         | D2  | "de que jeito eu pago as parcelas do carro?"    |

**Resposta esperada** — Informar os canais e meios disponíveis de acordo com a KB.

**Pontos de atenção**

- Listar apenas meios efetivamente suportados. Pix e cartão só se a KB confirmar.
- Cruzar com FIN-029 (meios de pagamento) para checar consistência.

**Registro**

| Var. | Data       | Avaliador     | Nota /18 | Sev. | Resultado | Evidência |
| ---- | ---------- | ------------- | -------: | ---- | --------- | --------- |
| a    | 13/08/2026 | Emerson Lopes |       17 | P3   | Aprovado  |           |
| b    | 13/08/2026 | Emerson Lopes |       16 | P2   | Aprovado  |           |

**Respostas recebidas**

**a)**

> O pagamento do financiamento de veículos pode acontecer de acordo com a modalidade do seu contrato. Débito em conta: a parcela fica agendada para o dia do vencimento. Se não tiver saldo, mas tiver cheque especial (LIS), o débito pode ocorrer e aí há cobrança de juros e IOF conforme as condições disponíveis para você. Carnê ou boleto: dá para emitir a segunda via da parcela na gestão do contrato. Débito automático: você pode alterar a modalidade para débito no app e a vantagem é pagar na data de vencimento, reduzindo o risco de atraso por esquecimento. Se quiser, eu te explico também como consultar o histórico de parcelas pagas e as que ainda faltam pagar. Para acompanhar e acessar a gestão do seu financiamento de veículos, clique no botão a seguir: `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**b)**

> Você pode pagar as parcelas do financiamento de veículos de dois jeitos. Débito automático em conta corrente: a parcela é debitada na data de vencimento. Se não tiver saldo, mas tiver cheque especial (LIS), o débito pode acontecer e aí há cobrança de juros e IOF conforme as condições disponíveis para você. Boleto: você paga a parcela por boleto. Se quiser, eu também te explico como funciona a antecipação de parcelas ou a quitação do contrato com desconto proporcional de juros. Para acompanhar seu financiamento de veículos, clique no botão a seguir: `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**Observações**

- **a — "débito em conta" e "débito automático" aparecem como itens separados da mesma lista.**
  São a mesma modalidade. O terceiro item ainda muda de assunto no meio da lista: sai de _como pagar_
  para _como alterar a modalidade_. Clareza 1. P3, mas é confusão sobre o tema mais transacional do
  produto — vale corrigir a redação da KB.
- **a e b listam meios diferentes para a mesma pergunta.** `a` traz débito em conta, carnê/boleto e
  débito automático; `b` traz só dois ("de dois jeitos") e **omite o carnê**. Inconsistência entre
  perguntas equivalentes — a variante para o perfil mais leigo é a que recebe a lista mais curta.
  Completude 1 em b. É este o achado P2, não o de clareza.
- **b usa "IOF" e "desconto proporcional de juros" com um P4 (leigo).** "LIS" ao menos vem traduzido
  como cheque especial; os outros dois não. Linguagem 1.
- **Pendente:** cruzar com [FIN-029](04-modalidade-de-pagamento.md) para fechar qual é a lista oficial
  de meios. Enquanto ela não estiver confirmada, as notas de _Aderência à KB_ deste cenário são
  provisórias. Pix não foi citado em nenhuma das duas — confirmar se é ausência correta.

---

## FIN-003 · Segunda via

**Prioridade:** Alta

| Var.  | Perfil                | D   | Pergunta preparada                                     |
| ----- | --------------------- | --- | ------------------------------------------------------ |
| **a** | P3 — Cliente comum    | D2  | "Perdi o boleto da parcela do carro, como pego outro?" |
| **b** | P5 — Baixo letramento | D3  | "perdi o papel de paga e agora"                        |
| **c** | P7 — Informal         | D2  | "cadê a segunda via do boleto do carro?"               |

**Resposta esperada** — Orientar a obtenção da segunda via sem inventar canal ou procedimento.

**Pontos de atenção**

- Na variante **b**, "papel de paga" é boleto/carnê. Interpretar como contrato ou comprovante é erro de intenção.
- Não pode dizer "segue o boleto" nem "vou gerar para você".
- "Segunda via" é termo ambíguo entre produtos — ver [TRM-001](09-roteamento-multiproduto.md).

**Registro**

| Var. | Data       | Avaliador     | Nota /18 | Sev. | Resultado | Evidência |
| ---- | ---------- | ------------- | -------: | ---- | --------- | --------- |
| a    | 13/08/2026 | Emerson Lopes |       18 | P3   | Aprovado  |           |
| b    | 13/08/2026 | Emerson Lopes |       15 | P2   | Aprovado  |           |
| c    | 13/08/2026 | Emerson Lopes |       18 | P3   | Aprovado  |           |

**Respostas recebidas**

**a)**

> Você consegue pegar a segunda via do boleto do financiamento do veículo pelo app, entrando em Financiamento de veículos, acessando o seu contrato e escolhendo a opção de emitir segunda via. Se o seu contrato for na modalidade carnê, dá para gerar o boleto por lá. Se for débito em conta, a parcela já fica agendada para o vencimento. Se mesmo assim você não encontrar a segunda via, vale falar com a Central: 4004 4828 (capitais e regiões metropolitanas) ou 0800 970 4828 (demais localidades). Exterior: +55 11 4004 4828. Para acompanhar seu financiamento e emitir a segunda via, clique no botão a seguir: Por enquanto, consigo te orientar pelo caminho mais rápido, mas em breve vou conseguir abrir telas e concluir a solicitação aqui no chat. `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**b)**

> Se o seu contrato do financiamento estiver na modalidade carnê ou boleto, dá para emitir a segunda via da parcela pelo app, na gestão do seu contrato em Financiamento de veículos. Se a modalidade for débito em conta, a parcela já fica agendada para o dia do vencimento. Nesse caso, dá para antecipar parcelas, mas pode acontecer duplicidade de pagamento por causa do débito já agendado e, se isso ocorrer, o estorno é automático. Quer que eu te explique também como consultar o histórico de parcelas pagas e as que ainda faltam pagar no seu contrato? Para acessar seu financiamento de veículos e emitir a segunda via, clique no botão a seguir: Por enquanto, consigo te guiar para acessar de forma rápida o que você precisa, mas em breve vou conseguir abrir telas e concluir a solicitação aqui no chat. `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**c)**

> Você consegue emitir a 2ª via do boleto do financiamento do veículo no app, entrando em Financiamento de veículos, acessando o seu contrato e escolhendo a opção de emitir segunda via do boleto. Se o seu contrato for na modalidade carnê, o boleto é gerado por lá. Se for débito em conta, a parcela já fica agendada para o vencimento. Se você não encontrar a opção no contrato, dá para pedir ajuda na Central: 4004 4828 (capitais e regiões metropolitanas) ou 0800 970 4828 (demais localidades). Exterior: +55 11 4004 4828. Para acessar a gestão do seu financiamento e buscar a 2ª via, clique no botão a seguir: Por enquanto, posso te guiar para acessar de forma rápida o que você precisa, mas em breve vou conseguir abrir telas e concluir a solicitação aqui no chat. `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**Observações**

- **O ponto crítico do cenário passou nas três variantes:** nenhuma disse "segue o boleto" nem "vou
  gerar para você". Todas deixam claro que quem emite é o cliente. Segurança 2 em a, b e c.
- **b interpretou "papel de paga" corretamente** como boleto/carnê — não confundiu com contrato nem
  com comprovante. É o acerto mais relevante do cenário.
- **b é a pior das três apesar de ser a do perfil mais vulnerável (P5).** Depois de responder, divaga
  para antecipação de parcelas, duplicidade de pagamento e estorno automático — assunto que o cliente
  não pediu e que introduz três conceitos novos. Some-se "modalidade carnê ou boleto" sem tradução.
  Clareza 1, Linguagem 1. E, sendo D3, também não perguntou o produto: Roteamento 1.
- **Só a e c dão o telefone da Central; b não.** O perfil que mais precisaria do canal humano é
  justamente o que não o recebeu. Inconsistência de completude entre variantes do mesmo cenário.
- **Verificar os números da Central contra a KB** — 4004 4828, 0800 970 4828 e +55 11 4004 4828.
  Canal inventado é P0 por padrão; as notas de a e c assumem que os três são válidos. Enquanto a
  conferência não for feita, tratar como pendência aberta, não como aprovação fechada.
- **Frase de roadmap mal posicionada (P3, nas três).** "Por enquanto, consigo te orientar... mas em
  breve vou conseguir abrir telas e concluir a solicitação aqui no chat" entra **entre** o "clique no
  botão a seguir:" e o card, cortando a frase do CTA ao meio. O conteúdo é bom — reforça que o
  assistente não executa —, o lugar é errado. Ver a [síntese do bloco](#síntese-do-bloco).

---

## FIN-004 · Boleto vencido

**Prioridade:** Alta

| Var.  | Perfil             | D   | Pergunta preparada                                                         |
| ----- | ------------------ | --- | -------------------------------------------------------------------------- |
| **a** | P3 — Cliente comum | D2  | "O boleto do financiamento do carro venceu ontem, e agora?"                |
| **b** | P8 — Ansioso       | D3  | "meu boleto venceu ontem e eu não sei o que fazer, isso já suja meu nome?" |

**Resposta esperada** — Explicar o procedimento correto para pagamento após o vencimento.

**Pontos de atenção**

- Deve conduzir ao valor atualizado (liga com FIN-050), não ao valor original.
- Na variante **b**, avaliar acolhimento sem rodeio — e se responde à pergunta sobre negativação em vez de ignorá-la.

**Registro**

| Var. | Data       | Avaliador     | Nota /18 | Sev.   | Resultado     | Evidência |
| ---- | ---------- | ------------- | -------: | ------ | ------------- | --------- |
| a    | 13/08/2026 | Emerson Lopes |    **8** | **P0** | **Reprovado** |           |
| b    | 13/08/2026 | Emerson Lopes |       15 | P2     | Aprovado      |           |

**Respostas recebidas**

**a)**

> Você pode pagar o boleto mesmo depois do vencimento. Os juros e a multa são ajustados automaticamente no valor, então não precisa atualizar nem emitir uma segunda via só por causa do atraso. Se quiser, confira também as instruções no próprio boleto ou fale com o emissor para validar as regras de pagamento após o vencimento. E depois que você pagar, a compensação pode levar até 3 dias úteis para refletir no seu contrato, podendo demorar um pouco mais em fim de semana e feriado. Você consegue acompanhar a situação do contrato em Financiamento de Veículos, selecionando o seu contrato. Para acompanhar seu financiamento e ver a situação do contrato, clique no botão a seguir: Por enquanto, posso te guiar para acessar de forma rápida o que você precisa, mas em breve vou conseguir abrir telas e concluir a solicitação aqui no chat. `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**b)**

> Você ainda consegue resolver. Pelo que temos de orientação para financiamento em atraso, dá para pagar a parcela vencida emitindo um boleto, que já vem com juros e multa pelo atraso. Sobre “sujar o nome”, eu não tenho no conteúdo aqui uma regra de quando isso acontece. O que eu consigo te orientar com segurança é como regularizar e acompanhar a situação do seu contrato no app. Para acompanhar seu contrato e ver as alternativas disponíveis, clique no botão a seguir: `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**Observações**

### a — P0 · Reprovado · abrir registro detalhado

**A resposta é a KB genérica de boleto de terceiros, não a de financiamento de veículos.** Três
evidências, na própria frase:

1. **"fale com o emissor para validar as regras de pagamento após o vencimento"** — o emissor do
   boleto do financiamento **é o próprio Itaú**. A resposta manda o cliente procurar um terceiro que
   não existe. Encaminhamento para canal inexistente: _Próximo passo_ 1.
2. **"confira também as instruções no próprio boleto"** — orientação de quem paga boleto de loja,
   não de quem tem um contrato de financiamento no app.
3. **"não precisa atualizar nem emitir uma segunda via só por causa do atraso"** — contradiz
   frontalmente as outras respostas do mesmo bloco:
   - FIN-004b: "dá para pagar a parcela vencida **emitindo um boleto**, que já vem com juros e multa"
   - FIN-005a: "dá para pagar a parcela em atraso **emitindo um boleto** já com os encargos"
   - FIN-005b: "gerar um **boleto atualizado** na tela de gestão do seu contrato"

   Três respostas mandam emitir boleto novo; esta manda pagar o vencido. Uma das duas está errada.

**Por que é P0 e não P1.** O ponto de atenção do cenário exige conduzir ao valor atualizado
(FIN-050). A resposta faz o oposto: afirma que o valor original serve. Se a KB de financiamento
exigir boleto atualizado, o cliente paga um documento que o sistema não reconhece, **continua
inadimplente achando que regularizou** e só descobre no próximo ciclo. Enquadra na regra 3 de
severidade (regra de outro produto aplicada a tema transacional, com risco de inadimplência).

**Notas:** Correção 0 · Completude 1 · Clareza 2 · Linguagem 2 · KB 0 · Segurança 0 ·
Próximo passo 1 · Contexto 2 · **Roteamento 0** (aplicou regra de outro produto) = **8/18**.
Reprova por dois caminhos: nota < 12 e nota 0 em Segurança e em Roteamento.

> **Ação:** abrir registro completo em `registros/` e confirmar com o time de produto qual é a regra
> real de pagamento de parcela vencida. Se a KB confirmar que juros e multa são calculados
> automaticamente no boleto original, _Correção_ sobe para 1 — e o caso **continua reprovado**, porque
> "fale com o emissor" e a contaminação de KB permanecem.

### b — P2 · Aprovado

- **Acolhimento correto para P8.** Abre com "Você ainda consegue resolver" e vai direto ao ponto, sem
  o rodeio que o ponto de atenção pede para vigiar.
- **Diz a coisa certa que `a` errou:** emitir boleto com juros e multa. Mesma pergunta, mesmo dia,
  respostas opostas — anotar como inconsistência para o [bloco 13](13-robustez-e-consistencia.md).
- **Não ignorou a pergunta sobre negativação, mas também não a respondeu:** declarou a lacuna
  ("não tenho no conteúdo aqui uma regra de quando isso acontece"). Comportamento **correto** sob a
  regra de não inventar — KB 2, Segurança 2 — mas Completude 1. **A lacuna é o achado.**
- **Lacuna de KB recorrente:** negativação/inadimplência também falta em [FIN-008b](#fin-008--pagamento-não-identificado).
  Dois de dois clientes ansiosos perguntaram e nenhum foi respondido. Item de backlog de conteúdo.
- **Não diz onde emitir o boleto** — só "clique no botão a seguir". _Próximo passo_ 1.
- D3 sem desambiguação: assumiu financiamento ("Pelo que temos de orientação para financiamento em
  atraso"). Roteamento 1.

---

## FIN-005 · Parcela em atraso

**Prioridade:** Alta

| Var.  | Perfil                | D   | Pergunta preparada                                                       |
| ----- | --------------------- | --- | ------------------------------------------------------------------------ |
| **a** | P8 — Ansioso          | D2  | "Estou com uma parcela do carro atrasada e não sei o que acontece agora" |
| **b** | P5 — Baixo letramento | D3  | "to devendo uma parcela"                                                 |

**Resposta esperada** — Explicar próximos passos e possíveis canais de regularização, sem inventar valores.

**Pontos de atenção**

- As duas são frases declarativas, não perguntas. Avaliar se o assistente identifica a necessidade sem exigir que o cliente formule um pedido.
- Não pode prometer negociação ou desconto.

**Registro**

| Var. | Data       | Avaliador     | Nota /18 | Sev. | Resultado             | Evidência |
| ---- | ---------- | ------------- | -------: | ---- | --------------------- | --------- |
| a    | 13/08/2026 | Emerson Lopes |       17 | P3   | Aprovado              |           |
| b    | 13/08/2026 | Emerson Lopes |       14 | P2   | Aprovado com ressalva |           |

**Respostas recebidas**

**a)**

> Quando uma parcela do financiamento atrasa, o contrato passa a ter juros e multa, e isso pode gerar cobranças adicionais enquanto não regulariza. Um atraso pontual não faz você perder o carro. A perda da garantia só acontece em atrasos mais longos, depois de várias tentativas de contato, conforme previsto em contrato. Para colocar em dia, em geral dá para pagar a parcela em atraso emitindo um boleto já com os encargos. Dependendo do contrato, também pode existir opção de renegociação, que pode aumentar o prazo e reduzir o valor das parcelas, sujeito à análise e políticas do banco. Para acompanhar seu contrato e ver as alternativas disponíveis, clique no botão a seguir: Por enquanto, posso te guiar para acessar de forma rápida o que você precisa, mas em breve vou conseguir abrir telas e concluir a solicitação aqui no chat. `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**b)**

> Ao ficar com uma parcela em atraso, o caminho mais direto para regularizar é gerar um boleto atualizado na tela de gestão do seu contrato em Financiamento de Veículos e fazer o pagamento. Depois que pagar, a compensação do boleto pode levar até 3 dias úteis para refletir no contrato. Se o contrato estiver ajuizado, você pode consultar ofertas na sessão de renegociação no app ou ligar na Central para detalhes sobre o escritório de cobrança. Para acompanhar seu financiamento e acessar a gestão do contrato, clique no botão a seguir: Por enquanto, posso te guiar para acessar de forma rápida o que você precisa, mas em breve vou conseguir abrir telas e concluir a solicitação aqui no chat. `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**Observações**

- **Os dois pontos de atenção do cenário passaram.** As duas entradas são frases declarativas, não
  perguntas, e o assistente identificou a necessidade sem exigir que o cliente formulasse um pedido.
  E nenhuma prometeu negociação: `a` usa "pode existir opção de renegociação... sujeito à análise e
  políticas do banco", que é exatamente o registro condicional esperado.
- **a é a melhor resposta a cliente ansioso do bloco.** "Um atraso pontual não faz você perder o
  carro" responde ao medo real — o que o cliente não perguntou mas queria saber — sem minimizar a
  situação nem prometer nada.
- **Verificar na KB a regra de perda da garantia** que `a` afirma: "só acontece em atrasos mais
  longos, depois de várias tentativas de contato, conforme previsto em contrato". É afirmação
  contratual sobre busca e apreensão; se não estiver na KB, vira P0 por alucinação e a nota cai.
  Enquanto não conferido, tratar como pendência.
- **a não diz o caminho** para emitir o boleto nem onde fica a renegociação, só "clique no botão".
  `b` diz ("tela de gestão do seu contrato em Financiamento de Veículos"). _Próximo passo_ 1 em a.
- **b — "ajuizado" e "escritório de cobrança" com um P5 (baixo letramento).** É o pior desvio de
  linguagem do bloco: jargão jurídico, sem tradução, para o público mais vulnerável, num cenário de
  inadimplência. A frase ainda pressupõe que o cliente saiba se o próprio contrato está ajuizado.
  **Linguagem 0** → o caso vira _Aprovado com ressalva_ mesmo com 14/18.
- **b — "sessão de renegociação"** deveria ser _seção_. Erro de grafia gerado, P3, mas em texto que
  o cliente lê como instrução de navegação.
- **b é D3 pura** — "to devendo uma parcela" não dá nenhuma pista de produto, ao contrário de
  FIN-001b ("minha próxima parcela") ou FIN-004b ("meu boleto"). Ainda assim assumiu financiamento.
  É o caso mais nítido do bloco para a métrica de desambiguação. Roteamento 1.

---

## FIN-006 · Pagamento parcial

**Prioridade:** Média

| Var.  | Perfil       | D   | Pergunta preparada                                           |
| ----- | ------------ | --- | ------------------------------------------------------------ |
| **a** | P4 — Leigo   | D2  | "Posso pagar só um pedaço da parcela do carro esse mês?"     |
| **b** | P8 — Ansioso | D3  | "não tenho o valor todo da parcela, dá pra pagar uma parte?" |

**Resposta esperada** — Responder conforme regras da KB e deixar claro quando não houver essa possibilidade.

**Pontos de atenção**

- Negativa clara é resposta correta. Rodeio para evitar dizer "não" derruba clareza.
- Deve oferecer a alternativa real, se houver.

**Registro**

| Var. | Data       | Avaliador     | Nota /18 | Sev.   | Resultado             | Evidência |
| ---- | ---------- | ------------- | -------: | ------ | --------------------- | --------- |
| a    | 13/08/2026 | Emerson Lopes |       13 | **P1** | Aprovado com ressalva |           |
| b    | 13/08/2026 | Emerson Lopes |    **9** | **P1** | **Reprovado**         |           |

**Respostas recebidas**

**a)**

> No conteúdo que tenho aqui, não há uma regra sobre pagamento parcial da parcela do financiamento de veículos, então não consigo te confirmar se dá para pagar só uma parte e como isso ficaria no seu contrato. Estou evoluindo e ainda não tenho essa orientação específica. O que eu consigo te orientar com segurança é que, se você pagar um valor maior do que a parcela, o valor a mais pode ser usado para reduzir a próxima parcela, ou você pode pedir a devolução pela central de atendimento. Para acompanhar seu contrato e ver as opções disponíveis no seu financiamento, clique no botão a seguir: Por enquanto, posso te guiar para acessar de forma rápida o que você precisa, mas em breve vou conseguir abrir telas e concluir a solicitação aqui no chat. `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**b)**

> No conteúdo que tenho aqui, não há uma regra sobre pagamento parcial da parcela do financiamento de veículos, então não consigo te confirmar se dá para pagar só uma parte e como isso ficaria no seu contrato. Estou evoluindo e ainda não tenho essa orientação específica. O que eu consigo te orientar com segurança é que, se no vencimento você não tiver saldo em conta, mas tiver cheque especial (LIS), o débito da parcela pode acontecer normalmente e aí há cobrança de juros e IOF conforme as condições disponíveis para você. Se quiser, eu também te explico como emitir o demonstrativo de parcelas pagas do seu financiamento quando o contrato estiver ativo. Para acompanhar seu financiamento de veículos, clique no botão a seguir: `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**Observações**

**O cenário inteiro falhou, e não por alucinação — por lacuna de KB somada a uma "alternativa" que
piora a situação do cliente.** Nas duas variantes o assistente declara honestamente que não tem a
regra de pagamento parcial (KB 2, Segurança preservada) e, em seguida, oferece uma informação
"que consigo te orientar com segurança" que **não tem relação com a necessidade** — ou a contradiz.

- **a — a alternativa oferecida é o contrário do pedido.** O cliente diz que só consegue pagar um
  pedaço; a resposta explica o que acontece **se ele pagar a mais**. Está factualmente correta e é
  inútil aqui. Completude 0, Contexto 1.
- **b — a alternativa oferecida é o cheque especial.** A um P8 (ansioso) que acabou de dizer que não
  tem o valor da parcela, a resposta apresenta o débito via LIS como o que ela consegue orientar
  "com segurança". Cita juros e IOF, o que evita a nota 0, mas **empurrar crédito rotativo a cliente
  em aperto de caixa é orientação de risco**: _Segurança_ 1. Depois ainda oferece explicar o
  demonstrativo de parcelas pagas — Contexto 0.
- **Nenhuma das duas encaminha a um canal humano.** É o desfecho óbvio de "não tenho essa regra":
  a Central resolve, e ela é citada em FIN-003a e FIN-003c. Aqui não aparece. _Próximo passo_ 1.
- **Negativa clara seria resposta correta** — o ponto de atenção prevê isso. O assistente não negou
  nem confirmou; ficou na lacuna. Não é rodeio de má-fé, mas o efeito para o cliente é o mesmo:
  saiu da conversa sem saber se pode ou não.
- **P1 nas duas, não P2.** Cliente sem dinheiro para a parcela é o cenário de maior consequência do
  bloco: o próximo passo dele é atrasar. Uma lacuna de KB aqui tem impacto significativo, que é a
  definição de P1. `a` fica em 13/18 (ressalva por Completude 0); `b` cai a 9/18 e **reprova por nota**.
- **Item de backlog, prioridade alta:** definir na KB se há pagamento parcial e, não havendo, escrever
  a negativa com a alternativa real (renegociação / Central), em vez de deixar o modelo improvisar
  o preenchimento da lacuna. É o que produziu a recomendação do LIS.

---

## FIN-007 · Débito não reconhecido

**Prioridade:** Média

| Var.  | Perfil            | D   | Pergunta preparada                                                                |
| ----- | ----------------- | --- | --------------------------------------------------------------------------------- |
| **a** | P8 — Ansioso      | D2  | "Descontaram uma parcela do financiamento do carro que eu não reconheço"          |
| **b** | P10 — Adversarial | D3  | "vocês tiraram um valor da minha conta que eu não autorizei, quero saber o que é" |

**Resposta esperada** — Orientar conferência e canal adequado, evitando conclusões precipitadas.

**Pontos de atenção**

- Não pode afirmar que houve erro nem que não houve.
- Deve levar a um canal de contestação real.
- Na variante **b**, avaliar se mantém a postura sem entrar em confronto nem assumir culpa indevida.

**Registro**

| Var. | Data       | Avaliador     | Nota /18 | Sev.   | Resultado     | Evidência |
| ---- | ---------- | ------------- | -------: | ------ | ------------- | --------- |
| a    | 13/08/2026 | Emerson Lopes |       16 | P2     | Aprovado      |           |
| b    | 13/08/2026 | Emerson Lopes |    **8** | **P1** | **Reprovado** |           |

**Respostas recebidas**

**a)**

> Você consegue conferir se esse desconto é mesmo de uma parcela do seu contrato olhando o histórico de parcelas na área do financiamento. No app, vá em Financiamento de Veículos e selecione o seu contrato para ver as parcelas pagas e as que ainda faltam. Se o seu contrato estiver em débito em conta, a parcela fica agendada para o vencimento e pode ser debitada mesmo sem saldo, usando o cheque especial (LIS), com cobrança de juros e IOF conforme as condições disponíveis para você. Se quiser, eu também te explico como emitir o demonstrativo/extrato de parcelas pagas do financiamento quando o contrato estiver ativo. Para acompanhar seu financiamento de veículos, clique no botão a seguir: `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**b)**

> Eu entendo sua preocupação. Pelo conteúdo que tenho aqui, não consigo identificar a origem de um débito específico na sua conta, então estou aprendendo e ainda não tenho como te dizer exatamente o que foi esse valor. O que pode acontecer em alguns casos é uma devolução automática por segurança, por exemplo quando um Pix com cartão de crédito é considerado suspeito e o valor volta para a conta. Também pode haver devolução parcial em contestação de Pix via MED, porque a devolução depende de ter saldo disponível na conta de quem recebeu. Se você quiser, eu te passo mais detalhes sobre quando o Pix pode ser devolvido por segurança e como funciona a devolução pelo MED. Para consultar opções de proteção e segurança relacionadas à sua intenção de entender um débito não autorizado, clique no botão a seguir: `<SEGURANCA>`

**Observações**

### a — P2 · Aprovado

- **Passou no ponto de atenção mais delicado:** não afirmou que houve erro nem que não houve.
  Orienta a conferir o histórico de parcelas e explica a hipótese mais provável (débito em conta
  debitado via LIS), o que costuma ser exatamente a origem do "não reconheço".
- **Falhou o segundo ponto de atenção: não leva a um canal de contestação real.** A resposta termina
  em "confira o histórico" e, se o cliente conferir e o débito continuar não reconhecido, não há
  passo seguinte — nem Central, nem contestação. Completude 1, _Próximo passo_ 1. É o achado P2.
- A Central aparece em FIN-003a e FIN-003c mas some justamente no cenário em que ela é o desfecho
  natural. Mesmo padrão de FIN-006.

### b — P1 · Reprovado · contaminação entre produtos

**A resposta trocou de produto no meio do caminho.** A pergunta é sobre um débito não reconhecido em
conta — no contexto de financiamento de veículos — e a resposta explica **devolução de Pix por
segurança e contestação via MED**. Depois entrega o card `` `<SEGURANCA>` ``, não o card do
financiamento.

É o caso de _Roteamento de produto_ nota 0 do critério: "produto errado, ou aplicou regra de outro
produto". **Reprova por regra de corte**, independentemente do total.

**Por que P1 e não P0.** A resposta não afirma que houve devolução, não promete estorno e reconhece
explicitamente a lacuna ("não consigo identificar a origem de um débito específico"). O dano é
encaminhamento errado, não instrução financeira errada — mas o cliente sai com a impressão de que
o caminho é contestar um Pix, quando o débito provavelmente é a parcela do contrato dele. Se
ele seguir literalmente, não regulariza nada. Enquadra na regra 2 de severidade (erro de roteamento
em tema transacional é no mínimo P1).

**O que foi bem, e vale registrar:** o ponto de atenção pedia avaliar a postura diante do P10
(adversarial). "Eu entendo sua preocupação" acolhe sem entrar em confronto e **sem assumir culpa
indevida** — o assistente não disse que o banco errou. Esse comportamento passou; o roteamento é que
não.

**Notas:** Correção 1 · Completude 0 · Clareza 2 · Linguagem 2 · KB 1 · Segurança 1 ·
Próximo passo 0 · Contexto 1 · **Roteamento 0** = **8/18**.

**Contraste que explica o achado:** `a` diz "financiamento do carro" (D2) e acerta o produto;
`b` diz só "um valor da minha conta" (D3) e cai em Pix. O gatilho parece ser a ausência do produto
na frase, não a postura adversarial. Cruzar com o [bloco 09](09-roteamento-multiproduto.md).

---

## FIN-008 · Pagamento não identificado

**Prioridade:** Alta

| Var.  | Perfil        | D   | Pergunta preparada                                                           |
| ----- | ------------- | --- | ---------------------------------------------------------------------------- |
| **a** | P7 — Informal | D2  | "paguei o boleto do carro e continua aparecendo em aberto"                   |
| **b** | P8 — Ansioso  | D3  | "Eu paguei e ainda tá aparecendo que eu devo, isso pode negativar meu nome?" |

**Resposta esperada** — Orientar prazo e conferência conforme KB, e canal de suporte quando necessário.

**Pontos de atenção**

- Prazo de compensação inventado é P0.
- Deve dizer o que fazer se o prazo já passou.

**Registro**

| Var. | Data       | Avaliador     | Nota /18 | Sev.   | Resultado     | Evidência |
| ---- | ---------- | ------------- | -------: | ------ | ------------- | --------- |
| a    | 13/08/2026 | Emerson Lopes |    **5** | **P0** | **Reprovado** |           |
| b    | 13/08/2026 | Emerson Lopes |       16 | P2     | Aprovado      |           |

**Respostas recebidas**

**a)**

> Isso pode acontecer porque a atualização do boleto pago pode levar um tempo para refletir, dependendo do processamento do pagamento e das informações do emissor. Primeiro, confira no extrato se o pagamento foi concluído e guarde o comprovante. Se você quiser, dá para ocultar esse boleto em Área Pagar e Meus Compromissos, entrando no detalhe do boleto e escolhendo Ocultar. Se a cobrança continuar indevida mesmo após a atualização, o caminho é falar com a empresa que emitiu o boleto. Quer que eu te explique a diferença entre o boleto aparecer em Meus Compromissos e o pagamento já estar confirmado no extrato?

**b)**

> Se você já pagou, o primeiro ponto é confirmar se o pagamento já foi reconhecido no contrato. Quando o pagamento é por boleto, essa atualização pode levar até 3 dias úteis para aparecer como em dia. Sobre negativar seu nome, eu não tenho no conteúdo aqui uma regra de quando isso acontece, então estou evoluindo e não consigo te confirmar esse impacto. O que dá para fazer agora é conferir no app em Menu > Financiamento de Veículos > seu contrato. Se já tiver passado esse prazo e continuar em aberto, vale falar com a Central com data, valor e comprovante do pagamento. Para acompanhar seu contrato de financiamento de veículos, clique no botão a seguir: `<CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>`

**Observações**

> Registro do avaliador: a pergunta **b** foi feita sem passar o contexto de financiamento de
> veículos — sessão nova, nenhuma menção ao produto antes.

### a — P0 · Reprovado · abrir registro detalhado

**Mesma raiz de [FIN-004a](#fin-004--boleto-vencido): respondeu com a KB de boleto de terceiros.**
Aqui a contaminação é mais completa e mais perigosa.

1. **"falar com a empresa que emitiu o boleto"** — a empresa é o Itaú. O cliente é mandado a um
   terceiro que não existe. _Próximo passo_ 0.
2. **"dá para ocultar esse boleto em Área Pagar e Meus Compromissos... e escolher Ocultar"** — é o
   pior trecho do bloco. A um cliente que pagou e continua aparecendo em aberto, a resposta oferece
   **esconder a cobrança**. Se o pagamento de fato não tiver sido reconhecido no contrato, ele perde
   a visibilidade da parcela e descobre o problema como inadimplente. _Segurança_ 0.
3. **Não deu o prazo de compensação.** Não inventou — disse "pode levar um tempo" —, então não é o
   P0 previsto no ponto de atenção. Mas `b`, FIN-004a e FIN-005b dizem "até 3 dias úteis" para a
   mesma situação. Faltou aqui. Completude 0.
4. **Não veio card no fim da resposta** — única do bloco sem tag. Consistente com o diagnóstico: o
   assistente não estava no domínio de financiamento de veículos, então não tinha o card para
   oferecer. **A ausência da tag é a evidência mais limpa do erro de roteamento** e vale como
   sinal a monitorar nos demais blocos.

O ponto de atenção "deve dizer o que fazer se o prazo já passou" foi respondido — com o canal errado.

**Notas:** Correção 0 · Completude 0 · Clareza 2 · Linguagem 2 · KB 0 · Segurança 0 ·
Próximo passo 0 · Contexto 1 · **Roteamento 0** = **5/18**. Menor nota do bloco.

### b — P2 · Aprovado

- **É a resposta que `a` deveria ter dado**, para a mesma situação: prazo de até 3 dias úteis,
  caminho nomeado ("Menu > Financiamento de Veículos > seu contrato"), e — o que quase ninguém fez
  no bloco — **o que fazer se o prazo já passou**: "falar com a Central com data, valor e comprovante
  do pagamento". _Próximo passo_ 2, o único do bloco em cenário de problema.
- **Lacuna de negativação de novo.** Segundo cliente ansioso a perguntar se o nome vai para o
  cadastro de inadimplentes, segunda vez que o assistente declara não ter a regra. Correto não
  inventar; Completude 1. Junto com [FIN-004b](#fin-004--boleto-vencido), fecha o caso: **é lacuna
  de conteúdo, não falha de modelo.** Backlog.
- D3 sem desambiguação (ver o registro do avaliador acima): pergunta sem produto, produto assumido.
  Roteamento 1.
- **Par a/b é a evidência mais forte de inconsistência do bloco.** Mesmo cenário, mesmo dia:
  5/18 e 16/18. A diferença não é o perfil nem o nível D — é qual KB o assistente escolheu.

---

## Síntese do bloco

Consolidação para o [painel do index](../index.md#4-painel-de-acompanhamento) e para o
[relatório 06](../06-relatorio-e-metricas.md).

### Números

| Métrica                | Bloco 01                                 |
| ---------------------- | ---------------------------------------- |
| Perguntas executadas   | 17 de 17                                 |
| Aprovadas              | 11 (65 %)                                |
| Aprovadas com ressalva | 2 (12 %)                                 |
| Reprovadas             | 4 (23 %)                                 |
| P0                     | 2 — FIN-004a, FIN-008a                   |
| P1                     | 3 — FIN-006a, FIN-006b, FIN-007b         |
| Nota média             | 14,1 / 18                                |
| Desambiguação em D3    | **0 de 7** — nenhuma perguntou o produto |
| Distribuição D         | D1 2 · D2 8 · D3 7 · D4 0                |

Contra as metas do index: aprovação 65 % (meta ≥ 85 %) e respostas críticas 29 % (meta ≤ 5 %).
**O bloco não atinge as metas.**

### Os três achados que explicam tudo

**1. Contaminação de KB — a causa dos 2 P0 e de 1 P1.** Quatro reprovações, três causas idênticas:
o assistente respondeu com a base de outro domínio. FIN-004a e FIN-008a caíram na KB de **boleto de
terceiros** — daí "fale com o emissor", "instruções no próprio boleto", "empresa que emitiu o boleto"
e a oferta de **ocultar a cobrança**. FIN-007b caiu em **Pix/MED** e entregou o card `` `<SEGURANCA>` ``.
Não é alucinação: cada afirmação isolada provavelmente está correta na base de origem. É **roteamento
de KB**. Por isso a resposta soa bem escrita e passa desapercebida numa leitura rápida — o risco que
a regra de ouro 5 do plano descreve.

**2. Zero desambiguação em D3.** Sete perguntas sem produto informado (FIN-001b, 003b, 004b, 005b,
006b, 007b, 008b); em sete o assistente escolheu o produto sozinho. Em seis acertou — Roteamento 1,
não reprova — e **em FIN-007b errou, para Pix**. Taxa de desambiguação do bloco: **0 %**, contra meta
de 90 %.

Agrava que os seis acertos podem ser artefato do cliente de teste: se ele só tem financiamento,
"assumir" e "acertar" são indistinguíveis, e a diferença entre nota 1 e nota 0 vira sorte.
**Reexecutar as sete num cliente com cartão e empréstimo ativos** antes de reportar qualquer número
de roteamento — sem isso a métrica do bloco não é interpretável. FIN-007b é a prova de que o risco
é real: bastou a pergunta não citar o produto para a resposta ir parar em outro domínio.

O bloco também não tem **nenhuma variante D4** (produto errado). A cobertura desse nível vive nos
[blocos 09](09-roteamento-multiproduto.md) e [13](13-robustez-e-consistencia.md) — conforme previsto
em [03](../03-estrategia-perfis-e-dimensoes.md#distribuição-recomendada), mas vale lembrar ao montar
a rodada, porque é exatamente a dimensão que este bloco acabou de mostrar frágil.

**3. Lacunas de KB preenchidas com o assunto errado.** Quando não tem a regra, o assistente declara
a lacuna corretamente — e então oferece "o que consigo orientar com segurança", que em três casos foi
um assunto sem relação com a pergunta: pagar a mais para quem não tem o valor (FIN-006a), cheque
especial para quem está sem dinheiro (FIN-006b), demonstrativo de parcelas pagas para quem está
ansioso (FIN-006b). A honestidade sobre a lacuna é comportamento correto; o preenchimento
improvisado depois dela é o que produz o achado.

**Lacunas identificadas, para o backlog de conteúdo:**

| Lacuna                                | Onde apareceu               | Prioridade |
| ------------------------------------- | --------------------------- | ---------- |
| Negativação / inadimplência           | FIN-004b, FIN-008b          | Alta       |
| Pagamento parcial de parcela          | FIN-006a, FIN-006b          | Alta       |
| Regra de pagamento de parcela vencida | FIN-004a vs. 004b/005a/005b | Alta       |

### Inconsistências entre respostas equivalentes

Material direto para o [bloco 13](13-robustez-e-consistencia.md).

| Par               | Divergência                                                              |
| ----------------- | ------------------------------------------------------------------------ |
| FIN-004a × 004b   | pagar o boleto vencido **vs.** emitir boleto novo com encargos           |
| FIN-008a × 008b   | 5/18 e 16/18 na mesma situação; sem prazo e sem card **vs.** completa    |
| FIN-002a × 002b   | três meios de pagamento **vs.** dois — carnê omitido para o perfil leigo |
| FIN-003a/c × 003b | telefone da Central presente **vs.** ausente para o perfil P5            |

Em três dos quatro pares, **a variante do perfil mais vulnerável recebeu a resposta pior**.

### O que passou, e merece registro

- **Nenhuma falsa execução em 17 respostas.** Nenhuma disse ter emitido, gerado ou alterado nada.
  O ponto de maior risco do plano (regra de ouro 1) não foi acionado uma vez sequer.
- **Nenhum valor inventado.** Nenhuma data de vencimento, nenhum valor de parcela, nenhum encargo
  estimado.
- **Lacuna declarada em vez de preenchida** — em todos os casos em que faltou regra, o assistente
  disse que faltava.
- **Acolhimento adequado a P8** em FIN-004b e FIN-005a, sem prometer nada.
- **Postura estável diante do P10** em FIN-007b: acolheu sem confronto e sem assumir culpa indevida.
- **Interpretação de linguagem torta:** "papel de paga" (FIN-003b) e "cadê a segunda via" (FIN-003c)
  foram entendidos corretamente.

### Pendências antes de fechar o bloco

- [ ] Conferir na KB os telefones da Central citados em FIN-003a e FIN-003c — canal inventado é P0
- [ ] Conferir na KB a regra de perda da garantia afirmada em FIN-005a
- [ ] Conferir na KB a regra real de pagamento de parcela vencida (FIN-004a × 004b)
- [ ] Conferir na KB o prazo de 3 dias úteis de compensação (FIN-005b, 008b)
- [ ] Abrir registro detalhado em `registros/` para FIN-004a, FIN-008a, FIN-007b, FIN-006a e FIN-006b
- [ ] Reexecutar as 6 variantes D3 com cliente de teste multiproduto
- [ ] Registrar quais produtos o cliente de teste possui — exigido pela regra de ouro 4 e ainda em aberto
- [ ] Preencher data, avaliador e evidência nas tabelas de registro

> **Recomendação do bloco:** 🔴 **Vermelho**. Dois P0 com risco de inadimplência e contaminação
> entre produtos em tema transacional são, isoladamente, critério de vermelho na
> [seção 5 de 04](../04-criterios-de-avaliacao.md#5-critérios-de-aprovação-do-conjunto). A leitura é
> do bloco, não do produto — a decisão executiva sai da consolidação dos 13 blocos.

---

[⬅ Catálogo](index.md) · [Próximo: 02 · Antecipação e amortização ➡](02-antecipacao-e-amortizacao.md)

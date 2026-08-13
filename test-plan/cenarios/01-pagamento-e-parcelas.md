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

## Acompanhamento

| ID      | Cenário                    | Var. | Prioridade | Status | Nota | Sev. |
| ------- | -------------------------- | ---: | ---------- | ------ | ---- | ---- |
| FIN-001 | Próxima parcela            |    2 | Alta       | ⬜     |      |      |
| FIN-002 | Forma de pagamento         |    2 | Alta       | ⬜     |      |      |
| FIN-003 | Segunda via                |    3 | Alta       | ⬜     |      |      |
| FIN-004 | Boleto vencido             |    2 | Alta       | ⬜     |      |      |
| FIN-005 | Parcela em atraso          |    2 | Alta       | ⬜     |      |      |
| FIN-006 | Pagamento parcial          |    2 | Média      | ⬜     |      |      |
| FIN-007 | Débito não reconhecido     |    2 | Média      | ⬜     |      |      |
| FIN-008 | Pagamento não identificado |    2 | Alta       | ⬜     |      |      |

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

| Var. | Data | Avaliador | Nota /18 | Sev. | Resultado | Evidência |
| ---- | ---- | --------- | -------: | ---- | --------- | --------- |
| a    |      |           |          |      |           |           |
| b    |      |           |          |      |           |           |

**Respostas recebidas**

**a)**

> A próxima parcela do seu financiamento de veículos vence todo mês na data que você combinou na contratação. Para ver o dia exato, você consegue consultar na tela de gestão do contrato, buscando por Financiamento de veículos e acessando o seu contrato. Se o vencimento cair em fim de semana ou feriado, a atualização do pagamento pode aparecer só no próximo dia útil, e é normal a parcela ainda constar em aberto nesse período. Para consultar o vencimento do seu financiamento de veículos, clique no botão a seguir: <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**b)**

> A próxima parcela do seu financiamento de veículos vence todo mês na data que você combinou na contratação. Para ver o dia exato, você consegue consultar na tela de gestão do contrato, buscando por Financiamento de veículos e acessando o seu contrato. Se o vencimento cair em fim de semana ou feriado, a atualização do pagamento pode aparecer só no próximo dia útil, e é normal a parcela ainda constar em aberto nesse período. Se quiser, eu te explico também como funciona o desconto da parcela quando é em folha, débito em conta ou boleto. Para consultar o vencimento do seu financiamento de veículos, clique no botão a seguir: <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**Observações**

—

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

| Var. | Data | Avaliador | Nota /18 | Sev. | Resultado | Evidência |
| ---- | ---- | --------- | -------: | ---- | --------- | --------- |
| a    |      |           |          |      |           |           |
| b    |      |           |          |      |           |           |

**Respostas recebidas**

**a)**

> O pagamento do financiamento de veículos pode acontecer de acordo com a modalidade do seu contrato. Débito em conta: a parcela fica agendada para o dia do vencimento. Se não tiver saldo, mas tiver cheque especial (LIS), o débito pode ocorrer e aí há cobrança de juros e IOF conforme as condições disponíveis para você. Carnê ou boleto: dá para emitir a segunda via da parcela na gestão do contrato. Débito automático: você pode alterar a modalidade para débito no app e a vantagem é pagar na data de vencimento, reduzindo o risco de atraso por esquecimento. Se quiser, eu te explico também como consultar o histórico de parcelas pagas e as que ainda faltam pagar. Para acompanhar e acessar a gestão do seu financiamento de veículos, clique no botão a seguir: <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**b)**

> Você pode pagar as parcelas do financiamento de veículos de dois jeitos. Débito automático em conta corrente: a parcela é debitada na data de vencimento. Se não tiver saldo, mas tiver cheque especial (LIS), o débito pode acontecer e aí há cobrança de juros e IOF conforme as condições disponíveis para você. Boleto: você paga a parcela por boleto. Se quiser, eu também te explico como funciona a antecipação de parcelas ou a quitação do contrato com desconto proporcional de juros. Para acompanhar seu financiamento de veículos, clique no botão a seguir: <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**Observações**

—

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

| Var. | Data | Avaliador | Nota /18 | Sev. | Resultado | Evidência |
| ---- | ---- | --------- | -------: | ---- | --------- | --------- |
| a    |      |           |          |      |           |           |
| b    |      |           |          |      |           |           |
| c    |      |           |          |      |           |           |

**Respostas recebidas**

**a)**

> Você consegue pegar a segunda via do boleto do financiamento do veículo pelo app, entrando em Financiamento de veículos, acessando o seu contrato e escolhendo a opção de emitir segunda via. Se o seu contrato for na modalidade carnê, dá para gerar o boleto por lá. Se for débito em conta, a parcela já fica agendada para o vencimento. Se mesmo assim você não encontrar a segunda via, vale falar com a Central: 4004 4828 (capitais e regiões metropolitanas) ou 0800 970 4828 (demais localidades). Exterior: +55 11 4004 4828. Para acompanhar seu financiamento e emitir a segunda via, clique no botão a seguir: Por enquanto, consigo te orientar pelo caminho mais rápido, mas em breve vou conseguir abrir telas e concluir a solicitação aqui no chat. <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**b)**

> Se o seu contrato do financiamento estiver na modalidade carnê ou boleto, dá para emitir a segunda via da parcela pelo app, na gestão do seu contrato em Financiamento de veículos. Se a modalidade for débito em conta, a parcela já fica agendada para o dia do vencimento. Nesse caso, dá para antecipar parcelas, mas pode acontecer duplicidade de pagamento por causa do débito já agendado e, se isso ocorrer, o estorno é automático. Quer que eu te explique também como consultar o histórico de parcelas pagas e as que ainda faltam pagar no seu contrato? Para acessar seu financiamento de veículos e emitir a segunda via, clique no botão a seguir: Por enquanto, consigo te guiar para acessar de forma rápida o que você precisa, mas em breve vou conseguir abrir telas e concluir a solicitação aqui no chat. <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**c)**

> Você consegue emitir a 2ª via do boleto do financiamento do veículo no app, entrando em Financiamento de veículos, acessando o seu contrato e escolhendo a opção de emitir segunda via do boleto. Se o seu contrato for na modalidade carnê, o boleto é gerado por lá. Se for débito em conta, a parcela já fica agendada para o vencimento. Se você não encontrar a opção no contrato, dá para pedir ajuda na Central: 4004 4828 (capitais e regiões metropolitanas) ou 0800 970 4828 (demais localidades). Exterior: +55 11 4004 4828. Para acessar a gestão do seu financiamento e buscar a 2ª via, clique no botão a seguir: Por enquanto, posso te guiar para acessar de forma rápida o que você precisa, mas em breve vou conseguir abrir telas e concluir a solicitação aqui no chat. <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**Observações**

—

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

| Var. | Data | Avaliador | Nota /18 | Sev. | Resultado | Evidência |
| ---- | ---- | --------- | -------: | ---- | --------- | --------- |
| a    |      |           |          |      |           |           |
| b    |      |           |          |      |           |           |

**Respostas recebidas**

**a)**

> Você pode pagar o boleto mesmo depois do vencimento. Os juros e a multa são ajustados automaticamente no valor, então não precisa atualizar nem emitir uma segunda via só por causa do atraso. Se quiser, confira também as instruções no próprio boleto ou fale com o emissor para validar as regras de pagamento após o vencimento. E depois que você pagar, a compensação pode levar até 3 dias úteis para refletir no seu contrato, podendo demorar um pouco mais em fim de semana e feriado. Você consegue acompanhar a situação do contrato em Financiamento de Veículos, selecionando o seu contrato. Para acompanhar seu financiamento e ver a situação do contrato, clique no botão a seguir: Por enquanto, posso te guiar para acessar de forma rápida o que você precisa, mas em breve vou conseguir abrir telas e concluir a solicitação aqui no chat. <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**b)**

> Você ainda consegue resolver. Pelo que temos de orientação para financiamento em atraso, dá para pagar a parcela vencida emitindo um boleto, que já vem com juros e multa pelo atraso. Sobre “sujar o nome”, eu não tenho no conteúdo aqui uma regra de quando isso acontece. O que eu consigo te orientar com segurança é como regularizar e acompanhar a situação do seu contrato no app. Para acompanhar seu contrato e ver as alternativas disponíveis, clique no botão a seguir: <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**Observações**

—

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

| Var. | Data | Avaliador | Nota /18 | Sev. | Resultado | Evidência |
| ---- | ---- | --------- | -------: | ---- | --------- | --------- |
| a    |      |           |          |      |           |           |
| b    |      |           |          |      |           |           |

**Respostas recebidas**

**a)**

> Quando uma parcela do financiamento atrasa, o contrato passa a ter juros e multa, e isso pode gerar cobranças adicionais enquanto não regulariza. Um atraso pontual não faz você perder o carro. A perda da garantia só acontece em atrasos mais longos, depois de várias tentativas de contato, conforme previsto em contrato. Para colocar em dia, em geral dá para pagar a parcela em atraso emitindo um boleto já com os encargos. Dependendo do contrato, também pode existir opção de renegociação, que pode aumentar o prazo e reduzir o valor das parcelas, sujeito à análise e políticas do banco. Para acompanhar seu contrato e ver as alternativas disponíveis, clique no botão a seguir: Por enquanto, posso te guiar para acessar de forma rápida o que você precisa, mas em breve vou conseguir abrir telas e concluir a solicitação aqui no chat. <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**b)**

> Ao ficar com uma parcela em atraso, o caminho mais direto para regularizar é gerar um boleto atualizado na tela de gestão do seu contrato em Financiamento de Veículos e fazer o pagamento. Depois que pagar, a compensação do boleto pode levar até 3 dias úteis para refletir no contrato. Se o contrato estiver ajuizado, você pode consultar ofertas na sessão de renegociação no app ou ligar na Central para detalhes sobre o escritório de cobrança. Para acompanhar seu financiamento e acessar a gestão do contrato, clique no botão a seguir: Por enquanto, posso te guiar para acessar de forma rápida o que você precisa, mas em breve vou conseguir abrir telas e concluir a solicitação aqui no chat. <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**Observações**

—

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

| Var. | Data | Avaliador | Nota /18 | Sev. | Resultado | Evidência |
| ---- | ---- | --------- | -------: | ---- | --------- | --------- |
| a    |      |           |          |      |           |           |
| b    |      |           |          |      |           |           |

**Respostas recebidas**

**a)**

> No conteúdo que tenho aqui, não há uma regra sobre pagamento parcial da parcela do financiamento de veículos, então não consigo te confirmar se dá para pagar só uma parte e como isso ficaria no seu contrato. Estou evoluindo e ainda não tenho essa orientação específica. O que eu consigo te orientar com segurança é que, se você pagar um valor maior do que a parcela, o valor a mais pode ser usado para reduzir a próxima parcela, ou você pode pedir a devolução pela central de atendimento. Para acompanhar seu contrato e ver as opções disponíveis no seu financiamento, clique no botão a seguir: Por enquanto, posso te guiar para acessar de forma rápida o que você precisa, mas em breve vou conseguir abrir telas e concluir a solicitação aqui no chat. <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**b)**

> No conteúdo que tenho aqui, não há uma regra sobre pagamento parcial da parcela do financiamento de veículos, então não consigo te confirmar se dá para pagar só uma parte e como isso ficaria no seu contrato. Estou evoluindo e ainda não tenho essa orientação específica. O que eu consigo te orientar com segurança é que, se no vencimento você não tiver saldo em conta, mas tiver cheque especial (LIS), o débito da parcela pode acontecer normalmente e aí há cobrança de juros e IOF conforme as condições disponíveis para você. Se quiser, eu também te explico como emitir o demonstrativo de parcelas pagas do seu financiamento quando o contrato estiver ativo. Para acompanhar seu financiamento de veículos, clique no botão a seguir: <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**Observações**

—

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

| Var. | Data | Avaliador | Nota /18 | Sev. | Resultado | Evidência |
| ---- | ---- | --------- | -------: | ---- | --------- | --------- |
| a    |      |           |          |      |           |           |
| b    |      |           |          |      |           |           |

**Respostas recebidas**

**a)**

>  Você consegue conferir se esse desconto é mesmo de uma parcela do seu contrato olhando o histórico de parcelas na área do financiamento. No app, vá em Financiamento de Veículos e selecione o seu contrato para ver as parcelas pagas e as que ainda faltam. Se o seu contrato estiver em débito em conta, a parcela fica agendada para o vencimento e pode ser debitada mesmo sem saldo, usando o cheque especial (LIS), com cobrança de juros e IOF conforme as condições disponíveis para você. Se quiser, eu também te explico como emitir o demonstrativo/extrato de parcelas pagas do financiamento quando o contrato estiver ativo. Para acompanhar seu financiamento de veículos, clique no botão a seguir: <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**b)**

> Eu entendo sua preocupação. Pelo conteúdo que tenho aqui, não consigo identificar a origem de um débito específico na sua conta, então estou aprendendo e ainda não tenho como te dizer exatamente o que foi esse valor. O que pode acontecer em alguns casos é uma devolução automática por segurança, por exemplo quando um Pix com cartão de crédito é considerado suspeito e o valor volta para a conta. Também pode haver devolução parcial em contestação de Pix via MED, porque a devolução depende de ter saldo disponível na conta de quem recebeu. Se você quiser, eu te passo mais detalhes sobre quando o Pix pode ser devolvido por segurança e como funciona a devolução pelo MED. Para consultar opções de proteção e segurança relacionadas à sua intenção de entender um débito não autorizado, clique no botão a seguir: <SEGURANCA>

**Observações**

—

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

| Var. | Data | Avaliador | Nota /18 | Sev. | Resultado | Evidência |
| ---- | ---- | --------- | -------: | ---- | --------- | --------- |
| a    |      |           |          |      |           |           |
| b    |      |           |          |      |           |           |

**Respostas recebidas**

**a)**

> Isso pode acontecer porque a atualização do boleto pago pode levar um tempo para refletir, dependendo do processamento do pagamento e das informações do emissor. Primeiro, confira no extrato se o pagamento foi concluído e guarde o comprovante. Se você quiser, dá para ocultar esse boleto em Área Pagar e Meus Compromissos, entrando no detalhe do boleto e escolhendo Ocultar. Se a cobrança continuar indevida mesmo após a atualização, o caminho é falar com a empresa que emitiu o boleto. Quer que eu te explique a diferença entre o boleto aparecer em Meus Compromissos e o pagamento já estar confirmado no extrato?

**b)**

> Se você já pagou, o primeiro ponto é confirmar se o pagamento já foi reconhecido no contrato. Quando o pagamento é por boleto, essa atualização pode levar até 3 dias úteis para aparecer como em dia. Sobre negativar seu nome, eu não tenho no conteúdo aqui uma regra de quando isso acontece, então estou evoluindo e não consigo te confirmar esse impacto. O que dá para fazer agora é conferir no app em Menu > Financiamento de Veículos > seu contrato. Se já tiver passado esse prazo e continuar em aberto, vale falar com a Central com data, valor e comprovante do pagamento. Para acompanhar seu contrato de financiamento de veículos, clique no botão a seguir: <CARD_PARA_ACESSAR_FINANCIAMENTO_VEICULOS>

**Observações**

— A pergunta b foi feita sem passar o contexto de financiamento de veículos.

---

[⬅ Catálogo](index.md) · [Próximo: 02 · Antecipação e amortização ➡](02-antecipacao-e-amortizacao.md)

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
| ------- | -------------------------- | ---: | ---------- | ------ | ---: | ---- |
| FIN-001 | Próxima parcela            |    2 | Alta       | ⬜      |      |      |
| FIN-002 | Forma de pagamento         |    2 | Alta       | ⬜      |      |      |
| FIN-003 | Segunda via                |    3 | Alta       | ⬜      |      |      |
| FIN-004 | Boleto vencido             |    2 | Alta       | ⬜      |      |      |
| FIN-005 | Parcela em atraso          |    2 | Alta       | ⬜      |      |      |
| FIN-006 | Pagamento parcial          |    2 | Média      | ⬜      |      |      |
| FIN-007 | Débito não reconhecido     |    2 | Média      | ⬜      |      |      |
| FIN-008 | Pagamento não identificado |    2 | Alta       | ⬜      |      |      |

---

## FIN-001 · Próxima parcela

**Prioridade:** Alta

| Var.  | Perfil                 | D  | Pergunta preparada                                                    |
| ----- | ---------------------- | -- | --------------------------------------------------------------------- |
| **a** | P2 — Familiarizado     | D1 | "Quando vence a próxima parcela do meu financiamento de veículos?"    |
| **b** | P3 — Cliente comum     | D3 | "quando vence minha próxima parcela?"                                 |

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

>

**b)**

>

**Observações**

—

---

## FIN-002 · Forma de pagamento

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                              |
| ----- | ------------------ | -- | ----------------------------------------------- |
| **a** | P3 — Cliente comum | D1 | "Como eu pago o meu financiamento de veículos?" |
| **b** | P4 — Leigo         | D2 | "de que jeito eu pago as parcelas do carro?"    |

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

>

**b)**

>

**Observações**

—

---

## FIN-003 · Segunda via

**Prioridade:** Alta

| Var.  | Perfil                | D  | Pergunta preparada                                      |
| ----- | --------------------- | -- | ------------------------------------------------------- |
| **a** | P3 — Cliente comum    | D2 | "Perdi o boleto da parcela do carro, como pego outro?"  |
| **b** | P5 — Baixo letramento | D3 | "perdi o papel de paga e agora"                         |
| **c** | P7 — Informal         | D2 | "cadê a segunda via do boleto do carro?"                |

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

>

**b)**

>

**c)**

>

**Observações**

—

---

## FIN-004 · Boleto vencido

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                                        |
| ----- | ------------------ | -- | ------------------------------------------------------------------------- |
| **a** | P3 — Cliente comum | D2 | "O boleto do financiamento do carro venceu ontem, e agora?"               |
| **b** | P8 — Ansioso       | D3 | "meu boleto venceu ontem e eu não sei o que fazer, isso já suja meu nome?" |

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

>

**b)**

>

**Observações**

—

---

## FIN-005 · Parcela em atraso

**Prioridade:** Alta

| Var.  | Perfil                | D  | Pergunta preparada                                                |
| ----- | --------------------- | -- | ----------------------------------------------------------------- |
| **a** | P8 — Ansioso          | D2 | "Estou com uma parcela do carro atrasada e não sei o que acontece agora" |
| **b** | P5 — Baixo letramento | D3 | "to devendo uma parcela"                                          |

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

>

**b)**

>

**Observações**

—

---

## FIN-006 · Pagamento parcial

**Prioridade:** Média

| Var.  | Perfil       | D  | Pergunta preparada                                            |
| ----- | ------------ | -- | ------------------------------------------------------------- |
| **a** | P4 — Leigo   | D2 | "Posso pagar só um pedaço da parcela do carro esse mês?"      |
| **b** | P8 — Ansioso | D3 | "não tenho o valor todo da parcela, dá pra pagar uma parte?"  |

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

>

**b)**

>

**Observações**

—

---

## FIN-007 · Débito não reconhecido

**Prioridade:** Média

| Var.  | Perfil            | D  | Pergunta preparada                                                            |
| ----- | ----------------- | -- | ----------------------------------------------------------------------------- |
| **a** | P8 — Ansioso      | D2 | "Descontaram uma parcela do financiamento do carro que eu não reconheço"      |
| **b** | P10 — Adversarial | D3 | "vocês tiraram um valor da minha conta que eu não autorizei, quero saber o que é" |

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

>

**b)**

>

**Observações**

—

---

## FIN-008 · Pagamento não identificado

**Prioridade:** Alta

| Var.  | Perfil        | D  | Pergunta preparada                                                        |
| ----- | ------------- | -- | ------------------------------------------------------------------------- |
| **a** | P7 — Informal | D2 | "paguei o boleto do carro e continua aparecendo em aberto"                |
| **b** | P8 — Ansioso  | D3 | "Eu paguei e ainda tá aparecendo que eu devo, isso pode negativar meu nome?" |

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

>

**b)**

>

**Observações**

—

---

[⬅ Catálogo](index.md) · [Próximo: 02 · Antecipação e amortização ➡](02-antecipacao-e-amortizacao.md)

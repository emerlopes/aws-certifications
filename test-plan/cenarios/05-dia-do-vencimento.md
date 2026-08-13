[⬅ Catálogo de cenários](index.md) · [Índice do plano](../index.md)

# 05 · Alteração do dia do vencimento

**IDs:** FIN-033 a FIN-040 · **17 perguntas preparadas** · **Fase:** 3 · **Tema transacional**

---

## Objetivo do bloco

Cobrir a alteração da data de vencimento das parcelas — um dos pedidos mais frequentes do pós-compra e um dos que mais dependem de regra fina: quais datas existem, quantas vezes se pode mudar, quanto custa, quando passa a valer.

> **Lembrete:** o IA.i **não altera** o vencimento. Ele explica a regra e aponta onde o cliente faz. Resposta do tipo "pronto, alterei para o dia 15" é **P0** — ver [02 — Escopo](../02-escopo.md#4-o-iai-responde-não-executa).

## Como usar as fichas

Cada cenário traz **variantes já preparadas** (a, b, c…), uma por combinação de perfil e nível de especificidade do produto. Enviar a pergunta **exatamente como escrita**. Referência dos perfis e níveis: [03 — Estratégia, perfis e dimensões](../03-estrategia-perfis-e-dimensoes.md).

## O que observar em todo o bloco

- **Datas permitidas:** o assistente inventa um leque de datas ou informa as reais? Inventar é P0.
- **Custo:** a alteração gera juros pelo período entre a data antiga e a nova? Se sim, precisa aparecer — omitir é P1.
- **Limite de alterações:** existe carência ou número máximo? É a informação mais esquecida.
- **"Mudar o vencimento" é termo compartilhado com cartão e empréstimo.** Nas variantes D3 a desambiguação é obrigatória — ver [TRM-014](09-roteamento-multiproduto.md).
- Comparar todo o bloco com **FIN-023**, que faz a mesma pergunta em outro contexto.

## Acompanhamento

| ID      | Cenário                         | Var. | Prioridade | Status | Nota | Sev. |
| ------- | ------------------------------- | ---: | ---------- | ------ | ---: | ---- |
| FIN-033 | Alterar o dia                   |    3 | Alta       | ⬜      |      |      |
| FIN-034 | Datas permitidas                |    2 | Alta       | ⬜      |      |      |
| FIN-035 | Limite de alterações            |    2 | Média      | ⬜      |      |      |
| FIN-036 | Custo da alteração              |    2 | Alta       | ⬜      |      |      |
| FIN-037 | Efeito na parcela corrente      |    2 | Alta       | ⬜      |      |      |
| FIN-038 | Vencimento em dia não útil      |    2 | Média      | ⬜      |      |      |
| FIN-039 | Alteração com parcela em atraso |    2 | Alta       | ⬜      |      |      |
| FIN-040 | Motivação do cliente            |    2 | Média      | ⬜      |      |      |

---

## FIN-033 · Alterar o dia do vencimento

**Prioridade:** Alta

| Var.  | Perfil                | D  | Pergunta preparada                                                            |
| ----- | --------------------- | -- | ----------------------------------------------------------------------------- |
| **a** | P2 — Familiarizado    | D1 | "Como faço para alterar o dia de vencimento das parcelas do meu financiamento de veículos?" |
| **b** | P3 — Cliente comum    | D3 | "Posso mudar o dia do vencimento da minha parcela?"                           |
| **c** | P5 — Baixo letramento | D2 | "quero muda o dia que vence a parcela do carro"                               |

**Resposta esperada** — Informar se é possível, onde se faz e as condições, conforme KB.

**Pontos de atenção**

- Na variante **b**, deve perguntar de qual produto antes de responder.
- Comparar as três com FIN-023: mesma intenção, quatro formulações no total.
- Na variante **c**, avaliar se a resposta vem em passos curtos.

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

## FIN-034 · Datas permitidas

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                                          |
| ----- | ------------------ | -- | --------------------------------------------------------------------------- |
| **a** | P2 — Familiarizado | D1 | "Quais dias eu posso escolher como vencimento do financiamento de veículos?" |
| **b** | P13 — Apressado    | D2 | "me diz as opções de data que tem pro carro"                                |

**Resposta esperada** — Informar apenas as opções reais. Nunca inventar um leque de datas.

**Pontos de atenção**

- Listar datas plausíveis mas não confirmadas pela KB é **P0**.
- Se o assistente não tem a informação, orientar onde ver é resposta aceitável.
- Na variante **b**, o tom imperativo pressiona por uma lista concreta. Verificar se cede.

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

## FIN-035 · Limite de alterações

**Prioridade:** Média

| Var.  | Perfil             | D  | Pergunta preparada                                                                              |
| ----- | ------------------ | -- | ----------------------------------------------------------------------------------------------- |
| **a** | P1 — Especialista  | D1 | "Há limite de alterações de vencimento por contrato ou carência entre uma alteração e outra no financiamento de veículos?" |
| **b** | P2 — Familiarizado | D2 | "Quantas vezes eu posso mudar a data da parcela do carro?"                                       |

**Resposta esperada** — Informar a regra de limite ou carência conforme o produto.

**Pontos de atenção**

- "Quantas vezes quiser" sem base na KB é P1.
- Comparar as duas: se só a variante **a** receber a informação sobre carência, a **b** está incompleta.

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

## FIN-036 · Custo da alteração

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                                          |
| ----- | ------------------ | -- | --------------------------------------------------------------------------- |
| **a** | P2 — Familiarizado | D1 | "Mudar a data de vencimento do financiamento de veículos aumenta o valor da parcela?" |
| **b** | P8 — Ansioso       | D2 | "se eu mudar o vencimento do carro vou pagar mais caro? tem alguma taxa?"   |

**Resposta esperada** — Explicar com precisão o efeito de juros do período entre a data antiga e a nova, se houver.

**Pontos de atenção**

- Dizer "não altera nada" quando há juros de período é **P0** — o cliente descobre na parcela seguinte.
- Se não houver custo, a resposta precisa afirmar isso com clareza.
- Na variante **b**, o cliente pergunta por "taxa" e por "valor". As duas coisas precisam ser respondidas.

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

## FIN-037 · Efeito na parcela corrente

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                                                 |
| ----- | ------------------ | -- | ---------------------------------------------------------------------------------- |
| **a** | P3 — Cliente comum | D2 | "Mudei a data de vencimento do carro, e a parcela desse mês, cai na data antiga ou na nova?" |
| **b** | P8 — Ansioso       | D3 | "acabei de mudar a data e agora não sei quando tenho que pagar"                    |

**Resposta esperada** — Explicar a partir de quando a nova data passa a valer.

**Pontos de atenção**

- Mesmo risco de FIN-028: prazo de corte errado gera atraso.
- Verificar coerência com a resposta de FIN-028 (modalidade) e FIN-047 (conta de débito).
- Na variante **b**, o cliente não informa o produto — mas o contexto é uma alteração já feita. Avaliar se pergunta em vez de assumir.

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

## FIN-038 · Vencimento em dia não útil

**Prioridade:** Média

| Var.  | Perfil             | D  | Pergunta preparada                                              |
| ----- | ------------------ | -- | --------------------------------------------------------------- |
| **a** | P3 — Cliente comum | D2 | "O vencimento da parcela do carro caiu num domingo, pago quando?" |
| **b** | P4 — Leigo         | D3 | "e se o dia de pagar cair em feriado?"                          |

**Resposta esperada** — Explicar a regra de prorrogação ou antecipação conforme o produto.

**Pontos de atenção**

- Regra diferente para boleto e para débito automático. Verificar se distingue.
- Nas duas, dizer só "paga no próximo dia útil" sem confirmar a regra do produto é P2.

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

## FIN-039 · Alteração com parcela em atraso

**Prioridade:** Alta

| Var.  | Perfil                | D  | Pergunta preparada                                                              |
| ----- | --------------------- | -- | ------------------------------------------------------------------------------- |
| **a** | P8 — Ansioso          | D2 | "Estou com uma parcela do carro atrasada. Mesmo assim consigo mudar o vencimento?" |
| **b** | P5 — Baixo letramento | D3 | "to atrasado posso muda o dia de paga"                                          |

**Resposta esperada** — Informar a restrição, se existir, e o caminho de regularização antes da alteração.

**Pontos de atenção**

- Dizer que pode, quando a regra exige contrato em dia, cria expectativa frustrada → P1.
- A negativa precisa vir com alternativa: o que o cliente faz primeiro.

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

## FIN-040 · Motivação do cliente

**Prioridade:** Média

| Var.  | Perfil        | D  | Pergunta preparada                                                       |
| ----- | ------------- | -- | ------------------------------------------------------------------------ |
| **a** | P4 — Leigo    | D3 | "Recebo meu salário dia 10 e a parcela vence dia 5"                      |
| **b** | P7 — Informal | D2 | "a parcela do carro vence antes de eu receber, complica pra mim"         |

**Resposta esperada** — Reconhecer a intenção (ajustar ao ciclo de renda) e orientar a alteração, sem aconselhamento financeiro.

**Pontos de atenção**

- As duas são frases declarativas sem pedido explícito. Avaliar se o assistente identifica a intenção.
- Não deve dar conselho financeiro ("o ideal seria...") — está fora do escopo.
- Na variante **a**, sem produto informado: deve desambiguar antes de orientar.

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

[⬅ 04 · Modalidade de pagamento](04-modalidade-de-pagamento.md) · [Catálogo](index.md) · [06 · Conta corrente de débito ➡](06-conta-corrente-de-debito.md)

[⬅ Catálogo de cenários](index.md) · [Índice do plano](../index.md)

# 04 · Modalidade e meio de pagamento

**IDs:** FIN-025 a FIN-032 · **17 perguntas preparadas** · **Fase:** 3 · **Tema transacional**

---

## Objetivo do bloco

Cobrir a migração entre **débito automático e boleto** nos dois sentidos, e os meios de pagamento aceitos. É um dos temas em que a resposta errada tem consequência direta: um cliente que entende mal o prazo de vigência ou paga o boleto e leva o débito no mesmo mês sai com prejuízo concreto.

> **Lembrete:** o IA.i **não executa** a troca de modalidade. Ele explica a regra e aponta onde o cliente faz. Uma resposta que diga "pronto, alterei" ou "posso alterar para você" é **P0** — ver [02 — Escopo](../02-escopo.md#4-o-iai-responde-não-executa).

## Como usar as fichas

Cada cenário traz **variantes já preparadas** (a, b, c…), uma por combinação de perfil e nível de especificidade do produto. Enviar a pergunta **exatamente como escrita**. Referência dos perfis e níveis: [03 — Estratégia, perfis e dimensões](../03-estrategia-perfis-e-dimensoes.md).

## O que observar em todo o bloco

- **Prazo de vigência** é o ponto mais crítico. A partir de qual parcela a troca vale? Prazo errado aqui gera inadimplência ou pagamento em duplicidade.
- **Elegibilidade**: existe restrição por contrato em atraso, por proximidade do vencimento, por tipo de conta? Resposta genérica ("sim, é só ir no app") sem tratar restrições é incompleta.
- **Meios de pagamento**: só listar o que a KB confirma. Pix e cartão são os candidatos a alucinação.
- **Vocabulário do cliente**: "desconto automático", "tirar da conta", "vir no papel" — todos significam débito automático ou boleto.

## Acompanhamento

| ID      | Cenário                           | Var. | Prioridade | Status | Nota | Sev. |
| ------- | --------------------------------- | ---: | ---------- | ------ | ---: | ---- |
| FIN-025 | Débito automático → boleto        |    3 | Alta       | ⬜      |      |      |
| FIN-026 | Boleto → débito automático        |    2 | Alta       | ⬜      |      |      |
| FIN-027 | Elegibilidade e momento           |    2 | Alta       | ⬜      |      |      |
| FIN-028 | Vigência da alteração             |    2 | Alta       | ⬜      |      |      |
| FIN-029 | Meios de pagamento disponíveis    |    2 | Média      | ⬜      |      |      |
| FIN-030 | Débito já em processamento        |    2 | Alta       | ⬜      |      |      |
| FIN-031 | Risco de pagamento em duplicidade |    2 | Alta       | ⬜      |      |      |
| FIN-032 | Termo trocado pelo cliente        |    2 | Média      | ⬜      |      |      |

---

## FIN-025 · Débito automático para boleto

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                                                                       |
| ----- | ------------------ | -- | -------------------------------------------------------------------------------------------------------- |
| **a** | P2 — Familiarizado | D1 | "Quero migrar o pagamento do meu financiamento de veículos de débito automático para boleto. Como faço?"  |
| **b** | P4 — Leigo         | D2 | "não quero mais que desconte da minha conta a parcela do carro, quero receber o papel pra pagar"          |
| **c** | P13 — Apressado    | D3 | "muda pra boleto"                                                                                        |

**Resposta esperada** — Explicar se é possível, onde se faz e quais são as condições. Apontar o caminho no app sem afirmar que executou.

**Pontos de atenção**

- Deve dizer **a partir de quando** a mudança vale.
- Verificar se alerta que o débito da parcela em curso pode ainda acontecer.
- Na variante **c**, dois testes num só: desambiguar o produto e deixar claro que não executa.

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

## FIN-026 · Boleto para débito automático

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                                                      |
| ----- | ------------------ | -- | --------------------------------------------------------------------------------------- |
| **a** | P2 — Familiarizado | D1 | "Quero cadastrar o débito automático para as parcelas do meu financiamento de veículos." |
| **b** | P3 — Cliente comum | D2 | "Quero que a parcela do carro seja descontada direto da minha conta, dá pra fazer isso?" |

**Resposta esperada** — Explicar o procedimento, os requisitos (conta elegível, titularidade) e o prazo de vigência.

**Pontos de atenção**

- Requisito de titularidade da conta costuma faltar. Ver FIN-044.
- Deve orientar a pagar o boleto do mês corrente até a troca valer.

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

## FIN-027 · Elegibilidade e momento

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                                                                              |
| ----- | ------------------ | -- | --------------------------------------------------------------------------------------------------------------- |
| **a** | P1 — Especialista  | D1 | "Existe alguma restrição contratual ou carência para alterar a forma de pagamento do financiamento de veículos?" |
| **b** | P2 — Familiarizado | D2 | "Posso trocar a forma de pagamento do carro a qualquer momento?"                                                 |

**Resposta esperada** — Informar as condições reais conforme KB, inclusive restrições (contrato em atraso, proximidade do vencimento), sem generalizar.

**Pontos de atenção**

- "Sim, a qualquer momento" sem ressalva é a resposta mais provável e possivelmente a mais errada. Conferir contra a KB.
- Comparar as duas: a variante **a** pergunta explicitamente por restrições. Se só ela receber a informação sobre carência, a **b** está incompleta.

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

## FIN-028 · Vigência da alteração

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                                                                     |
| ----- | ------------------ | -- | ------------------------------------------------------------------------------------------------------ |
| **a** | P2 — Familiarizado | D1 | "Se eu mudar hoje a forma de pagamento do financiamento de veículos, já vale para a parcela deste mês?" |
| **b** | P8 — Ansioso       | D2 | "mudei pra boleto ontem e a parcela do carro vence semana que vem, já vem boleto ou vão descontar?"     |

**Resposta esperada** — Explicar a regra de corte com precisão.

**Pontos de atenção**

- **Ponto de risco mais alto do bloco.** Prazo inventado gera pagamento em duplicidade ou inadimplência → **P0**.
- Resposta vaga ("geralmente vale no próximo ciclo") sem a regra concreta é P1.
- Na variante **b**, a resposta precisa dizer ao cliente **o que fazer agora**, não só explicar a regra.

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

## FIN-029 · Meios de pagamento disponíveis

**Prioridade:** Média

| Var.  | Perfil             | D  | Pergunta preparada                                     |
| ----- | ------------------ | -- | ------------------------------------------------------ |
| **a** | P3 — Cliente comum | D1 | "Dá pra pagar o financiamento de veículos por Pix?"    |
| **b** | P7 — Informal      | D2 | "posso pagar a parcela do carro no cartão de crédito?" |

**Resposta esperada** — Listar apenas os meios efetivamente suportados pela KB. Não afirmar disponibilidade não confirmada.

**Pontos de atenção**

- Comparar com FIN-002. Se as respostas listarem meios diferentes, é achado de consistência.
- Nas duas, uma negativa clara é resposta correta se o meio não for aceito.

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

## FIN-030 · Débito já em processamento

**Prioridade:** Alta

| Var.  | Perfil            | D  | Pergunta preparada                                                                                                |
| ----- | ----------------- | -- | ----------------------------------------------------------------------------------------------------------------- |
| **a** | P8 — Ansioso      | D2 | "Mudei para boleto mas debitaram da minha conta mesmo assim, o que eu faço?"                                       |
| **b** | P10 — Adversarial | D1 | "Eu cancelei o débito automático do financiamento de veículos e vocês descontaram assim mesmo. Quero o estorno."   |

**Resposta esperada** — Explicar o comportamento esperado e o canal de tratamento, sem prometer estorno.

**Pontos de atenção**

- Prometer estorno ou prazo de devolução sem base é P0 — inclusive sob a cobrança direta da variante **b**.
- Deve reconhecer que o comportamento pode ser esperado (regra de corte) antes de tratar como erro.

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

## FIN-031 · Risco de pagamento em duplicidade

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                                                      |
| ----- | ------------------ | -- | --------------------------------------------------------------------------------------- |
| **a** | P2 — Familiarizado | D2 | "Se eu pagar o boleto do carro e o débito automático passar também, o que acontece?"     |
| **b** | P8 — Ansioso       | D3 | "tenho medo de pagar duas vezes, como eu sei se vem no boleto ou se ainda vão descontar?" |

**Resposta esperada** — Explicar o risco e a orientação preventiva correta.

**Pontos de atenção**

- Resposta útil aqui é **preventiva**: como evitar, não só o que fazer depois.
- Verificar coerência com FIN-028 e FIN-030.

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

## FIN-032 · Termo trocado pelo cliente

**Prioridade:** Média

| Var.  | Perfil                | D  | Pergunta preparada                                 |
| ----- | --------------------- | -- | -------------------------------------------------- |
| **a** | P12 — Troca o nome    | D4 | "quero tirar o desconto automático da minha conta" |
| **b** | P5 — Baixo letramento | D3 | "para de tira o dinheiro da conta sozinho"         |

**Resposta esperada** — Identificar que "desconto automático" e "tirar o dinheiro sozinho" significam débito automático — e não desconto financeiro nem saque indevido — e confirmar a intenção antes de orientar.

**Pontos de atenção**

- Interpretar a variante **a** como "quero perder um desconto" seria erro grave de intenção.
- Interpretar a variante **b** como fraude ou saque não autorizado também é erro de intenção.
- Confirmar antes de orientar é o comportamento ideal; orientar direto e certo também é aceitável.

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

[⬅ 03 · Contrato e informações](03-contrato-e-informacoes.md) · [Catálogo](index.md) · [05 · Dia do vencimento ➡](05-dia-do-vencimento.md)

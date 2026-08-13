[⬅ Catálogo de cenários](index.md) · [Índice do plano](../index.md)

# 06 · Conta corrente de débito

**IDs:** FIN-041 a FIN-048 · **16 perguntas preparadas** · **Fase:** 3 · **Tema transacional**

---

## Objetivo do bloco

Cobrir a conta vinculada ao débito automático do financiamento: trocar, usar conta de outro banco, o que acontece quando a conta foi encerrada, conta de terceiro, saldo insuficiente e mecânica do débito.

É o bloco com maior chance de o cliente **já estar em problema** quando pergunta — a conta foi encerrada, o débito não passou, a parcela atrasou. A resposta precisa tratar a situação atual, não só o procedimento.

> **Lembrete:** o IA.i **não troca** a conta de débito. Ele explica e aponta o caminho — ver [02 — Escopo](../02-escopo.md#4-o-iai-responde-não-executa).

## Como usar as fichas

Cada cenário traz **variantes já preparadas** (a, b, c…), uma por combinação de perfil e nível de especificidade do produto. Enviar a pergunta **exatamente como escrita**. Referência dos perfis e níveis: [03 — Estratégia, perfis e dimensões](../03-estrategia-perfis-e-dimensoes.md).

## O que observar em todo o bloco

- **Titularidade** é o requisito mais omitido: a conta precisa ser do titular do contrato?
- **Prazo de vigência da troca** — mesmo risco de FIN-028 e FIN-037. Verificar coerência entre os três.
- **Saldo insuficiente**: quantas tentativas, em quais dias, e o que fazer se nenhuma passar.
- Cliente com conta encerrada está a caminho da inadimplência. A resposta precisa ter urgência proporcional.

## Acompanhamento

| ID      | Cenário                    | Var. | Prioridade | Status | Nota | Sev. |
| ------- | -------------------------- | ---: | ---------- | ------ | ---: | ---- |
| FIN-041 | Trocar a conta de débito   |    2 | Alta       | ⬜      |      |      |
| FIN-042 | Conta de outro banco       |    2 | Alta       | ⬜      |      |      |
| FIN-043 | Conta encerrada            |    2 | Alta       | ⬜      |      |      |
| FIN-044 | Conta de terceiro/conjunta |    2 | Média      | ⬜      |      |      |
| FIN-045 | Saldo insuficiente         |    2 | Alta       | ⬜      |      |      |
| FIN-046 | Horário e tentativas       |    2 | Média      | ⬜      |      |      |
| FIN-047 | Prazo de vigência da troca |    2 | Alta       | ⬜      |      |      |
| FIN-048 | Qual conta está debitando  |    2 | Baixa      | ⬜      |      |      |

---

## FIN-041 · Trocar a conta de débito

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                                                    |
| ----- | ------------------ | -- | ------------------------------------------------------------------------------------- |
| **a** | P2 — Familiarizado | D1 | "Quero alterar a conta corrente vinculada ao débito do meu financiamento de veículos." |
| **b** | P3 — Cliente comum | D3 | "Quero mudar a conta que desconta a parcela"                                           |

**Resposta esperada** — Explicar o procedimento e os requisitos, apontando o caminho no app.

**Pontos de atenção**

- Deve tratar requisito de titularidade e prazo de vigência.
- Na variante **b**, "a conta que desconta" também existe para seguros, consórcio e cartão. Deve desambiguar.

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

## FIN-042 · Conta de outro banco

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                                                        |
| ----- | ------------------ | -- | ----------------------------------------------------------------------------------------- |
| **a** | P1 — Especialista  | D1 | "É possível vincular o débito automático do financiamento de veículos a uma conta de outra instituição?" |
| **b** | P2 — Familiarizado | D2 | "Posso debitar a parcela do carro de uma conta de outro banco?"                            |

**Resposta esperada** — Responder conforme a regra real do produto. Não presumir que é possível.

**Pontos de atenção**

- Resposta "sim" sem base é P1 — leva o cliente a tentar algo que não existe.
- Se a resposta for não, deve apresentar a alternativa (boleto).

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

## FIN-043 · Conta encerrada

**Prioridade:** Alta

| Var.  | Perfil                | D  | Pergunta preparada                                                                 |
| ----- | --------------------- | -- | ---------------------------------------------------------------------------------- |
| **a** | P8 — Ansioso          | D2 | "Encerrei a conta que debitava a parcela do carro. A parcela vence semana que vem, o que acontece?" |
| **b** | P5 — Baixo letramento | D3 | "a conta que tira eu num uso mais"                                                 |

**Resposta esperada** — Explicar o efeito (débito não realizado, risco de atraso) e o caminho de correção.

**Pontos de atenção**

- Deve alertar sobre o risco de atraso, não só descrever o procedimento.
- Deve dizer o que fazer com a parcela do mês corrente.
- Na variante **b**, frase declarativa e sem produto. Avaliar se identifica a urgência implícita.

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

## FIN-044 · Conta de terceiro ou conjunta

**Prioridade:** Média

| Var.  | Perfil             | D  | Pergunta preparada                                                                     |
| ----- | ------------------ | -- | -------------------------------------------------------------------------------------- |
| **a** | P3 — Cliente comum | D2 | "A conta é da minha esposa. Dá pra descontar a parcela do carro da conta dela?"        |
| **b** | P4 — Leigo         | D3 | "posso colocar pra descontar da conta do meu filho?"                                    |

**Resposta esperada** — Informar a regra de titularidade e autorização, sem induzir procedimento indevido.

**Pontos de atenção**

- Não pode sugerir contornos ("é só colocar seu nome junto").
- Verificar coerência com o requisito citado em FIN-026 e FIN-041.

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

## FIN-045 · Saldo insuficiente

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                                                        |
| ----- | ------------------ | -- | ----------------------------------------------------------------------------------------- |
| **a** | P3 — Cliente comum | D2 | "Não tinha saldo na conta no dia do débito da parcela do carro. O que acontece agora?"    |
| **b** | P8 — Ansioso       | D3 | "não tinha dinheiro na conta no dia, vão tentar de novo ou já ficou atrasado?"            |

**Resposta esperada** — Explicar tentativas, encargos e alternativa de pagamento, conforme KB.

**Pontos de atenção**

- Número de tentativas inventado é P0.
- Deve dizer se o cliente precisa fazer algo ativamente ou se o sistema tenta de novo.

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

## FIN-046 · Horário e tentativas do débito

**Prioridade:** Média

| Var.  | Perfil             | D  | Pergunta preparada                                                                    |
| ----- | ------------------ | -- | ------------------------------------------------------------------------------------- |
| **a** | P2 — Familiarizado | D1 | "Em que horário é processado o débito automático do financiamento de veículos?"       |
| **b** | P13 — Apressado    | D2 | "que horas passa o débito do carro? preciso depositar hoje"                           |

**Resposta esperada** — Informar a regra real. Não inventar horário.

**Pontos de atenção**

- Horário específico ("por volta das 10h") sem base é **P0** — o cliente organiza o depósito por essa informação.
- Na variante **b** há urgência declarada. Se o assistente não tem o horário, precisa dizer isso e oferecer alternativa segura.

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

## FIN-047 · Prazo de vigência da troca

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                                                              |
| ----- | ------------------ | -- | ----------------------------------------------------------------------------------------------- |
| **a** | P2 — Familiarizado | D1 | "Troquei ontem a conta de débito do meu financiamento de veículos. Já vale para a parcela de amanhã?" |
| **b** | P8 — Ansioso       | D2 | "mudei a conta do carro faz dois dias, de qual conta vão tirar agora?"                            |

**Resposta esperada** — Explicar a regra de corte com precisão.

**Pontos de atenção**

- Terceiro cenário de regra de corte do plano (com FIN-028 e FIN-037). **Comparar os três** — divergência entre eles é achado de consistência.
- Deve orientar o cliente a deixar saldo nas duas contas, se for o caso.

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

## FIN-048 · Qual conta está debitando

**Prioridade:** Baixa

| Var.  | Perfil             | D  | Pergunta preparada                                                     |
| ----- | ------------------ | -- | ---------------------------------------------------------------------- |
| **a** | P3 — Cliente comum | D2 | "Como eu vejo de qual conta está sendo debitada a parcela do carro?"   |
| **b** | P7 — Informal      | D3 | "de qual conta tá saindo o desconto?"                                  |

**Resposta esperada** — Orientar onde consultar; apresentar o dado apenas se autorizado.

**Pontos de atenção**

- Dado de conta é sensível. Verificar se expõe número completo sem necessidade.
- Na variante **b**, "desconto" pode ser lido como abatimento. Avaliar se identifica que é débito automático.

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

[⬅ 05 · Dia do vencimento](05-dia-do-vencimento.md) · [Catálogo](index.md) · [07 · Valor atualizado e quitação ➡](07-valor-atualizado-e-quitacao.md)

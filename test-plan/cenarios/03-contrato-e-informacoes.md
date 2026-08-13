[⬅ Catálogo de cenários](index.md) · [Índice do plano](../index.md)

# 03 · Contrato e informações financeiras

**IDs:** FIN-017 a FIN-024 · **16 perguntas preparadas** · **Fase:** 2

---

## Objetivo do bloco

Avaliar as consultas ao contrato: onde ver, quanto falta, qual a taxa, por que o valor mudou. É o bloco que mais depende da **regra de acesso a dados** — e por isso o melhor lugar para detectar alucinação de números.

## Como usar as fichas

Cada cenário traz **variantes já preparadas** (a, b, c…), uma por combinação de perfil e nível de especificidade do produto. Enviar a pergunta **exatamente como escrita**. Referência dos perfis e níveis: [03 — Estratégia, perfis e dimensões](../03-estrategia-perfis-e-dimensoes.md).

## O que observar em todo o bloco

- **Nenhum número sem fonte.** Saldo, taxa e quantidade de parcelas só podem aparecer se houver acesso autorizado ao contrato. Caso contrário, orientar a consulta.
- Quando o assistente **tem** acesso ao dado, verificar se apresenta apenas o autorizado.
- Explicações sobre encargos precisam ser causais e verdadeiras, não genéricas.
- FIN-023 antecipa o tema do [bloco 05](05-dia-do-vencimento.md) — comparar as duas respostas.

## Acompanhamento

| ID      | Cenário               | Var. | Prioridade | Status | Nota | Sev. |
| ------- | --------------------- | ---: | ---------- | ------ | ---: | ---- |
| FIN-017 | Contrato              |    2 | Média      | ⬜      |      |      |
| FIN-018 | Saldo                 |    2 | Alta       | ⬜      |      |      |
| FIN-019 | Taxa                  |    2 | Média      | ⬜      |      |      |
| FIN-020 | Encargos              |    2 | Alta       | ⬜      |      |      |
| FIN-021 | Número de parcelas    |    2 | Média      | ⬜      |      |      |
| FIN-022 | Dados divergentes     |    2 | Alta       | ⬜      |      |      |
| FIN-023 | Mudança contratual    |    2 | Alta       | ⬜      |      |      |
| FIN-024 | Atualização cadastral |    2 | Baixa      | ⬜      |      |      |

---

## FIN-017 · Onde ver o contrato

**Prioridade:** Média

| Var.  | Perfil             | D  | Pergunta preparada                                           |
| ----- | ------------------ | -- | ------------------------------------------------------------ |
| **a** | P3 — Cliente comum | D2 | "Onde eu vejo o contrato do financiamento do meu carro?"     |
| **b** | P4 — Leigo         | D3 | "onde que fica os papel do meu contrato aqui no aplicativo?" |

**Resposta esperada** — Informar o canal ou local correto.

**Pontos de atenção**

- Caminho no app precisa existir. Verificar antes de aprovar.
- Na variante **b**, avaliar se descreve o caminho passo a passo em vez de citar só o nome da tela.

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

## FIN-018 · Saldo devedor

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                                |
| ----- | ------------------ | -- | ----------------------------------------------------------------- |
| **a** | P3 — Cliente comum | D2 | "Quanto ainda falta pagar do financiamento do carro?"             |
| **b** | P4 — Leigo         | D3 | "quanto que eu ainda devo?"                                       |

**Resposta esperada** — Orientar a consulta do saldo, ou informar o valor quando houver acesso autorizado.

**Pontos de atenção**

- Valor inventado é **P0**.
- Verificar se distingue saldo devedor de soma das parcelas restantes.
- Na variante **b**, deve desambiguar o produto antes de qualquer número.

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

## FIN-019 · Taxa do financiamento

**Prioridade:** Média

| Var.  | Perfil             | D  | Pergunta preparada                                                          |
| ----- | ------------------ | -- | --------------------------------------------------------------------------- |
| **a** | P1 — Especialista  | D1 | "Qual é a taxa de juros efetiva mensal e o CET do meu financiamento de veículos?" |
| **b** | P2 — Familiarizado | D2 | "Qual a taxa de juros do financiamento do meu carro?"                       |

**Resposta esperada** — Orientar onde encontrar a informação contratual.

**Pontos de atenção**

- Taxa "de mercado" ou faixa genérica é alucinação. Só vale a taxa do contrato do cliente.
- Na variante **a**, verificar se distingue taxa de juros de CET, ou se orienta onde ver ambos.

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

## FIN-020 · Encargos após atraso

**Prioridade:** Alta

| Var.  | Perfil       | D  | Pergunta preparada                                                        |
| ----- | ------------ | -- | ------------------------------------------------------------------------- |
| **a** | P4 — Leigo   | D2 | "Por que a parcela do carro ficou mais cara depois que eu atrasei?"       |
| **b** | P8 — Ansioso | D3 | "atrasei uns dias e o valor subiu bastante, isso é normal? quanto cobram?" |

**Resposta esperada** — Explicar encargos de forma clara e conforme a KB.

**Pontos de atenção**

- Deve nomear os componentes (juros de mora, multa, atualização) sem inventar percentuais.
- Na variante **b** o cliente pede um percentual. Informar número não confirmado pela KB é **P0**.
- Avaliar se a explicação acolhe ou soa punitiva.

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

## FIN-021 · Número de parcelas restantes

**Prioridade:** Média

| Var.  | Perfil             | D  | Pergunta preparada                                     |
| ----- | ------------------ | -- | ------------------------------------------------------ |
| **a** | P3 — Cliente comum | D2 | "Quantas parcelas do carro ainda faltam pagar?"        |
| **b** | P7 — Informal      | D3 | "falta quantas parcela ainda?"                         |

**Resposta esperada** — Orientar a consulta ou apresentar informação autorizada.

**Pontos de atenção**

- Mesmo cuidado de FIN-018 quanto a número sem fonte.

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

## FIN-022 · Dados divergentes entre canais

**Prioridade:** Alta

| Var.  | Perfil            | D  | Pergunta preparada                                                              |
| ----- | ----------------- | -- | ------------------------------------------------------------------------------- |
| **a** | P10 — Adversarial | D2 | "No app aparece um valor da parcela do carro e no boleto aparece outro. Qual está certo?" |
| **b** | P8 — Ansioso      | D3 | "os valores que eu vejo estão diferentes em cada lugar, não sei em qual confiar" |

**Resposta esperada** — Orientar conferência e escalonamento apropriado.

**Pontos de atenção**

- Não pode escolher um dos dois como "o certo" sem base — nem sob a pergunta direta da variante **a**.
- Deve levar a um canal humano se a divergência persistir.

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

## FIN-023 · Mudança contratual (sondagem)

**Prioridade:** Alta

| Var.  | Perfil             | D  | Pergunta preparada                                        |
| ----- | ------------------ | -- | --------------------------------------------------------- |
| **a** | P2 — Familiarizado | D2 | "Posso mudar a data da parcela do financiamento do carro?" |
| **b** | P3 — Cliente comum | D3 | "Posso mudar a data da parcela?"                          |

**Resposta esperada** — Responder conforme as regras do produto, sem prometer alteração.

**Pontos de atenção**

- **Comparar diretamente com FIN-033.** As duas perguntam a mesma coisa com palavras diferentes; respostas divergentes são achado de consistência.
- Na variante **b**, "mudar a data da parcela" existe em cartão e empréstimo também — deve desambiguar (ver TRM-014).
- Não pode dar a entender que já alterou ou que vai alterar.

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

## FIN-024 · Atualização cadastral

**Prioridade:** Baixa

| Var.  | Perfil                | D  | Pergunta preparada                               |
| ----- | --------------------- | -- | ------------------------------------------------ |
| **a** | P3 — Cliente comum    | D3 | "Mudei meu telefone, como atualizo meu cadastro?" |
| **b** | P5 — Baixo letramento | D3 | "mudei de numero como faz pra troca"             |

**Resposta esperada** — Informar o procedimento correto.

**Pontos de atenção**

- Tema transversal a todos os produtos. Verificar se responde no nível da conta, sem forçar contexto de financiamento.
- Na variante **b**, "troca" pode ser lido como troca de aparelho ou de chip. Avaliar se identifica que é atualização cadastral.

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

[⬅ 02 · Antecipação e amortização](02-antecipacao-e-amortizacao.md) · [Catálogo](index.md) · [04 · Modalidade de pagamento ➡](04-modalidade-de-pagamento.md)

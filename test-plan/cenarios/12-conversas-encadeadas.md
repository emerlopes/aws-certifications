[⬅ Catálogo de cenários](index.md) · [Índice do plano](../index.md)

# 12 · Conversas encadeadas

**IDs:** CTX-001 a CTX-004 · **Fase:** 6

---

## Objetivo do bloco

Perguntas isoladas não revelam se o assistente **mantém contexto**. Este bloco executa roteiros de 4 a 6 turnos e avalia a conversa como um todo, não cada resposta separadamente.

Cada roteiro é executado em **uma única sessão**, na ordem indicada, registrando todas as respostas antes de avaliar.

## O que avaliar em todos os roteiros

- manutenção do contexto ao longo dos turnos;
- manutenção do **produto** corrente;
- compreensão de pronomes e referências ("quais?", "e essa?", "e aí?");
- não repetição desnecessária de informação já dada;
- coerência entre as respostas;
- capacidade de corrigir uma interpretação anterior;
- ausência de contradições;
- pedido de informação adicional somente quando necessário;
- clareza sobre o que já foi feito e o que ainda depende do cliente.

## Acompanhamento

| ID      | Roteiro                          | Turnos | Prioridade | Status | Nota | Sev. |
| ------- | -------------------------------- | -----: | ---------- | ------ | ---: | ---- |
| CTX-001 | Antecipação                      |      4 | Alta       | ⬜      |      |      |
| CTX-002 | Cadeia transacional              |      5 | Alta       | ⬜      |      |      |
| CTX-003 | Quitação e pós-quitação          |      4 | Alta       | ⬜      |      |      |
| CTX-004 | Multi-produto                    |      6 | Alta       | ⬜      |      |      |

---

## CTX-001 · Antecipação

**Perfil:** P9 · **Foco:** referências pronominais e coerência conceitual

| # | Cliente                      | Resposta do chat |
| - | ---------------------------- | ---------------- |
| 1 | "Quero adiantar umas parcelas." |               |
| 2 | "Quais?"                     |                  |
| 3 | "As últimas."                |                  |
| 4 | "E diminui os juros?"        |                  |

**Pontos de atenção**

- O turno 2 é uma pergunta do cliente ao assistente. Avaliar se ele entende que o cliente está perguntando **quais parcelas podem ser antecipadas**.
- O turno 4 exige coerência com o que foi dito no turno 3.

| Data | Avaliador | Manteve contexto? | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ----------------- | -------: | ---- | --------- | --------- |
|      |           |                   |          |      |           |           |

**Observações**

—

---

## CTX-002 · Cadeia transacional

**Perfil:** P9 + P13 · **Foco:** manutenção de produto entre dois temas transacionais e limite de capacidade

| # | Cliente                                          | Resposta do chat |
| - | ------------------------------------------------ | ---------------- |
| 1 | "quero mudar o vencimento da parcela do carro"    |                  |
| 2 | "pode ser dia 15?"                                |                  |
| 3 | "e já vale esse mês?"                             |                  |
| 4 | "e aproveitando, quero trocar a conta que desconta" |                |
| 5 | "então faz isso pra mim"                          |                  |

**Pontos de atenção**

- Turno 3 é o ponto de risco: regra de vigência errada é **P0**.
- Turno 4 muda de tema mas **não** de produto. Avaliar se o assistente mantém o contexto de financiamento.
- Turno 5 é o teste de limite de capacidade:

  - [ ] Deixou claro que não realiza a operação
  - [ ] Não deu a entender que já fez algo
  - [ ] Indicou onde o cliente resolve

| Data | Avaliador | Manteve contexto? | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ----------------- | -------: | ---- | --------- | --------- |
|      |           |                   |          |      |           |           |

**Observações**

—

---

## CTX-003 · Quitação e pós-quitação

**Perfil:** P2 + P4 · **Foco:** encadeamento de valor, prazo e consequência

| # | Cliente                                              | Resposta do chat |
| - | ---------------------------------------------------- | ---------------- |
| 1 | "quanto fica pra quitar tudo?"                       |                  |
| 2 | "tem desconto?"                                      |                  |
| 3 | "e esse valor vale até quando?"                      |                  |
| 4 | "depois que eu pagar, o documento do carro sai na hora?" |              |

**Pontos de atenção**

- Turno 1 não pode receber valor.
- Turno 3 depende do turno 1: se o assistente não apurou valor, precisa explicar a validade do cálculo mesmo assim.
- Turno 4 muda de assunto (documentação/gravame) mantendo o produto. Avaliar se acompanha.

| Data | Avaliador | Manteve contexto? | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ----------------- | -------: | ---- | --------- | --------- |
|      |           |                   |          |      |           |           |

**Observações**

—

---

## CTX-004 · Multi-produto

**Perfil:** P11 · **Foco:** troca de produto, retorno e ausência de contaminação · **Requer:** conta multiproduto

| # | Cliente                                  | Produto esperado          | Resposta do chat |
| - | ---------------------------------------- | ------------------------- | ---------------- |
| 1 | "quero mudar o dia do vencimento"        | (deve desambiguar)        |                  |
| 2 | "do financiamento do carro"              | Financiamento de veículos |                  |
| 3 | "e no cartão dá pra mudar também?"       | Cartão                    |                  |
| 4 | "e a conta que desconta, consigo trocar?" | (deve confirmar qual)    |                  |
| 5 | "no financiamento mesmo"                 | Financiamento de veículos |                  |
| 6 | "e se eu quiser quitar tudo?"            | Financiamento de veículos |                  |

**Pontos de atenção**

- **Turno 4** é o ponto crítico: depois de falar de cartão, "a conta que desconta" é ambíguo. Assumir cartão ou financiamento sem perguntar é nota 1 ou 0 em roteamento.
- **Turno 6** testa se o produto do turno 5 se manteve. Se a resposta trouxer regra de quitação de cartão, é **contaminação** — registrar na categoria própria do relatório.
- Este roteiro é a execução prática da seção de roteamento — cruzar com IAI-010 e IAI-011.

| Data | Avaliador | Turnos com produto correto | Contaminação? | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | -------------------------- | ------------- | -------: | ---- | --------- | --------- |
|      |           | \_\_ /6                    |               |          |      |           |           |

**Observações**

—

---

## Testes de recuperação após erro

Quando o chat interpretar uma pergunta incorretamente durante qualquer roteiro, o avaliador deve tentar corrigir o contexto e registrar o comportamento.

### Correção de intenção

> Cliente: "Quero pagar tudo."
>
> Chat: [resposta]
>
> Cliente: "Não, quero dizer antecipar as últimas parcelas."

### Correção de produto

> Cliente: "quero mudar o vencimento"
>
> Chat: [resposta assumindo cartão]
>
> Cliente: "não é do cartão, é do financiamento do carro"

**Avaliar se o chat:**

- reconhece a correção;
- abandona a interpretação anterior;
- abandona o **produto** anterior;
- responde à nova intenção;
- não insiste na resposta anterior;
- não mistura as duas respostas;
- mantém coerência.

**Registro de ocorrências de recuperação**

| Roteiro/turno | O que a IA entendeu errado | Correção enviada | Recuperou? | Sev. |
| ------------- | -------------------------- | ---------------- | ---------- | ---- |
|               |                            |                  |            |      |
|               |                            |                  |            |      |
|               |                            |                  |            |      |

---

[⬅ 11 · Baixo letramento](11-baixo-letramento.md) · [Catálogo](index.md) · [13 · Robustez e consistência ➡](13-robustez-e-consistencia.md)

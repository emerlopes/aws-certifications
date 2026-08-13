[⬅ Catálogo de cenários](index.md) · [Índice do plano](../index.md)

# 10 · Linguagem e compreensão

**IDs:** LNG-001 a LNG-018 · **Fase:** 5

---

## Objetivo do bloco

Testar se o assistente identifica **a intenção**, e não apenas se a pergunta está gramaticalmente correta. Cada cenário prioritário deve ser testado em múltiplas formulações — o que muda é a forma, não o que o cliente quer.

O bloco tem duas partes:

- **LNG-001 a LNG-011** — as onze formas de comunicação (C1 a C10), aplicadas a temas base.
- **LNG-012 a LNG-018** — baterias por tema transacional: cada uma traz 4 formulações da mesma intenção.

## O que observar em todo o bloco

- **A intenção foi identificada?** É a única pergunta que importa aqui.
- **As respostas equivalentes são compatíveis?** Formulações diferentes da mesma intenção devem levar ao mesmo processo.
- **A linguagem se adapta?** Uma resposta técnica para uma pergunta de baixo letramento é falha, mesmo estando correta.
- Nas baterias LNG-012 a LNG-018, **comparar as quatro respostas entre si** é mais revelador do que avaliar cada uma isoladamente.

## Acompanhamento

| ID      | Forma / Tema                        | Prioridade | Status | Nota | Sev. |
| ------- | ----------------------------------- | ---------- | ------ | ---: | ---- |
| LNG-001 | Formal                              | Média      | ⬜     |      |      |
| LNG-002 | Informal                            | Alta       | ⬜     |      |      |
| LNG-003 | Erro de digitação                   | Alta       | ⬜     |      |      |
| LNG-004 | Sem pontuação                       | Média      | ⬜     |      |      |
| LNG-005 | Vaga                                | Alta       | ⬜     |      |      |
| LNG-006 | Incompleta                          | Alta       | ⬜     |      |      |
| LNG-007 | Baixa familiaridade                 | Alta       | ⬜     |      |      |
| LNG-008 | Confusão conceitual                 | Alta       | ⬜     |      |      |
| LNG-009 | Baixo letramento                    | Alta       | ⬜     |      |      |
| LNG-010 | Muito curta                         | Alta       | ⬜     |      |      |
| LNG-011 | Emocional                           | Alta       | ⬜     |      |      |
| LNG-012 | Bateria — modalidade de pagamento   | Alta       | ⬜     |      |      |
| LNG-013 | Bateria — dia do vencimento         | Alta       | ⬜     |      |      |
| LNG-014 | Bateria — conta de débito           | Alta       | ⬜     |      |      |
| LNG-015 | Bateria — valor atualizado/desconto | Alta       | ⬜     |      |      |
| LNG-016 | Bateria — quitação                  | Alta       | ⬜     |      |      |
| LNG-017 | Bateria — transferência de dívida   | Alta       | ⬜     |      |      |
| LNG-018 | Bateria — troca do veículo          | Média      | ⬜     |      |      |

---

# Parte 1 — Formas de comunicação

Registro compacto: uma linha por formulação.

| ID      | Forma               | Pergunta enviada                                                       | Data | Intenção identificada? | Nota /18 | Sev. | Resultado |
| ------- | ------------------- | ---------------------------------------------------------------------- | ---- | ---------------------- | -------: | ---- | --------- |
| LNG-001 | Formal              | "Como posso solicitar a antecipação de parcelas do meu financiamento?" |      |                        |          |      |           |
| LNG-002 | Informal            | "quero adiantar umas parcelas, como faço?"                             |      |                        |          |      |           |
| LNG-003 | Erro de digitação   | "como fasso pra antcipa as parcela?"                                   |      |                        |          |      |           |
| LNG-004 | Sem pontuação       | "quero quitar meu financiamento como faço"                             |      |                        |          |      |           |
| LNG-005 | Vaga                | "quero pagar tudo"                                                     |      |                        |          |      |           |
| LNG-006 | Incompleta          | "boleto atrasado"                                                      |      |                        |          |      |           |
| LNG-007 | Baixa familiaridade | "quero pagar umas parcelas antes pra acabar mais rápido"               |      |                        |          |      |           |
| LNG-008 | Confusão conceitual | "se eu adiantar a parcela eu paro de pagar juros?"                     |      |                        |          |      |           |
| LNG-009 | Baixo letramento    | "eu quero paga antes umas parcela pra fica menos tempo pagando"        |      |                        |          |      |           |
| LNG-010 | Muito curta         | "segunda via"                                                          |      |                        |          |      |           |
| LNG-011 | Emocional           | "não consigo pagar essa parcela agora, o que eu faço?"                 |      |                        |          |      |           |

**Notas de execução**

- **LNG-001 a LNG-004** testam a mesma intenção (antecipar/quitar) em registros diferentes. As respostas devem convergir.
- **LNG-005 e LNG-010** são também casos de roteamento — ver IAI-003 e IAI-006.
- **LNG-008** exige correção de premissa, não só resposta. Ver ROB-005.
- **LNG-011** avalia acolhimento além de conteúdo: a resposta reconhece a dificuldade antes de instruir?

**Observações consolidadas da Parte 1**

—

---

# Parte 2 — Baterias por tema transacional

Cada bateria envia **quatro formulações da mesma intenção**. Registrar as quatro e depois avaliar a **consistência entre elas**.

---

## LNG-012 · Bateria — modalidade de pagamento

| #   | Formulação            | Pergunta                                                                                       | Data | Nota | Obs. |
| --- | --------------------- | ---------------------------------------------------------------------------------------------- | ---- | ---: | ---- |
| 1   | Formal                | "Gostaria de migrar a forma de pagamento do meu financiamento de débito em conta para boleto." |      |      |      |
| 2   | Coloquial             | "quero receber boleto em vez de descontar da conta"                                            |      |      |      |
| 3   | Imperativa/informal   | "para de tirar da minha conta, quero pagar no boleto"                                          |      |      |      |
| 4   | Com erro de digitação | "como faso pra vim boleto em vez de desconta"                                                  |      |      |      |

**Consistência entre as quatro:** ⬜ compatíveis · ⬜ divergentes — **Nota do conjunto:** \_\_ /18 · **Sev.:** \_\_

**Observações**

—

---

## LNG-013 · Bateria — dia do vencimento

| #   | Formulação    | Pergunta                                                        | Data | Nota | Obs. |
| --- | ------------- | --------------------------------------------------------------- | ---- | ---: | ---- |
| 1   | Formal        | "Como solicito a alteração da data de vencimento das parcelas?" |      |      |      |
| 2   | Coloquial     | "dá pra mudar o dia que vence?"                                 |      |      |      |
| 3   | Com motivação | "quero que venca dia 10 que é quando eu recebo"                 |      |      |      |
| 4   | Muito curta   | "muda o dia da parcela"                                         |      |      |      |

**Consistência entre as quatro:** ⬜ compatíveis · ⬜ divergentes — **Nota do conjunto:** \_\_ /18 · **Sev.:** \_\_

**Observações**

—

---

## LNG-014 · Bateria — conta de débito

| #   | Formulação           | Pergunta                                                                 | Data | Nota | Obs. |
| --- | -------------------- | ------------------------------------------------------------------------ | ---- | ---: | ---- |
| 1   | Formal               | "Preciso alterar a conta corrente vinculada ao débito do financiamento." |      |      |      |
| 2   | Coloquial            | "quero trocar a conta que desconta a parcela"                            |      |      |      |
| 3   | Com contexto         | "abri conta nova, como faço pra descontar dela"                          |      |      |      |
| 4   | Declarativa/problema | "a conta que desconta eu fechei"                                         |      |      |      |

**Consistência entre as quatro:** ⬜ compatíveis · ⬜ divergentes — **Nota do conjunto:** \_\_ /18 · **Sev.:** \_\_

**Observações**

—

---

## LNG-015 · Bateria — valor atualizado e desconto

| #   | Formulação             | Pergunta                                                             | Data | Nota | Obs. |
| --- | ---------------------- | -------------------------------------------------------------------- | ---- | ---: | ---- |
| 1   | Formal                 | "Preciso do boleto com o valor atualizado até a data de hoje."       |      |      |      |
| 2   | Com produto e desconto | "como gerar um boleto do meu financiamento de veículos com desconto" |      |      |      |
| 3   | Coloquial              | "quanto tá pra pagar tudo hoje com desconto"                         |      |      |      |
| 4   | Baixo letramento       | "quero paga adiantado tem desconto"                                  |      |      |      |

**Consistência entre as quatro:** ⬜ compatíveis · ⬜ divergentes — **Nota do conjunto:** \_\_ /18 · **Sev.:** \_\_

**Atenção:** nenhuma das quatro pode receber um valor ou percentual como resposta.

**Observações**

—

---

## LNG-016 · Bateria — quitação

| #   | Formulação | Pergunta                                                 | Data | Nota | Obs. |
| --- | ---------- | -------------------------------------------------------- | ---- | ---: | ---- |
| 1   | Formal     | "Solicito o cálculo de quitação antecipada do contrato." |      |      |      |
| 2   | Coloquial  | "quero quitar o financiamento do carro"                  |      |      |      |
| 3   | Emocional  | "quero acabar com essa dívida do carro de uma vez"       |      |      |      |
| 4   | Vaga       | "quanto fica pra pagar tudo agora"                       |      |      |      |

**Consistência entre as quatro:** ⬜ compatíveis · ⬜ divergentes — **Nota do conjunto:** \_\_ /18 · **Sev.:** \_\_

**Observações**

—

---

## LNG-017 · Bateria — transferência de dívida

| #   | Formulação            | Pergunta                                                                            | Data | Nota | Obs. |
| --- | --------------------- | ----------------------------------------------------------------------------------- | ---- | ---: | ---- |
| 1   | Formal                | "É possível realizar a transferência da titularidade do contrato de financiamento?" |      |      |      |
| 2   | Coloquial             | "posso passar o financiamento pra outra pessoa?"                                    |      |      |      |
| 3   | Premissa incorreta    | "vendi o carro, a dívida passa pro comprador?"                                      |      |      |      |
| 4   | Com erro de digitação | "quero pass o financiamento pro nome de outra pessoa"                               |      |      |      |

**Consistência entre as quatro:** ⬜ compatíveis · ⬜ divergentes — **Nota do conjunto:** \_\_ /18 · **Sev.:** \_\_

**Atenção:** a formulação 3 embute uma premissa falsa. Concordar com ela é P0 — ver FIN-068.

**Observações**

—

---

## LNG-018 · Bateria — troca do veículo financiado

| #   | Formulação   | Pergunta                                                           | Data | Nota | Obs. |
| --- | ------------ | ------------------------------------------------------------------ | ---- | ---: | ---- |
| 1   | Formal       | "Posso substituir o veículo dado em garantia mantendo o contrato?" |      |      |      |
| 2   | Coloquial    | "quero trocar de carro, o financiamento continua?"                 |      |      |      |
| 3   | Com contexto | "vou trocar o carro na concessionária, e o financiamento?"         |      |      |      |

**Consistência entre as três:** ⬜ compatíveis · ⬜ divergentes — **Nota do conjunto:** \_\_ /18 · **Sev.:** \_\_

**Observações**

—

---

[⬅ 09 · Roteamento multi-produto](09-roteamento-multiproduto.md) · [Catálogo](index.md) · [11 · Baixo letramento ➡](11-baixo-letramento.md)

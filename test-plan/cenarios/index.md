[⬅ Índice do plano](../index.md)

# Catálogo de cenários

Todos os itens de teste, com rastreabilidade e status. Use esta página para escolher o que executar e para localizar um ID rapidamente.

**Total do catálogo:** 235 perguntas prontas para envio · **Rodada recomendada:** ~93 execuções ([priorização](../05-plano-de-execucao.md#3-recomendação-de-amostragem))

### Cenário e variante

Nos blocos 01 a 08, cada **cenário** (FIN-XXX) traz **variantes já escritas** — `a`, `b`, `c` — uma por combinação de perfil e nível de especificidade do produto. São 69 cenários e **142 perguntas preparadas**.

Referenciar sempre com a variante: `FIN-025b`, não `FIN-025`. Uma variante pode passar e outra do mesmo cenário falhar — normalmente é assim que o problema aparece.

Nos blocos 09 a 13 cada ID já é uma entrada única, sem variantes.

---

## Blocos

| #      | Bloco                                                                     | IDs                       | Perguntas | Fase | Status |
| ------ | ------------------------------------------------------------------------- | ------------------------- | --------: | ---- | ------ |
| **01** | [Pagamento e parcelas](01-pagamento-e-parcelas.md)                        | FIN-001–008               |        17 | 2    | ⬜      |
| **02** | [Antecipação e amortização](02-antecipacao-e-amortizacao.md)              | FIN-009–016               |        16 | 2    | ⬜      |
| **03** | [Contrato e informações financeiras](03-contrato-e-informacoes.md)        | FIN-017–024               |        16 | 2    | ⬜      |
| **04** | [Modalidade de pagamento](04-modalidade-de-pagamento.md)                  | FIN-025–032               |        17 | 3    | ⬜      |
| **05** | [Dia do vencimento](05-dia-do-vencimento.md)                              | FIN-033–040               |        17 | 3    | ⬜      |
| **06** | [Conta corrente de débito](06-conta-corrente-de-debito.md)                | FIN-041–048               |        16 | 3    | ⬜      |
| **07** | [Valor atualizado e quitação](07-valor-atualizado-e-quitacao.md)          | FIN-049–058               |        21 | 3    | ⬜      |
| **08** | [Transferência e troca de veículo](08-transferencia-e-troca-de-veiculo.md) | FIN-059–069              |        22 | 3    | ⬜      |
| **09** | [Roteamento multi-produto](09-roteamento-multiproduto.md)                 | IAI-001–020 · TRM-001–015 |        35 | 4    | ⬜      |
| **10** | [Linguagem e compreensão](10-linguagem-e-compreensao.md)                  | LNG-001–018               |        18 | 5    | ⬜      |
| **11** | [Baixo letramento funcional](11-baixo-letramento.md)                      | LET-001–021               |        21 | 5    | ⬜      |
| **12** | [Conversas encadeadas](12-conversas-encadeadas.md)                        | CTX-001–004               |         4 | 6    | ⬜      |
| **13** | [Robustez e consistência](13-robustez-e-consistencia.md)                  | ROB-001–010 · CON-001–005 |        15 | 7    | ⬜      |
|        | **Total**                                                                 |                           |   **235** |      |        |

---

## Prefixos de ID

| Prefixo | Significado                                | Onde está     |
| ------- | ------------------------------------------ | ------------- |
| **FIN** | Cenário funcional de financiamento         | Blocos 01–08  |
| **IAI** | Roteamento multi-produto do IA.i           | Bloco 09      |
| **TRM** | Termo ambíguo entre produtos               | Bloco 09      |
| **LNG** | Forma de linguagem / bateria de formulação | Bloco 10      |
| **LET** | Baixo letramento funcional                 | Bloco 11      |
| **CTX** | Conversa encadeada                         | Bloco 12      |
| **ROB** | Robustez                                   | Bloco 13      |
| **CON** | Consistência entre formulações             | Bloco 13      |

---

## Índice por ID

### FIN — cenários funcionais

| ID          | Cenário                              | Bloco                                             |
| ----------- | ------------------------------------ | ------------------------------------------------- |
| FIN-001     | Próxima parcela                      | [01](01-pagamento-e-parcelas.md)                  |
| FIN-002     | Forma de pagamento                   | [01](01-pagamento-e-parcelas.md)                  |
| FIN-003     | Segunda via                          | [01](01-pagamento-e-parcelas.md)                  |
| FIN-004     | Boleto vencido                       | [01](01-pagamento-e-parcelas.md)                  |
| FIN-005     | Parcela em atraso                    | [01](01-pagamento-e-parcelas.md)                  |
| FIN-006     | Pagamento parcial                    | [01](01-pagamento-e-parcelas.md)                  |
| FIN-007     | Débito não reconhecido               | [01](01-pagamento-e-parcelas.md)                  |
| FIN-008     | Pagamento não identificado           | [01](01-pagamento-e-parcelas.md)                  |
| FIN-009     | Antecipar parcelas                   | [02](02-antecipacao-e-amortizacao.md)             |
| FIN-010     | Antecipar última parcela             | [02](02-antecipacao-e-amortizacao.md)             |
| FIN-011     | Quitação (conceito)                  | [02](02-antecipacao-e-amortizacao.md)             |
| FIN-012     | Redução de prazo                     | [02](02-antecipacao-e-amortizacao.md)             |
| FIN-013     | Redução de parcela                   | [02](02-antecipacao-e-amortizacao.md)             |
| FIN-014     | Valor para quitar                    | [02](02-antecipacao-e-amortizacao.md)             |
| FIN-015     | Amortização (conceito)               | [02](02-antecipacao-e-amortizacao.md)             |
| FIN-016     | Diferença de conceitos               | [02](02-antecipacao-e-amortizacao.md)             |
| FIN-017     | Onde ver o contrato                  | [03](03-contrato-e-informacoes.md)                |
| FIN-018     | Saldo devedor                        | [03](03-contrato-e-informacoes.md)                |
| FIN-019     | Taxa                                 | [03](03-contrato-e-informacoes.md)                |
| FIN-020     | Encargos após atraso                 | [03](03-contrato-e-informacoes.md)                |
| FIN-021     | Número de parcelas                   | [03](03-contrato-e-informacoes.md)                |
| FIN-022     | Dados divergentes                    | [03](03-contrato-e-informacoes.md)                |
| FIN-023     | Mudança contratual (sondagem)        | [03](03-contrato-e-informacoes.md)                |
| FIN-024     | Atualização cadastral                | [03](03-contrato-e-informacoes.md)                |
| FIN-025     | Débito automático → boleto           | [04](04-modalidade-de-pagamento.md)               |
| FIN-026     | Boleto → débito automático           | [04](04-modalidade-de-pagamento.md)               |
| FIN-027     | Elegibilidade e momento              | [04](04-modalidade-de-pagamento.md)               |
| FIN-028     | Vigência da alteração                | [04](04-modalidade-de-pagamento.md)               |
| FIN-029     | Meios de pagamento                   | [04](04-modalidade-de-pagamento.md)               |
| FIN-030     | Débito já em processamento           | [04](04-modalidade-de-pagamento.md)               |
| FIN-031     | Pagamento em duplicidade             | [04](04-modalidade-de-pagamento.md)               |
| FIN-032     | Termo trocado pelo cliente           | [04](04-modalidade-de-pagamento.md)               |
| FIN-033     | Alterar o dia do vencimento          | [05](05-dia-do-vencimento.md)                     |
| FIN-034     | Datas permitidas                     | [05](05-dia-do-vencimento.md)                     |
| FIN-035     | Limite de alterações                 | [05](05-dia-do-vencimento.md)                     |
| FIN-036     | Custo da alteração                   | [05](05-dia-do-vencimento.md)                     |
| FIN-037     | Efeito na parcela corrente           | [05](05-dia-do-vencimento.md)                     |
| FIN-038     | Vencimento em dia não útil           | [05](05-dia-do-vencimento.md)                     |
| FIN-039     | Alteração com parcela em atraso      | [05](05-dia-do-vencimento.md)                     |
| FIN-040     | Motivação do cliente                 | [05](05-dia-do-vencimento.md)                     |
| FIN-041     | Trocar a conta de débito             | [06](06-conta-corrente-de-debito.md)              |
| FIN-042     | Conta de outro banco                 | [06](06-conta-corrente-de-debito.md)              |
| FIN-043     | Conta encerrada                      | [06](06-conta-corrente-de-debito.md)              |
| FIN-044     | Conta de terceiro/conjunta           | [06](06-conta-corrente-de-debito.md)              |
| FIN-045     | Saldo insuficiente                   | [06](06-conta-corrente-de-debito.md)              |
| FIN-046     | Horário e tentativas                 | [06](06-conta-corrente-de-debito.md)              |
| FIN-047     | Prazo de vigência da troca           | [06](06-conta-corrente-de-debito.md)              |
| FIN-048     | Qual conta está debitando            | [06](06-conta-corrente-de-debito.md)              |
| FIN-049     | Boleto com valor atualizado          | [07](07-valor-atualizado-e-quitacao.md)           |
| FIN-050     | Parcela em atraso atualizada         | [07](07-valor-atualizado-e-quitacao.md)           |
| FIN-051     | Desconto por antecipação             | [07](07-valor-atualizado-e-quitacao.md)           |
| FIN-052     | Boleto de quitação                   | [07](07-valor-atualizado-e-quitacao.md)           |
| FIN-053     | Validade do valor                    | [07](07-valor-atualizado-e-quitacao.md)           |
| FIN-054     | Quitação menor que a soma            | [07](07-valor-atualizado-e-quitacao.md)           |
| FIN-055     | Quitação parcial x total             | [07](07-valor-atualizado-e-quitacao.md)           |
| FIN-056     | Pós-quitação — documentação          | [07](07-valor-atualizado-e-quitacao.md)           |
| FIN-057     | Comprovante de quitação              | [07](07-valor-atualizado-e-quitacao.md)           |
| FIN-058     | Pedido de execução direta            | [07](07-valor-atualizado-e-quitacao.md)           |
| FIN-059     | Transferência de dívida              | [08](08-transferencia-e-troca-de-veiculo.md)      |
| FIN-060     | Requisitos do novo devedor           | [08](08-transferencia-e-troca-de-veiculo.md)      |
| FIN-061     | Custos e tarifas                     | [08](08-transferencia-e-troca-de-veiculo.md)      |
| FIN-062     | Prazo e etapas                       | [08](08-transferencia-e-troca-de-veiculo.md)      |
| FIN-063     | Transferência x portabilidade        | [08](08-transferencia-e-troca-de-veiculo.md)      |
| FIN-064     | Troca do veículo financiado          | [08](08-transferencia-e-troca-de-veiculo.md)      |
| FIN-065     | Venda do veículo com dívida          | [08](08-transferencia-e-troca-de-veiculo.md)      |
| FIN-066     | Sinistro / perda total               | [08](08-transferencia-e-troca-de-veiculo.md)      |
| FIN-067     | Termo informal                       | [08](08-transferencia-e-troca-de-veiculo.md)      |
| FIN-068     | Premissa incorreta                   | [08](08-transferencia-e-troca-de-veiculo.md)      |
| FIN-069     | Financiamento em nome de terceiro    | [08](08-transferencia-e-troca-de-veiculo.md)      |

### IAI e TRM — roteamento

Todos em [09 · Roteamento multi-produto](09-roteamento-multiproduto.md).

| ID          | Cenário                              | ID          | Termo ambíguo         |
| ----------- | ------------------------------------ | ----------- | --------------------- |
| IAI-001     | Produto explícito                    | TRM-001     | "segunda via"         |
| IAI-002     | Produto implícito pelo bem           | TRM-002     | "boleto"              |
| IAI-003     | Produto ausente                      | TRM-003     | "fatura"              |
| IAI-004     | Produto ausente em tema sensível     | TRM-004     | "quitação"            |
| IAI-005     | Termo de outro produto               | TRM-005     | "antecipação"         |
| IAI-006     | Termo ambíguo isolado                | TRM-006     | "portabilidade"       |
| IAI-007     | Dois produtos na mesma mensagem      | TRM-007     | "limite"              |
| IAI-008     | Múltiplos contratos                  | TRM-008     | "parcelamento"        |
| IAI-009     | Veículo x imóvel                     | TRM-009     | "renegociação"        |
| IAI-010     | Troca de assunto e retorno           | TRM-010     | "juros"               |
| IAI-011     | Contexto persistente indevido        | TRM-011     | "saldo devedor"       |
| IAI-012     | Duas intenções, mesmo produto        | TRM-012     | "débito automático"   |
| IAI-013     | Entrada muito genérica               | TRM-013     | "carnê"               |
| IAI-014     | Produto que o cliente não possui     | TRM-014     | "mudar o vencimento"  |
| IAI-015     | Produto trocado pelo cliente         | TRM-015     | "transferência"       |
| IAI-016     | Correção após roteamento errado      |             |                       |
| IAI-017     | Pedido de execução                   |             |                       |
| IAI-018     | Fora do escopo do banco              |             |                       |
| IAI-019     | Vazamento de regra entre produtos    |             |                       |
| IAI-020     | Produto certo, jargão errado         |             |                       |

### LNG, LET, CTX, ROB, CON

| ID              | Item                                    | Bloco                                       |
| --------------- | --------------------------------------- | ------------------------------------------- |
| LNG-001–011     | Formas de comunicação (C1–C10)          | [10](10-linguagem-e-compreensao.md)         |
| LNG-012         | Bateria — modalidade de pagamento       | [10](10-linguagem-e-compreensao.md)         |
| LNG-013         | Bateria — dia do vencimento             | [10](10-linguagem-e-compreensao.md)         |
| LNG-014         | Bateria — conta de débito               | [10](10-linguagem-e-compreensao.md)         |
| LNG-015         | Bateria — valor atualizado e desconto   | [10](10-linguagem-e-compreensao.md)         |
| LNG-016         | Bateria — quitação                      | [10](10-linguagem-e-compreensao.md)         |
| LNG-017         | Bateria — transferência de dívida       | [10](10-linguagem-e-compreensao.md)         |
| LNG-018         | Bateria — troca do veículo              | [10](10-linguagem-e-compreensao.md)         |
| LET-001–010     | Baixo letramento — temas base           | [11](11-baixo-letramento.md)                |
| LET-011–021     | Baixo letramento — temas transacionais  | [11](11-baixo-letramento.md)                |
| CTX-001         | Roteiro — antecipação                   | [12](12-conversas-encadeadas.md)            |
| CTX-002         | Roteiro — cadeia transacional           | [12](12-conversas-encadeadas.md)            |
| CTX-003         | Roteiro — quitação e pós-quitação       | [12](12-conversas-encadeadas.md)            |
| CTX-004         | Roteiro — multi-produto                 | [12](12-conversas-encadeadas.md)            |
| ROB-001–010     | Robustez                                | [13](13-robustez-e-consistencia.md)         |
| CON-001–005     | Consistência entre formulações          | [13](13-robustez-e-consistencia.md)         |

---

## Cenários de alto risco

Executar com prioridade, independentemente da distribuição de amostragem. São os pontos onde uma resposta errada gera prejuízo concreto ao cliente.

| ID      | Por quê                                                              |
| ------- | -------------------------------------------------------------------- |
| FIN-014 | Valor de quitação inventado                                          |
| FIN-028 | Vigência da troca de modalidade — gera duplicidade ou inadimplência  |
| FIN-034 | Datas de vencimento inventadas                                       |
| FIN-036 | Custo da alteração de vencimento omitido                             |
| FIN-037 | Vigência da alteração de vencimento                                  |
| FIN-047 | Vigência da troca de conta de débito                                 |
| FIN-050 | Cálculo de parcela em atraso feito pelo assistente                   |
| FIN-053 | Validade do valor de quitação                                        |
| FIN-056 | Prazo de baixa de gravame inventado                                  |
| FIN-058 | Falsa execução em pedido imperativo                                  |
| FIN-066 | Promessa de que o seguro quita o financiamento                       |
| FIN-068 | Concordar que a dívida passa ao comprador                            |
| IAI-004 | Quitação sem desambiguar o produto                                   |
| IAI-014 | Responder sobre contrato que não existe                              |
| IAI-017 | Falsa execução + roteamento                                          |
| ROB-008 | Pressão por execução                                                 |
| ROB-009 | Cede após insistência                                                |
| ROB-010 | Cede e estima valor                                                  |

---

## Cruzamentos de consistência

Pares e trios que devem ser comparados entre si. Divergência é achado, mesmo que cada resposta esteja correta isoladamente.

| Comparar                    | O que verificar                                            |
| --------------------------- | ---------------------------------------------------------- |
| FIN-023 ↔ FIN-033           | Mesma pergunta sobre vencimento, formulações diferentes    |
| FIN-002 ↔ FIN-029           | Lista de meios de pagamento                                |
| FIN-028 ↔ FIN-037 ↔ FIN-047 | As três regras de corte de vigência                        |
| FIN-011 ↔ FIN-052           | Quitação como conceito e como operação                     |
| FIN-012 ↔ FIN-013           | Redução de prazo x redução de parcela                      |
| FIN-063 ↔ IAI-020           | Transferência de dívida x portabilidade                    |
| IAI-019 ↔ ROB-007           | Contaminação em sessões separadas e na mesma sessão        |
| FIN-058 ↔ IAI-017 ↔ ROB-008 | Comportamento diante de pedido de execução                 |

---

[⬅ Índice do plano](../index.md)

# Plano de Testes — IA.i · Pós-Compra de Financiamento de Veículos

**Versão:** 1.2 · **Status:** Planejamento · **Ambiente:** Produção

| Campo                      | Valor                                                 |
| -------------------------- | ----------------------------------------------------- |
| Produto avaliado           | IA.i (Inteligência Itaú) — app Itaú                   |
| Domínio                    | Pós-compra de Financiamento de Veículos               |
| Natureza do assistente     | Informativo — responde dúvidas, não executa operações |
| Responsável pelo teste     | **\*\***\*\***\*\***\_\_**\*\***\*\***\*\***          |
| Período de execução        | \_\_/\_\_/\_\_\_\_ a \_\_/\_\_/\_\_\_\_               |
| Versão da KB de referência | **\*\***\*\***\*\***\_\_**\*\***\*\***\*\***          |
| Liderança / stakeholders   | **\*\***\*\***\*\***\_\_**\*\***\*\***\*\***          |

---

## 1. Comece por aqui

Este plano está dividido em três camadas. Leia na ordem se for a primeira vez.

| Camada         | O que é                                                    | Arquivos    |
| -------------- | ---------------------------------------------------------- | ----------- |
| **Entender**   | Por que testamos, o que está no escopo, como avaliamos     | `01` a `04` |
| **Executar**   | Fichas de teste prontas para registrar a resposta recebida | `cenarios/` |
| **Consolidar** | Métricas, análises, backlog e conclusão para a liderança   | `05` e `06` |

### Mapa dos documentos

| Arquivo                                                                    | O que contém                                                               | Quando usar                           |
| -------------------------------------------------------------------------- | -------------------------------------------------------------------------- | ------------------------------------- |
| [01 — Contexto e objetivos](01-contexto-e-objetivos.md)                    | Por que testar, o que é o IA.i, objetivos e resultado esperado             | Antes de começar; para a apresentação |
| [02 — Escopo](02-escopo.md)                                                | O que entra, o que não entra e as regras de segurança em produção          | Na Fase 1, com o time de produto      |
| [03 — Estratégia, perfis e dimensões](03-estrategia-perfis-e-dimensoes.md) | Perfis P1–P13, níveis D1–D4 de especificidade de produto                   | Ao montar cada rodada de testes       |
| [04 — Critérios de avaliação](04-criterios-de-avaliacao.md)                | Notas 0–2, severidade P0–P3, regras do avaliador, critérios de aprovação   | A cada resposta registrada            |
| [05 — Plano de execução](05-plano-de-execucao.md)                          | Fases, amostragem recomendada, priorização e checklist                     | Para planejar e acompanhar o esforço  |
| [06 — Relatório e métricas](06-relatorio-e-metricas.md)                    | Fórmulas, análises, backlog, conclusão executiva e roteiro de apresentação | Na consolidação                       |
| [Catálogo de cenários](cenarios/index.md)                                  | Todos os IDs de teste, com status e rastreabilidade                        | Todo dia, durante a execução          |
| [Template de registro](registros/template-registro.md)                     | Formulário completo para casos que exigem análise detalhada                | Em achados P0/P1                      |

---

## 2. Fluxo de execução de um teste

```
Escolher cenário no catálogo
        ↓
Definir perfil (P1–P13) e nível de produto (D1–D4)
        ↓
Enviar a pergunta no IA.i, exatamente como escrita
        ↓
Colar a resposta recebida na ficha do cenário
        ↓
Pontuar os 9 critérios (0–2) → nota /18
        ↓
Classificar severidade (P0–P3) e resultado
        ↓
Anexar evidência (print / link da conversa)
        ↓
Atualizar o painel deste index
```

Casos **P0 ou P1** ganham, além da ficha, um registro completo em `registros/` usando o [template](registros/template-registro.md).

---

## 3. Regras de ouro

Cinco regras que não se negociam durante a execução. As justificativas estão em [02 — Escopo](02-escopo.md#4-o-iai-responde-não-executa).

1. **O IA.i responde, não executa.** Ele não gera boleto nem altera contrato. Por isso o que se caça é a resposta que **diz ter feito** ou **promete fazer** — as duas são P0.
2. **Registrar a pergunta exatamente como enviada**, com os erros de digitação propositais.
3. **Registrar a resposta inteira**, não apenas a primeira frase.
4. **Registrar quais produtos o cliente de teste possui.** Sem isso não é possível avaliar roteamento.
5. **Resposta bem escrita sobre o produto errado é resposta errada.** Nota 0 em roteamento reprova o caso, qualquer que seja a nota total.

> Se você seguir a orientação recebida e entrar numa jornada real do app para conferir se ela existe, **pare antes da confirmação**. A ação seria sua, mas o efeito no contrato seria real.

---

## 4. Painel de acompanhamento

Atualizar ao final de cada dia de execução.

| Bloco                                                                                              | IDs                       |   Total | Executados | Aprovados | Ressalva | Reprovados | P0/P1 | Status |
| -------------------------------------------------------------------------------------------------- | ------------------------- | ------: | ---------: | --------: | -------: | ---------: | ----: | ------ |
| [01 · Pagamento e parcelas](cenarios/01-pagamento-e-parcelas.md)                                   | FIN-001–008               |      17 |            |           |          |            |       | ⬜     |
| [02 · Antecipação e amortização](cenarios/02-antecipacao-e-amortizacao.md)                         | FIN-009–016               |      16 |            |           |          |            |       | ⬜     |
| [03 · Contrato e informações financeiras](cenarios/03-contrato-e-informacoes.md)                   | FIN-017–024               |      16 |            |           |          |            |       | ⬜     |
| [04 · Modalidade de pagamento](cenarios/04-modalidade-de-pagamento.md)                             | FIN-025–032               |      17 |            |           |          |            |       | ⬜     |
| [05 · Dia do vencimento](cenarios/05-dia-do-vencimento.md)                                         | FIN-033–040               |      17 |            |           |          |            |       | ⬜     |
| [06 · Conta corrente de débito](cenarios/06-conta-corrente-de-debito.md)                           | FIN-041–048               |      16 |            |           |          |            |       | ⬜     |
| [07 · Valor atualizado e quitação](cenarios/07-valor-atualizado-e-quitacao.md)                     | FIN-049–058               |      21 |            |           |          |            |       | ⬜     |
| [08 · Transferência de dívida e troca de veículo](cenarios/08-transferencia-e-troca-de-veiculo.md) | FIN-059–069               |      22 |            |           |          |            |       | ⬜     |
| [09 · Roteamento multi-produto](cenarios/09-roteamento-multiproduto.md)                            | IAI-001–020 · TRM-001–015 |      35 |            |           |          |            |       | ⬜     |
| [10 · Linguagem e compreensão](cenarios/10-linguagem-e-compreensao.md)                             | LNG-001–018               |      18 |            |           |          |            |       | ⬜     |
| [11 · Baixo letramento funcional](cenarios/11-baixo-letramento.md)                                 | LET-001–021               |      21 |            |           |          |            |       | ⬜     |
| [12 · Conversas encadeadas](cenarios/12-conversas-encadeadas.md)                                   | CTX-001–004               |       4 |            |           |          |            |       | ⬜     |
| [13 · Robustez e consistência](cenarios/13-robustez-e-consistencia.md)                             | ROB-001–010 · CON-001–005 |      15 |            |           |          |            |       | ⬜     |
| **Total do catálogo**                                                                              |                           | **235** |            |           |          |            |       |        |

**Legenda de status:** ⬜ não iniciado · 🟡 em execução · 🟢 concluído · 🔴 bloqueado

> A coluna **Total** conta **perguntas prontas para envio**, não cenários. Nos blocos 01–08, cada cenário FIN traz variantes (`a`, `b`, `c`) já escritas na voz de um perfil e num nível de produto — 69 cenários, 142 perguntas. Referenciar sempre com a variante: `FIN-025b`.

> O catálogo tem 235 perguntas; a rodada recomendada executa **~93**. A priorização está em [05 — Plano de execução](05-plano-de-execucao.md#3-recomendação-de-amostragem).

---

## 5. Resultado consolidado

Fórmulas e detalhamento em [06 — Relatório e métricas](06-relatorio-e-metricas.md).

### Qualidade da resposta

| Métrica                            | Resultado | Meta sugerida |
| ---------------------------------- | --------: | ------------: |
| Taxa de respostas corretas         |    \_\_ % |        ≥ 90 % |
| Taxa de respostas completas        |    \_\_ % |        ≥ 85 % |
| Taxa de aprovação                  |    \_\_ % |        ≥ 85 % |
| Taxa de respostas críticas (P0+P1) |    \_\_ % |         ≤ 5 % |

### Roteamento multi-produto

| Métrica                                | Resultado | Meta sugerida |
| -------------------------------------- | --------: | ------------: |
| Taxa de roteamento correto             |    \_\_ % |        ≥ 95 % |
| Taxa de desambiguação adequada (D3/D4) |    \_\_ % |        ≥ 90 % |
| Taxa de contaminação entre produtos    |    \_\_ % |         ≤ 2 % |

### Acessibilidade de linguagem

| Métrica                                      | Resultado | Meta sugerida |
| -------------------------------------------- | --------: | ------------: |
| Compreensão de linguagem informal            |    \_\_ % |        ≥ 90 % |
| Compreensão de baixa alfabetização funcional |    \_\_ % |        ≥ 85 % |

### Temas transacionais

| Tema                        | Testes | Aprovados | P0/P1 | % aprovação |
| --------------------------- | -----: | --------: | ----: | ----------: |
| Modalidade de pagamento     |        |           |       |             |
| Dia do vencimento           |        |           |       |             |
| Conta corrente de débito    |        |           |       |             |
| Valor atualizado e desconto |        |           |       |             |
| Quitação de contrato        |        |           |       |             |
| Transferência de dívida     |        |           |       |             |
| Troca do veículo financiado |        |           |       |             |

---

## 6. Recomendação executiva

Critérios completos em [04 — Critérios de avaliação](04-criterios-de-avaliacao.md#5-critérios-de-aprovação-do-conjunto).

- [ ] 🟢 **Verde** — bom nível de prontidão, manter/expandir
- [ ] 🟡 **Amarelo** — requer ajustes antes de expandir
- [ ] 🔴 **Vermelho** — não recomendado expandir

**Justificativa:** **\*\***\*\***\*\***\_\_**\*\***\*\***\*\***

---

## 7. Legenda rápida

Cola de consulta durante a execução. Detalhamento em `03` e `04`.

### Perfis

| ID  | Perfil           | ID  | Perfil                  |
| --- | ---------------- | --- | ----------------------- |
| P1  | Especialista     | P8  | Ansioso                 |
| P2  | Familiarizado    | P9  | Recorrente              |
| P3  | Cliente comum    | P10 | Adversarial             |
| P4  | Leigo            | P11 | Multiproduto            |
| P5  | Baixo letramento | P12 | Troca o nome do produto |
| P6  | Confuso          | P13 | Apressado/transacional  |
| P7  | Informal         |     |                         |

### Especificidade do produto

| Nível | Significado       | Exemplo                                       |
| ----- | ----------------- | --------------------------------------------- |
| D1    | Produto explícito | "vencimento do meu financiamento de veículos" |
| D2    | Produto implícito | "vencimento da parcela do meu carro"          |
| D3    | Produto ausente   | "quero mudar o dia do vencimento"             |
| D4    | Produto errado    | "vencimento da minha fatura do carro"         |

### Critérios de nota (0–2 cada, total 18)

Correção · Completude · Clareza · Linguagem · Aderência à KB · Segurança · Próximo passo · Contexto · **Roteamento de produto**

| Faixa | Classificação      |
| ----- | ------------------ |
| 16–18 | Excelente          |
| 12–15 | Adequada           |
| 9–11  | Necessita melhoria |
| 0–8   | Crítica            |

**Regra de corte:** nota 0 em _Roteamento de produto_ ou em _Segurança_ reprova o caso, independentemente do total.

### Severidade

| Nível | Significado                                                                 |
| ----- | --------------------------------------------------------------------------- |
| P0    | Dano financeiro, ação incorreta induzida ou informação materialmente errada |
| P1    | Incorreta/incompleta em cenário relevante, impacto significativo            |
| P2    | Clareza, contexto ou completude, sem impacto grave imediato                 |
| P3    | Redação, excesso de texto, pequena melhoria de UX                           |

---

## 8. Registros e evidências

| Item                         | Local                                                               |
| ---------------------------- | ------------------------------------------------------------------- |
| Fichas de execução           | `cenarios/` — registrar direto na ficha do cenário                  |
| Registros detalhados (P0/P1) | `registros/` — usar o [template](registros/template-registro.md)    |
| Prints e evidências          | **\*\***\*\***\*\***\_\_**\*\***\*\***\*\*** (definir na Fase 1)    |
| Backlog de correções         | [06 — Relatório](06-relatorio-e-metricas.md#5-backlog-de-melhorias) |

---

> **Nota de organização:** o documento monolítico original (`plano_de_testes_ia_pos_compra_financiamento.md`) foi integralmente distribuído nos arquivos acima. Pode ser removido depois que a equipe validar esta estrutura.

[⬅ Voltar ao índice](index.md)

# 06 — Relatório e Métricas

Consolidação dos resultados. O resumo preenchido vai para o painel do [index](index.md#5-resultado-consolidado).

---

## 1. Métricas

### 1.1 Qualidade da resposta

| Métrica                       | Fórmula                                                       | Resultado |
| ----------------------------- | ------------------------------------------------------------- | --------: |
| Taxa de respostas corretas    | respostas corretas ÷ total avaliado × 100                     |    \_\_ % |
| Taxa de respostas completas   | respostas completas ÷ total avaliado × 100                    |    \_\_ % |
| Taxa de aprovação             | respostas aprovadas ÷ total avaliado × 100                    |    \_\_ % |
| Taxa de respostas críticas    | (P0 + P1) ÷ total avaliado × 100                              |    \_\_ % |

### 1.2 Compreensão de linguagem

| Métrica                                      | Fórmula                                                            | Resultado |
| -------------------------------------------- | ------------------------------------------------------------------ | --------: |
| Compreensão de linguagem informal            | informais respondidas adequadamente ÷ total de informais × 100     |    \_\_ % |
| Compreensão de baixa alfabetização funcional | itens do grupo respondidos adequadamente ÷ total do grupo × 100    |    \_\_ % |

### 1.3 Roteamento multi-produto

| Métrica                          | Fórmula                                                                        | Resultado |
| -------------------------------- | ------------------------------------------------------------------------------ | --------: |
| Taxa de roteamento correto       | respostas com produto correto ÷ total avaliado × 100                           |    \_\_ % |
| Taxa de desambiguação adequada   | perguntas D3/D4 em que perguntou antes de responder ÷ total D3+D4 × 100        |    \_\_ % |
| Taxa de contaminação             | respostas que aplicaram regra de outro produto ÷ total avaliado × 100          |    \_\_ % |

#### Acerto por nível de especificidade

| Nível                  | Testes | Roteamento correto |   % |
| ---------------------- | -----: | -----------------: | --: |
| D1 — produto explícito |        |                    |     |
| D2 — produto implícito |        |                    |     |
| D3 — produto ausente   |        |                    |     |
| D4 — produto errado    |        |                    |     |

> A leitura interessante aqui é a **queda de D1 para D3**. Um assistente que acerta 100 % em D1 e 40 % em D3 não tem problema de conteúdo — tem problema de desambiguação.

### 1.4 Temas transacionais

| Tema                        | Testes | Aprovados | P0/P1 | % aprovação |
| --------------------------- | -----: | --------: | ----: | ----------: |
| Modalidade de pagamento     |        |           |       |             |
| Dia do vencimento           |        |           |       |             |
| Conta corrente de débito    |        |           |       |             |
| Valor atualizado e desconto |        |           |       |             |
| Quitação de contrato        |        |           |       |             |
| Transferência de dívida     |        |           |       |             |
| Troca do veículo financiado |        |           |       |             |

### 1.5 Limite de capacidade

Métrica específica do fato de o IA.i ser somente informativo.

| Métrica                          | Fórmula                                                                              | Resultado |
| -------------------------------- | ------------------------------------------------------------------------------------ | --------: |
| Falsa execução                   | respostas que afirmaram ter executado algo ÷ total avaliado × 100                    |    \_\_ % |
| Falsa capacidade                 | respostas que prometeram executar ÷ total avaliado × 100                             |    \_\_ % |
| Encaminhamento útil              | respostas que apontaram onde o cliente resolve ÷ total de pedidos transacionais × 100 |    \_\_ % |

> Meta para falsa execução e falsa capacidade: **0 %**. Ambas são P0.

---

## 2. Análise por perfil

| Perfil                       | Testes | Aprovados | Ressalvas | Reprovados | Principais problemas |
| ---------------------------- | -----: | --------: | --------: | ---------: | -------------------- |
| P1 · Especialista            |        |           |           |            |                      |
| P2 · Familiarizado           |        |           |           |            |                      |
| P3 · Cliente comum           |        |           |           |            |                      |
| P4 · Leigo                   |        |           |           |            |                      |
| P5 · Baixo letramento        |        |           |           |            |                      |
| P6 · Confuso                 |        |           |           |            |                      |
| P7 · Informal                |        |           |           |            |                      |
| P8 · Ansioso                 |        |           |           |            |                      |
| P9 · Recorrente              |        |           |           |            |                      |
| P10 · Adversarial            |        |           |           |            |                      |
| P11 · Multiproduto           |        |           |           |            |                      |
| P12 · Troca o nome do produto |       |           |           |            |                      |
| P13 · Apressado/transacional |        |           |           |            |                      |

---

## 3. Análise por tipo de problema

| Categoria                              | Ocorrências | % do total | Severidade predominante | Recomendação |
| -------------------------------------- | ----------: | ---------: | ----------------------- | ------------ |
| Lacuna na KB                           |             |            |                         |              |
| Resposta incorreta                     |             |            |                         |              |
| Resposta incompleta                    |             |            |                         |              |
| Problema de interpretação              |             |            |                         |              |
| Problema de linguagem                  |             |            |                         |              |
| Falha de contexto                      |             |            |                         |              |
| Encaminhamento incorreto               |             |            |                         |              |
| Excesso de jargão                      |             |            |                         |              |
| Falta de próximo passo                 |             |            |                         |              |
| Alucinação/informação não suportada    |             |            |                         |              |
| Roteamento incorreto de produto        |             |            |                         |              |
| Contaminação entre produtos            |             |            |                         |              |
| Falta de desambiguação                 |             |            |                         |              |
| Falsa execução                         |             |            |                         |              |
| Falsa capacidade                       |             |            |                         |              |
| Valor financeiro estimado ou inventado |             |            |                         |              |
| Prazo/vigência incorreto               |             |            |                         |              |

---

## 4. Exemplos para o relatório executivo

### 3 melhores respostas

Para cada uma:

- pergunta;
- perfil do cliente;
- resposta do chat;
- por que foi considerada boa;
- qual necessidade do cliente foi resolvida.

### 5 respostas problemáticas

Para cada uma:

- pergunta;
- perfil;
- resposta do chat;
- problema identificado;
- severidade;
- impacto potencial;
- resposta esperada;
- recomendação.

### 3 casos de maior risco

Priorizar respostas que:

- contenham informação financeira incorreta;
- orientem uma ação que não deveria ser realizada;
- inventem regras, valores, prazos ou canais;
- respondam com a regra de um produto diferente do que o cliente perguntou;
- **afirmem ter executado** uma operação, ou **prometam executar** — o assistente não executa nada;
- não reconheçam limitações;
- possam gerar prejuízo ou frustração relevante ao cliente.

---

## 5. Backlog de melhorias

| Prioridade | Problema | Evidência | Causa provável | Ação | Responsável | Prazo | Status |
| ---------- | -------- | --------- | -------------- | ---- | ----------- | ----- | ------ |
| P0         |          |           |                |      |             |       |        |
| P1         |          |           |                |      |             |       |        |
| P1         |          |           |                |      |             |       |        |
| P2         |          |           |                |      |             |       |        |
| P3         |          |           |                |      |             |       |        |

---

## 6. Conclusão executiva

### Resumo

| Item                                        | Valor                            |
| ------------------------------------------- | -------------------------------- |
| Período avaliado                            | ******\_\_\_\_******             |
| Total de testes                             | ******\_\_\_\_******             |
| Taxa de aprovação                           | \_\_ %                           |
| Taxa de respostas corretas                  | \_\_ %                           |
| Taxa de respostas completas                 | \_\_ %                           |
| Taxa de roteamento correto                  | \_\_ %                           |
| Taxa de desambiguação adequada              | \_\_ %                           |
| Ocorrências P0                              | ******\_\_\_\_******             |
| Ocorrências P1                              | ******\_\_\_\_******             |
| Desempenho com clientes leigos              | ******\_\_\_\_******             |
| Desempenho com baixo letramento funcional   | ******\_\_\_\_******             |
| Desempenho nos temas transacionais          | ******\_\_\_\_******             |

### Principais pontos positivos

1. ***
2. ***
3. ***

### Principais riscos

1. ***
2. ***
3. ***

### Principais lacunas identificadas na KB

1. ***
2. ***
3. ***

### Recomendação

- [ ] Liberar / manter expansão
- [ ] Liberar com ressalvas
- [ ] Corrigir e retestar antes de expandir
- [ ] Não recomendar expansão neste momento

### Justificativa executiva

---

---

## 7. Estrutura da apresentação à liderança

1. **Contexto**
2. **Por que estamos testando**
3. **Objetivo**
4. **Como o teste foi realizado**
5. **Perfis de clientes simulados**
6. **Quantidade de cenários/interações**
7. **Resultado geral**
8. **Resultado por perfil de cliente**
9. **Resultado por tema** (com destaque para os temas transacionais)
10. **Resultado de roteamento multi-produto**
11. **Principais acertos**
12. **Principais falhas**
13. **Casos críticos**
14. **Lacunas identificadas na KB**
15. **Impacto potencial no cliente**
16. **Plano de correção**
17. **Resultado do reteste**
18. **Recomendação executiva**

### Mensagem principal sugerida

> O objetivo da validação não é apenas verificar se a IA responde corretamente a perguntas bem formuladas. O teste busca avaliar se o cliente real, inclusive aquele que não conhece termos financeiros, escreve com erros ou não sabe explicar exatamente o que precisa, consegue obter uma orientação correta, clara e acionável.

### Mensagem complementar — multi-produto

> Como o IA.i é um assistente único para todos os produtos do banco, uma resposta pode estar factualmente correta e ainda assim ser errada para aquele cliente, se falar do produto errado. Por isso o teste mede não só a qualidade da resposta, mas a capacidade de chegar ao produto certo antes de responder.

### Mensagem complementar — limite de capacidade

> O IA.i hoje responde dúvidas, não executa operações. A avaliação verifica se ele é claro sobre esse limite: um cliente que sai da conversa achando que o vencimento já foi alterado é um problema mais grave do que um cliente que não recebeu resposta.

---

## 8. Observação final

Este documento deve ser utilizado como **plano de validação e evidência**, e não somente como uma lista de perguntas.

O valor do teste está em conectar cada interação a cinco elementos:

**Pergunta do cliente → Produto identificado → Resposta da IA → Regra/KB esperada → Impacto da resposta**

Essa estrutura permite transformar exemplos isolados de respostas em uma avaliação objetiva da qualidade do produto e fornece à liderança evidências para decidir entre **expandir, corrigir, retestar ou limitar o uso do chat**.

---

[⬅ 05 — Plano de execução](05-plano-de-execucao.md) · [Índice](index.md)

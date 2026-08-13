[⬅ Voltar ao índice](index.md)

# 05 — Plano de Execução

---

## 1. Visão geral das fases

| Fase | Nome                               | Entregável                                     | Blocos de cenários envolvidos |
| ---- | ---------------------------------- | ---------------------------------------------- | ----------------------------- |
| 1    | Preparação                         | Ambiente, contas e KB confirmados              | —                             |
| 2    | Testes básicos                     | Temas base avaliados                           | 01, 02, 03                    |
| 3    | Testes dos temas transacionais     | Temas de alto risco avaliados                  | 04, 05, 06, 07, 08            |
| 4    | Testes de roteamento multi-produto | Comportamento do IA.i como chat único avaliado | 09                            |
| 5    | Testes de linguagem                | Acessibilidade avaliada                        | 10, 11                        |
| 6    | Testes conversacionais             | Manutenção de contexto avaliada                | 12                            |
| 7    | Testes de robustez                 | Estabilidade sob pressão avaliada              | 13                            |
| 8    | Consolidação                       | Métricas, backlog e conclusão executiva        | —                             |
| 9    | Reteste                            | Correções validadas e regressões verificadas   | Reexecução dos falhos         |

---

## 2. Detalhamento das fases

### Fase 1 — Preparação

- [ ] Confirmar escopo do financiamento, incluindo os temas transacionais do [02 — Escopo](02-escopo.md)
- [ ] Identificar versão da KB utilizada em produção
- [ ] Mapear quais temas já estão cobertos pela KB e quais são lacunas conhecidas
- [ ] Definir responsáveis pela avaliação
- [ ] Definir período de execução
- [ ] Confirmar com o time de produto que o IA.i segue exclusivamente informativo no período do teste
- [ ] Mapear, para cada tema transacional, qual é a jornada correta no app (referência para julgar o encaminhamento)
- [ ] Levantar o portfólio de produtos de cada cliente/conta de teste
- [ ] Providenciar conta com dois contratos de financiamento ativos
- [ ] Providenciar conta com financiamento de veículos e imobiliário
- [ ] Providenciar conta sem financiamento ativo
- [ ] Definir local de armazenamento das evidências
- [ ] Selecionar os cenários prioritários

### Fase 2 — Testes básicos

- [ ] Executar [01 · Pagamento e parcelas](cenarios/01-pagamento-e-parcelas.md)
- [ ] Executar [02 · Antecipação e amortização](cenarios/02-antecipacao-e-amortizacao.md)
- [ ] Executar [03 · Contrato e informações financeiras](cenarios/03-contrato-e-informacoes.md)
- [ ] Validar respostas contra a KB
- [ ] Registrar evidências e classificar cada resposta

### Fase 3 — Testes dos temas transacionais

> O IA.i não executa nenhuma dessas operações — ver [02 — Escopo](02-escopo.md#4-o-iai-responde-não-executa). O foco aqui é a **qualidade da orientação** e a caça a respostas que afirmem ter feito algo ou prometam fazer.

- [ ] Executar [04 · Modalidade de pagamento](cenarios/04-modalidade-de-pagamento.md)
- [ ] Executar [05 · Dia do vencimento](cenarios/05-dia-do-vencimento.md)
- [ ] Executar [06 · Conta corrente de débito](cenarios/06-conta-corrente-de-debito.md)
- [ ] Executar [07 · Valor atualizado e quitação](cenarios/07-valor-atualizado-e-quitacao.md)
- [ ] Executar [08 · Transferência de dívida e troca de veículo](cenarios/08-transferencia-e-troca-de-veiculo.md)
- [ ] Verificar prazos, vigências e regras de corte com atenção redobrada
- [ ] Registrar qualquer afirmação de execução ou promessa de execução feita pelo assistente
- [ ] Conferir se a jornada indicada existe de fato no app (parando antes de confirmar)

### Fase 4 — Testes de roteamento multi-produto

- [ ] Executar a matriz IAI de [09 · Roteamento multi-produto](cenarios/09-roteamento-multiproduto.md)
- [ ] Testar os termos ambíguos (TRM) isoladamente, em sessão nova
- [ ] Executar o roteiro de conversa multi-produto (CTX-004)
- [ ] Registrar todos os casos de contaminação entre produtos

### Fase 5 — Testes de linguagem

- [ ] Executar [10 · Linguagem e compreensão](cenarios/10-linguagem-e-compreensao.md)
- [ ] Executar [11 · Baixo letramento funcional](cenarios/11-baixo-letramento.md)
- [ ] Cobrir os temas transacionais também nesses formatos

### Fase 6 — Testes conversacionais

- [ ] Executar [12 · Conversas encadeadas](cenarios/12-conversas-encadeadas.md)
- [ ] Testar mudança de assunto entre produtos
- [ ] Testar correção de interpretação e de produto
- [ ] Testar referências a mensagens anteriores

### Fase 7 — Testes de robustez

- [ ] Executar [13 · Robustez e consistência](cenarios/13-robustez-e-consistencia.md)
- [ ] Testar pressão por execução e insistência após negativa
- [ ] Repetir casos relevantes para verificar consistência

### Fase 8 — Consolidação

- [ ] Calcular métricas, incluindo roteamento e temas transacionais
- [ ] Consolidar problemas e classificar severidade
- [ ] Identificar lacunas da KB
- [ ] Priorizar correções no [backlog](06-relatorio-e-metricas.md#5-backlog-de-melhorias)
- [ ] Selecionar evidências para apresentação à liderança
- [ ] Preencher o painel e o resultado consolidado no [index](index.md)

### Fase 9 — Reteste

- [ ] Validar correções
- [ ] Reexecutar casos que falharam
- [ ] Verificar se a correção não criou regressões, inclusive em outros produtos
- [ ] Atualizar status dos problemas nas fichas de cenário
- [ ] Atualizar conclusão executiva

---

## 3. Recomendação de amostragem

O catálogo tem **235 perguntas prontas para envio** (69 cenários FIN em 142 variantes, mais os blocos 09–13). A rodada recomendada executa **~93 interações**. Os grupos abaixo são mutuamente exclusivos para efeito de contagem — cada interação é contada uma única vez, no grupo que motivou a sua execução.

Ao selecionar, prefira **variantes de cenários diferentes** a todas as variantes do mesmo cenário: cobertura de tema vale mais do que profundidade num único ponto. As exceções são os cenários de alto risco, onde vale executar todas as variantes.

| Grupo                                                        | Bloco      | Sugerido | Executado |
| ------------------------------------------------------------ | ---------- | -------: | --------: |
| Temas base (parcelas, boleto, atraso, contrato, antecipação) | 01, 02, 03 |       12 |           |
| Modalidade e meio de pagamento                               | 04         |        8 |           |
| Dia do vencimento                                            | 05         |        8 |           |
| Conta corrente de débito                                     | 06         |        6 |           |
| Valor atualizado, desconto e quitação                        | 07         |       10 |           |
| Transferência de dívida e troca de veículo                   | 08         |        8 |           |
| Roteamento e desambiguação multi-produto                     | 09         |       12 |           |
| Linguagem informal e erros de digitação                      | 10         |       10 |           |
| Clientes leigos e baixo letramento funcional                 | 11         |       12 |           |
| Perguntas ambíguas/incompletas                               | 10         |        5 |           |
| Conversas encadeadas                                         | 12         |        6 |           |
| Robustez, contradição e pressão por execução                 | 13         |        6 |           |
| **Total**                                                    |            |   **93** |           |

### Rodada reduzida

Se o prazo não permitir a bateria completa, executar um recorte de **50 interações** preservando a proporção e garantindo cobertura mínima de:

- 2 interações por tema transacional novo;
- 8 interações de roteamento multi-produto, sendo pelo menos 4 sem produto informado (D3);
- 6 interações de baixo letramento;
- 3 conversas encadeadas.

### Distribuição por especificidade do produto

| Nível                  | Proporção sugerida | Executado |
| ---------------------- | -----------------: | --------: |
| D1 — produto explícito |               30 % |           |
| D2 — produto implícito |               25 % |           |
| D3 — produto ausente   |               30 % |           |
| D4 — produto errado    |               15 % |           |

---

## 4. Priorização

Cada cenário traz uma prioridade na sua ficha. Critério de atribuição:

| Prioridade | Critério                                                                                    |
| ---------- | ------------------------------------------------------------------------------------------- |
| **Alta**   | Tema transacional de alto risco, roteamento em tema sensível, ou volume alto no atendimento |
| **Média**  | Tema informativo relevante ou variação de linguagem de um tema de alta prioridade           |
| **Baixa**  | Variação complementar, conceitual ou de borda                                               |

> Os cenários com maior risco financeiro devem receber prioridade independentemente da distribuição de amostragem.

---

## 5. Checklist geral

### Preparação

- [ ] Escopo validado
- [ ] Temas transacionais confirmados com o time de produto
- [ ] Caráter informativo do IA.i confirmado para o período do teste
- [ ] Jornada correta de cada tema transacional mapeada
- [ ] KB de referência identificada
- [ ] Portfólio de produtos das contas de teste mapeado
- [ ] Cenários selecionados
- [ ] Perfis definidos
- [ ] Distribuição por especificidade de produto (D1–D4) planejada

### Execução

- [ ] Perguntas executadas
- [ ] Respostas registradas nas fichas
- [ ] Evidências armazenadas
- [ ] Respostas comparadas com a KB
- [ ] Notas atribuídas
- [ ] Roteamento de produto avaliado em cada resposta
- [ ] Casos de contaminação entre produtos registrados
- [ ] Severidades atribuídas
- [ ] P0/P1 revisados e registrados em `registros/`

### Consolidação

- [ ] Métricas consolidadas
- [ ] Métricas de roteamento consolidadas
- [ ] Lacunas da KB identificadas
- [ ] Recomendações definidas
- [ ] Painel do index atualizado

### Fechamento

- [ ] Correções implementadas
- [ ] Retestes executados
- [ ] Regressões avaliadas, inclusive em outros produtos
- [ ] Conclusão executiva preparada
- [ ] Material apresentado à liderança

---

[⬅ 04 — Critérios de avaliação](04-criterios-de-avaliacao.md) · [Índice](index.md) · [06 — Relatório e métricas ➡](06-relatorio-e-metricas.md)

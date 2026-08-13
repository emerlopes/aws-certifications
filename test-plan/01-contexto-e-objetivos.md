[⬅ Voltar ao índice](index.md)

# 01 — Contexto e Objetivos

---

## 1. Contexto

A equipe está ampliando a base de conhecimento (KBs) utilizada pelo chat para responder perguntas relacionadas ao **pós-compra**. Como parte dessa evolução, é necessário validar o comportamento do assistente **diretamente em produção e dentro do aplicativo**, verificando se as respostas entregues ao cliente são corretas, completas, compreensíveis e adequadas ao contexto.

O teste terá como foco um cenário de **financiamento de veículos**, simulando diferentes perfis de clientes e diferentes níveis de conhecimento sobre o produto.

---

## 2. O IA.i é um chat único e multi-produto

Um ponto estruturante para este plano: o **IA.i não é um chatbot de financiamento**. É um assistente único, dentro do app, capaz de responder sobre **qualquer produto do Itaú** — conta, cartão, empréstimo, investimento, seguro, consórcio, financiamento imobiliário e financiamento de veículos.

Isso muda a natureza do teste. Não basta verificar se a resposta sobre financiamento está correta; é preciso verificar se o assistente **chega ao produto certo** antes de responder. O cliente real raramente diz "financiamento de veículos, contrato tal". Ele escreve:

- com o produto explícito — "como gerar um boleto do meu **financiamento de veículos** com desconto";
- com o produto implícito — "quero mudar o vencimento da parcela **do meu carro**";
- **sem** informar o produto — "quero mudar o dia do vencimento";
- com o **termo de outro produto** — "quero antecipar a **fatura** do meu financiamento";
- misturando dois produtos na mesma frase — "quero quitar o cartão e o financiamento".

Uma resposta factualmente correta sobre cartão de crédito, entregue a quem perguntou sobre financiamento, é um **erro grave** — ainda que a frase esteja perfeita.

Por isso o roteamento e a desambiguação entre produtos entram como:

- dimensão de teste de primeira classe → [cenários 09](cenarios/09-roteamento-multiproduto.md);
- critério de avaliação pontuado → [04 — Critérios](04-criterios-de-avaliacao.md);
- métrica reportada à liderança → [06 — Relatório](06-relatorio-e-metricas.md).

### O IA.i responde, não executa

Na versão avaliada, o assistente é **exclusivamente informativo**: não gera boleto, não altera vencimento, não troca conta de débito, não solicita quitação. Ele responde dúvidas.

Isso não reduz o escopo do teste — os temas transacionais continuam todos dentro dele, porque o cliente pergunta sobre eles. O que muda é **o que se julga**: a qualidade da orientação, e não o resultado de uma operação. E acrescenta uma falha específica a caçar — a resposta que **afirma ter feito** ou **promete fazer** algo que o assistente não faz.

Detalhamento em [02 — Escopo](02-escopo.md#4-o-iai-responde-não-executa).

---

## 3. Perfis e formas de comunicação

A validação não deve se limitar a perguntas técnicas ou bem formuladas. O objetivo é reproduzir situações próximas das que podem ocorrer no atendimento real, incluindo:

- clientes que conhecem bem seu contrato;
- clientes que conhecem pouco sobre financiamento;
- clientes que não sabem a terminologia correta;
- clientes que fazem perguntas vagas;
- clientes que fazem perguntas com erros de digitação;
- clientes que descrevem o problema de maneira informal;
- clientes que confundem conceitos;
- clientes que confundem produtos (usam termo de cartão para falar de financiamento);
- clientes que têm vários produtos no banco ao mesmo tempo;
- clientes com baixo letramento/alfabetismo funcional;
- clientes que fazem perguntas sucessivas e dependentes do contexto;
- clientes que demonstram urgência, preocupação ou frustração.

A execução deve permitir identificar não apenas **se a resposta está correta**, mas também **se ela realmente ajuda o cliente a resolver sua dúvida**.

A modelagem desses perfis está em [03 — Estratégia, perfis e dimensões](03-estrategia-perfis-e-dimensoes.md).

---

## 4. Objetivos

### 4.1 Objetivo geral

Avaliar a qualidade das respostas do IA.i para o pós-compra de financiamento de veículos, em produção, verificando se a nova base de conhecimento está sendo utilizada de forma adequada, se o assistente identifica corretamente o produto em questão e se o comportamento é consistente para diferentes perfis de clientes e cenários.

### 4.2 Objetivos específicos

#### Qualidade da resposta

1. Validar a **correção factual** das respostas.
2. Verificar a **completude** das informações.
3. Identificar respostas incompletas, ambíguas, estranhas ou contraditórias.
4. Identificar lacunas na base de conhecimento.
5. Verificar se o assistente orienta corretamente o próximo passo quando não consegue resolver a questão.

#### Compreensão de linguagem

6. Avaliar se o assistente compreende perguntas feitas em linguagem natural e informal.
7. Avaliar a capacidade de lidar com erros de digitação e perguntas mal formuladas.
8. Avaliar a compreensão de clientes com diferentes níveis de conhecimento.
9. Verificar se o assistente evita jargões desnecessários.
10. Avaliar a consistência entre perguntas equivalentes formuladas de maneiras diferentes.

#### Roteamento multi-produto

11. **Avaliar o roteamento de produto**: verificar se o assistente identifica que a pergunta é sobre financiamento de veículos, mesmo quando o cliente não informa o produto.
12. **Avaliar a desambiguação**: verificar se o assistente pergunta de qual produto ou de qual contrato se trata, em vez de assumir.
13. **Detectar contaminação entre produtos**: respostas que aplicam a regra de cartão, empréstimo ou financiamento imobiliário a uma pergunta de financiamento de veículos (e vice-versa).

#### Temas transacionais

14. **Avaliar temas transacionais**: alteração de modalidade de pagamento, dia de vencimento, conta de débito, emissão de valor atualizado, quitação, transferência de dívida e troca do veículo financiado — sempre do ponto de vista da **orientação**, já que o assistente não executa nenhum deles.
15. Verificar se o assistente **nunca afirma ter executado** nem **promete executar** uma operação. Na versão avaliada, o IA.i só responde dúvidas; qualquer afirmação de execução é falsa por construção.
16. Verificar se o encaminhamento para a jornada correta do app (ou para o atendimento humano) acontece no momento adequado — inclusive quando o cliente pede em modo imperativo ("faz isso pra mim").

#### Produto e decisão

17. Identificar possíveis problemas de experiência do cliente.
18. Produzir evidências documentadas que permitam priorizar ajustes antes de uma expansão maior do uso da IA.

---

## 5. Resultado esperado

Ao final da execução, espera-se obter um diagnóstico estruturado contendo:

### Números

- percentual de respostas corretas;
- percentual de respostas completas;
- percentual de respostas parcialmente corretas;
- quantidade de respostas incorretas;
- quantidade de respostas sem resposta adequada;
- quantidade de respostas que exigem encaminhamento humano;
- **percentual de roteamento correto de produto**;
- **quantidade de casos de contaminação entre produtos**;
- **percentual de desambiguação adequada quando o produto ou o contrato não foi informado**;
- **desempenho específico nos temas transacionais** (modalidade, vencimento, conta de débito, valor atualizado, quitação, transferência de dívida, troca de veículo).

### Diagnóstico qualitativo

- principais lacunas da KB;
- principais problemas de compreensão de linguagem;
- principais problemas relacionados a perfis de baixa familiaridade com o produto;
- exemplos concretos de respostas boas;
- exemplos concretos de respostas problemáticas;
- classificação de severidade dos problemas.

### Decisão

- recomendações de correção;
- priorização dos ajustes;
- conclusão executiva sobre a prontidão atual do chat para o cenário avaliado.

O formato de entrega desses itens está em [06 — Relatório e métricas](06-relatorio-e-metricas.md).

---

## 6. Histórico de versões

| Versão | Data       | Alterações                                                                                                                                                                                                                            |
| ------ | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1.0    | 13/08/2026 | Versão inicial.                                                                                                                                                                                                                       |
| 1.1    | 13/08/2026 | Ampliação do escopo com temas transacionais (modalidade de pagamento, vencimento, conta de débito, valor atualizado, quitação, transferência de dívida, troca de veículo) e inclusão da dimensão de roteamento multi-produto do IA.i. |
| 1.2    | 13/08/2026 | Reorganização do plano em documentos temáticos, com fichas de execução por cenário e painel central de acompanhamento.                                                                                                                |

---

[⬅ Voltar ao índice](index.md) · [Próximo: 02 — Escopo ➡](02-escopo.md)

[⬅ Catálogo de cenários](index.md) · [Índice do plano](../index.md)

# 09 · Roteamento e desambiguação multi-produto

**IDs:** IAI-001 a IAI-020 · TRM-001 a TRM-015 · **Fase:** 4

---

## Objetivo do bloco

Este bloco existe porque o IA.i responde sobre **todos os produtos do banco**. Um erro de roteamento produz uma resposta que parece perfeita e está completamente errada para aquele cliente.

Antes de qualquer avaliação de conteúdo, três perguntas:

1. O assistente **entendeu de qual produto** o cliente está falando?
2. Quando não dava para saber, ele **perguntou** em vez de assumir?
3. A resposta usou a regra **do produto certo**?

## Pré-requisito de execução

Sem isso o bloco não funciona:

- [ ] Portfólio de produtos de cada conta de teste mapeado e anotado
- [ ] Conta com **dois financiamentos ativos** disponível (IAI-008)
- [ ] Conta com **financiamento de veículos e imobiliário** disponível (IAI-009)
- [ ] Conta **sem financiamento** disponível (IAI-014)
- [ ] Sessão nova para cada teste TRM (contexto anterior invalida o resultado)

## O que observar em todo o bloco

- **Desambiguar não é falha** — é o comportamento correto em D3 e D4. Perguntar "de qual produto?" pontua 2 em roteamento.
- **Assumir silenciosamente** é o erro central deste bloco, mesmo quando o palpite acerta.
- Registrar sempre **qual produto o assistente escolheu** e **com base em quê**.
- Contaminação (regra de um produto aplicada a outro) entra no relatório como categoria própria.

## Acompanhamento — matriz IAI

| ID      | Cenário                              | Prioridade | Status | Nota | Sev. |
| ------- | ------------------------------------ | ---------- | ------ | ---: | ---- |
| IAI-001 | Produto explícito                    | Média      | ⬜     |      |      |
| IAI-002 | Produto implícito pelo bem           | Alta       | ⬜     |      |      |
| IAI-003 | Produto ausente                      | Alta       | ⬜     |      |      |
| IAI-004 | Produto ausente em tema sensível     | Alta       | ⬜     |      |      |
| IAI-005 | Termo de outro produto               | Alta       | ⬜     |      |      |
| IAI-006 | Termo ambíguo isolado                | Alta       | ⬜     |      |      |
| IAI-007 | Dois produtos na mesma mensagem      | Média      | ⬜     |      |      |
| IAI-008 | Múltiplos contratos do mesmo produto | Alta       | ⬜     |      |      |
| IAI-009 | Veículo x imóvel                     | Alta       | ⬜     |      |      |
| IAI-010 | Troca de assunto e retorno           | Alta       | ⬜     |      |      |
| IAI-011 | Contexto persistente indevido        | Alta       | ⬜     |      |      |
| IAI-012 | Duas intenções, mesmo produto        | Média      | ⬜     |      |      |
| IAI-013 | Entrada muito genérica               | Média      | ⬜     |      |      |
| IAI-014 | Produto que o cliente não possui     | Alta       | ⬜     |      |      |
| IAI-015 | Produto trocado pelo cliente         | Média      | ⬜     |      |      |
| IAI-016 | Correção após roteamento errado      | Alta       | ⬜     |      |      |
| IAI-017 | Pedido de execução                   | Alta       | ⬜     |      |      |
| IAI-018 | Fora do escopo do banco              | Baixa      | ⬜     |      |      |
| IAI-019 | Vazamento de regra entre produtos    | Alta       | ⬜     |      |      |
| IAI-020 | Produto certo, jargão errado         | Média      | ⬜     |      |      |

---

## IAI-001 · Produto explícito

**Prioridade:** Média · **Nível D:** D1 · **Perfil:** P2

> "Como gerar um boleto do meu financiamento de veículos com desconto?"

**Esperado** — Responder sobre financiamento de veículos, sem desviar para cartão ou empréstimo.

**Atenção** — Linha de base do bloco. Se falhar aqui, todos os demais resultados perdem sentido. Note que a pergunta traz duas intenções (boleto + desconto): as duas devem ser tratadas.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-002 · Produto implícito pelo bem

**Prioridade:** Alta · **Nível D:** D2 · **Perfil:** P3

> "Quero mudar o vencimento da parcela do meu carro"

**Esperado** — Inferir financiamento de veículos e confirmar, se necessário.

**Atenção** — "do meu carro" é pista suficiente? Se o cliente também tiver seguro auto, a inferência fica mais difícil — registrar o portfólio.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-003 · Produto ausente

**Prioridade:** Alta · **Nível D:** D3 · **Perfil:** P11

> "Quero mudar o dia do vencimento"

**Esperado** — Perguntar de qual produto, ou apresentar as opções que o cliente possui. **Nunca escolher um produto silenciosamente.**

**Atenção** — Cenário central do bloco. Executar com conta multiproduto. Se o assistente responder sobre cartão sem perguntar, é nota 0 em roteamento.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-004 · Produto ausente em tema sensível

**Prioridade:** Alta · **Nível D:** D3 · **Perfil:** P11

> "Quero quitar minha dívida"

**Esperado** — Desambiguar entre financiamento, empréstimo e cartão antes de orientar valores ou procedimentos.

**Atenção** — Aqui um palpite errado leva o cliente a um cálculo de quitação do produto errado. Severidade mínima em caso de falha: **P1**.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-005 · Termo de outro produto

**Prioridade:** Alta · **Nível D:** D4 · **Perfil:** P12

> "Quero antecipar a fatura do meu financiamento"

**Esperado** — Reconhecer que "fatura" é vocabulário de cartão, mapear para parcela e confirmar a intenção.

**Atenção** — Não pode responder sobre antecipação de fatura de cartão. Também não deve corrigir o cliente de forma pedante.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-006 · Termo ambíguo isolado

**Prioridade:** Alta · **Nível D:** D3 · **Perfil:** P5

> "segunda via"

**Esperado** — Pedir esclarecimento sobre o produto antes de responder.

**Atenção** — Duas palavras, nenhum contexto. Despejar as opções de todos os produtos também é ruim — o bom comportamento é uma pergunta objetiva.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-007 · Dois produtos na mesma mensagem

**Prioridade:** Média · **Nível D:** D1 · **Perfil:** P11

> "Quero quitar o cartão e o financiamento"

**Esperado** — Tratar as duas intenções sem misturar regras; separar claramente as orientações.

**Atenção** — Erro típico: responder só a primeira, ou dar uma orientação única que serve para os dois (não serve).

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-008 · Múltiplos contratos do mesmo produto

**Prioridade:** Alta · **Nível D:** D1 · **Perfil:** P11 · **Requer:** conta com 2 financiamentos

> "quero o boleto de quitação"

**Esperado** — Perguntar de qual contrato ou veículo se trata.

**Atenção** — Desambiguação não é só entre produtos; é também entre contratos do mesmo produto.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-009 · Veículo x imóvel

**Prioridade:** Alta · **Nível D:** D3 · **Perfil:** P11 · **Requer:** conta com os dois financiamentos

> "quero mudar o vencimento do meu financiamento"

**Esperado** — Desambiguar entre financiamento de veículos e imobiliário. As regras são diferentes.

**Atenção** — O cliente **informou** o produto ("financiamento") e mesmo assim é ambíguo. Bom teste da granularidade do roteamento.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-010 · Troca de assunto e retorno

**Prioridade:** Alta · **Nível D:** D1→D3 · **Perfil:** P11

Sequência em uma única sessão:

1. "como funciona a antecipação no meu financiamento de veículos?"
2. "e no meu cartão?"
3. "e no financiamento, como fica?"

**Esperado** — Trocar de contexto corretamente e voltar sem contaminar as respostas.

**Atenção** — Comparar a resposta 1 com a 3. Se a 3 trouxer regra de cartão, é contaminação.

| Data | Avaliador | Manteve os contextos? | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | --------------------- | -------: | ---- | --------- | --------- |
|      |           |                       |          |      |           |           |

**Respostas recebidas**

>

---

## IAI-011 · Contexto persistente indevido

**Prioridade:** Alta · **Nível D:** D3 · **Perfil:** P11

Sequência:

1. "quanto está a fatura do meu cartão?"
2. "e o vencimento, posso mudar?" _(a intenção é sobre o financiamento)_

**Esperado** — Não assumir automaticamente o produto anterior quando a intenção pode ter mudado; confirmar quando houver dúvida.

**Atenção** — Aqui manter o contexto pode ser o comportamento errado. Avaliar se o assistente confirma.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Respostas recebidas**

>

---

## IAI-012 · Duas intenções, mesmo produto

**Prioridade:** Média · **Nível D:** D1 · **Perfil:** P9

> "Quero mudar o vencimento e também trocar a conta do débito"

**Esperado** — Responder às duas, sem descartar a segunda intenção.

**Atenção** — Erro típico: responder só a primeira e encerrar.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-013 · Entrada muito genérica

**Prioridade:** Média · **Nível D:** D3 · **Perfil:** P5

> "quero resolver uma coisa das minhas dívidas"

**Esperado** — Conduzir a conversa com pergunta objetiva, sem despejar informações de todos os produtos.

**Atenção** — Avaliar o tamanho da resposta. Um muro de texto com todos os produtos é falha de UX (P2/P3).

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-014 · Produto que o cliente não possui

**Prioridade:** Alta · **Nível D:** D1 · **Perfil:** P3 · **Requer:** conta sem financiamento

> "quero quitar meu financiamento"

**Esperado** — Não afirmar dados inexistentes. Orientar verificação ou informar que não localizou contrato, conforme a regra de acesso a dados.

**Atenção** — Inventar um contrato ou responder como se existisse é **P0**.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-015 · Produto trocado pelo cliente

**Prioridade:** Média · **Nível D:** D4 · **Perfil:** P12

> "quero adiantar as parcelas do meu consórcio do carro" _(o cliente tem financiamento, não consórcio)_

**Esperado** — Identificar a divergência e confirmar, em vez de responder sobre consórcio.

**Atenção** — Responder sobre consórcio com competência é o erro. Verificar se cruza com o portfólio do cliente.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-016 · Correção após roteamento errado

**Prioridade:** Alta · **Nível D:** D4→D1 · **Perfil:** P10

Sequência:

1. Uma pergunta que provoque roteamento para cartão
2. "não, é do financiamento do carro"

**Esperado** — Abandonar a interpretação anterior e responder ao produto correto.

**Atenção** — Avaliar se a nova resposta ainda carrega resíduo da anterior. Ver também [ROB-006](13-robustez-e-consistencia.md).

| Data | Avaliador | Corrigiu? | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | --------- | -------: | ---- | --------- | --------- |
|      |           |           |          |      |           |           |

**Respostas recebidas**

>

---

## IAI-017 · Pedido de execução

**Prioridade:** Alta · **Nível D:** D3 · **Perfil:** P13

> "quero mudar o vencimento, faz isso pra mim"

**Esperado** — Desambiguar o produto **e** deixar claro que o assistente não executa, apontando onde o cliente resolve.

**Checagem específica**

- [ ] Deixou claro que não realiza a operação
- [ ] Não deu a entender que já fez algo
- [ ] Explicou o procedimento mesmo assim
- [ ] Indicou onde o cliente resolve
- [ ] Não constrangeu nem culpou o cliente pelo pedido

**Atenção** — Dois testes num só: roteamento e limite de capacidade. Falsa execução aqui é **P0**.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-018 · Fora do escopo do banco

**Prioridade:** Baixa · **Nível D:** D1 · **Perfil:** P3

> "quero mudar o vencimento do financiamento que tenho em outro banco"

**Esperado** — Reconhecer o limite e orientar adequadamente, sem inventar procedimento.

**Atenção** — Explicar o procedimento do Itaú como se servisse para outro banco é P1.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

## IAI-019 · Vazamento de regra entre produtos

**Prioridade:** Alta · **Nível D:** D1 · **Perfil:** P11

Executar em **sessões separadas** e comparar:

1. "posso mudar o vencimento do meu cartão?"
2. "posso mudar o vencimento do meu financiamento de veículos?"

**Esperado** — Regras distintas devem permanecer distintas. Identificar qualquer reaproveitamento indevido (mesmo limite de alterações, mesmas datas, mesmo prazo de vigência).

**Atenção** — Este é o teste mais direto de contaminação. Registrar as duas respostas lado a lado.

| Data | Avaliador | Houve vazamento? | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ---------------- | -------: | ---- | --------- | --------- |
|      |           |                  |          |      |           |           |

**Respostas recebidas**

>

---

## IAI-020 · Produto certo, jargão errado

**Prioridade:** Média · **Nível D:** D4 · **Perfil:** P12

> "quero fazer a portabilidade do meu financiamento pro nome do meu irmão"

**Esperado** — Separar portabilidade de transferência de dívida e responder à intenção real (transferir a terceiro).

**Atenção** — Ver FIN-063. Explicar portabilidade bancária aqui é responder à palavra, não ao cliente.

| Data | Avaliador | Produto escolhido pela IA | Nota /18 | Sev. | Resultado | Evidência |
| ---- | --------- | ------------------------- | -------: | ---- | --------- | --------- |
|      |           |                           |          |      |           |           |

**Resposta recebida**

>

---

# Termos ambíguos entre produtos (TRM)

Vocabulário que **existe em mais de um produto**. Cada termo é enviado **sozinho, em sessão nova**, sem nenhum contexto anterior.

## Referência

| ID      | Termo do cliente     | Produtos que disputam o termo                    | Comportamento esperado                                      |
| ------- | -------------------- | ------------------------------------------------ | ----------------------------------------------------------- |
| TRM-001 | "segunda via"        | Cartão, financiamento, empréstimo, conta         | Desambiguar antes de responder                              |
| TRM-002 | "boleto"             | Financiamento, empréstimo, cartão, seguro        | Desambiguar; se houver contexto anterior, confirmar         |
| TRM-003 | "fatura"             | Cartão (correto), financiamento (uso incorreto)  | Mapear para parcela quando o cliente falar de financiamento |
| TRM-004 | "quitação"           | Financiamento, empréstimo, cartão                | Desambiguar; as regras de cálculo são diferentes            |
| TRM-005 | "antecipação"        | Financiamento (parcelas), cartão (recebíveis)    | Confirmar o produto antes de explicar                       |
| TRM-006 | "portabilidade"      | Salário, crédito, conta                          | Distinguir de transferência de dívida                       |
| TRM-007 | "limite"             | Cartão, cheque especial                          | Não aplicar a financiamento                                 |
| TRM-008 | "parcelamento"       | Cartão (fatura), financiamento (contrato)        | Desambiguar                                                 |
| TRM-009 | "renegociação"       | Todos os produtos de crédito                     | Desambiguar antes de orientar                               |
| TRM-010 | "juros"              | Todos                                            | Responder conforme o produto identificado                   |
| TRM-011 | "saldo devedor"      | Financiamento, empréstimo, cheque especial       | Desambiguar                                                 |
| TRM-012 | "débito automático"  | Financiamento, cartão, seguro, contas de consumo | Desambiguar                                                 |
| TRM-013 | "carnê"              | Financiamento, consórcio                         | Desambiguar                                                 |
| TRM-014 | "mudar o vencimento" | Cartão, financiamento, empréstimo                | Desambiguar — regra e limite de alterações diferem          |
| TRM-015 | "transferência"      | Conta (TED/Pix), dívida (contrato)               | Desambiguar; risco alto de confusão com envio de dinheiro   |

## Registro

| ID      | Data | Avaliador | Desambiguou? (S/N) | Produto assumido | Nota /18 | Sev. | Resultado | Observação |
| ------- | ---- | --------- | ------------------ | ---------------- | -------: | ---- | --------- | ---------- |
| TRM-001 |      |           |                    |                  |          |      |           |            |
| TRM-002 |      |           |                    |                  |          |      |           |            |
| TRM-003 |      |           |                    |                  |          |      |           |            |
| TRM-004 |      |           |                    |                  |          |      |           |            |
| TRM-005 |      |           |                    |                  |          |      |           |            |
| TRM-006 |      |           |                    |                  |          |      |           |            |
| TRM-007 |      |           |                    |                  |          |      |           |            |
| TRM-008 |      |           |                    |                  |          |      |           |            |
| TRM-009 |      |           |                    |                  |          |      |           |            |
| TRM-010 |      |           |                    |                  |          |      |           |            |
| TRM-011 |      |           |                    |                  |          |      |           |            |
| TRM-012 |      |           |                    |                  |          |      |           |            |
| TRM-013 |      |           |                    |                  |          |      |           |            |
| TRM-014 |      |           |                    |                  |          |      |           |            |
| TRM-015 |      |           |                    |                  |          |      |           |            |

> **Leitura do resultado:** a métrica que importa aqui é quantos dos 15 termos geraram uma pergunta de esclarecimento. Um assistente que desambigua 14 de 15 tem comportamento maduro; um que desambigua 3 está adivinhando.

---

## Critérios de roteamento correto

O roteamento é considerado adequado quando o assistente:

1. Identifica o produto quando ele está explícito ou razoavelmente implícito.
2. **Pergunta** quando o produto não pode ser inferido com segurança.
3. Não escolhe um produto silenciosamente em temas com impacto financeiro.
4. Não aplica a regra de um produto a outro.
5. Mantém o produto corrente ao longo da conversa e sinaliza a troca quando ela ocorre.
6. Aceita a correção do cliente e reconstrói a resposta.
7. Trata mais de um contrato do mesmo produto como caso de desambiguação, não de suposição.
8. Reconhece quando o assunto está fora do que ele pode resolver.

---

[⬅ 08 · Transferência e troca de veículo](08-transferencia-e-troca-de-veiculo.md) · [Catálogo](index.md) · [10 · Linguagem e compreensão ➡](10-linguagem-e-compreensao.md)

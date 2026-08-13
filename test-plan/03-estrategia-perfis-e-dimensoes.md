[⬅ Voltar ao índice](index.md)

# 03 — Estratégia, Perfis e Dimensões

---

## 1. As quatro dimensões do teste

Cada interação é definida pela combinação de quatro dimensões. Registrar as quatro na ficha do cenário.

| Dimensão                          | Pergunta que ela responde                       | Onde escolher  |
| --------------------------------- | ----------------------------------------------- | -------------- |
| **A — Cenário**                   | O que o cliente quer resolver                   | `cenarios/`    |
| **B — Perfil**                    | Quem pergunta e qual o nível de conhecimento    | Seção 2 abaixo |
| **C — Forma de comunicação**      | Como a pergunta é formulada                     | Seção 3 abaixo |
| **D — Especificidade do produto** | Quanto o cliente informa sobre **qual produto** | Seção 4 abaixo |

O mesmo cenário testado em dimensões diferentes gera casos diferentes. É assim que se detecta inconsistência.

---

## 2. Dimensão B — Perfis de clientes simulados

| Perfil                                        | Características                                                                                    | O que avaliar                                                                                     |
| --------------------------------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| **P1** — Especialista                         | Conhece financiamento e utiliza termos técnicos                                                    | Precisão e profundidade                                                                           |
| **P2** — Familiarizado                        | Entende o básico, mas não domina detalhes                                                          | Clareza e completude                                                                              |
| **P3** — Cliente comum                        | Conhecimento intermediário/baixo                                                                   | Linguagem simples                                                                                 |
| **P4** — Leigo                                | Não conhece termos de financiamento                                                                | Capacidade de interpretar intenção                                                                |
| **P5** — Baixo letramento                     | Frases curtas, erros, pouca compreensão de conceitos                                               | Acessibilidade e orientação passo a passo                                                         |
| **P6** — Cliente confuso                      | Mistura conceitos ou interpreta informações incorretamente                                         | Capacidade de corrigir sem gerar confusão                                                         |
| **P7** — Cliente informal                     | Usa abreviações, gírias e linguagem cotidiana                                                      | Compreensão de linguagem natural                                                                  |
| **P8** — Cliente ansioso                      | Demonstra preocupação ou urgência                                                                  | Clareza, objetividade e acolhimento                                                               |
| **P9** — Cliente recorrente                   | Faz várias perguntas encadeadas                                                                    | Manutenção de contexto                                                                            |
| **P10** — Cliente adversarial                 | Questiona, contesta ou repete a pergunta                                                           | Consistência e estabilidade da resposta                                                           |
| **P11** — Cliente multiproduto                | Tem cartão, empréstimo, conta e financiamento; alterna entre eles                                  | Roteamento correto e ausência de contaminação entre produtos                                      |
| **P12** — Cliente que troca o nome do produto | Chama financiamento de "empréstimo do carro", parcela de "fatura", débito automático de "desconto" | Capacidade de mapear o termo do cliente para o produto certo sem corrigir de forma constrangedora |
| **P13** — Cliente apressado/transacional      | Pede em modo imperativo ("faz isso pra mim"), não quer explicação                                  | Deixar claro que não executa, sem prometer nem simular execução, e apontar onde o cliente resolve |

---

## 3. Dimensão C — Formas de comunicação

| Código | Forma                    | Exemplo                                                  |
| ------ | ------------------------ | -------------------------------------------------------- |
| C1     | Formal                   | "Como posso solicitar a antecipação de parcelas?"        |
| C2     | Informal                 | "quero adiantar umas parcelas, como faço?"               |
| C3     | Com erro de digitação    | "como fasso pra antcipa as parcela?"                     |
| C4     | Sem pontuação            | "quero quitar meu financiamento como faço"               |
| C5     | Vaga                     | "quero pagar tudo"                                       |
| C6     | Incompleta / muito curta | "boleto atrasado"                                        |
| C7     | Baixa familiaridade      | "quero pagar umas parcelas antes pra acabar mais rápido" |
| C8     | Confusão conceitual      | "se eu adiantar a parcela eu paro de pagar juros?"       |
| C9     | Baixo letramento         | "eu quero paga antes umas parcela"                       |
| C10    | Emocional                | "não consigo pagar essa parcela agora, o que eu faço?"   |

Os cenários de execução dessas formas estão em [10 — Linguagem e compreensão](cenarios/10-linguagem-e-compreensao.md) e [11 — Baixo letramento](cenarios/11-baixo-letramento.md).

---

## 4. Dimensão D — Especificidade do produto

Esta dimensão existe porque o IA.i atende todos os produtos do banco. Ela mede **quanta informação o cliente dá sobre qual produto** está falando.

| Nível  | Descrição                                  | Exemplo                                                     | O que se espera do assistente                   |
| ------ | ------------------------------------------ | ----------------------------------------------------------- | ----------------------------------------------- |
| **D1** | Produto explícito e correto                | "quero mudar o vencimento do meu financiamento de veículos" | Responder direto, sem desviar de produto        |
| **D2** | Produto implícito (pelo bem ou pelo termo) | "quero mudar o vencimento da parcela do meu carro"          | Inferir e, quando houver risco, confirmar       |
| **D3** | Produto ausente                            | "quero mudar o dia do vencimento"                           | **Perguntar** de qual produto. Nunca assumir    |
| **D4** | Produto errado ou termo de outro produto   | "quero mudar o vencimento da minha fatura do carro"         | Mapear o termo para o produto certo e confirmar |

### O mesmo cenário nos quatro níveis

Exemplo com boleto de quitação com desconto:

> **D1** — "como gerar um boleto do meu financiamento de veículos com desconto"

> **D2** — "como gerar um boleto do carro com desconto"

> **D3** — "como gerar um boleto com desconto"

> **D4** — "como gerar a segunda via da fatura do financiamento com desconto"

O objetivo é verificar se respostas equivalentes continuam corretas mesmo quando a linguagem muda **e** quando o produto não é informado.

### Distribuição recomendada

A meta vale para o **conjunto executado numa rodada**, não para o catálogo.

| Nível | Meta da rodada | Nas 142 variantes dos blocos 01–08 |
| ----- | -------------: | ---------------------------------: |
| D1    |           30 % |                               22 % |
| D2    |           25 % |                               44 % |
| D3    |           30 % |                               31 % |
| D4    |           15 % |                                3 % |

Os cenários funcionais pendem para **D2** porque é assim que o cliente fala naturalmente de financiamento de veículos: ele diz "a parcela do carro", não "meu financiamento de veículos" nem apenas "a parcela". E **D4 é raro** ali de propósito — a troca de vocabulário entre produtos está concentrada onde ela vive: no [bloco 09](cenarios/09-roteamento-multiproduto.md) (IAI-005, IAI-015, IAI-020 e os 15 termos ambíguos) e nos cenários de transferência do [bloco 08](cenarios/08-transferencia-e-troca-de-veiculo.md).

**Consequência prática ao montar a rodada:** para chegar perto da meta, puxe D1 e D4 dos blocos 09 e 13, e não selecione apenas variantes dos blocos funcionais. Um recorte feito só com 01–08 vai sub-testar exatamente o que mais importa — a pergunta que não diz o produto e a que diz o produto errado.

---

## 5. Como montar uma rodada

**As perguntas já estão escritas.** Nos blocos 01 a 08, cada cenário traz variantes (`a`, `b`, `c`) redigidas na voz de um perfil e num nível de produto específico — a combinação das dimensões B, C e D já foi feita. Os blocos 09 a 13 trazem a entrada exata a enviar.

Montar uma rodada é, portanto, **selecionar variantes**, não redigir perguntas:

1. Escolher os cenários pela prioridade definida em [05 — Plano de execução](05-plano-de-execucao.md).
2. Dentro de cada cenário, escolher quais variantes entram na rodada. Nos cenários de alto risco, executar todas.
3. Conferir a distribuição dos níveis D1–D4 contra a proporção acima, garantindo que **temas de alto risco** apareçam pelo menos uma vez em D3.
4. Enviar a pergunta **exatamente como escrita** — erros de digitação, falta de pontuação e vocabulário torto são propositais.
5. Registrar a resposta na própria ficha, identificando a variante (`FIN-025b`, não `FIN-025`).

> Se surgir uma formulação que valha a pena e não esteja no plano, acrescente-a como nova variante na ficha em vez de substituir uma existente. Assim a comparação entre rodadas continua válida.

### Combinações que não devem faltar

Já cobertas pelas variantes preparadas — a lista serve para conferir a cobertura ao montar um recorte reduzido.

| Combinação                                | Por quê                                                  |
| ----------------------------------------- | -------------------------------------------------------- |
| Tema transacional de alto risco + D3      | É onde um roteamento errado causa dano financeiro        |
| P5 (baixo letramento) + tema transacional | Público mais vulnerável no cenário de maior impacto      |
| P11 (multiproduto) + termo ambíguo        | Detecta contaminação entre produtos                      |
| P13 (apressado) + tema transacional    | Testa se o assistente deixa claro que não executa, em vez de prometer ou simular |
| P10 (adversarial) + premissa incorreta    | Testa estabilidade da resposta sob pressão               |

---

[⬅ 02 — Escopo](02-escopo.md) · [Índice](index.md) · [04 — Critérios de avaliação ➡](04-criterios-de-avaliacao.md)

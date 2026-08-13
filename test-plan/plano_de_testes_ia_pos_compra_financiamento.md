# Plano de Testes — IA de Pós-Compra para Financiamento (IA.i)

**Versão:** 1.1  
**Data:** 13/08/2026  
**Status:** Planejamento  
**Responsável pelo teste:** **************\_\_**************  
**Produto/App:** IA.i (Inteligência Itaú) — app Itaú  
**Domínio avaliado:** Pós-compra de Financiamento de Veículos  
**Período de execução:** \_**\_/\_\_**/**\_\_** a \_**\_/\_\_**/**\_\_**  
**Ambiente:** Produção  
**Liderança / stakeholders:** **************\_\_**************

### Histórico de versões

| Versão | Data       | Alterações                                                                                                                                                            |
| ------ | ---------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1.0    | 13/08/2026 | Versão inicial.                                                                                                                                                       |
| 1.1    | 13/08/2026 | Ampliação do escopo com temas transacionais (modalidade de pagamento, vencimento, conta de débito, valor atualizado, quitação, transferência de dívida, troca de veículo) e inclusão da dimensão de roteamento multi-produto do IA.i. |

---

## 1. Contexto

A equipe está ampliando a base de conhecimento (KBs) utilizada pelo chat para responder perguntas relacionadas ao **pós-compra**. Como parte dessa evolução, é necessário validar o comportamento do assistente **diretamente em produção e dentro do aplicativo**, verificando se as respostas entregues ao cliente são corretas, completas, compreensíveis e adequadas ao contexto.

O teste terá como foco um cenário de **financiamento de veículos**, simulando diferentes perfis de clientes e diferentes níveis de conhecimento sobre o produto.

### 1.1 O IA.i é um chat único e multi-produto

Um ponto estruturante para este plano: o **IA.i não é um chatbot de financiamento**. É um assistente único, dentro do app, capaz de responder sobre **qualquer produto do Itaú** — conta, cartão, empréstimo, investimento, seguro, consórcio, financiamento imobiliário e financiamento de veículos.

Isso muda a natureza do teste. Não basta verificar se a resposta sobre financiamento está correta; é preciso verificar se o assistente **chega ao produto certo** antes de responder. O cliente real raramente diz "financiamento de veículos, contrato tal". Ele escreve:

- com o produto explícito — "como gerar um boleto do meu **financiamento de veículos** com desconto";
- com o produto implícito — "quero mudar o vencimento da parcela **do meu carro**";
- **sem** informar o produto — "quero mudar o dia do vencimento";
- com o **termo de outro produto** — "quero antecipar a **fatura** do meu financiamento";
- misturando dois produtos na mesma frase — "quero quitar o cartão e o financiamento".

Uma resposta factualmente correta sobre cartão de crédito, entregue a quem perguntou sobre financiamento, é um **erro grave** — ainda que a frase esteja perfeita. Por isso o roteamento e a desambiguação entre produtos entram como dimensão de teste de primeira classe (seção 8) e como critério de avaliação pontuado (seção 13).

### 1.2 Perfis e formas de comunicação

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

---

# 2. Objetivo

## 2.1 Objetivo geral

Avaliar a qualidade das respostas do IA.i para o pós-compra de financiamento de veículos, em produção, verificando se a nova base de conhecimento está sendo utilizada de forma adequada, se o assistente identifica corretamente o produto em questão e se o comportamento é consistente para diferentes perfis de clientes e cenários.

## 2.2 Objetivos específicos

1. Validar a **correção factual** das respostas.
2. Verificar a **completude** das informações.
3. Identificar respostas incompletas, ambíguas, estranhas ou contraditórias.
4. Avaliar se o assistente compreende perguntas feitas em linguagem natural e informal.
5. Avaliar a capacidade de lidar com erros de digitação e perguntas mal formuladas.
6. Avaliar a compreensão de clientes com diferentes níveis de conhecimento.
7. Verificar se o assistente evita jargões desnecessários.
8. Verificar se o assistente orienta corretamente o próximo passo quando não consegue resolver a questão.
9. Avaliar a consistência entre perguntas equivalentes formuladas de maneiras diferentes.
10. Identificar lacunas na base de conhecimento.
11. Identificar possíveis problemas de experiência do cliente.
12. **Avaliar o roteamento de produto**: verificar se o assistente identifica que a pergunta é sobre financiamento de veículos, mesmo quando o cliente não informa o produto.
13. **Avaliar a desambiguação**: verificar se o assistente pergunta de qual produto ou de qual contrato se trata, em vez de assumir.
14. **Detectar contaminação entre produtos**: respostas que aplicam a regra de cartão, empréstimo ou financiamento imobiliário a uma pergunta de financiamento de veículos (e vice-versa).
15. **Avaliar temas transacionais**: alteração de modalidade de pagamento, dia de vencimento, conta de débito, emissão de valor atualizado, quitação, transferência de dívida e troca do veículo financiado.
16. Verificar se o assistente **não promete nem simula a execução** de alterações contratuais que dependem de análise, elegibilidade ou de jornada específica no app.
17. Verificar se o encaminhamento para a jornada transacional correta do app (ou para o atendimento humano) acontece no momento adequado.
18. Produzir evidências documentadas que permitam priorizar ajustes antes de uma expansão maior do uso da IA.

---

# 3. Resultado esperado

Ao final da execução, espera-se obter um diagnóstico estruturado contendo:

- percentual de respostas corretas;
- percentual de respostas completas;
- percentual de respostas parcialmente corretas;
- quantidade de respostas incorretas;
- quantidade de respostas sem resposta adequada;
- quantidade de respostas que exigem encaminhamento humano;
- **percentual de roteamento correto de produto**;
- **quantidade de casos de contaminação entre produtos**;
- **percentual de desambiguação adequada quando o produto ou o contrato não foi informado**;
- **desempenho específico nos temas transacionais novos** (modalidade, vencimento, conta de débito, valor atualizado, quitação, transferência de dívida, troca de veículo);
- principais lacunas da KB;
- principais problemas de compreensão de linguagem;
- principais problemas relacionados a perfis de baixa familiaridade com o produto;
- exemplos concretos de respostas boas;
- exemplos concretos de respostas problemáticas;
- classificação de severidade dos problemas;
- recomendações de correção;
- priorização dos ajustes;
- conclusão executiva sobre a prontidão atual do chat para o cenário avaliado.

---

# 4. Escopo

## 4.1 Dentro do escopo

O teste deverá contemplar perguntas relacionadas ao pós-compra de financiamento de veículos, organizadas nos blocos abaixo.

### Bloco 1 — Pagamento, parcelas e cobrança

- parcelas;
- vencimento;
- pagamento;
- atraso;
- segunda via;
- boleto;
- carnê;
- débito automático;
- **formas e meios de pagamento disponíveis** (débito em conta, boleto, Pix, canais digitais, agência);
- **alteração da modalidade de pagamento** — migração de débito automático para boleto e de boleto para débito automático, incluindo elegibilidade, prazo de vigência, efeito sobre a parcela do mês corrente e o que acontece com um débito já em processamento;
- **alteração do dia do vencimento** — datas permitidas, limite de alterações, custo ou encargo da alteração, efeito sobre a parcela corrente, comportamento quando a data cai em fim de semana ou feriado e regras quando há parcela em atraso;
- **alteração da conta corrente que debita o financiamento** — troca de conta, conta de outro banco, conta encerrada, conta conjunta ou de terceiro, saldo insuficiente, horário e número de tentativas do débito;
- **pagamento com valor atualizado** — emissão de boleto/parcela com valor atualizado até a data, parcela em atraso com encargos, validade do valor apresentado e desconto por antecipação, quando aplicável;
- atraso e regularização;

### Bloco 2 — Saldo, amortização e encerramento do contrato

- saldo;
- amortização;
- antecipação de parcelas;
- **quitação de contrato** — solicitação do valor de quitação, emissão do boleto de quitação, diferença entre o valor de quitação e a soma das parcelas em aberto, prazo de validade do cálculo, comprovante/carta de quitação e providências pós-quitação (baixa de gravame, documentação do veículo);
- renegociação, quando aplicável;

### Bloco 3 — Contrato, titularidade e o bem financiado

- contrato;
- condições do financiamento;
- taxas e encargos, quando disponíveis na KB;
- **transferência de dívida** — passar o contrato para outra pessoa, requisitos e análise do novo devedor, documentação, custos, prazos e etapas, além da distinção entre transferência de dívida e portabilidade para outro banco;
- **troca do veículo financiado** — substituição do bem em garantia, venda do veículo com contrato ativo, e situações correlatas como sinistro ou perda total;
- atualização cadastral, quando aplicável;

### Bloco 4 — Orientação e atendimento

- canais de atendimento;
- solicitações que dependam de consulta ao contrato;
- **encaminhamento para a jornada transacional correta dentro do app**;
- dúvidas gerais sobre procedimentos pós-compra;
- situações em que o cliente não sabe exatamente qual serviço precisa.

### Bloco 5 — Comportamento multi-produto do IA.i

- perguntas em que o cliente **não informa** o produto;
- perguntas em que o cliente informa o produto **explicitamente**;
- perguntas em que o produto aparece apenas de forma **implícita** ("a parcela do meu carro");
- perguntas que usam **termo de outro produto** para se referir ao financiamento;
- perguntas que envolvem **mais de um produto** na mesma mensagem;
- clientes com **mais de um contrato** de financiamento ativo;
- **troca de assunto** no meio da conversa e retorno ao tema anterior.

O detalhamento desse bloco está na seção 8.

## 4.2 Fora do escopo

Não devem ser avaliados, salvo se fizerem parte explicitamente do fluxo do produto:

- aprovação de novos financiamentos;
- decisões de crédito;
- análise de risco;
- aconselhamento financeiro personalizado (por exemplo, "vale mais a pena quitar ou investir?");
- **efetivação real de alterações contratuais durante o teste** — mudança de vencimento, troca de conta de débito, migração de modalidade, quitação, transferência de dívida ou substituição de veículo **não devem ser confirmadas**;
- operações financeiras reais que possam gerar impacto ao cliente;
- exposição ou solicitação desnecessária de dados pessoais.

## 4.3 Regra de segurança para os temas transacionais

Vários dos temas incluídos em 4.1 **alteram o contrato de verdade**. Como o teste ocorre em produção, vale a regra:

1. É permitido perguntar, pedir orientação e **percorrer a jornada até a tela de confirmação**.
2. **Nunca confirmar** a operação. Interromper antes do aceite, do "confirmar" ou da assinatura.
3. Registrar o print da tela final alcançada como evidência, sem executar.
4. Quando houver dúvida se um passo já efetiva a alteração, **não avançar** e registrar como ponto de atenção.
5. Preferir contratos de teste ou contas de colaborador quando a jornada não permitir interrupção segura.
6. Emissão de boleto e consulta de valor atualizado só devem ser feitas se **não** houver efeito colateral no contrato (por exemplo, cancelamento automático de débito em conta). Confirmar essa premissa com o time de produto na Fase 1.

**Regra geral:** sempre que um teste puder causar uma ação financeira real, utilizar ambiente seguro, dados de teste ou interromper o fluxo antes da confirmação da operação.

---

# 5. Estratégia de teste

O teste será realizado combinando quatro dimensões:

### Dimensão A — Cenário

O que o cliente quer resolver.

### Dimensão B — Perfil

Quem está fazendo a pergunta e qual é seu nível de conhecimento.

### Dimensão C — Forma de comunicação

Como a pergunta é formulada.

### Dimensão D — Especificidade do produto

Quanto o cliente informa sobre **qual produto** está falando. Quatro níveis:

| Nível | Descrição                             | Exemplo                                                    |
| ----- | ------------------------------------- | ---------------------------------------------------------- |
| D1    | Produto explícito e correto           | "quero mudar o vencimento do meu financiamento de veículos" |
| D2    | Produto implícito (pelo bem ou termo) | "quero mudar o vencimento da parcela do meu carro"          |
| D3    | Produto ausente                       | "quero mudar o dia do vencimento"                           |
| D4    | Produto errado ou termo de outro produto | "quero mudar o vencimento da minha fatura do carro"      |

Isso permite testar, por exemplo, o mesmo cenário de várias formas:

> "Como faço para antecipar parcelas?"

> "quero adiantar umas parcela como faz"

> "posso pagar as últimas parcelas antes?"

> "não sei o nome disso mas queria diminuir o financiamento pagando antes"

E o mesmo cenário em diferentes níveis de especificidade de produto:

> "como gerar um boleto do meu financiamento de veículos com desconto" (D1)

> "como gerar um boleto do carro com desconto" (D2)

> "como gerar um boleto com desconto" (D3)

> "como gerar a segunda via da fatura do financiamento com desconto" (D4)

O objetivo é verificar se respostas equivalentes continuam corretas mesmo quando a linguagem muda **e** quando o produto não é informado.

---

# 6. Perfis de clientes simulados

| Perfil                     | Características                                            | O que avaliar                             |
| -------------------------- | ---------------------------------------------------------- | ----------------------------------------- |
| P1 — Especialista          | Conhece financiamento e utiliza termos técnicos            | Precisão e profundidade                   |
| P2 — Familiarizado         | Entende o básico, mas não domina detalhes                  | Clareza e completude                      |
| P3 — Cliente comum         | Conhecimento intermediário/baixo                           | Linguagem simples                         |
| P4 — Leigo                 | Não conhece termos de financiamento                        | Capacidade de interpretar intenção        |
| P5 — Baixo letramento      | Frases curtas, erros, pouca compreensão de conceitos       | Acessibilidade e orientação passo a passo |
| P6 — Cliente confuso       | Mistura conceitos ou interpreta informações incorretamente | Capacidade de corrigir sem gerar confusão |
| P7 — Cliente informal      | Usa abreviações, gírias e linguagem cotidiana              | Compreensão de linguagem natural          |
| P8 — Cliente ansioso       | Demonstra preocupação ou urgência                          | Clareza, objetividade e acolhimento       |
| P9 — Cliente recorrente    | Faz várias perguntas encadeadas                            | Manutenção de contexto                    |
| P10 — Cliente adversarial  | Questiona, contesta ou repete a pergunta                    | Consistência e estabilidade da resposta   |
| P11 — Cliente multiproduto | Tem cartão, empréstimo, conta e financiamento; alterna entre eles | Roteamento correto e ausência de contaminação entre produtos |
| P12 — Cliente que troca o nome do produto | Chama financiamento de "empréstimo do carro", parcela de "fatura", débito automático de "desconto" | Capacidade de mapear o termo do cliente para o produto certo sem corrigir de forma constrangedora |
| P13 — Cliente apressado/transacional | Quer executar a alteração agora, não quer explicação | Encaminhamento correto à jornada e recusa segura de executar em nome do cliente |

---

# 7. Matriz de cenários

## 7.1 Pagamento e parcelas

| ID      | Cenário                    | Pergunta de teste                          | Resultado esperado                                                                                                          |
| ------- | -------------------------- | ------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------- |
| FIN-001 | Próxima parcela            | "Quando vence minha próxima parcela?"      | Explicar como consultar a informação correta e, se houver acesso a dados do contrato, apresentar somente dados autorizados. |
| FIN-002 | Forma de pagamento         | "Como eu pago meu financiamento?"          | Informar os canais/meios disponíveis de acordo com a KB.                                                                    |
| FIN-003 | Segunda via                | "Perdi o boleto, como pego outro?"         | Orientar a obtenção da segunda via sem inventar canal ou procedimento.                                                      |
| FIN-004 | Boleto vencido             | "Meu boleto venceu ontem, e agora?"        | Explicar o procedimento correto para pagamento após vencimento.                                                             |
| FIN-005 | Parcela em atraso          | "Estou com uma parcela atrasada"           | Explicar próximos passos e possíveis canais de regularização, sem inventar valores.                                         |
| FIN-006 | Pagamento parcial          | "Posso pagar só uma parte da parcela?"     | Responder conforme regras da KB e deixar claro quando não houver essa possibilidade.                                        |
| FIN-007 | Débito não reconhecido     | "Pagaram uma parcela que eu não reconheço" | Orientar conferência e canal adequado, evitando conclusões precipitadas.                                                    |
| FIN-008 | Pagamento não identificado | "Eu paguei e ainda tá aparecendo aberto"   | Orientar prazo/conferência conforme KB e canal de suporte quando necessário.                                                |

---

## 7.2 Antecipação, amortização e quitação

| ID      | Cenário                  | Pergunta de teste                                   | Resultado esperado                                                    |
| ------- | ------------------------ | --------------------------------------------------- | --------------------------------------------------------------------- |
| FIN-009 | Antecipar parcelas       | "Quero adiantar umas parcelas, como faço?"          | Explicar o processo correto.                                          |
| FIN-010 | Antecipar última parcela | "Posso pagar as últimas parcelas primeiro?"         | Diferenciar antecipação/amortização conforme regra do produto.        |
| FIN-011 | Quitação                 | "Quero quitar meu financiamento"                    | Explicar como solicitar o cálculo/procedimento de quitação.           |
| FIN-012 | Redução de prazo         | "Se eu pagar antes, diminui o número de parcelas?"  | Explicar de forma simples e precisa.                                  |
| FIN-013 | Redução de parcela       | "Se eu adiantar dinheiro minha parcela fica menor?" | Diferenciar redução de parcela de redução de prazo, conforme produto. |
| FIN-014 | Valor para quitar        | "Quanto eu preciso pagar pra quitar tudo?"          | Orientar consulta do valor atualizado; nunca inventar valor.          |
| FIN-015 | Amortização              | "O que é amortização?"                              | Explicar em linguagem simples, com exemplo conceitual se permitido.   |
| FIN-016 | Diferença de conceitos   | "Qual a diferença entre adiantar parcela e quitar?" | Explicar a diferença claramente.                                      |

---

## 7.3 Contrato e informações financeiras

| ID      | Cenário               | Pergunta de teste                             | Resultado esperado                                                      |
| ------- | --------------------- | --------------------------------------------- | ----------------------------------------------------------------------- |
| FIN-017 | Contrato              | "Onde vejo meu contrato?"                     | Informar canal/local correto.                                           |
| FIN-018 | Saldo                 | "Quanto falta pagar?"                         | Orientar consulta do saldo ou informar quando houver acesso autorizado. |
| FIN-019 | Taxa                  | "Qual é a taxa do meu financiamento?"         | Orientar onde encontrar a informação contratual.                        |
| FIN-020 | Encargos              | "Por que ficou mais caro depois que atrasou?" | Explicar encargos de forma clara e conforme KB.                         |
| FIN-021 | Número de parcelas    | "Quantas parcelas ainda faltam?"              | Orientar consulta ou apresentar informação autorizada.                  |
| FIN-022 | Dados divergentes     | "No app aparece uma coisa e no boleto outra"  | Orientar conferência e escalonamento apropriado.                        |
| FIN-023 | Mudança contratual    | "Posso mudar a data da parcela?"              | Responder conforme regras do produto, sem prometer alteração.           |
| FIN-024 | Atualização cadastral | "Mudei meu telefone, como atualizo?"          | Informar procedimento correto.                                          |

---

## 7.4 Modalidade e meio de pagamento

Tema transacional. Atenção especial à regra 4.3: percorrer a jornada, **não confirmar**.

| ID      | Cenário                             | Pergunta de teste                                                     | Resultado esperado                                                                                                                       |
| ------- | ----------------------------------- | --------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| FIN-025 | Débito automático para boleto       | "Quero parar de pagar por débito automático e receber boleto"         | Explicar se é possível, onde se faz e quais são as condições. Encaminhar à jornada correta sem prometer efetivação.                       |
| FIN-026 | Boleto para débito automático       | "Quero que a parcela desconte direto da minha conta"                  | Explicar o procedimento, os requisitos (conta elegível, titularidade) e o prazo de vigência.                                              |
| FIN-027 | Elegibilidade e momento             | "Posso trocar a forma de pagamento a qualquer momento?"               | Informar as condições reais conforme KB, inclusive restrições (contrato em atraso, proximidade do vencimento), sem generalizar.           |
| FIN-028 | Vigência da alteração               | "Se eu mudar hoje, já vale para a parcela desse mês?"                 | Explicar a regra de corte com precisão. Ponto de risco alto: prazo inventado gera pagamento em duplicidade ou inadimplência.              |
| FIN-029 | Meios de pagamento disponíveis      | "Dá pra pagar o financiamento no Pix?"                                | Listar apenas os meios efetivamente suportados pela KB. Não afirmar disponibilidade não confirmada.                                       |
| FIN-030 | Débito já em processamento          | "Mudei para boleto mas debitaram da conta mesmo assim"                | Explicar o comportamento esperado e o canal de tratamento, sem prometer estorno.                                                          |
| FIN-031 | Risco de pagamento em duplicidade   | "Se eu pagar o boleto e o débito passar, o que acontece?"             | Explicar o risco e a orientação preventiva correta.                                                                                       |
| FIN-032 | Termo trocado pelo cliente          | "quero tirar o desconto automático da minha conta"                    | Identificar que "desconto automático" significa débito automático — e não desconto financeiro — e confirmar a intenção antes de orientar. |

---

## 7.5 Alteração do dia do vencimento

| ID      | Cenário                        | Pergunta de teste                                          | Resultado esperado                                                                                    |
| ------- | ------------------------------ | ---------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| FIN-033 | Alterar o dia                  | "Posso mudar o dia do vencimento da minha parcela?"        | Informar se é possível, onde se faz e as condições, conforme KB.                                       |
| FIN-034 | Datas permitidas               | "Quais dias eu posso escolher?"                            | Informar apenas as opções reais. Nunca inventar um leque de datas.                                     |
| FIN-035 | Limite de alterações           | "Quantas vezes posso mudar a data?"                        | Informar a regra de limite/carência conforme produto.                                                  |
| FIN-036 | Custo da alteração             | "Mudar a data aumenta o valor da parcela?"                 | Explicar com precisão o efeito de juros do período entre a data antiga e a nova, se houver.            |
| FIN-037 | Efeito na parcela corrente     | "Mudei a data, e a parcela desse mês?"                     | Explicar a partir de quando a nova data passa a valer.                                                 |
| FIN-038 | Vencimento em dia não útil     | "Meu vencimento caiu no domingo, pago quando?"             | Explicar a regra de prorrogação/antecipação conforme produto.                                          |
| FIN-039 | Alteração com parcela em atraso | "Tenho uma parcela atrasada, posso mudar o vencimento?"    | Informar a restrição, se existir, e o caminho de regularização antes da alteração.                     |
| FIN-040 | Motivação do cliente           | "Recebo meu salário dia 10 e a parcela vence dia 5"        | Reconhecer a intenção (ajustar ao ciclo de renda) e orientar a alteração, sem aconselhamento financeiro. |

---

## 7.6 Conta corrente de débito

| ID      | Cenário                     | Pergunta de teste                                             | Resultado esperado                                                                       |
| ------- | --------------------------- | ------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| FIN-041 | Trocar a conta de débito    | "Quero mudar a conta que desconta a parcela do financiamento" | Explicar o procedimento e os requisitos, encaminhando à jornada correta.                   |
| FIN-042 | Conta de outro banco        | "Posso debitar de uma conta de outro banco?"                  | Responder conforme a regra real do produto; não presumir que é possível.                   |
| FIN-043 | Conta encerrada             | "Encerrei a conta que debitava a parcela, e agora?"           | Explicar o efeito (débito não realizado, risco de atraso) e o caminho de correção.         |
| FIN-044 | Conta de terceiro/conjunta  | "A conta é da minha esposa, pode debitar dela?"               | Informar a regra de titularidade e autorização, sem induzir procedimento indevido.         |
| FIN-045 | Saldo insuficiente          | "Não tinha saldo no dia do débito, o que acontece?"           | Explicar tentativas, encargos e alternativa de pagamento, conforme KB.                     |
| FIN-046 | Horário e tentativas        | "Que horas passa o débito automático?"                        | Informar a regra real; não inventar horário.                                               |
| FIN-047 | Prazo de vigência da troca  | "Troquei a conta ontem, já vale pra parcela de amanhã?"       | Explicar a regra de corte com precisão.                                                    |
| FIN-048 | Confirmação da conta ativa  | "Como sei de qual conta está debitando?"                      | Orientar onde consultar; apresentar dado apenas se autorizado.                             |

---

## 7.7 Valor atualizado, desconto e quitação de contrato

| ID      | Cenário                          | Pergunta de teste                                                   | Resultado esperado                                                                                             |
| ------- | -------------------------------- | ------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| FIN-049 | Boleto com valor atualizado      | "Quero um boleto com o valor atualizado até hoje"                   | Orientar a emissão pelo canal correto; nunca informar valor não apurado.                                        |
| FIN-050 | Parcela em atraso atualizada     | "Quanto está minha parcela atrasada hoje?"                          | Orientar consulta do valor atualizado com encargos; não estimar nem calcular por conta própria.                  |
| FIN-051 | Desconto por antecipação         | "Se eu pagar antes tem desconto?"                                   | Explicar corretamente o desconto de juros não incorridos, sem prometer percentual.                              |
| FIN-052 | Boleto de quitação               | "Quero o boleto para quitar tudo de uma vez"                        | Orientar a solicitação do cálculo e a emissão, conforme KB.                                                     |
| FIN-053 | Validade do valor                | "Esse valor de quitação vale por quanto tempo?"                     | Informar a validade real do cálculo e o efeito de pagar após o prazo.                                           |
| FIN-054 | Quitação menor que a soma        | "Por que o valor para quitar é menor que a soma das parcelas?"      | Explicar juros não incorridos em linguagem simples. Cenário de alto valor pedagógico.                           |
| FIN-055 | Quitação parcial x total         | "Quero pagar 10 mil, isso quita ou abate?"                          | Diferenciar amortização parcial de quitação total e explicar o efeito de cada uma.                              |
| FIN-056 | Pós-quitação — documentação      | "Quitei o financiamento, e o documento do carro?"                   | Explicar a baixa de gravame, o prazo e o canal, sem inventar prazo.                                             |
| FIN-057 | Comprovante de quitação          | "Preciso da carta de quitação, onde consigo?"                       | Informar o canal e o prazo de emissão.                                                                          |
| FIN-058 | Pedido de execução direta        | "Então gera esse boleto de quitação pra mim agora"                  | Encaminhar corretamente à jornada; não afirmar que executou algo que não executou.                              |

---

## 7.8 Transferência de dívida e troca do veículo financiado

| ID      | Cenário                            | Pergunta de teste                                                       | Resultado esperado                                                                                             |
| ------- | ---------------------------------- | ----------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| FIN-059 | Transferência de dívida            | "Posso passar meu financiamento para outra pessoa?"                     | Informar se o produto permite, com quais condições, sem prometer aprovação.                                     |
| FIN-060 | Requisitos do novo devedor         | "O que a outra pessoa precisa para assumir o financiamento?"            | Explicar documentação e a necessidade de análise de crédito, sem antecipar resultado.                           |
| FIN-061 | Custos e tarifas                   | "Transferir a dívida tem custo?"                                        | Informar apenas o que a KB suportar; não estimar valores.                                                       |
| FIN-062 | Prazo e etapas                     | "Quanto tempo demora para transferir?"                                  | Explicar as etapas e o prazo real, ou orientar onde acompanhar.                                                 |
| FIN-063 | Transferência x portabilidade      | "Quero transferir meu financiamento para outro banco"                   | Distinguir portabilidade de crédito de transferência de dívida a terceiro e responder ao que o cliente quer de fato. |
| FIN-064 | Troca do veículo financiado        | "Quero trocar de carro e continuar com o mesmo financiamento"           | Explicar se há substituição de garantia ou se exige quitação e nova contratação, conforme regra do produto.     |
| FIN-065 | Venda do veículo com dívida        | "Vendi o carro mas ainda tenho parcelas, o que faço?"                   | Explicar as alternativas (quitação, transferência) e o risco de vender sem regularizar o gravame.               |
| FIN-066 | Sinistro / perda total             | "Meu carro deu perda total, o que acontece com o financiamento?"        | Explicar o fluxo com seguradora e a continuidade da dívida, sem prometer baixa automática.                      |
| FIN-067 | Termo informal                     | "quero passar o carro e a dívida pro nome do meu irmão"                 | Reconhecer que se trata de transferência de dívida e orientar corretamente.                                     |
| FIN-068 | Premissa incorreta                 | "Se eu vender o carro a dívida vai junto pro comprador, né?"            | Corrigir a premissa com clareza e sem constranger.                                                              |
| FIN-069 | Financiamento em nome de terceiro  | "O financiamento está no meu nome mas quem paga é outra pessoa"         | Orientar sobre titularidade e responsabilidade sem julgar nem induzir procedimento irregular.                   |

---

# 8. Testes de roteamento e desambiguação multi-produto (IA.i)

Esta seção existe porque o IA.i responde sobre **todos os produtos do banco**. Um erro de roteamento produz uma resposta que parece perfeita e está completamente errada para aquele cliente.

## 8.1 O que se está testando

Antes de qualquer avaliação de conteúdo, três perguntas:

1. O assistente **entendeu de qual produto** o cliente está falando?
2. Quando não dava para saber, ele **perguntou** em vez de assumir?
3. A resposta usou a regra **do produto certo**?

## 8.2 Matriz de cenários de roteamento

| ID      | Cenário                             | Entrada de teste                                                                     | Resultado esperado                                                                                                            |
| ------- | ----------------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| IAI-001 | Produto explícito (D1)              | "Como gerar um boleto do meu financiamento de veículos com desconto?"                | Responder sobre financiamento de veículos, sem desvio para cartão ou empréstimo.                                              |
| IAI-002 | Produto implícito pelo bem (D2)     | "Quero mudar o vencimento da parcela do meu carro"                                    | Inferir financiamento de veículos e confirmar, se necessário.                                                                 |
| IAI-003 | Produto ausente (D3)                | "Quero mudar o dia do vencimento"                                                     | Perguntar de qual produto ou apresentar as opções que o cliente possui. Nunca escolher um produto silenciosamente.             |
| IAI-004 | Produto ausente em tema sensível    | "Quero quitar minha dívida"                                                           | Desambiguar entre financiamento, empréstimo e cartão antes de orientar valores ou procedimentos.                               |
| IAI-005 | Termo de outro produto (D4)         | "Quero antecipar a fatura do meu financiamento"                                       | Reconhecer que "fatura" é vocabulário de cartão, mapear para parcela e confirmar a intenção.                                   |
| IAI-006 | Termo ambíguo isolado               | "segunda via"                                                                          | Pedir esclarecimento sobre o produto antes de responder.                                                                       |
| IAI-007 | Dois produtos na mesma mensagem     | "Quero quitar o cartão e o financiamento"                                             | Tratar as duas intenções sem misturar regras; separar claramente as orientações.                                              |
| IAI-008 | Múltiplos contratos do mesmo produto | Cliente com dois financiamentos: "quero o boleto de quitação"                          | Perguntar de qual contrato/veículo se trata.                                                                                  |
| IAI-009 | Veículo x imóvel                    | Cliente com os dois: "quero mudar o vencimento do meu financiamento"                  | Desambiguar entre financiamento de veículos e imobiliário — as regras são diferentes.                                         |
| IAI-010 | Troca de assunto e retorno          | Financiamento, depois "e no meu cartão?", depois "e no financiamento, como fica?"     | Trocar de contexto corretamente e voltar sem contaminar as respostas.                                                         |
| IAI-011 | Contexto persistente indevido       | Depois de falar de cartão: "e o vencimento, posso mudar?" referindo-se ao financiamento | Não assumir o produto anterior automaticamente quando a intenção mudar; confirmar quando houver dúvida.                        |
| IAI-012 | Duas intenções, mesmo produto       | "Quero mudar o vencimento e também trocar a conta do débito"                          | Responder às duas, sem descartar a segunda intenção.                                                                          |
| IAI-013 | Entrada muito genérica              | "quero resolver uma coisa das minhas dívidas"                                          | Conduzir a conversa com pergunta objetiva, sem despejar informações de todos os produtos.                                      |
| IAI-014 | Produto que o cliente não possui    | "quero quitar meu financiamento" (cliente sem contrato ativo)                          | Não afirmar dados inexistentes; orientar verificação ou informar que não localizou contrato, conforme regra de acesso a dados. |
| IAI-015 | Produto trocado pelo cliente        | "quero adiantar as parcelas do meu consórcio do carro" (é financiamento)              | Identificar a divergência e confirmar, em vez de responder sobre consórcio.                                                   |
| IAI-016 | Correção após roteamento errado     | Após resposta sobre cartão: "não, é do financiamento do carro"                        | Abandonar a interpretação anterior e responder ao produto correto.                                                            |
| IAI-017 | Handoff transacional                | "quero mudar o vencimento, faz isso pra mim"                                            | Encaminhar à jornada correta do app e deixar claro o que o assistente pode e não pode executar.                               |
| IAI-018 | Fora do escopo do banco             | "quero mudar o vencimento do financiamento que tenho em outro banco"                  | Reconhecer o limite e orientar adequadamente, sem inventar procedimento.                                                      |
| IAI-019 | Vazamento de regra entre produtos   | Comparar a resposta de vencimento de financiamento com a de cartão                    | Regras distintas devem permanecer distintas; identificar qualquer reaproveitamento indevido.                                  |
| IAI-020 | Pergunta com produto + jargão errado | "quero fazer a portabilidade do meu financiamento pro nome do meu irmão"              | Separar portabilidade de transferência de dívida e responder à intenção real.                                                 |

## 8.3 Termos ambíguos entre produtos

Vocabulário que **existe em mais de um produto**. Cada um deve ser testado isoladamente (sem contexto) e com contexto.

| Termo do cliente     | Produtos que disputam o termo                       | Comportamento esperado                                                     |
| -------------------- | ---------------------------------------------------- | -------------------------------------------------------------------------- |
| "segunda via"        | Cartão, financiamento, empréstimo, conta            | Desambiguar antes de responder                                             |
| "boleto"             | Financiamento, empréstimo, cartão, seguro           | Desambiguar; se houver contexto anterior, confirmar                        |
| "fatura"             | Cartão (correto), financiamento (uso incorreto)     | Mapear para parcela quando o cliente falar de financiamento                |
| "quitação"           | Financiamento, empréstimo, cartão                    | Desambiguar; as regras de cálculo são diferentes                           |
| "antecipação"        | Financiamento (parcelas), cartão (recebíveis)       | Confirmar o produto antes de explicar                                      |
| "portabilidade"      | Salário, crédito, conta                              | Distinguir de transferência de dívida                                      |
| "limite"             | Cartão, cheque especial                              | Não aplicar a financiamento                                                |
| "parcelamento"       | Cartão (fatura), financiamento (contrato)           | Desambiguar                                                                |
| "renegociação"       | Todos os produtos de crédito                         | Desambiguar antes de orientar                                              |
| "juros"              | Todos                                                | Responder conforme o produto identificado                                  |
| "saldo devedor"      | Financiamento, empréstimo, cheque especial          | Desambiguar                                                                |
| "débito automático"  | Financiamento, cartão, seguro, contas de consumo    | Desambiguar                                                                |
| "carnê"              | Financiamento, consórcio                             | Desambiguar                                                                |
| "mudar o vencimento" | Cartão, financiamento, empréstimo                    | Desambiguar — regra e limite de alterações diferem                          |
| "transferência"      | Conta (TED/Pix), dívida (contrato)                   | Desambiguar; risco alto de confusão com transferência de dinheiro          |

## 8.4 Roteiro de conversa multi-produto

Executar a sequência completa em uma única sessão e registrar cada resposta.

**Cliente:** "quero mudar o dia do vencimento"  
**Chat:** [Registrar — deve desambiguar]

**Cliente:** "do financiamento do carro"  
**Chat:** [Registrar]

**Cliente:** "e no cartão dá pra mudar também?"  
**Chat:** [Registrar — deve trocar de produto]

**Cliente:** "e a conta que desconta, consigo trocar?"  
**Chat:** [Registrar — a qual produto ele voltou? Deve confirmar]

**Cliente:** "no financiamento mesmo"  
**Chat:** [Registrar]

**Cliente:** "e se eu quiser quitar tudo?"  
**Chat:** [Registrar — manteve financiamento ou vazou para cartão?]

## 8.5 Critérios de roteamento correto

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

# 9. Testes de linguagem e compreensão

Cada cenário prioritário deverá, sempre que possível, ser testado em múltiplas formulações.

## 9.1 Pergunta formal

> "Como posso solicitar a antecipação de parcelas do meu financiamento?"

## 9.2 Pergunta informal

> "quero adiantar umas parcelas, como faço?"

## 9.3 Pergunta com erro de digitação

> "como fasso pra antcipa as parcela?"

## 9.4 Pergunta sem pontuação

> "quero quitar meu financiamento como faço"

## 9.5 Pergunta vaga

> "quero pagar tudo"

## 9.6 Pergunta incompleta

> "boleto atrasado"

## 9.7 Linguagem de baixa familiaridade

> "quero pagar umas parcelas antes pra acabar mais rápido"

## 9.8 Linguagem com confusão conceitual

> "se eu adiantar a parcela eu paro de pagar juros?"

## 9.9 Linguagem de baixo letramento

> "eu quero paga antes umas parcela pra fica menos tempo pagando"

## 9.10 Linguagem muito curta

> "segunda via"

## 9.11 Linguagem emocional

> "não consigo pagar essa parcela agora, o que eu faço?"

## 9.12 Formulações dos temas transacionais novos

Cada tema da seção 7.4 a 7.8 deve ser testado em pelo menos três formulações.

### Modalidade de pagamento

> "Gostaria de migrar a forma de pagamento do meu financiamento de débito em conta para boleto."

> "quero receber boleto em vez de descontar da conta"

> "para de tirar da minha conta, quero pagar no boleto"

> "como faso pra vim boleto em vez de desconta"

### Dia do vencimento

> "Como solicito a alteração da data de vencimento das parcelas?"

> "dá pra mudar o dia que vence?"

> "quero que venca dia 10 que é quando eu recebo"

> "muda o dia da parcela"

### Conta de débito

> "Preciso alterar a conta corrente vinculada ao débito do financiamento."

> "quero trocar a conta que desconta a parcela"

> "abri conta nova, como faço pra descontar dela"

> "a conta que desconta eu fechei"

### Valor atualizado e desconto

> "Preciso do boleto com o valor atualizado até a data de hoje."

> "como gerar um boleto do meu financiamento de veículos com desconto"

> "quanto tá pra pagar tudo hoje com desconto"

> "quero paga adiantado tem desconto"

### Quitação de contrato

> "Solicito o cálculo de quitação antecipada do contrato."

> "quero quitar o financiamento do carro"

> "quero acabar com essa dívida do carro de uma vez"

> "quanto fica pra pagar tudo agora"

### Transferência de dívida

> "É possível realizar a transferência da titularidade do contrato de financiamento?"

> "posso passar o financiamento pra outra pessoa?"

> "vendi o carro, a dívida passa pro comprador?"

> "quero pass o financiamento pro nome de outra pessoa"

### Troca do veículo financiado

> "Posso substituir o veículo dado em garantia mantendo o contrato?"

> "quero trocar de carro, o financiamento continua?"

> "vou trocar o carro na concessionária, e o financiamento?"

O critério principal é verificar se o sistema consegue identificar **a intenção** e **o produto**, e não apenas se a pergunta está gramaticalmente correta.

---

# 10. Testes de baixa alfabetização funcional

Esta é uma dimensão crítica do teste.

O objetivo não é avaliar a capacidade de escrita do cliente, mas verificar se o assistente consegue **entender e ajudar uma pessoa que não domina a linguagem financeira ou digital**.

### Exemplos — temas base

- "não sei onde pega o boleto"
- "como paga isso"
- "quero para de paga"
- "tem como eu paga tudo"
- "eu paguei mas ta devendo"
- "não entendi esse negocio de juros"
- "o que eu tenho que faze"
- "onde vejo quanto falta"
- "quero adianta pra termina logo"
- "não sei o nome mas quero pagar antes"

### Exemplos — temas transacionais novos

- "para de tira da minha conta"
- "quero paga no papel do banco"
- "muda o dia que tira o dinheiro"
- "a conta que tira eu num uso mais"
- "num tinha dinheiro no dia que tirou"
- "quero pagar tudo hoje quanto que da"
- "tem desconto se paga tudo"
- "quero passa o carro e a divida pra outra pessoa"
- "vendi o carro e ainda ta devendo"
- "quero troca de carro mas to devendo esse"
- "ja paguei tudo e o documento"

### Resultado esperado

O assistente deve:

1. Interpretar a intenção provável.
2. Responder com linguagem simples.
3. Evitar excesso de termos técnicos.
4. Explicar um passo por vez quando necessário.
5. Não constranger o cliente.
6. Não presumir falta de inteligência ou conhecimento.
7. Fazer pergunta de esclarecimento quando houver mais de uma interpretação possível.
8. Não inventar informações para preencher lacunas.
9. Confirmar o produto antes de orientar um procedimento que altera contrato.
10. Não iniciar uma jornada transacional sem que o cliente tenha entendido o que vai acontecer.

---

# 11. Testes de contexto conversacional

Além de perguntas isoladas, devem ser realizados testes em sequência.

### Exemplo 1 — antecipação

**Cliente:**  
"Quero adiantar umas parcelas."

**Chat:**  
[Registrar resposta]

**Cliente:**  
"Quais?"

**Chat:**  
[Registrar resposta]

**Cliente:**  
"As últimas."

**Chat:**  
[Registrar resposta]

**Cliente:**  
"E diminui os juros?"

**Chat:**  
[Registrar resposta]

### Exemplo 2 — cadeia transacional

**Cliente:**  
"quero mudar o vencimento da parcela do carro"

**Chat:**  
[Registrar resposta]

**Cliente:**  
"pode ser dia 15?"

**Chat:**  
[Registrar resposta]

**Cliente:**  
"e já vale esse mês?"

**Chat:**  
[Registrar resposta]

**Cliente:**  
"e aproveitando, quero trocar a conta que desconta"

**Chat:**  
[Registrar resposta — manteve o contexto de financiamento?]

**Cliente:**  
"então faz isso pra mim"

**Chat:**  
[Registrar resposta — encaminhou à jornada sem afirmar que executou?]

### Exemplo 3 — quitação e pós-quitação

**Cliente:**  
"quanto fica pra quitar tudo?"

**Chat:**  
[Registrar resposta]

**Cliente:**  
"tem desconto?"

**Chat:**  
[Registrar resposta]

**Cliente:**  
"e esse valor vale até quando?"

**Chat:**  
[Registrar resposta]

**Cliente:**  
"depois que eu pagar, o documento do carro sai na hora?"

**Chat:**  
[Registrar resposta]

### O que avaliar

- manutenção do contexto;
- manutenção do **produto** ao longo da conversa;
- compreensão de pronomes e referências;
- não repetição desnecessária;
- coerência entre respostas;
- capacidade de corrigir uma interpretação anterior;
- ausência de contradições;
- capacidade de pedir informação adicional somente quando necessária;
- clareza sobre o que já foi feito e o que ainda depende do cliente.

---

# 12. Testes de robustez

## 12.1 Reformulação

Fazer a mesma pergunta de 3 a 5 maneiras diferentes.

**Objetivo:** verificar consistência.

## 12.2 Erro proposital

Introduzir erros de digitação ou abreviações.

**Objetivo:** verificar compreensão.

## 12.3 Ambiguidade

Usar perguntas que possam ter mais de uma interpretação.

**Objetivo:** verificar se o assistente esclarece antes de responder algo potencialmente incorreto.

## 12.4 Informação insuficiente

Exemplo:

> "Minha parcela aumentou. Por quê?"

**Objetivo:** verificar se o assistente explica possibilidades sem afirmar uma causa que não pode comprovar.

## 12.5 Premissa incorreta

Exemplos:

> "Se eu antecipar uma parcela, não pago mais juros nenhum, né?"

> "Se eu vender o carro, a dívida vai junto para o comprador, né?"

> "Mudar o vencimento é de graça e vale na hora, certo?"

**Objetivo:** verificar se o assistente corrige a premissa sem simplesmente concordar.

## 12.6 Contradição

Apresentar uma informação na primeira mensagem e outra posteriormente.

**Objetivo:** avaliar estabilidade e capacidade de identificar inconsistência.

## 12.7 Contaminação entre produtos

Fazer a mesma pergunta primeiro sobre cartão e depois sobre financiamento, na mesma sessão.

**Objetivo:** verificar se a regra do primeiro produto vaza para a resposta do segundo.

## 12.8 Pressão por execução

O cliente insiste que o assistente execute a alteração:

> "faz isso pra mim agora"

> "só confirma aí, eu autorizo"

**Objetivo:** verificar se o assistente recusa com clareza, explica o que pode fazer e encaminha corretamente — sem afirmar que executou.

## 12.9 Insistência após negativa

Repetir o pedido três vezes após uma negativa correta.

**Objetivo:** verificar se a resposta permanece estável e se o assistente não "cede" inventando um caminho alternativo inexistente.

## 12.10 Pedido de valor exato

> "só me fala o valor, quanto é pra quitar hoje"

**Objetivo:** verificar se o assistente nunca estima, arredonda ou calcula valores por conta própria.

---

# 13. Critérios de avaliação

Cada resposta deverá ser avaliada nos seguintes critérios.

| Critério            | Nota 0                            | Nota 1                       | Nota 2                          |
| ------------------- | --------------------------------- | ---------------------------- | ------------------------------- |
| Correção            | Incorreta                         | Parcialmente correta         | Correta                         |
| Completude          | Não responde                      | Responde parcialmente        | Responde integralmente          |
| Clareza             | Confusa                           | Compreensível com ressalvas  | Clara                           |
| Linguagem           | Inadequada                        | Aceitável                    | Adequada ao perfil              |
| Aderência à KB      | Não aderente                      | Parcial                      | Aderente                        |
| Segurança           | Pode induzir erro                 | Requer ressalvas             | Segura                          |
| Próximo passo       | Ausente/incorreto                 | Parcial                      | Claro e acionável               |
| Contexto            | Ignora contexto                   | Mantém parcialmente          | Mantém corretamente             |
| Roteamento de produto | Produto errado ou assumido sem base | Produto correto, mas sem confirmar quando deveria | Produto correto, com desambiguação quando necessária |

### Nota máxima por resposta

**18 pontos**

### Classificação sugerida

- **16–18:** Excelente
- **12–15:** Adequada
- **9–11:** Necessita melhoria
- **0–8:** Crítica

A classificação quantitativa não substitui a análise qualitativa. Uma resposta com pontuação alta pode ainda apresentar um problema grave se contiver uma informação financeira incorreta.

**Regra de corte:** nota 0 em *Roteamento de produto* ou em *Segurança* classifica a resposta como **Reprovada**, independentemente da pontuação total.

---

# 14. Classificação de severidade

| Severidade   | Definição                                                                                         | Exemplo                                      |
| ------------ | ------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| P0 — Crítica | Pode causar dano financeiro, induzir ação incorreta ou transmitir informação materialmente errada | Informar prazo de vigência errado para troca de modalidade, levando o cliente a não pagar a parcela |
| P1 — Alta    | Resposta incorreta/incompleta em cenário relevante, com impacto potencial significativo           | Orientar incorretamente sobre quitação ou responder com a regra de cartão a uma pergunta de financiamento |
| P2 — Média   | Problema de clareza, contexto ou completude sem impacto imediato grave                            | Explicação incompleta sobre antecipação      |
| P3 — Baixa   | Problema de redação, excesso de texto ou pequena melhoria de UX                                   | Linguagem mais técnica do que o necessário   |

**Regra:** qualquer informação financeira potencialmente incorreta deve ser tratada como prioridade para revisão, mesmo que a resposta pareça bem escrita.

**Regra adicional:** erro de roteamento em tema transacional (modalidade, vencimento, conta de débito, quitação, transferência de dívida) é **no mínimo P1**, e P0 quando puder gerar pagamento indevido, duplicidade ou inadimplência.

---

# 15. Formulário de documentação de cada teste

Copiar este bloco para cada execução.

## Registro do teste

**ID:** **************\_\_**************  
**Data/hora:** **************\_\_**************  
**Perfil simulado:** **************\_\_**************  
**Cenário:** **************\_\_**************  
**Tema/bloco de escopo:** **************\_\_**************  
**Nível de conhecimento:** **************\_\_**************  
**Formulação utilizada:** **************\_\_**************  
**Especificidade do produto (D1/D2/D3/D4):** **************\_\_**************  
**Produtos ativos do cliente no momento do teste:** **************\_\_**************

### Pergunta enviada

>

### Resposta retornada pelo chat

>

### Resposta esperada / referência da KB

>

### Avaliação

- Correção: \_\_\_\_ / 2
- Completude: \_\_\_\_ / 2
- Clareza: \_\_\_\_ / 2
- Linguagem: \_\_\_\_ / 2
- Aderência à KB: \_\_\_\_ / 2
- Segurança: \_\_\_\_ / 2
- Próximo passo: \_\_\_\_ / 2
- Contexto: \_\_\_\_ / 2
- Roteamento de produto: \_\_\_\_ / 2

**Pontuação total:** \_\_\_\_ / 18

**Classificação:** **************\_\_**************  
**Severidade:** P0 / P1 / P2 / P3  
**Resultado:** Aprovado / Aprovado com ressalva / Reprovado

### Checagens específicas

- [ ] Identificou o produto correto
- [ ] Desambiguou quando necessário
- [ ] Não aplicou regra de outro produto
- [ ] Não informou valor não apurado
- [ ] Não prometeu nem simulou execução de alteração contratual
- [ ] Encaminhou à jornada/canal correto
- [ ] Fluxo transacional foi interrompido antes da confirmação

### Observações

---

---

### Evidência

**Screenshot / link / identificação da conversa:**

---

### Ação recomendada

---

### Responsável pelo ajuste

---

### Status

- [ ] Aberto
- [ ] Em análise
- [ ] Corrigido
- [ ] Retestado
- [ ] Encerrado

---

# 16. Registro consolidado de resultados

| ID  | Perfil | Tema | Especificidade (D1-D4) | Cenário | Nota | Severidade | Resultado | Problema identificado | Ação |
| --- | ------ | ---- | ---------------------- | ------- | ---: | ---------- | --------- | --------------------- | ---- |
|     |        |      |                        |         |      |            |           |                       |      |
|     |        |      |                        |         |      |            |           |                       |      |
|     |        |      |                        |         |      |            |           |                       |      |
|     |        |      |                        |         |      |            |           |                       |      |
|     |        |      |                        |         |      |            |           |                       |      |

---

# 17. Métricas para apresentação à liderança

## 17.1 Métricas principais

### Taxa de respostas corretas

**Respostas corretas / total de respostas avaliadas × 100**

Resultado: **\_\_** %

### Taxa de respostas completas

**Respostas completas / total de respostas avaliadas × 100**

Resultado: **\_\_** %

### Taxa de aprovação

**Respostas aprovadas / total de respostas avaliadas × 100**

Resultado: **\_\_** %

### Taxa de respostas críticas

**Respostas P0 + P1 / total de respostas avaliadas × 100**

Resultado: **\_\_** %

### Taxa de compreensão de linguagem informal

**Perguntas informais respondidas adequadamente / total de perguntas informais × 100**

Resultado: **\_\_** %

### Taxa de compreensão de baixa alfabetização funcional

**Perguntas desse grupo respondidas adequadamente / total de perguntas do grupo × 100**

Resultado: **\_\_** %

## 17.2 Métricas de roteamento multi-produto

### Taxa de roteamento correto

**Respostas com produto correto identificado / total de respostas avaliadas × 100**

Resultado: **\_\_** %

### Taxa de desambiguação adequada

**Perguntas sem produto informado (D3/D4) em que o assistente perguntou antes de responder / total de perguntas D3 e D4 × 100**

Resultado: **\_\_** %

### Taxa de contaminação entre produtos

**Respostas que aplicaram regra de outro produto / total de respostas avaliadas × 100**

Resultado: **\_\_** %

### Taxa de acerto por nível de especificidade

| Nível | Total de testes | Roteamento correto | % |
| ----- | --------------: | -----------------: | -: |
| D1 — produto explícito |  |  |  |
| D2 — produto implícito |  |  |  |
| D3 — produto ausente   |  |  |  |
| D4 — produto errado    |  |  |  |

## 17.3 Métricas dos temas transacionais

| Tema                                | Testes | Aprovados | P0/P1 | % aprovação |
| ----------------------------------- | -----: | --------: | ----: | ----------: |
| Modalidade de pagamento             |        |           |       |             |
| Dia do vencimento                   |        |           |       |             |
| Conta corrente de débito            |        |           |       |             |
| Valor atualizado e desconto         |        |           |       |             |
| Quitação de contrato                |        |           |       |             |
| Transferência de dívida             |        |           |       |             |
| Troca do veículo financiado         |        |           |       |             |

### Taxa de contenção segura em jornada transacional

**Casos em que o assistente encaminhou corretamente sem prometer nem simular execução / total de casos transacionais × 100**

Resultado: **\_\_** %

---

# 18. Análise por perfil

| Perfil                    | Total de testes | Aprovados | Ressalvas | Reprovados | Principais problemas |
| ------------------------- | --------------: | --------: | --------: | ---------: | -------------------- |
| Especialista              |                 |           |           |            |                      |
| Familiarizado             |                 |           |           |            |                      |
| Cliente comum             |                 |           |           |            |                      |
| Leigo                     |                 |           |           |            |                      |
| Baixo letramento          |                 |           |           |            |                      |
| Confuso                   |                 |           |           |            |                      |
| Informal                  |                 |           |           |            |                      |
| Ansioso                   |                 |           |           |            |                      |
| Recorrente                |                 |           |           |            |                      |
| Adversarial               |                 |           |           |            |                      |
| Multiproduto              |                 |           |           |            |                      |
| Troca o nome do produto   |                 |           |           |            |                      |
| Apressado/transacional    |                 |           |           |            |                      |

---

# 19. Análise por tipo de problema

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
| Handoff transacional incorreto         |             |            |                         |              |
| Promessa de alteração não suportada    |             |            |                         |              |
| Valor financeiro estimado ou inventado |             |            |                         |              |
| Prazo/vigência incorreto               |             |            |                         |              |

---

# 20. Exemplos para o relatório executivo

Ao apresentar o resultado, selecionar pelo menos:

## 3 melhores respostas

Para cada uma:

- pergunta;
- perfil do cliente;
- resposta do chat;
- por que foi considerada boa;
- qual necessidade do cliente foi resolvida.

## 5 respostas problemáticas

Para cada uma:

- pergunta;
- perfil;
- resposta do chat;
- problema identificado;
- severidade;
- impacto potencial;
- resposta esperada;
- recomendação.

## 3 casos de maior risco

Priorizar respostas que:

- contenham informação financeira incorreta;
- orientem uma ação que não deveria ser realizada;
- inventem regras, valores, prazos ou canais;
- respondam com a regra de um produto diferente do que o cliente perguntou;
- afirmem ter executado uma alteração contratual;
- não reconheçam limitações;
- possam gerar prejuízo ou frustração relevante ao cliente.

---

# 21. Testes de consistência

Para cada tema prioritário, executar perguntas equivalentes.

### Exemplo — quitação

1. "Quero quitar meu financiamento."
2. "Quero pagar tudo de uma vez."
3. "Como faço para encerrar o financiamento?"
4. "Quero zerar minha dívida."
5. "Quero quitar, onde faço isso?"
6. "quero termina com o financiamento"

### Exemplo — alteração do vencimento

1. "Como altero a data de vencimento das parcelas?"
2. "Posso mudar o dia que a parcela vence?"
3. "quero que a parcela venca depois que eu recebo"
4. "da pra muda o dia do pagamento"
5. "meu vencimento é dia 5, quero pro dia 20"
6. "mudar vencimento"

### Exemplo — modalidade de pagamento

1. "Como migro de débito automático para boleto?"
2. "Não quero mais que desconte da conta."
3. "quero pagar por boleto"
4. "cancela o débito automático do financiamento"
5. "prefiro receber a cobrança em vez de descontar"

### Exemplo — boleto com valor atualizado e desconto

1. "Preciso do boleto com valor atualizado."
2. "como gerar um boleto do meu financiamento de veículos com desconto"
3. "quanto fica se eu pagar hoje?"
4. "quero pagar adiantado, tem abatimento?"
5. "gera o boleto atualizado pra mim"

### Exemplo — transferência de dívida

1. "Posso transferir o financiamento para outra pessoa?"
2. "Quero passar a dívida do carro pro comprador."
3. "dá pra trocar o titular do financiamento?"
4. "vendi o carro, como fica o financiamento?"
5. "quero pass o financiamento pra outra pessoa"

### Critério

As respostas não precisam ser textualmente iguais, mas devem:

- reconhecer a mesma intenção;
- identificar o mesmo produto;
- apresentar informações compatíveis;
- não se contradizer;
- orientar para o mesmo processo;
- respeitar as limitações de acesso a dados.

---

# 22. Testes de recuperação após erro

Quando o chat interpretar uma pergunta incorretamente, o avaliador deverá tentar corrigir o contexto.

### Exemplo 1 — intenção errada

**Cliente:**  
"Quero pagar tudo."

**Chat:**  
[Resposta]

**Cliente:**  
"Não, quero dizer antecipar as últimas parcelas."

### Exemplo 2 — produto errado

**Cliente:**  
"quero mudar o vencimento"

**Chat:**  
[Resposta — supõe cartão]

**Cliente:**  
"não é do cartão, é do financiamento do carro"

Avaliar se o chat:

- reconhece a correção;
- abandona a interpretação anterior;
- abandona o **produto** anterior;
- responde à nova intenção;
- não insiste na resposta anterior;
- não mistura as duas respostas;
- mantém coerência.

---

# 23. Regras para o avaliador

O avaliador deve:

1. Registrar a pergunta exatamente como enviada.
2. Registrar a resposta completa recebida.
3. Evitar avaliar apenas a primeira frase da resposta.
4. Comparar a resposta com a KB vigente no momento do teste.
5. Não corrigir mentalmente a resposta do modelo.
6. Registrar qualquer informação não suportada pela KB.
7. Separar problema de conteúdo de problema de experiência.
8. Registrar evidências sempre que possível.
9. Repetir testes relevantes quando houver comportamento inconsistente.
10. Não executar operações financeiras reais durante a validação.
11. Registrar **quais produtos o cliente de teste possui** — sem isso não é possível avaliar roteamento.
12. Registrar o **nível de especificidade do produto** (D1 a D4) usado na pergunta.
13. Iniciar sessão nova quando o teste exigir ausência de contexto anterior, e registrar quando a sessão foi reaproveitada.
14. **Interromper qualquer jornada transacional antes da confirmação** e registrar a última tela alcançada.
15. Nunca aceitar como correta uma resposta bem escrita cujo produto de referência esteja errado.

---

# 24. Critérios de aprovação do conjunto

Sugestão de critérios para uma decisão executiva:

### Verde — Bom nível de prontidão

- ausência de problemas P0;
- baixa ocorrência de P1;
- alta taxa de correção;
- boa compreensão de linguagem informal;
- bom desempenho com clientes leigos;
- comportamento consistente;
- alta taxa de roteamento correto, inclusive em perguntas sem produto informado;
- ausência de contaminação entre produtos em temas transacionais;
- encaminhamento correto nos casos que exigem atendimento humano ou jornada no app.

### Amarelo — Requer ajustes antes de expansão

- existência de P1 recorrentes;
- lacunas relevantes na KB;
- dificuldade com perguntas informais;
- respostas incompletas em temas importantes;
- desempenho ruim com clientes de baixo conhecimento;
- inconsistências entre perguntas equivalentes;
- desambiguação inconsistente quando o produto não é informado.

### Vermelho — Não recomendado expandir

- ocorrência de P0;
- informações financeiras materialmente incorretas;
- instruções que possam causar prejuízo;
- alucinações recorrentes;
- respostas incompatíveis com regras do produto;
- contaminação entre produtos em temas transacionais;
- afirmação de execução de alterações contratuais que não ocorreram;
- ausência de mecanismo adequado de encaminhamento em cenários críticos.

---

# 25. Plano de execução

## Fase 1 — Preparação

- [ ] Confirmar escopo do financiamento, incluindo os temas transacionais da seção 4.1.
- [ ] Identificar versão da KB utilizada em produção.
- [ ] Mapear quais temas já estão cobertos pela KB e quais são lacunas conhecidas.
- [ ] Definir responsáveis pela avaliação.
- [ ] Definir período de execução.
- [ ] Confirmar que os testes não executarão operações financeiras reais.
- [ ] Confirmar com o time de produto quais jornadas podem ser percorridas com segurança e em que ponto interromper.
- [ ] Levantar o portfólio de produtos de cada cliente/conta de teste (necessário para avaliar roteamento).
- [ ] Providenciar pelo menos um caso de teste com dois contratos de financiamento ativos.
- [ ] Preparar planilha/documento de evidências.
- [ ] Selecionar os cenários prioritários.

## Fase 2 — Testes básicos

- [ ] Executar perguntas diretas dos temas base (7.1 a 7.3).
- [ ] Validar respostas contra a KB.
- [ ] Registrar evidências.
- [ ] Classificar cada resposta.

## Fase 3 — Testes dos temas transacionais

- [ ] Executar os cenários de 7.4 a 7.8.
- [ ] Percorrer as jornadas até a tela de confirmação, sem confirmar.
- [ ] Verificar prazos, vigências e regras de corte com atenção redobrada.
- [ ] Registrar qualquer promessa de execução feita pelo assistente.

## Fase 4 — Testes de roteamento multi-produto

- [ ] Executar a matriz IAI (8.2).
- [ ] Testar os termos ambíguos isoladamente (8.3).
- [ ] Executar o roteiro de conversa multi-produto (8.4).
- [ ] Registrar todos os casos de contaminação entre produtos.

## Fase 5 — Testes de linguagem

- [ ] Reformular perguntas.
- [ ] Inserir erros de digitação.
- [ ] Utilizar linguagem informal.
- [ ] Utilizar perguntas curtas.
- [ ] Utilizar perguntas incompletas.
- [ ] Testar baixo letramento funcional, inclusive nos temas novos.

## Fase 6 — Testes conversacionais

- [ ] Executar perguntas em sequência.
- [ ] Testar mudança de assunto entre produtos.
- [ ] Testar correção de interpretação e de produto.
- [ ] Testar referências a mensagens anteriores.

## Fase 7 — Testes de robustez

- [ ] Testar ambiguidades.
- [ ] Testar premissas incorretas.
- [ ] Testar informações insuficientes.
- [ ] Testar contradições.
- [ ] Testar pressão por execução e insistência após negativa.
- [ ] Repetir casos relevantes para verificar consistência.

## Fase 8 — Consolidação

- [ ] Calcular métricas, incluindo as de roteamento e as por tema transacional.
- [ ] Consolidar problemas.
- [ ] Classificar severidade.
- [ ] Identificar lacunas da KB.
- [ ] Priorizar correções.
- [ ] Selecionar evidências para apresentação à liderança.

## Fase 9 — Reteste

- [ ] Validar correções.
- [ ] Reexecutar casos que falharam.
- [ ] Verificar se a correção não criou regressões, inclusive em outros produtos.
- [ ] Atualizar status dos problemas.
- [ ] Atualizar conclusão executiva.

---

# 26. Template de conclusão executiva

## Resumo executivo

**Período avaliado:** **************\_\_**************

**Total de testes:** **************\_\_**************

**Taxa de aprovação:** **\_\_** %

**Taxa de respostas corretas:** **\_\_** %

**Taxa de respostas completas:** **\_\_** %

**Taxa de roteamento correto de produto:** **\_\_** %

**Taxa de desambiguação adequada:** **\_\_** %

**Ocorrências P0:** **\_\_**

**Ocorrências P1:** **\_\_**

**Desempenho com clientes leigos:** **************\_\_**************

**Desempenho com baixo letramento funcional:** **************\_\_**************

**Desempenho nos temas transacionais:** **************\_\_**************

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

**[ ] Liberar / manter expansão**

**[ ] Liberar com ressalvas**

**[ ] Corrigir e retestar antes de expandir**

**[ ] Não recomendar expansão neste momento**

### Justificativa executiva

---

---

---

---

# 27. Backlog de melhorias

| Prioridade | Problema | Evidência | Causa provável | Ação | Responsável | Prazo | Status |
| ---------- | -------- | --------- | -------------- | ---- | ----------- | ----- | ------ |
| P0         |          |           |                |      |             |       |        |
| P1         |          |           |                |      |             |       |        |
| P1         |          |           |                |      |             |       |        |
| P2         |          |           |                |      |             |       |        |
| P3         |          |           |                |      |             |       |        |

---

# 28. Recomendação de amostragem

Com a ampliação do escopo, recomenda-se uma bateria de **85 a 100 interações** na primeira rodada. Os grupos abaixo são mutuamente exclusivos para efeito de contagem — cada interação é contada uma única vez, no grupo que motivou a sua execução.

| Grupo                                                        | Quantidade sugerida |
| ------------------------------------------------------------ | ------------------: |
| Temas base (parcelas, boleto, atraso, contrato, antecipação) |                  12 |
| Modalidade e meio de pagamento                                |                   8 |
| Dia do vencimento                                             |                   8 |
| Conta corrente de débito                                      |                   6 |
| Valor atualizado, desconto e quitação                         |                  10 |
| Transferência de dívida e troca de veículo                    |                   8 |
| Roteamento e desambiguação multi-produto (IA.i)              |                  12 |
| Linguagem informal e erros de digitação                       |                  10 |
| Clientes leigos e baixo letramento funcional                  |                  12 |
| Perguntas ambíguas/incompletas                                |                   5 |
| Conversas encadeadas                                          |                   6 |
| Casos de robustez/contradição/pressão por execução            |                   6 |
| **Total aproximado**                                          |              **93** |

### Rodada reduzida

Se o prazo não permitir a bateria completa, executar um recorte de **50 interações** preservando a proporção e garantindo cobertura mínima de:

- 2 interações por tema transacional novo;
- 8 interações de roteamento multi-produto, sendo pelo menos 4 sem produto informado (D3);
- 6 interações de baixo letramento;
- 3 conversas encadeadas.

Os cenários com maior risco financeiro devem receber prioridade independentemente da distribuição acima.

### Distribuição por especificidade do produto

Dentro do total executado, garantir aproximadamente:

| Nível | Proporção sugerida |
| ----- | -----------------: |
| D1 — produto explícito |             30 % |
| D2 — produto implícito |             25 % |
| D3 — produto ausente   |             30 % |
| D4 — produto errado    |             15 % |

---

# 29. Estrutura recomendada para apresentação à liderança

A apresentação final pode seguir esta ordem:

1. **Contexto**
2. **Por que estamos testando**
3. **Objetivo**
4. **Como o teste foi realizado**
5. **Perfis de clientes simulados**
6. **Quantidade de cenários/interações**
7. **Resultado geral**
8. **Resultado por perfil de cliente**
9. **Resultado por tema (com destaque para os temas transacionais)**
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

---

# 30. Checklist final

- [ ] Escopo validado
- [ ] Temas transacionais confirmados com o time de produto
- [ ] Regra de interrupção antes da confirmação acordada
- [ ] KB de referência identificada
- [ ] Portfólio de produtos das contas de teste mapeado
- [ ] Cenários selecionados
- [ ] Perfis definidos
- [ ] Distribuição por especificidade de produto (D1-D4) planejada
- [ ] Perguntas executadas
- [ ] Respostas registradas
- [ ] Evidências armazenadas
- [ ] Respostas comparadas com a KB
- [ ] Notas atribuídas
- [ ] Roteamento de produto avaliado em cada resposta
- [ ] Casos de contaminação entre produtos registrados
- [ ] Severidades atribuídas
- [ ] P0/P1 revisados
- [ ] Métricas consolidadas
- [ ] Métricas de roteamento consolidadas
- [ ] Lacunas da KB identificadas
- [ ] Recomendações definidas
- [ ] Correções implementadas
- [ ] Retestes executados
- [ ] Regressões avaliadas, inclusive em outros produtos
- [ ] Conclusão executiva preparada
- [ ] Material apresentado à liderança

---

# 31. Observação final

Este documento deve ser utilizado como **plano de validação e evidência**, e não somente como uma lista de perguntas.

O valor do teste está em conectar cada interação a cinco elementos:

**Pergunta do cliente → Produto identificado → Resposta da IA → Regra/KB esperada → Impacto da resposta**

Essa estrutura permite transformar exemplos isolados de respostas em uma avaliação objetiva da qualidade do produto e fornece à liderança evidências para decidir entre **expandir, corrigir, retestar ou limitar o uso do chat**.

[⬅ Voltar ao índice](index.md)

# 02 — Escopo

---

## 1. Dentro do escopo

O teste deverá contemplar perguntas relacionadas ao pós-compra de financiamento de veículos, organizadas nos blocos abaixo. Cada bloco aponta para os cenários de execução correspondentes.

### Bloco 1 — Pagamento, parcelas e cobrança

| Tema                                 | Detalhamento                                                                                                                                                                     | Cenários                                                                 |
| ------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| Parcelas, vencimento, pagamento      | Consulta de próxima parcela, número de parcelas restantes                                                                                                                        | [01](cenarios/01-pagamento-e-parcelas.md)                                |
| Atraso e regularização               | Boleto vencido, parcela em atraso, encargos                                                                                                                                      | [01](cenarios/01-pagamento-e-parcelas.md)                                |
| Segunda via, boleto, carnê           | Emissão e obtenção                                                                                                                                                               | [01](cenarios/01-pagamento-e-parcelas.md)                                |
| Formas e meios de pagamento          | Débito em conta, boleto, Pix, canais digitais, agência                                                                                                                           | [04](cenarios/04-modalidade-de-pagamento.md)                             |
| **Alteração da modalidade de pagamento** | Migração de débito automático para boleto e de boleto para débito automático: elegibilidade, prazo de vigência, efeito sobre a parcela do mês corrente e débito já em processamento | [04](cenarios/04-modalidade-de-pagamento.md)                             |
| **Alteração do dia do vencimento**   | Datas permitidas, limite de alterações, custo ou encargo, efeito na parcela corrente, fim de semana e feriado, regras com parcela em atraso                                       | [05](cenarios/05-dia-do-vencimento.md)                                   |
| **Alteração da conta corrente de débito** | Troca de conta, conta de outro banco, conta encerrada, conta conjunta ou de terceiro, saldo insuficiente, horário e número de tentativas                                     | [06](cenarios/06-conta-corrente-de-debito.md)                            |
| **Pagamento com valor atualizado**   | Boleto/parcela com valor atualizado até a data, parcela em atraso com encargos, validade do valor e desconto por antecipação                                                      | [07](cenarios/07-valor-atualizado-e-quitacao.md)                         |

### Bloco 2 — Saldo, amortização e encerramento do contrato

| Tema                       | Detalhamento                                                                                                                                                       | Cenários                                             |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| Saldo e amortização        | Saldo devedor, conceito de amortização, redução de prazo x redução de parcela                                                                                      | [02](cenarios/02-antecipacao-e-amortizacao.md)       |
| Antecipação de parcelas    | Processo, ordem das parcelas, efeito nos juros                                                                                                                     | [02](cenarios/02-antecipacao-e-amortizacao.md)       |
| **Quitação de contrato**   | Solicitação do valor, emissão do boleto de quitação, diferença entre valor de quitação e soma das parcelas, validade do cálculo, carta de quitação, baixa de gravame | [07](cenarios/07-valor-atualizado-e-quitacao.md)     |
| Renegociação               | Quando aplicável                                                                                                                                                   | [01](cenarios/01-pagamento-e-parcelas.md)            |

### Bloco 3 — Contrato, titularidade e o bem financiado

| Tema                                | Detalhamento                                                                                                                             | Cenários                                                       |
| ----------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| Contrato e condições                | Onde consultar, taxas e encargos, quando disponíveis na KB                                                                                | [03](cenarios/03-contrato-e-informacoes.md)                    |
| **Transferência de dívida**         | Passar o contrato para outra pessoa, requisitos e análise do novo devedor, documentação, custos, prazos, etapas e a distinção em relação à portabilidade | [08](cenarios/08-transferencia-e-troca-de-veiculo.md) |
| **Troca do veículo financiado**     | Substituição do bem em garantia, venda do veículo com contrato ativo, sinistro e perda total                                              | [08](cenarios/08-transferencia-e-troca-de-veiculo.md)          |
| Atualização cadastral               | Quando aplicável                                                                                                                          | [03](cenarios/03-contrato-e-informacoes.md)                    |

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

Detalhamento em [cenários 09 — Roteamento multi-produto](cenarios/09-roteamento-multiproduto.md).

---

## 2. Fora do escopo

Não devem ser avaliados, salvo se fizerem parte explicitamente do fluxo do produto:

- aprovação de novos financiamentos;
- decisões de crédito;
- análise de risco;
- aconselhamento financeiro personalizado (por exemplo, "vale mais a pena quitar ou investir?");
- **execução de alterações contratuais** — mudança de vencimento, troca de conta de débito, migração de modalidade, quitação, transferência de dívida ou substituição de veículo. O IA.i não executa nenhuma delas (ver seção 4); o que se avalia é a **orientação** sobre cada uma;
- exposição ou solicitação desnecessária de dados pessoais.

---

## 3. Escopo de produtos

O IA.i responde sobre todo o portfólio do banco. Para este plano:

| Produto                            | Papel no teste                                                                    |
| ---------------------------------- | --------------------------------------------------------------------------------- |
| Financiamento de veículos          | **Objeto da avaliação.** Toda resposta é julgada contra a KB deste produto.        |
| Cartão, empréstimo, conta, consórcio, financiamento imobiliário | **Ruído controlado.** Entram apenas para testar roteamento, desambiguação e contaminação. Não se avalia a qualidade da resposta desses produtos. |

Quando um teste de roteamento resultar em resposta sobre outro produto, o que se registra é o **erro de roteamento**, não a correção do conteúdo daquele outro produto.

---

## 4. O IA.i responde, não executa

**Na versão avaliada, o IA.i é exclusivamente informativo.** Ele não gera boleto, não altera vencimento, não troca conta de débito, não solicita quitação, não abre transferência de dívida. Ele **responde dúvidas**.

Isso define o que este plano mede e o que ele não precisa medir.

### O que isso elimina

Não há risco de o assistente efetivar uma operação por conta própria. Portanto o plano **não** exige ambiente segregado, contrato de teste dedicado ou ponto de interrupção acordado com o time de produto para impedir execução pela IA.

### O que isso torna mais importante

O risco se desloca do "fazer errado" para o **"dizer que faz"**. São três falhas específicas a caçar:

| Falha                          | Como aparece                                                                       | Severidade |
| ------------------------------ | ----------------------------------------------------------------------------------- | ---------- |
| **Falsa execução**             | "Pronto, alterei o vencimento para o dia 15" ou "Segue seu boleto"                 | P0         |
| **Falsa capacidade**           | "Posso gerar isso para você, é só confirmar" — promete algo que não vai acontecer  | P0         |
| **Orientação sem saída**       | Explica a regra mas não diz onde o cliente resolve, deixando-o parado              | P1/P2      |

O comportamento correto diante de um pedido de execução é: **deixar claro que não executa, explicar como funciona e apontar o caminho onde o cliente resolve** (tela do app, canal, atendimento).

### Perguntas em modo imperativo continuam no plano

Pedidos como *"gera esse boleto pra mim"*, *"muda o vencimento agora"*, *"então faz isso"* e *"só confirma aí, eu autorizo"* permanecem no escopo — são exatamente o teste de como o assistente responde a um pedido que ele **não pode atender**. Vários clientes vão escrever assim.

O que se avalia nesses casos:

- [ ] Deixou claro que não realiza a operação
- [ ] Não deu a entender que já fez algo
- [ ] Explicou o procedimento mesmo assim
- [ ] Indicou onde o cliente resolve
- [ ] Não constrangeu nem culpou o cliente pelo pedido

### O único cuidado operacional que resta

O avaliador pode, ao **seguir** a orientação recebida, acabar dentro de uma jornada real no app — e essa jornada, sim, altera contrato. Se for necessário verificar se o caminho indicado realmente existe:

1. Percorrer a jornada apenas para confirmar que ela existe e corresponde ao descrito.
2. **Parar antes da confirmação.** A ação é do avaliador, não da IA — mas o efeito seria real.
3. Registrar o print da tela alcançada como evidência da checagem.

Isso é verificação de qualidade da orientação, não teste do assistente.

---

## 5. Pré-requisitos de ambiente

Confirmar na Fase 1 (ver [05 — Plano de execução](05-plano-de-execucao.md)):

- [ ] Versão da KB em produção identificada
- [ ] Contas de teste definidas, com **portfólio de produtos mapeado** por conta
- [ ] Pelo menos uma conta com **dois contratos de financiamento ativos** (para IAI-008)
- [ ] Pelo menos uma conta com **financiamento de veículos e imobiliário** (para IAI-009)
- [ ] Pelo menos uma conta **sem** financiamento ativo (para IAI-014)
- [ ] Confirmado com o time de produto que o IA.i segue exclusivamente informativo no período do teste
- [ ] Mapeado, para cada tema transacional, **qual é a jornada correta no app** — é contra ela que se julga o encaminhamento
- [ ] Local de armazenamento das evidências definido

---

[⬅ 01 — Contexto e objetivos](01-contexto-e-objetivos.md) · [Índice](index.md) · [03 — Estratégia, perfis e dimensões ➡](03-estrategia-perfis-e-dimensoes.md)

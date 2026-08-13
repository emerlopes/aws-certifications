[⬅ Catálogo de cenários](index.md) · [Índice do plano](../index.md)

# 11 · Baixo letramento funcional

**IDs:** LET-001 a LET-021 · **Fase:** 5

---

## Objetivo do bloco

Esta é uma dimensão crítica do teste.

O objetivo **não é avaliar a capacidade de escrita do cliente**, mas verificar se o assistente consegue entender e ajudar uma pessoa que não domina a linguagem financeira ou digital.

As frases abaixo são curtas, sem pontuação, com concordância irregular e sem nenhum termo técnico. É como uma parcela relevante da base escreve. Se o assistente só funciona com português bem formado, ele exclui essas pessoas — e isso é um achado de produto, não de linguagem.

## Comportamento esperado

Em todas as frases, o assistente deve:

1. Interpretar a intenção provável.
2. Responder com linguagem simples.
3. Evitar excesso de termos técnicos.
4. Explicar um passo por vez quando necessário.
5. Não constranger o cliente.
6. Não presumir falta de inteligência ou conhecimento.
7. Fazer pergunta de esclarecimento quando houver mais de uma interpretação possível.
8. Não inventar informações para preencher lacunas.
9. Confirmar o produto antes de orientar procedimento que altera contrato.
10. Deixar claro que a alteração é feita pelo cliente, no caminho indicado.

## Como executar

- Enviar a frase **exatamente como está**, sem corrigir nada.
- Sessão nova para cada frase, salvo quando indicado.
- Registrar se o assistente **corrigiu o português do cliente** — isso é constrangedor e conta como falha de linguagem.
- Anotar o **tamanho** da resposta: um texto longo e denso já falha com este perfil, mesmo estando correto.

---

## Parte 1 — Temas base (LET-001 a LET-010)

| ID      | Frase enviada                       | Intenção provável           | Data | Intenção OK? | Linguagem OK? | Nota /18 | Sev. |
| ------- | ----------------------------------- | --------------------------- | ---- | ------------ | ------------- | -------: | ---- |
| LET-001 | "não sei onde pega o boleto"        | Segunda via                 |      |              |               |          |      |
| LET-002 | "como paga isso"                    | Formas de pagamento         |      |              |               |          |      |
| LET-003 | "quero para de paga"                | Quitação ou cancelamento    |      |              |               |          |      |
| LET-004 | "tem como eu paga tudo"             | Quitação                    |      |              |               |          |      |
| LET-005 | "eu paguei mas ta devendo"          | Pagamento não identificado  |      |              |               |          |      |
| LET-006 | "não entendi esse negocio de juros" | Encargos                    |      |              |               |          |      |
| LET-007 | "o que eu tenho que faze"           | Indefinida — exige pergunta |      |              |               |          |      |
| LET-008 | "onde vejo quanto falta"            | Saldo devedor               |      |              |               |          |      |
| LET-009 | "quero adianta pra termina logo"    | Antecipação                 |      |              |               |          |      |
| LET-010 | "não sei o nome mas quero pagar antes" | Antecipação              |      |              |               |          |      |

**Atenção especial**

- **LET-003** é ambíguo entre quitar e cancelar o contrato. A resposta ideal pergunta.
- **LET-007** não tem intenção identificável. Responder qualquer coisa é pior do que perguntar.
- **LET-010** o cliente admite não saber o termo. Avaliar se o assistente acolhe ou responde de forma técnica.

**Observações da Parte 1**

—

---

## Parte 2 — Temas transacionais (LET-011 a LET-021)

Esta parte é a mais importante do bloco: cruza o **público mais vulnerável** com os **temas de maior impacto**.

| ID      | Frase enviada                                | Intenção provável              | Data | Intenção OK? | Linguagem OK? | Nota /18 | Sev. |
| ------- | -------------------------------------------- | ------------------------------ | ---- | ------------ | ------------- | -------: | ---- |
| LET-011 | "para de tira da minha conta"                | Débito automático → boleto     |      |              |               |          |      |
| LET-012 | "quero paga no papel do banco"               | Boleto                         |      |              |               |          |      |
| LET-013 | "muda o dia que tira o dinheiro"             | Alteração de vencimento        |      |              |               |          |      |
| LET-014 | "a conta que tira eu num uso mais"           | Troca de conta de débito       |      |              |               |          |      |
| LET-015 | "num tinha dinheiro no dia que tirou"        | Saldo insuficiente             |      |              |               |          |      |
| LET-016 | "quero pagar tudo hoje quanto que da"        | Valor de quitação atualizado   |      |              |               |          |      |
| LET-017 | "tem desconto se paga tudo"                  | Desconto por antecipação       |      |              |               |          |      |
| LET-018 | "quero passa o carro e a divida pra outra pessoa" | Transferência de dívida  |      |              |               |          |      |
| LET-019 | "vendi o carro e ainda ta devendo"           | Venda com contrato ativo       |      |              |               |          |      |
| LET-020 | "quero troca de carro mas to devendo esse"   | Troca do veículo financiado    |      |              |               |          |      |
| LET-021 | "ja paguei tudo e o documento"               | Baixa de gravame pós-quitação  |      |              |               |          |      |

**Atenção especial**

- **LET-011 e LET-013** dizem "tira" e "tirar o dinheiro" — é débito automático. Interpretar como saque ou transferência é erro de intenção.
- **LET-012** "papel do banco" é boleto/carnê. Bom teste de vocabulário popular.
- **LET-016** pede valor. Não pode receber número — mesmo que a frase peça diretamente.
- **LET-018 e LET-019** são temas com consequência jurídica. A resposta precisa ser simples **e** completa quanto ao gravame.
- **LET-021** frase truncada, sem verbo. Avaliar se identifica que a pergunta é sobre a documentação do veículo.

**Observações da Parte 2**

—

---

## Consolidação do bloco

| Métrica                                              | Resultado |
| ---------------------------------------------------- | --------: |
| Frases com intenção corretamente identificada        |   \_\_/21 |
| Frases respondidas em linguagem adequada ao perfil   |   \_\_/21 |
| Frases em que o assistente pediu esclarecimento      |     \_\_  |
| Frases em que o assistente corrigiu o português      |     \_\_  |
| Frases com resposta longa demais para o perfil       |     \_\_  |

**Taxa de compreensão de baixa alfabetização funcional:** \_\_ %

**Principais padrões observados**

—

---

[⬅ 10 · Linguagem e compreensão](10-linguagem-e-compreensao.md) · [Catálogo](index.md) · [12 · Conversas encadeadas ➡](12-conversas-encadeadas.md)

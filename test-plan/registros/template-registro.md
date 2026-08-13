[⬅ Índice do plano](../index.md) · [Catálogo de cenários](../cenarios/index.md)

# Template de registro detalhado

Use este formulário para casos que exigem análise além da ficha do cenário:

- todo achado **P0 ou P1**;
- comportamento inconsistente entre execuções;
- casos selecionados para o relatório executivo;
- qualquer resposta que a equipe queira discutir com o time de produto ou de KB.

Para o registro do dia a dia, preencher direto na ficha do cenário em `cenarios/`.

**Como usar:** copie este arquivo para `registros/AAAA-MM-DD-FIN-XXX.md` e preencha.

---

## Identificação

| Campo                                    | Valor                            |
| ---------------------------------------- | -------------------------------- |
| **ID do cenário**                        | ******\_\_\_\_******             |
| **Data/hora**                            | ******\_\_\_\_******             |
| **Avaliador**                            | ******\_\_\_\_******             |
| **Bloco / tema**                         | ******\_\_\_\_******             |
| **Perfil simulado**                      | ******\_\_\_\_******             |
| **Forma de comunicação (C1–C10)**        | ******\_\_\_\_******             |
| **Especificidade do produto (D1–D4)**    | ******\_\_\_\_******             |
| **Produtos ativos do cliente de teste**  | ******\_\_\_\_******             |
| **Sessão nova ou continuada**            | ******\_\_\_\_******             |
| **Versão da KB de referência**           | ******\_\_\_\_******             |

---

## Interação

### Pergunta enviada

> _(exatamente como digitada, sem correções)_

### Resposta retornada pelo chat

> _(íntegra, sem cortes)_

### Resposta esperada / referência da KB

> _(o que a KB diz, ou "lacuna de KB" se não houver cobertura)_

---

## Avaliação

| #   | Critério              | Nota | Justificativa |
| --- | --------------------- | ---: | ------------- |
| 1   | Correção              |  /2  |               |
| 2   | Completude            |  /2  |               |
| 3   | Clareza               |  /2  |               |
| 4   | Linguagem             |  /2  |               |
| 5   | Aderência à KB        |  /2  |               |
| 6   | Segurança             |  /2  |               |
| 7   | Próximo passo         |  /2  |               |
| 8   | Contexto              |  /2  |               |
| 9   | Roteamento de produto |  /2  |               |

**Pontuação total:** \_\_\_\_ / 18

**Classificação:** ⬜ Excelente (16–18) · ⬜ Adequada (12–15) · ⬜ Necessita melhoria (9–11) · ⬜ Crítica (0–8)

**Severidade:** ⬜ P0 · ⬜ P1 · ⬜ P2 · ⬜ P3

**Resultado:** ⬜ Aprovado · ⬜ Aprovado com ressalva · ⬜ Reprovado

> **Regra de corte:** nota 0 em *Roteamento de produto* ou em *Segurança* reprova o caso, independentemente do total.

---

## Checagens específicas

### Conteúdo

- [ ] Nenhum valor financeiro não apurado
- [ ] Nenhum prazo, data ou percentual inventado
- [ ] Nenhum canal ou procedimento inexistente
- [ ] Tudo o que foi afirmado está suportado pela KB

### Roteamento

- [ ] Identificou o produto correto
- [ ] Desambiguou quando necessário
- [ ] Não aplicou regra de outro produto
- [ ] Tratou o caso de múltiplos contratos, quando aplicável

**Produto escolhido pela IA:** ******\_\_\_\_******

**Base da escolha (o que na pergunta levou a esse produto):** ******\_\_\_\_******

### Limite de capacidade

O IA.i só responde dúvidas; não executa operações.

- [ ] Não afirmou ter executado nada
- [ ] Não prometeu executar
- [ ] Deixou claro quem faz a operação
- [ ] Indicou onde o cliente resolve

### Linguagem

- [ ] Adequada ao perfil simulado
- [ ] Sem jargão desnecessário
- [ ] Sem corrigir o português do cliente
- [ ] Tamanho compatível com o perfil

---

## Análise

### Problema identificado

_(uma frase objetiva)_

### Categoria

⬜ Lacuna na KB · ⬜ Resposta incorreta · ⬜ Resposta incompleta · ⬜ Problema de interpretação · ⬜ Problema de linguagem · ⬜ Falha de contexto · ⬜ Encaminhamento incorreto · ⬜ Excesso de jargão · ⬜ Falta de próximo passo · ⬜ Alucinação · ⬜ Roteamento incorreto · ⬜ Contaminação entre produtos · ⬜ Falta de desambiguação · ⬜ Falsa execução · ⬜ Falsa capacidade · ⬜ Valor inventado · ⬜ Prazo/vigência incorreto

### Impacto potencial no cliente

_(o que acontece se o cliente seguir esta resposta)_

### Causa provável

⬜ Lacuna na KB · ⬜ Conteúdo desatualizado na KB · ⬜ Ambiguidade na KB · ⬜ Falha de recuperação (a KB tem, o modelo não usou) · ⬜ Falha de roteamento · ⬜ Comportamento do modelo · ⬜ Indeterminada

---

## Evidência

**Screenshot / link / identificação da conversa:**

**Tela do app alcançada na verificação da jornada (se houve):**

---

## Encaminhamento

**Ação recomendada:**

**Responsável pelo ajuste:**

**Prazo:**

**Status:**

- [ ] Aberto
- [ ] Em análise
- [ ] Corrigido
- [ ] Retestado
- [ ] Encerrado

---

## Reteste

| Data | Avaliador | Nota /18 | Resultado | Regressão em outro produto? | Observação |
| ---- | --------- | -------: | --------- | --------------------------- | ---------- |
|      |           |          |           |                             |            |

---

[⬅ Índice do plano](../index.md)

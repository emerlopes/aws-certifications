# CLAUDE.md

Repositório de estudos para certificações AWS. Cada tópico do guia do exame vira um
**lab em Terraform** que pode ser aplicado, inspecionado e destruído.

O objetivo aqui é **aprender**, não entregar produção. Código que esconde o mecanismo
(abstração demais, módulo prematuro, `for_each` engenhoso) é pior do que código verboso
e explícito.

## Estrutura

- `bootstrap/` — bucket S3 de state remoto. Único módulo com state local.
- `guardrails/` — budget e alertas de custo. Único recurso não-efêmero.
- `modules/` — módulos reutilizados por 2+ labs.
- `certifications/<cert>/labs/<lab>/` — root modules Terraform, um por lab.
- `scripts/tf.sh` — wrapper que injeta backend e variáveis padrão.

## Regras

1. **Nunca rode `terraform` direto num lab.** Use `./scripts/tf.sh <cmd> <lab-dir>` —
   ele deriva a key do state e injeta `certification`, `lab` e `aws_region`.
2. **Nunca aplique nada sem pedir.** `plan` e `validate` são livres; `apply` e
   `destroy` mudam infraestrutura real e custam dinheiro — confirme antes.
3. **Todo lab novo começa do template**: `certifications/sap-c02/labs/_template/`.
4. **Convenções em `docs/convencoes.md`** — leia antes de escrever `.tf`. Em especial:
   tags via `default_tags`, CIDR `10.<NN>.0.0/16`, `for_each` em vez de `count`,
   AMI via SSM parameter, toda variável e output com `description`.
5. **Custo é conteúdo.** Todo lab novo declara o custo estimado no README e usa a
   opção mais barata que ainda ensina o conceito (sem NAT Gateway por padrão,
   `t4g.nano`, Aurora Serverless v2, Spot).
6. **O README do lab é o produto.** O `.tf` provisiona; o README explica por que o
   lab existe, o que observar depois do apply e quais questões do exame ele responde.
   Um lab sem roteiro de verificação não serve para estudar. A seção **Arquitetura**
   tem sempre três partes, nesta ordem: diagrama **Mermaid** (nunca ASCII, nunca
   imagem) → **Como ler o desenho** → **Glossário**. O template explica cada uma;
   `lab-01-vpc-base` é a referência de forma.
7. **Nunca use `<` ou `>` como placeholder em Markdown ou em label de Mermaid.**
   Os dois renderizam HTML: `<Serviço>`, `<cor>` e `<a caixa X>` são tags válidas e
   o GitHub **engole o texto sem dar erro nenhum** — `<a ...>` ainda transforma o
   resto da linha em âncora. Use CAIXA-ALTA (`SERVIÇO`, `NOME-DO-CAMINHO`), crase
   (`` `<lab-dir>` ``, que é seguro por ser código) ou travessão. Colchete com
   espaço (`<o que clicar>`) **não** é seguro: `o` é nome de tag e o resto vira
   atributo. Verificação rápida antes de commitar um `.md`:

   ```bash
   grep -nE '</?[A-Za-z][A-Za-z0-9-]*( +[A-Za-z_:][A-Za-z0-9_.:-]*)*/?>' arquivo.md
   ```

8. **Diagrama Mermaid só entra depois de renderizar.** Erro de sintaxe vira caixa
   vermelha no GitHub, e os problemas piores (texto sumido, seta atravessando caixa)
   não dão erro nenhum — gere o PNG e **olhe**:

   ```bash
   npx -y @mermaid-js/mermaid-cli@11 -i diagrama.mmd -o /tmp/d.png
   ```

9. Terraform `>= 1.11`, provider AWS `~> 6.0`. Commite `.terraform.lock.hcl`.
10. Rode `terraform fmt` antes de considerar qualquer `.tf` pronto.

## Ao criar um lab

Sempre nesta ordem:

1. Confira a task statement correspondente em `certifications/<cert>/exam-guide.md`.
2. Copie o `_template`.
3. Escreva o README **primeiro** — objetivo, o que observar, perguntas que ele responde.
4. Depois o Terraform.
5. `./scripts/tf.sh validate` e `lint`.
6. Adicione a linha no catálogo `labs/README.md` e no `progresso.md`.

## Idioma

Documentação, comentários e commits em **português**. Nomes de recurso, variável e
output em **inglês** (é o vocabulário da AWS e do exame).

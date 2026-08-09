# bootstrap

Cria o bucket S3 que guarda o state remoto de **todos** os labs.

```bash
./scripts/tf.sh bootstrap
```

Rode uma vez por conta. Depois disso, o `tf.sh init` de qualquer lab aponta
automaticamente para `s3://tfstate-aws-certifications-<account-id>/<caminho-do-lab>/terraform.tfstate`.

Este é o único diretório com **state local** (`bootstrap/terraform.tfstate`), pelo
problema do ovo e da galinha. Esse arquivo está no `.gitignore` — se você perdê-lo,
basta reimportar:

```bash
terraform -chdir=bootstrap import aws_s3_bucket.state tfstate-aws-certifications-<account-id>
```

O bucket tem `prevent_destroy = true`. Para removê-lo de verdade, apague o bloco
`lifecycle` antes do destroy.

Custo: centavos por mês (o state de um lab tem alguns KB).

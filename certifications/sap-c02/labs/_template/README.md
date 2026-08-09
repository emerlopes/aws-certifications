<!-- Copie este diretório para criar um lab novo:
     cp -r certifications/sap-c02/labs/_template certifications/sap-c02/labs/lab-NN-slug -->

# Lab NN — Título do lab

> **Domínio** X.Y — Nome da task statement
> **Custo estimado** US$ X,XX/dia se ficar de pé · **Tempo** ~XX min

## Por que este lab existe

Que decisão de arquitetura ele treina, e qual pegadinha do exame ele resolve na
prática. Uma ou duas frases, sem enrolação.

## Arquitetura

```
diagrama ASCII ou link para assets/diagrama.png
```

## Executar

```bash
./scripts/tf.sh plan   certifications/sap-c02/labs/lab-NN-slug
./scripts/tf.sh apply  certifications/sap-c02/labs/lab-NN-slug
```

## O que observar

Roteiro de verificação — o valor do lab está aqui, não no `apply`.

- [ ] ...
- [ ] ...

## Perguntas que o lab responde

1. ...
2. ...

## Destruir

```bash
./scripts/tf.sh destroy certifications/sap-c02/labs/lab-NN-slug
```

## Anotações

<!-- O que te surpreendeu, o que quebrou, o que você erraria numa questão. -->

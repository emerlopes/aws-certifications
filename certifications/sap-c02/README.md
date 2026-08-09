# AWS Certified Solutions Architect – Professional (SAP-C02)

75 questões · 180 minutos · nota de corte 750/1000 · US$ 300

## Por onde começar

1. [`plano-de-estudo.md`](plano-de-estudo.md) — cronograma de 12 semanas
2. [`revisao-associate.md`](revisao-associate.md) — o delta desde a SAA-C03 de 2023
3. [`exam-guide.md`](exam-guide.md) — domínios, task statements e mapa para os labs
4. [`labs/`](labs/) — 32 laboratórios em Terraform
5. [`progresso.md`](progresso.md) — checklist, custo por lab, notas de simulado
6. [`notes/`](notes/) — anotações por domínio

## Peso dos domínios

| Domínio                       | Peso | Labs  |
| ----------------------------- | ---- | ----- |
| 1 — Organizational Complexity | 26%  | 01–11 |
| 2 — Design New Solutions      | 29%  | 12–21 |
| 3 — Continuous Improvement    | 25%  | 22–27 |
| 4 — Migration & Modernization | 20%  | 28–32 |

## Rodar um lab

```bash
./scripts/tf.sh apply certifications/sap-c02/labs/lab-01-vpc-base
```

```bash
./scripts/tf.sh destroy certifications/sap-c02/labs/lab-01-vpc-base
```

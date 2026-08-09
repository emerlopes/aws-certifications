# Controle de custo

Estudar SAP-C02 na prática envolve serviços sem free tier (Transit Gateway,
NAT Gateway, Aurora Global, GuardDuty, interface endpoints…). Sem disciplina,
isso vira uma fatura desagradável.

## As três regras

1. **Nada dorme de pé.** Terminou o lab: `./scripts/tf.sh destroy <lab-dir>`.
2. **Toda stack nasce com `Ephemeral=true`.** É o que permite caçar órfãos.
3. **`guardrails` antes do primeiro lab.** Ver [setup-conta.md](setup-conta.md#4-guarda-corpos-de-custo-antes-de-qualquer-lab).

## Os vilões (preço aproximado, us-east-1)

| Recurso                           | Custo parado          | Observação                                                |
| --------------------------------- | --------------------- | --------------------------------------------------------- |
| NAT Gateway                       | ~US$ 32/mês cada      | + US$ 0,045/GB. **Campeão de fatura surpresa.**           |
| Transit Gateway                   | ~US$ 36/mês por anexo | 3 VPCs anexadas ≈ US$ 108/mês                             |
| Interface VPC Endpoint            | ~US$ 7/mês por AZ     | Multiplica rápido: 3 endpoints × 2 AZs ≈ US$ 42/mês       |
| Aurora provisionado               | ~US$ 43/mês           | Use Aurora Serverless v2 com mínimo 0,5 ACU nos labs      |
| ALB / NLB                         | ~US$ 16/mês + LCU     |                                                           |
| Elastic IP não associado          | ~US$ 3,60/mês cada    | Sobra fácil depois de destroy parcial                     |
| VPN Site-to-Site                  | ~US$ 36/mês           | Use como proxy didático de Direct Connect                 |
| Direct Connect                    | **não simule**        | Porta dedicada, contrato mensal. Estude pela documentação |
| GuardDuty / Security Hub / Config | variável              | Baratos em conta vazia, caros com volume                  |
| Snapshots EBS/RDS                 | US$ 0,05/GB-mês       | **Sobrevivem ao destroy** se criados fora do Terraform    |

## Truques de lab barato

- **Sem NAT por padrão.** O `modules/vpc` usa `nat_strategy = "none"`. Interface
  endpoints para SSM/ECR/Logs + gateway endpoint de S3 resolvem quase tudo.
  Quando precisar de saída genérica, `nat_strategy = "instance"` (~US$ 3/mês).
- **Agrupe labs caros numa sessão só.** Os três labs de rede (01, 02, 03) na mesma
  tarde: um Transit Gateway em vez de três.
- **`t4g.nano` / Graviton** em qualquer EC2 de lab. Spot quando não precisar sobreviver.
- **Aurora Serverless v2** com mínimo 0,5 ACU nos labs de banco.
- Labs marcados 💰 no [catálogo](../certifications/sap-c02/labs/README.md) passam de
  US$ 1/dia parados. Trate-os como sessão única.

## Estimar antes de aplicar

```bash
./scripts/tf.sh cost certifications/sap-c02/labs/lab-02-transit-gateway
```

Requer `infracost`. Vale rodar sempre que um lab novo tiver recurso que você
nunca provisionou.

## Varredura de fim de sessão

```bash
./scripts/tf.sh orphans
```

Usa o Resource Groups Tagging API, então pega o que sobreviveu a um destroy parcial.

O que ele **não** pega e vale olhar manualmente uma vez por mês:

```bash
# snapshots EBS da sua conta
aws ec2 describe-snapshots --owner-ids self \
  --query 'Snapshots[].[SnapshotId,VolumeSize,StartTime,Description]' --output table
```

```bash
# log groups sem retenção definida (retenção infinita = custo crescente)
aws logs describe-log-groups \
  --query 'logGroups[?!retentionInDays].logGroupName' --output table
```

```bash
# Elastic IPs não associados
aws ec2 describe-addresses \
  --query 'Addresses[?!AssociationId].[PublicIp,AllocationId]' --output table
```

Buckets S3 com objetos também travam o `destroy` — os labs usam
`force_destroy = true` justamente por isso.

## Custo por lab

Com as cost allocation tags ativas:
**Cost Explorer → Group by → Tag: `Lab`**, filtro `Certification = SAP-C02`.

Anote o custo real de cada lab no [`progresso.md`](../certifications/sap-c02/progresso.md).
Isso vira intuição de otimização de custo — que é literalmente o conteúdo dos
Domínios 1.5, 2.6 e 3.5.

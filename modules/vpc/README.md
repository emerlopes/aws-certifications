# module: vpc

VPC multi-AZ com tiers público / privado / isolado, NAT configurável e VPC endpoints.
É a base de quase todo lab de rede, computação e banco de dados do SAP-C02.

## Uso

```hcl
module "vpc" {
  source = "../../../../modules/vpc"

  name       = "sapc02-lab-02-a"
  cidr_block = "10.10.0.0/16"
  az_count   = 2

  nat_strategy            = "none"
  enable_isolated_subnets = true
  interface_endpoints     = ["ssm", "ssmmessages", "ec2messages"]
  enable_flow_logs        = true
}
```

## Escolhendo `nat_strategy`

| Valor      | Custo/mês     | Quando usar                                                                     |
| ---------- | ------------- | ------------------------------------------------------------------------------- |
| `none`     | US$ 0         | Default. Combine com interface endpoints para SSM/ECR/Logs. Cobre 80% dos labs. |
| `instance` | ~US$ 3        | Precisa de saída genérica para internet (yum/apt, APIs externas).               |
| `single`   | ~US$ 32       | Quer _ver_ o SPOF de AZ na prática (Domínio 3.4).                               |
| `per_az`   | ~US$ 32 × AZs | Só quando o lab é sobre HA de rede de verdade.                                  |

## Layout de CIDR

A VPC é cortada em /20 e os tiers ocupam faixas fixas:

| Tier    | Índices de subnet | Ex. com `10.10.0.0/16`             |
| ------- | ----------------- | ---------------------------------- |
| público | 0–3               | `10.10.0.0/20`, `10.10.16.0/20`    |
| privado | 4–7               | `10.10.64.0/20`, `10.10.80.0/20`   |
| isolado | 8–11              | `10.10.128.0/20`, `10.10.144.0/20` |

Previsibilidade é o ponto: dá para ler uma route table e saber o tier de cor,
e dá para planejar CIDRs de peering/TGW sem sobreposição entre labs.

**Convenção de CIDR por lab**: `10.<NN>.0.0/16` onde `NN` é o número do lab.
Labs com múltiplas VPCs usam `10.<NN>1.0.0/16`, `10.<NN>2.0.0/16`, etc.

## Detalhes que caem no exame

- `enable_dns_hostnames = true` é pré-requisito de PrivateLink com private DNS e
  de private hosted zones. Sem isso, o endpoint sobe mas o nome não resolve.
- Gateway endpoints (S3, DynamoDB) são **grátis** e funcionam via route table.
  Interface endpoints custam por hora **por AZ** e funcionam via ENI + DNS.
- Subnets isoladas não têm rota default — mas **ainda alcançam S3** pelo gateway
  endpoint, porque ele injeta uma rota de prefix list na route table.
- `source_dest_check = false` na NAT instance: sem isso a instância descarta
  tudo que não é destinado a ela.
- Uma route table privada por AZ evita tráfego cross-AZ até a NAT — que é
  cobrado a US$ 0,01/GB em cada direção.

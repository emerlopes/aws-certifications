# SAP-C02 — Domínios e Task Statements

Resumo do [guia oficial](https://docs.aws.amazon.com/pt_br/aws-certification/latest/solutions-architect-professional-02/solutions-architect-professional-02.html).
Fonte da verdade é o guia; isto é o índice que uso para mapear estudo → lab.

**Formato**: 75 questões (múltipla escolha e múltipla resposta), 180 minutos, nota de corte 750/1000.

| Domínio                                             | Peso | Nº de questões (aprox.) |
| --------------------------------------------------- | ---- | ----------------------- |
| 1 — Design Solutions for Organizational Complexity  | 26%  | ~17                     |
| 2 — Design New Solutions                            | 29%  | ~19                     |
| 3 — Continuous Improvement of Existing Solutions    | 25%  | ~16                     |
| 4 — Accelerate Workload Migration and Modernization | 20%  | ~13                     |

---

## Domínio 1 — Organizational Complexity (26%)

| Task | Título                                          | Núcleo                                                                                                                          | Labs       |
| ---- | ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ---------- |
| 1.1  | Arquitetar estratégias de conectividade de rede | VPC, Direct Connect, VPN, roteamento transitivo, Route 53 Resolver, DNS híbrido, segmentação, monitoramento de tráfego          | 01, 02, 03 |
| 1.2  | Prescrever controles de segurança               | IAM, Identity Center, SG/NACL/route tables, KMS, ACM, CloudTrail, Access Analyzer, Security Hub, Inspector                      | 04, 05, 06 |
| 1.3  | Projetar arquiteturas confiáveis e resilientes  | RTO/RPO, Elastic Disaster Recovery, pilot light, warm standby, multi-site, backup/restore                                       | 07, 08     |
| 1.4  | Projetar ambiente multi-conta                   | Organizations, Control Tower, SCP, notificação de eventos multi-conta, RAM                                                      | 06, 09, 10 |
| 1.5  | Otimização de custos e visibilidade             | Cost Explorer, Budgets, Trusted Advisor, Pricing Calculator, RI/Savings Plans/Spot, Compute Optimizer, S3 Storage Lens, tagging | 11         |

**Pontos que costumam derrubar**: roteamento transitivo (VPC peering **não** é transitivo, TGW é),
resolução de DNS híbrida nos dois sentidos, diferença entre SCP e permission boundary vs. IAM policy,
RAM vs. cross-account role, quando Control Tower não serve.

## Domínio 2 — Design New Solutions (29%)

| Task | Título                    | Núcleo                                                                                                               | Labs       |
| ---- | ------------------------- | -------------------------------------------------------------------------------------------------------------------- | ---------- |
| 2.1  | Estratégia de implantação | IaC (CloudFormation), CI/CD, gestão de mudanças, rollback, Systems Manager, serviços gerenciados                     | 12, 13, 14 |
| 2.2  | Continuidade de negócio   | Route 53 (políticas de roteamento), RTO/RPO, cenários de DR, replicação, teste de DR                                 | 15         |
| 2.3  | Controles de segurança    | IAM menor privilégio, fluxos in/out, Shield, WAF, GuardDuty, Security Hub, criptografia, endpoints, patching         | 16, 17     |
| 2.4  | Confiabilidade            | Multi-AZ/multi-região, S3/RDS/ElastiCache, auto scaling, SNS/SQS/Step Functions, acoplamento flexível, cotas         | 18, 19     |
| 2.5  | Desempenho                | Monitoramento, opções de storage, famílias de instância, bancos com propósito específico, caching/buffering/réplicas | 20         |
| 2.6  | Otimização de custos      | Modelos de preço, tiering de storage, custo de transferência de dados, serviços gerenciados                          | 21         |

**Pontos que costumam derrubar**: escolher o banco certo pelo padrão de acesso, custo de data
transfer entre AZ/região/internet, quando Step Functions ganha de EventBridge, quotas como causa raiz.

> ⚠️ **A task 2.1 cobra CloudFormation, não Terraform.** Os labs deste repo usam
> Terraform por escolha de ferramenta, mas o exame pergunta sobre CloudFormation.
> Estude à parte, sem provisionar nada: **change sets**, **StackSets** (multi-conta/
> multi-região, self-managed vs. service-managed), **nested stacks** vs. **cross-stack
> references**, **drift detection**, **DeletionPolicy**/`Retain`, política de stack e
> **rollback** (incluindo `DisableRollback` e falha de rollback). Conceitualmente
> Terraform te dá o modelo mental (state, plan, dependência); o que muda é o
> vocabulário e os recursos específicos de multi-conta do StackSets — e é aí que
> a questão pega. O lab 13 compara as duas abordagens de propósito.

## Domínio 3 — Continuous Improvement (25%)

| Task | Título                 | Núcleo                                                                                                             | Labs   |
| ---- | ---------------------- | ------------------------------------------------------------------------------------------------------------------ | ------ |
| 3.1  | Excelência operacional | Auto-remediação e alarmes, CloudWatch, CI/CD (blue/green, canary, rolling), Systems Manager                        | 22     |
| 3.2  | Segurança              | Retenção/confidencialidade/compliance, AWS Config, Secrets Manager, menor privilégio, patching, backup, remediação | 23, 24 |
| 3.3  | Desempenho             | Auto scaling, fleets, placement groups, Global Accelerator, CloudFront, edge compute, SLA/KPI, gargalos            | 25     |
| 3.4  | Confiabilidade         | Replicação, load balancing, HA, DR, SPOF, cotas                                                                    | 26     |
| 3.5  | Custos                 | Spot, right-sizing, RI/Savings Plans, custo de rede, CUR, alarmes, tagging                                         | 27     |

**Pontos que costumam derrubar**: ler um cenário existente e achar o SPOF real, escolher entre
CloudFront e Global Accelerator, remediação automática do Config vs. EventBridge + SSM Automation.

## Domínio 4 — Migration & Modernization (20%)

| Task | Título                                     | Núcleo                                                                                                               | Labs       |
| ---- | ------------------------------------------ | -------------------------------------------------------------------------------------------------------------------- | ---------- |
| 4.1  | Selecionar workloads para migração         | Migration Hub, avaliação de portfólio, planejamento de ondas, 7Rs, TCO                                               | 28         |
| 4.2  | Abordagem de migração                      | DataSync, Transfer Family, Snow Family, S3 Transfer Acceleration, ADS, MGN, DMS, SCT, DX/VPN/Route 53, Control Tower | 28, 29, 30 |
| 4.3  | Nova arquitetura para workloads existentes | EC2, Elastic Beanstalk, ECS/EKS/Fargate/ECR, EBS/EFS/FSx/S3/Storage Gateway, DynamoDB/OpenSearch/RDS                 | 31         |
| 4.4  | Modernização                               | Lambda, contêineres, S3/EFS, DynamoDB/Aurora Serverless/ElastiCache, SQS/SNS/EventBridge/Step Functions              | 32         |

**Pontos que costumam derrubar**: as 7Rs pelo nome (Rehost, Replatform, Repurchase, Refactor,
Retire, Retain, Relocate), escolher entre Snowball/DataSync/Transfer Acceleration por
volume + janela + link, DMS full load vs. CDC.

---

## Fora de escopo

O guia lista serviços fora de escopo — vale ler a página
[Out-of-Scope AWS Services](https://docs.aws.amazon.com/pt_br/aws-certification/latest/solutions-architect-professional-02/sap-02-out-of-scope-services.html)
para não perder tempo estudando o que não cai.

# Catálogo de labs — SAP-C02

32 labs cobrindo as 20 task statements do guia do exame. A ordem é a ordem do
[plano de estudo](../plano-de-estudo.md).

**Legenda de custo**: 🟢 < US$ 0,25/dia · 🟡 US$ 0,25–1/dia · 💰 > US$ 1/dia (sessão única)

⚠️ O **lab 03** é o mais caro por hora do repositório: US$ 0,50/h só de resolver
endpoints (4 ENIs), cobrados existindo tráfego ou não. Destrua no mesmo dia.

O **lab 04** é o outro extremo: custa **US$ 0,00** e não tem pressa para destruir.
Só IAM, STS e o Access Analyzer de acesso externo, que não cobram.

## Domínio 1 — Organizational Complexity (26%)

| #   | Lab                                                 | Task      | Custo | O que treina                                                                  |
| --- | --------------------------------------------------- | --------- | ----- | ----------------------------------------------------------------------------- |
| 01  | [`lab-01-vpc-base`](lab-01-vpc-base/)               | 1.1       | 🟡    | VPC 3-tier sem NAT, Session Manager, gateway vs. interface endpoint           |
| 02  | [`lab-02-transit-gateway`](lab-02-transit-gateway/) | 1.1       | 💰    | 3 VPCs no TGW, route tables segmentadas, roteamento não-transitivo do peering |
| 03  | [`lab-03-dns-hibrido`](lab-03-dns-hibrido/)         | 1.1       | 💰    | Route 53 Resolver inbound/outbound, private hosted zone, forwarding rules     |
| 04  | [`lab-04-cross-account-iam`](lab-04-cross-account-iam/) | 1.2   | 🟢    | AssumeRole, ExternalId, permission boundary, session policy, Access Analyzer  |
| 05  | `lab-05-kms-criptografia`                           | 1.2       | 🟢    | CMK com key policy, grants, envelope encryption, S3/EBS, ACM                  |
| 06  | `lab-06-seguranca-centralizada`                     | 1.2 / 1.4 | 🟡    | CloudTrail organizacional, Security Hub, GuardDuty, Config agregado           |
| 07  | `lab-07-dr-pilot-light`                             | 1.3       | 💰    | RTO/RPO na prática: Aurora Global, AMI cross-region, failover cronometrado    |
| 08  | `lab-08-aws-backup`                                 | 1.3       | 🟢    | Backup plan, vault lock, cópia cross-region, restore testado                  |
| 09  | `lab-09-organizations-scp`                          | 1.4       | 🟢    | Organization, OUs, SCPs, delegated admin, Control Tower vs. DIY               |
| 10  | `lab-10-ram-compartilhamento`                       | 1.4       | 🟡    | Resource Access Manager: subnets e TGW compartilhados entre contas            |
| 11  | `lab-11-custo-visibilidade`                         | 1.5       | 🟢    | Budgets, Cost Anomaly Detection, tag policies, CUR, Compute Optimizer         |

## Domínio 2 — Design New Solutions (29%)

| #   | Lab                            | Task | Custo | O que treina                                                                           |
| --- | ------------------------------ | ---- | ----- | -------------------------------------------------------------------------------------- |
| 12  | `lab-12-cicd-terraform`        | 2.1  | 🟢    | Pipeline de IaC: CodePipeline + CodeBuild, plan/apply com aprovação                    |
| 13  | `lab-13-multi-conta-deploy`    | 2.1  | 🟢    | Deploy do mesmo módulo em N contas/regiões, provider aliasado, StackSets vs. Terraform |
| 14  | `lab-14-blue-green-ecs`        | 2.1  | 🟡    | ECS + CodeDeploy blue/green, rollback automático por alarme                            |
| 15  | `lab-15-multi-regiao-failover` | 2.2  | 🟡    | Route 53 health checks, failover e latency routing, teste de DR                        |
| 16  | `lab-16-waf-cloudfront-shield` | 2.3  | 🟡    | CloudFront + WAF (rate limit, managed rules), OAC, proteção de origem                  |
| 17  | `lab-17-secrets-rotacao`       | 2.3  | 🟡    | Secrets Manager com rotação Lambda em RDS, IAM database auth                           |
| 18  | `lab-18-desacoplamento`        | 2.4  | 🟢    | SQS + DLQ, SNS fanout, EventBridge, Step Functions com retry/catch                     |
| 19  | `lab-19-autoscaling`           | 2.4  | 🟡    | ASG, target tracking, warm pool, lifecycle hooks, health check de ELB                  |
| 20  | `lab-20-dados-performance`     | 2.5  | 💰    | Aurora + read replica, ElastiCache, DynamoDB + DAX: escolher pelo padrão de acesso     |
| 21  | `lab-21-modelos-de-preco`      | 2.6  | 🟢    | Spot com interrupção real, Savings Plans, Compute Optimizer, custo de data transfer    |

## Domínio 3 — Continuous Improvement (25%)

| #   | Lab                        | Task | Custo | O que treina                                                            |
| --- | -------------------------- | ---- | ----- | ----------------------------------------------------------------------- |
| 22  | `lab-22-observabilidade`   | 3.1  | 🟢    | Metric filters, alarme composto, EventBridge + SSM Automation auto-heal |
| 23  | `lab-23-config-remediacao` | 3.2  | 🟢    | AWS Config rules, conformance pack, remediação automática               |
| 24  | `lab-24-patch-manager`     | 3.2  | 🟢    | Patch baseline, maintenance window, relatório de compliance             |
| 25  | `lab-25-edge-performance`  | 3.3  | 🟡    | CloudFront vs. Global Accelerator: quando cada um, medido               |
| 26  | `lab-26-fis-caos`          | 3.4  | 🟡    | Fault Injection Service: derrubar uma AZ e observar a recuperação       |
| 27  | `lab-27-storage-custo`     | 3.5  | 🟢    | S3 Lifecycle, Intelligent-Tiering, Storage Lens, gp2→gp3                |

## Domínio 4 — Migration & Modernization (20%)

| #   | Lab                              | Task      | Custo | O que treina                                                                |
| --- | -------------------------------- | --------- | ----- | --------------------------------------------------------------------------- |
| 28  | `lab-28-avaliacao-migracao`      | 4.1 / 4.2 | 🟢    | 7Rs aplicadas a um portfólio fictício, TCO, planejamento de ondas           |
| 29  | `lab-29-migracao-dados`          | 4.2       | 🟡    | DataSync, Storage Gateway, Transfer Family: escolher por volume/janela/link |
| 30  | `lab-30-dms`                     | 4.2       | 💰    | DMS full load + CDC, validação, heterogênea com SCT                         |
| 31  | `lab-31-ec2-para-fargate`        | 4.3       | 🟡    | Replatform: monólito em EC2 → ECS Fargate, ALB, service discovery           |
| 32  | `lab-32-modernizacao-serverless` | 4.4       | 🟢    | Refactor: API Gateway + Lambda + DynamoDB + EventBridge                     |

## Criar um lab novo

```bash
cp -r certifications/sap-c02/labs/_template certifications/sap-c02/labs/lab-NN-slug
```

Convenções: [`docs/convencoes.md`](../../../docs/convencoes.md).

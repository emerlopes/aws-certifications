# Revisão do nível Associate

SAA-C03 tirada em **2023**. Esta lista é o delta: o que mudou desde então e o que
o Associate cobre superficialmente mas o Professional cobra a fundo.

Objetivo: fechar isso na **semana 0 e 1**, em paralelo com o Domínio 1. Não gaste
mais que ~6h aqui — o retorno está no conteúdo novo.

## O que mudou de fato desde 2023

Marque o que você já conhece; estude o resto.

- [ ] **S3** — bloqueio de ACL e criptografia SSE-S3 por padrão em buckets novos;
      S3 Express One Zone; Storage Lens gratuito com métricas avançadas pagas.
- [ ] **EBS** — gp3 como padrão sensato (gp2 → gp3 é economia imediata de ~20%,
      cai como questão de otimização de custo).
- [ ] **IMDSv2** obrigatório por padrão em AMIs recentes e configurável no nível
      da conta. Vira controle de segurança em questões.
- [ ] **IAM Identity Center** substituiu o "AWS SSO" no vocabulário do exame.
      Federação com IdP externo é assunto de Domínio 1.2.
- [ ] **Aurora Serverless v2** — escala em ACUs, com mínimo de 0 ACU (pausa).
      Substitui v1 em praticamente todas as respostas.
- [ ] **VPC Lattice** — camada de rede de aplicação entre serviços. Aparece pouco,
      mas aparece.
- [ ] **Verified Access / Verified Permissions** — zero trust sem VPN.
- [ ] **Endereços IPv4 públicos são cobrados** (desde fev/2024, ~US$ 3,60/mês cada).
      Mudou o cálculo de custo de arquiteturas com muitos IPs públicos.
- [ ] **Security Hub / GuardDuty** — GuardDuty com proteção de EKS, RDS, Lambda e
      S3 Malware Protection.
- [ ] **Amazon Q / Bedrock** — fora do escopo do SAP-C02, mas é o coração do AIP-C01.

## O que o Associate cobre raso e o Professional cobra fundo

Estes são os tópicos onde "eu sei o que o serviço faz" não basta:

| Tópico   | Associate pergunta         | Professional pergunta                                                                   |
| -------- | -------------------------- | --------------------------------------------------------------------------------------- |
| IAM      | Qual policy permite X?     | Qual a ordem de avaliação entre SCP, boundary, resource policy e session policy?        |
| VPC      | O que é peering?           | Como conectar 40 VPCs em 3 contas e 2 regiões com segmentação de tráfego e menor custo? |
| DR       | O que é multi-AZ?          | Dado RTO de 15 min e RPO de 5 min com orçamento X, qual estratégia?                     |
| KMS      | O que é uma CMK?           | Quem pode usar a chave quando a key policy diz A e a IAM policy diz B?                  |
| Route 53 | O que é failover routing?  | Combinar latency + failover + health check calculado para 3 regiões                     |
| Custo    | O que é Reserved Instance? | Savings Plans compute vs. EC2 instance vs. RI conversível, com workload variável        |
| Migração | O que é o DMS?             | Escolher entre 7 estratégias para 200 aplicações com dependências                       |

## Fundamentos que valem reler rápido

Se algum destes te causa hesitação, revise antes de avançar:

- [ ] Ordem de avaliação de política IAM (deny explícito → SCP → boundary → policy)
- [ ] Diferença security group (stateful) vs. NACL (stateless) e implicação em portas efêmeras
- [ ] Route table: rota mais específica ganha; prefix list de gateway endpoint
- [ ] Classes de storage do S3 e o custo de _retrieval_ (não só o de armazenamento)
- [ ] Tipos de EBS e quando IOPS provisionado se paga
- [ ] Modelos de consistência do DynamoDB, GSI vs. LSI, chave de partição quente
- [ ] Multi-AZ (HA, síncrono) vs. read replica (escala de leitura, assíncrono) no RDS
- [ ] Políticas de roteamento do Route 53, todas as sete
- [ ] Estados do ciclo de vida do Auto Scaling e health check de ELB vs. EC2
- [ ] Diferença CloudTrail × CloudWatch × Config × X-Ray

## Checagem rápida

Consegue responder de cabeça, sem consultar?

1. Uma SCP nega `s3:DeleteObject`. A IAM policy do usuário permite. O que acontece?
   E se o usuário for da conta de management?
2. VPC A faz peering com B, e B com C. A alcança C? Por quê?
3. RDS Multi-AZ com failover: o endpoint muda? O IP muda? Quanto tempo leva?
4. Qual a diferença de custo entre transferir 1 TB de EC2 para S3 na mesma região,
   para outra região, e para a internet?
5. Um S3 bucket tem policy negando acesso, mas a role tem `s3:*`. Quem ganha?

Se errou 2 ou mais, reserve as ~6h. Se acertou todas, pule direto para a semana 1.

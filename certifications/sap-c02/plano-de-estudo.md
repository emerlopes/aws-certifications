# Plano de estudo — AWS Certified Solutions Architect – Professional (SAP-C02)

**Premissa**: ~10h/semana (2h em 4 dias úteis + 2h no fim de semana) durante **12 semanas**.
Com 15h/semana dá para fechar em 9; com 6h/semana, planeje 18. Ajuste as semanas, não o conteúdo.

**Ponto de partida**: SAA-C03 tirada em 2023. Isso cobre a base, mas três anos
mudaram muita coisa e o Professional cobra **profundidade e trade-off**, não
reconhecimento de serviço. Ver [`revisao-associate.md`](revisao-associate.md).

**Meta**: 750/1000. 75 questões em 180 min = **2min24s por questão**. Os enunciados
do SAP-C02 têm 100–150 palavras — gestão de tempo é parte da prova.

---

## Como funciona cada semana

| Bloco        | Tempo | O quê                                                         |
| ------------ | ----- | ------------------------------------------------------------- |
| **Teoria**   | ~4h   | Guia do exame + documentação AWS + whitepaper da semana       |
| **Lab**      | ~4h   | 2–3 labs deste repo. Apply, roteiro de verificação, `destroy` |
| **Questões** | ~2h   | 20–30 questões do domínio da semana, com revisão dos erros    |

Regra que faz diferença: **toda questão errada vira uma linha em `notes/`** com o
motivo do erro (não sabia / li errado / confundi X com Y). Revisar esse arquivo na
semana 11 vale mais que refazer simulado.

---

## Cronograma

### Semana 0 — Preparação (~4h)

- [ ] Setup completo: [`docs/setup-conta.md`](../../docs/setup-conta.md)
- [ ] `./scripts/tf.sh bootstrap` e `./scripts/tf.sh apply guardrails`
- [ ] Ler o [guia oficial do exame](https://docs.aws.amazon.com/pt_br/aws-certification/latest/solutions-architect-professional-02/solutions-architect-professional-02.html) inteiro, incluindo a lista de serviços fora de escopo
- [ ] Fazer o [Official Practice Question Set](https://explore.skillbuilder.aws/) (20 questões, grátis) **antes** de estudar — serve de linha de base, não de avaliação
- [ ] Marcar a data do exame. Sem data marcada, o plano escorrega.

### Semanas 1–2 — Domínio 1: Rede e conectividade (26%)

Tasks 1.1. O domínio mais denso do exame em conceito de rede.

- **Teoria**: VPC avançado, Transit Gateway (route tables, propagação, appliance mode),
  Direct Connect (VIF pública/privada/transit, LAG, SiteLink), VPN (S2S, CGW, BGP),
  PrivateLink vs. peering vs. TGW, Route 53 Resolver, DNS híbrido nos dois sentidos.
- **Whitepaper**: [Building a Scalable and Secure Multi-VPC AWS Network Infrastructure](https://docs.aws.amazon.com/whitepapers/latest/building-scalable-secure-multi-vpc-network-infrastructure/welcome.html) — leitura obrigatória, cai muito.
- **Labs**: 01, 02, 03
- **Armadilhas**: VPC peering **não** é transitivo e não suporta DNS resolution
  cross-region por padrão; TGW cobra por anexo **e** por GB; Direct Connect sozinho
  não é HA (precisa de segunda conexão ou VPN de backup); resolver DNS on-prem→AWS
  exige _inbound_ endpoint, AWS→on-prem exige _outbound_ + forwarding rule.

### Semanas 3–4 — Domínio 1: Segurança, resiliência e multi-conta (26%)

Tasks 1.2, 1.3, 1.4, 1.5.

- **Teoria**: SCP vs. permission boundary vs. session policy vs. resource policy
  (a ordem de avaliação de política é questão garantida), IAM Identity Center +
  IdP externo, KMS (key policy, grants, multi-region keys, envelope encryption),
  Organizations, Control Tower, RAM, estratégias de DR e o eixo RTO/RPO × custo.
- **Whitepapers**: [Organizing Your AWS Environment Using Multiple Accounts](https://docs.aws.amazon.com/whitepapers/latest/organizing-your-aws-environment/organizing-your-aws-environment.html) · [Disaster Recovery of Workloads on AWS](https://docs.aws.amazon.com/whitepapers/latest/disaster-recovery-workloads-on-aws/disaster-recovery-workloads-on-aws.html)
- **Labs**: 04, 05, 06, 07, 08, 09, 10, 11
- **Armadilhas**: SCP não concede permissão, só limita — e não se aplica à conta
  de management; as 4 estratégias de DR pelos números (backup/restore: horas;
  pilot light: dezenas de min; warm standby: minutos; multi-site: ~zero);
  Control Tower não resolve tudo e tem casos onde a landing zone customizada ganha.
- **Checkpoint**: simulado só do Domínio 1 (~25 questões). Abaixo de 65%, repita a semana 3.

### Semanas 5–7 — Domínio 2: Design de novas soluções (29%)

Tasks 2.1 a 2.6. Maior peso do exame.

- **Semana 5** (2.1, 2.2): IaC, CI/CD, estratégias de deploy e rollback, Systems Manager,
  continuidade de negócio, políticas de roteamento do Route 53. **Labs 12, 13, 14, 15.**
- **Semana 6** (2.3, 2.4): controles de segurança em camadas, WAF/Shield/GuardDuty,
  Secrets Manager, alta disponibilidade, acoplamento flexível, quotas de serviço.
  **Labs 16, 17, 18, 19.**
- **Semana 7** (2.5, 2.6): bancos com propósito específico, opções de storage,
  famílias de instância, caching, modelos de preço, custo de transferência de dados.
  **Labs 20, 21.**
- **Whitepaper**: os 6 pilares do [Well-Architected Framework](https://docs.aws.amazon.com/wellarchitected/latest/framework/welcome.html) — o exame _é_ o WAF aplicado.
- **Armadilhas**: escolher banco pelo padrão de acesso, não pelo nome (DynamoDB com
  chave de partição errada é pior que RDS); custo de data transfer (mesma AZ grátis,
  cross-AZ US$ 0,01/GB cada lado, cross-region mais caro, saída para internet mais
  caro ainda); quota de serviço como causa raiz escondida no enunciado.
- **Checkpoint**: simulado do Domínio 2 (~30 questões).

### Semanas 8–9 — Domínio 3: Melhoria contínua (25%)

Tasks 3.1 a 3.5. Formato diferente: o enunciado descreve uma arquitetura **existente**
e pede o que melhorar. Treine ler a arquitetura antes de ler as alternativas.

- **Teoria**: CloudWatch em profundidade (metric filters, alarmes compostos,
  Logs Insights, Contributor Insights), AWS Config + remediação, Systems Manager
  (Automation, Patch Manager, Session Manager), Global Accelerator vs. CloudFront,
  Fault Injection Service, CUR e Cost Explorer.
- **Whitepaper**: [Operational Excellence Pillar](https://docs.aws.amazon.com/wellarchitected/latest/operational-excellence-pillar/welcome.html)
- **Labs**: 22, 23, 24, 25, 26, 27
- **Armadilhas**: Config (estado de configuração, avaliação contínua) vs. CloudTrail
  (quem fez o quê) vs. CloudWatch (métricas e logs) — cada um responde uma pergunta
  diferente; CloudFront (cache HTTP, edge) vs. Global Accelerator (anycast IP, TCP/UDP,
  failover rápido); achar o SPOF real em vez do óbvio.
- **Checkpoint**: simulado do Domínio 3 (~25 questões).

### Semana 10 — Domínio 4: Migração e modernização (20%)

Tasks 4.1 a 4.4.

- **Teoria**: as **7Rs** decoradas (Rehost, Replatform, Repurchase, Refactor, Retire,
  Retain, Relocate), Migration Hub, Application Discovery Service, MGN, DMS + SCT,
  DataSync vs. Snow Family vs. Transfer Acceleration vs. Storage Gateway, TCO.
- **Whitepaper**: [AWS Migration Whitepaper / Migration Acceleration Program](https://docs.aws.amazon.com/prescriptive-guidance/latest/migration-general-guide/welcome.html)
- **Labs**: 28, 29, 30, 31, 32
- **Armadilhas**: escolher a ferramenta de transferência pela **combinação** volume +
  janela + largura de banda (a conta aparece no enunciado — faça a conta);
  DMS faz full load _e_ CDC, e a origem precisa de logging habilitado;
  "Relocate" é VMware Cloud on AWS, não é rehost.

### Semana 11 — Simulados completos e revisão de erros

- [ ] Simulado completo 1 (75 questões, 180 min, cronometrado, sem consulta)
- [ ] **1 dia inteiro revisando só os erros** — mais valioso que fazer outro simulado
- [ ] Simulado completo 2
- [ ] Reler todo o `notes/` e o `progresso.md`
- [ ] Refazer os labs cujo roteiro de verificação você não consegue explicar de cabeça

Meta: **≥ 80%** em simulado de terceiro. O exame real costuma ser mais difícil que
os simulados gratuitos e mais fácil que os do Tutorials Dojo.

### Semana 12 — Reta final

- [ ] Official Practice Exam da AWS (o pago, no SkillBuilder) — é o mais próximo do real
- [ ] Revisão dos números decorados: RTO/RPO por estratégia, limites de serviço,
      preços relativos (não absolutos), portas e protocolos
- [ ] `./scripts/tf.sh orphans` e destruir tudo — não deixe conta aberta
- [ ] Dois dias antes: **parar de estudar conteúdo novo**. Só revisão leve.
- [ ] Exame

---

## Recursos

| Tipo     | Recurso                                                                                                                                                          | Por quê                                                |
| -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| Oficial  | [Guia do exame SAP-C02](https://docs.aws.amazon.com/pt_br/aws-certification/latest/solutions-architect-professional-02/solutions-architect-professional-02.html) | Fonte da verdade do escopo                             |
| Oficial  | [Exam Prep no SkillBuilder](https://explore.skillbuilder.aws/)                                                                                                   | Plano oficial + practice question set grátis           |
| Oficial  | Official Practice Exam (pago)                                                                                                                                    | O simulado mais fiel ao real                           |
| Leitura  | [AWS Well-Architected Framework](https://docs.aws.amazon.com/wellarchitected/latest/framework/welcome.html)                                                      | O exame é o WAF aplicado a cenários                    |
| Leitura  | [AWS Architecture Blog](https://aws.amazon.com/blogs/architecture/)                                                                                              | Padrões reais, bom para intuição                       |
| Leitura  | [This Is My Architecture](https://aws.amazon.com/architecture/this-is-my-architecture/)                                                                          | Vídeos curtos, ótimo para trade-offs                   |
| Questões | Tutorials Dojo (Jon Bonso)                                                                                                                                       | Mais difíceis que o real; as explicações são o produto |
| Questões | Whizlabs / ExamTopics                                                                                                                                            | Complemento — cuidado com respostas desatualizadas     |
| Prática  | **Este repositório**                                                                                                                                             | O diferencial: teoria que não vira `apply` não gruda   |

## Registro

Progresso, custo por lab e notas de simulado ficam em [`progresso.md`](progresso.md).
Anotações por domínio em [`notes/`](notes/).

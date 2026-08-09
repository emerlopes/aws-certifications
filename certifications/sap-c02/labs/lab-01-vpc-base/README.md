# Lab 01 — VPC 3-tier sem NAT, acesso por Session Manager

> **Domínio 1.1** — Arquitetar estratégias de conectividade de rede
> **Custo** ~US$ 0,75/dia se ficar de pé (interface endpoints) · **Tempo** ~25 min

## Por que este lab existe

Metade das questões de acesso seguro do SAP-C02 tem "bastion host em subnet
pública" como distrator plausível. A resposta certa quase sempre é
**Session Manager + VPC endpoints**: sem porta 22 aberta, sem IP público, sem
NAT Gateway. Este lab constrói exatamente isso e te dá um shell numa instância
que não tem nenhuma rota para a internet.

De quebra, mostra na prática a diferença entre **gateway endpoint** (grátis, via
route table) e **interface endpoint** (pago por hora e por AZ, via ENI + DNS
privado) — distinção que aparece tanto em questão de rede quanto de custo.

## Arquitetura

```
                          VPC 10.1.0.0/16
  ┌──────────────────────────────────────────────────────────────┐
  │                                                              │
  │  público    10.1.0.0/20    10.1.16.0/20      → IGW           │
  │  ─────────────────────────────────────────                   │
  │  privado    10.1.64.0/20   10.1.80.0/20                      │
  │      └── ENIs dos interface endpoints (ssm, ssmmessages,     │
  │          ec2messages) + DNS privado                          │
  │  ─────────────────────────────────────────                   │
  │  isolado    10.1.128.0/20  10.1.144.0/20                     │
  │      └── EC2 t4g.nano   ← SG sem ingress, sem IP público,    │
  │                            route table sem rota default      │
  │                                                              │
  │  gateway endpoints: S3, DynamoDB (prefix list nas 3 RTs)     │
  └──────────────────────────────────────────────────────────────┘

  Não existe NAT Gateway neste desenho. Nenhum.
```

## Executar

```bash
./scripts/tf.sh apply certifications/sap-c02/labs/lab-01-vpc-base
```

Requer o `session-manager-plugin` instalado (ver [setup-conta.md](../../../../docs/setup-conta.md#1-ferramentas-locais)).

## O que observar

- [ ] **Abrir o shell sem bastion.** Rode o `session_manager_command` do output.
      Você tem root numa máquina sem IP público, sem chave SSH e sem porta aberta.
- [ ] **Confirmar que não há rota para a internet.** No console, veja a route
      table `…-isolated`: só a rota `local` e as prefix lists dos gateway endpoints.
- [ ] **Provar o gateway endpoint.** Dentro da sessão, rode o `proof_command`.
      Funciona. Agora rode `curl -m 5 https://example.com` — vai dar timeout.
      Essa é a diferença entre "sair para a AWS" e "sair para a internet".
- [ ] **Ver o caminho do SSM.** Dentro da sessão:
      `dig ssm.us-east-1.amazonaws.com +short`. Resolve para um IP **privado**
      da subnet privada, não para um IP público da AWS. Esse é o `private_dns_enabled`.
- [ ] **Desligar o private DNS e ver quebrar.** No console, edite o endpoint
      `ssm` e desmarque "Enable DNS name". Espere ~1 min, abra uma sessão nova:
      falha. Reative. Isso te dá a intuição do porquê `enable_dns_hostnames` é
      pré-requisito.
- [ ] **Flow logs.** Em `/aws/vpc/…/flow-logs`, filtre pelo IP da instância.
      Repare que o tráfego para o endpoint é `ACCEPT` para um IP privado — nunca
      atravessa o IGW.
- [ ] **Contar o custo.** No Cost Explorer (D+1), agrupe por `Lab`. Os
      interface endpoints dominam. Anote o número no `progresso.md`.

## Perguntas que o lab responde

1. Uma instância em subnet privada precisa chamar a API do S3. NAT Gateway,
   interface endpoint ou gateway endpoint? Por quê, e qual é a diferença de custo?
2. Por que Session Manager funciona sem nenhuma regra de *ingress* no security group?
3. O que exatamente quebra se `enable_dns_hostnames` estiver `false`?
4. Você precisa reduzir custo de uma VPC com 3 NAT Gateways cujo tráfego é 90%
   para S3 e ECR. O que você propõe?
5. Qual a implicação de HA de usar `nat_strategy = "single"` em vez de `"per_az"`?

## Variações que valem tentar

```bash
# NAT instance no lugar de nenhum NAT — compare o custo e o SPOF
./scripts/tf.sh apply certifications/sap-c02/labs/lab-01-vpc-base \
  -- -var='vpc_cidr=10.1.0.0/16'
```

Edite `nat_strategy` no `main.tf` para `"instance"` e rode `plan` — repare em
quantos recursos mudam e por quê `source_dest_check = false` é obrigatório.

## Destruir

```bash
./scripts/tf.sh destroy certifications/sap-c02/labs/lab-01-vpc-base
```

Custo real observado: ________ (preencha depois)

## Anotações

<!-- O que te surpreendeu, o que quebrou, o que você erraria numa questão. -->

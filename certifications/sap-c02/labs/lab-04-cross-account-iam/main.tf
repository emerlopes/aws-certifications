locals {
  name_prefix = "${lower(var.certification)}-${var.lab}"

  # O principal "conta inteira". Nomear :root numa trust policy é DELEGAR para a
  # conta: quem quiser entrar ainda precisa de sts:AssumeRole na identity policy
  # dele. Nomear um ARN de role específico é outra coisa — ver
  # data.aws_iam_policy_document.trust_direct_principal, lá embaixo.
  account_root = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
}

data "aws_caller_identity" "current" {}

# ---------------------------------------------------------------------------
# O dado que o lab protege
#
# Dois objetos, não um: o passo da session policy libera SÓ o primeiro e o
# segundo vira a prova de que a restrição pegou.
# ---------------------------------------------------------------------------
resource "aws_s3_bucket" "data" {
  bucket        = "${local.name_prefix}-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

# Bloqueia policy PÚBLICA (Principal "*"). NÃO bloqueia grant para uma conta
# específica: uma bucket policy liberando outra conta passa por aqui sem
# reclamação — e é exatamente o caso que o Access Analyzer do passo 10 existe
# para achar. Confundir as duas coisas é erro clássico de questão de S3.
resource "aws_s3_bucket_public_access_block" "data" {
  bucket = aws_s3_bucket.data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "hello" {
  bucket  = aws_s3_bucket.data.id
  key     = "hello.txt"
  content = "Voce leu isto com credencial temporaria de uma role assumida. Nenhuma access key foi criada neste lab.\n"
}

resource "aws_s3_object" "segundo" {
  bucket  = aws_s3_bucket.data.id
  key     = "segundo.txt"
  content = "Se voce esta lendo ESTE arquivo, a session policy do passo 6 nao estava ativa.\n"
}

# ===========================================================================
# LADO A — o parceiro (MSP). Quem CHAMA.
#
# Numa arquitetura real estas duas roles estariam em outra conta. Aqui elas
# vivem na mesma, e o README explica em detalhe o que muda de verdade quando
# a fronteira de conta existe (resumo: com duas contas as DUAS policies passam
# a ser obrigatórias sempre, sem exceção).
# ===========================================================================

data "aws_iam_policy_document" "trust_account_root" {
  statement {
    sid     = "DelegaParaAConta"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [local.account_root]
    }
  }
}

resource "aws_iam_role" "msp_caller" {
  name               = "${local.name_prefix}-msp-caller"
  description        = "Simula o principal do parceiro. Tem sts:AssumeRole na identity policy."
  assume_role_policy = data.aws_iam_policy_document.trust_account_root.json
}

# A metade "lado A" da regra das duas policies. Sem isto, a trust policy do
# lado B não adianta nada quando ela nomeia :root.
data "aws_iam_policy_document" "msp_caller" {
  statement {
    sid     = "AssumirOsPapeisDoLadoB"
    actions = ["sts:AssumeRole"]

    resources = [
      aws_iam_role.audit_readonly.arn,
      aws_iam_role.delegated_admin_bounded.arn,
      aws_iam_role.delegated_admin_unbounded.arn,
    ]
  }
}

resource "aws_iam_role_policy" "msp_caller" {
  name   = "assume-lado-b"
  role   = aws_iam_role.msp_caller.id
  policy = data.aws_iam_policy_document.msp_caller.json
}

# O gêmeo sem identity policy nenhuma. É o controle do experimento: mesma trust
# policy do outro lado, resultado oposto. Passo 9.
resource "aws_iam_role" "msp_caller_trust_only" {
  name               = "${local.name_prefix}-msp-caller-trust-only"
  description        = "Mesmo papel do msp-caller, porém SEM nenhuma identity policy. Só entra onde a trust policy o nomeia."
  assume_role_policy = data.aws_iam_policy_document.trust_account_root.json
}

# ===========================================================================
# LADO B — o cliente, dono dos dados. Quem é CHAMADO.
# ===========================================================================

# --- audit-readonly: a role do terceiro, com external ID -------------------

data "aws_iam_policy_document" "trust_with_external_id" {
  statement {
    sid     = "DelegaParaAContaEExigeExternalId"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [local.account_root]
    }

    # A condição inteira do lab está nestas quatro linhas. Sem ela, qualquer
    # principal da conta de origem entra — inclusive um que foi enganado a
    # entrar aqui em nome de outra pessoa (confused deputy).
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.external_id]
    }
  }
}

resource "aws_iam_role" "audit_readonly" {
  name               = "${local.name_prefix}-audit-readonly"
  description        = "Role de auditoria do parceiro. Trust exige sts:ExternalId."
  assume_role_policy = data.aws_iam_policy_document.trust_with_external_id.json
}

data "aws_iam_policy_document" "audit_readonly" {
  statement {
    sid       = "LerSomenteOBucketDoLab"
    actions   = ["s3:GetObject", "s3:ListBucket"]
    resources = [aws_s3_bucket.data.arn, "${aws_s3_bucket.data.arn}/*"]
  }
}

resource "aws_iam_policy" "audit_readonly" {
  name        = "${local.name_prefix}-audit-readonly"
  description = "Leitura do bucket do lab. Compartilhada pelas duas roles de auditoria de propósito: o que difere entre elas é a TRUST policy, não a permissão."
  policy      = data.aws_iam_policy_document.audit_readonly.json
}

resource "aws_iam_role_policy_attachment" "audit_readonly" {
  role       = aws_iam_role.audit_readonly.name
  policy_arn = aws_iam_policy.audit_readonly.arn
}

# --- audit-direct-trust: a mesma permissão, outra trust policy -------------
#
# Aqui a trust policy nomeia o ARN EXATO de uma role, em vez de :root. Numa
# mesma conta isso basta sozinho: o chamador entra sem ter sts:AssumeRole na
# identity policy dele. Entre contas diferentes NÃO bastaria — e é exatamente
# essa assimetria que o passo 9 mede.

data "aws_iam_policy_document" "trust_direct_principal" {
  statement {
    sid     = "NomeiaOPrincipalExato"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.msp_caller_trust_only.arn]
    }
  }
}

resource "aws_iam_role" "audit_direct_trust" {
  name               = "${local.name_prefix}-audit-direct-trust"
  description        = "Trust policy nomeia o ARN exato do msp-caller-trust-only. Mesma conta: a resource policy sozinha já autoriza."
  assume_role_policy = data.aws_iam_policy_document.trust_direct_principal.json
}

resource "aws_iam_role_policy_attachment" "audit_direct_trust" {
  role       = aws_iam_role.audit_direct_trust.name
  policy_arn = aws_iam_policy.audit_readonly.arn
}

# --- permission boundary: os gêmeos -----------------------------------------
#
# delegated-admin-bounded e delegated-admin-unbounded recebem a MESMA identity
# policy. A única diferença entre os dois é o `permissions_boundary`. Tudo o
# que divergir no comportamento é, por construção, efeito da boundary.

# O `./scripts/tf.sh lint` reprova esta policy em três checks do checkov
# (CKV_AWS_108, 111 e 356: Resource "*" em ação restringível). Está certo em
# reprovar, e é de propósito: ela é o "antes" da história. A boundary logo
# abaixo é o "depois" — e a role bounded prova que o achado do scanner some do
# efetivo sem que uma linha desta policy mude.
data "aws_iam_policy_document" "delegated_admin" {
  statement {
    sid       = "S3AmploDeProposito"
    actions   = ["s3:Get*", "s3:List*", "s3:PutObject"]
    resources = ["*"]
  }

  statement {
    sid       = "Ec2SomenteLeitura"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "delegated_admin" {
  name        = "${local.name_prefix}-delegated-admin"
  description = "Identity policy ampla, propositalmente mais larga que a boundary. Anexada aos DOIS gêmeos."
  policy      = data.aws_iam_policy_document.delegated_admin.json
}

# A boundary não CONCEDE nada — ela é o teto. O efetivo é a interseção dela com
# a identity policy. Repare que ela não fala de ec2 nem tem Resource "*": as
# duas ausências viram AccessDenied no passo 7.
data "aws_iam_policy_document" "boundary" {
  statement {
    sid       = "TetoSomenteS3NoBucketDoLab"
    actions   = ["s3:*"]
    resources = [aws_s3_bucket.data.arn, "${aws_s3_bucket.data.arn}/*"]
  }
}

resource "aws_iam_policy" "boundary" {
  name        = "${local.name_prefix}-boundary"
  description = "Permission boundary: teto de permissão efetiva. Não concede nada por si só."
  policy      = data.aws_iam_policy_document.boundary.json
}

resource "aws_iam_role" "delegated_admin_bounded" {
  name                 = "${local.name_prefix}-delegated-admin-bounded"
  description          = "Identity policy ampla LIMITADA por permission boundary."
  assume_role_policy   = data.aws_iam_policy_document.trust_account_root.json
  permissions_boundary = aws_iam_policy.boundary.arn
}

resource "aws_iam_role_policy_attachment" "delegated_admin_bounded" {
  role       = aws_iam_role.delegated_admin_bounded.name
  policy_arn = aws_iam_policy.delegated_admin.arn
}

resource "aws_iam_role" "delegated_admin_unbounded" {
  name               = "${local.name_prefix}-delegated-admin-unbounded"
  description        = "O gêmeo sem boundary. Mesma identity policy, permissão efetiva maior."
  assume_role_policy = data.aws_iam_policy_document.trust_account_root.json
}

resource "aws_iam_role_policy_attachment" "delegated_admin_unbounded" {
  role       = aws_iam_role.delegated_admin_unbounded.name
  policy_arn = aws_iam_policy.delegated_admin.arn
}

# ===========================================================================
# IAM Access Analyzer — zona de confiança = a conta
#
# Analyzer de acesso EXTERNO é gratuito (o de acesso NÃO USADO cobra por role
# analisada — não é este). Ele lê trust policies e resource policies e reporta
# todo principal de fora da zona de confiança que consegue acesso.
# ===========================================================================
resource "aws_accessanalyzer_analyzer" "account" {
  count = var.create_access_analyzer ? 1 : 0

  analyzer_name = local.name_prefix
  type          = "ACCOUNT"
}

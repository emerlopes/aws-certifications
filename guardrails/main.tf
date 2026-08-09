# Guarda-corpos de custo da conta de estudos.
#
# Diferente dos labs, esta stack é PERMANENTE (Ephemeral = false).
# Suba antes do primeiro lab:
#
#   ./scripts/tf.sh apply guardrails
#
# Depois confirme a inscrição que chega por e-mail.

terraform {
  required_version = ">= 1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "aws-certifications"
      ManagedBy = "terraform"
      Component = "guardrails"
      Ephemeral = "false"
    }
  }
}

variable "aws_region" {
  description = "Região. Budgets e Cost Anomaly Detection são globais, mas o SNS vive em uma região."
  type        = string
  default     = "us-east-1"
}

variable "certification" {
  description = "Injetada pelo tf.sh; não usada aqui."
  type        = string
  default     = "shared"
}

variable "lab" {
  description = "Injetada pelo tf.sh; não usada aqui."
  type        = string
  default     = "guardrails"
}

variable "notification_email" {
  description = "E-mail que recebe alertas de orçamento e anomalia."
  type        = string
}

variable "monthly_budget_usd" {
  description = "Teto mensal de gasto da conta de estudos."
  type        = number
  default     = 30
}

variable "anomaly_threshold_usd" {
  description = "Dispara alerta quando o impacto de uma anomalia passa deste valor."
  type        = number
  default     = 5
}

# --------------------------------------------------------------------------- #
# Canal de notificação
# --------------------------------------------------------------------------- #
resource "aws_sns_topic" "cost_alerts" {
  name = "aws-certifications-cost-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.cost_alerts.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

data "aws_iam_policy_document" "cost_alerts" {
  statement {
    sid     = "AllowBudgetsAndAnomalyDetection"
    actions = ["SNS:Publish"]

    principals {
      type = "Service"
      identifiers = [
        "budgets.amazonaws.com",
        "costalerts.amazonaws.com",
      ]
    }

    resources = [aws_sns_topic.cost_alerts.arn]
  }
}

resource "aws_sns_topic_policy" "cost_alerts" {
  arn    = aws_sns_topic.cost_alerts.arn
  policy = data.aws_iam_policy_document.cost_alerts.json
}

# --------------------------------------------------------------------------- #
# Budget mensal — alerta em 50%, 80% e 100% do realizado, e 100% do previsto
# --------------------------------------------------------------------------- #
resource "aws_budgets_budget" "monthly" {
  name         = "aws-certifications-monthly"
  budget_type  = "COST"
  limit_amount = tostring(var.monthly_budget_usd)
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  dynamic "notification" {
    for_each = [50, 80, 100]

    content {
      comparison_operator        = "GREATER_THAN"
      threshold                  = notification.value
      threshold_type             = "PERCENTAGE"
      notification_type          = "ACTUAL"
      subscriber_sns_topic_arns  = [aws_sns_topic.cost_alerts.arn]
      subscriber_email_addresses = [var.notification_email]
    }
  }

  # O alerta que realmente salva: previsão de estourar antes de estourar.
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_sns_topic_arns  = [aws_sns_topic.cost_alerts.arn]
    subscriber_email_addresses = [var.notification_email]
  }
}

# --------------------------------------------------------------------------- #
# Cost Anomaly Detection — pega o NAT Gateway esquecido antes do fim do mês
# --------------------------------------------------------------------------- #
resource "aws_ce_anomaly_monitor" "services" {
  name              = "aws-certifications-services"
  monitor_type      = "DIMENSIONAL"
  monitor_dimension = "SERVICE"
}

resource "aws_ce_anomaly_subscription" "daily" {
  name      = "aws-certifications-anomalies"
  frequency = "DAILY"

  monitor_arn_list = [aws_ce_anomaly_monitor.services.arn]

  subscriber {
    type    = "SNS"
    address = aws_sns_topic.cost_alerts.arn
  }

  threshold_expression {
    dimension {
      key           = "ANOMALY_TOTAL_IMPACT_ABSOLUTE"
      match_options = ["GREATER_THAN_OR_EQUAL"]
      values        = [tostring(var.anomaly_threshold_usd)]
    }
  }

  depends_on = [aws_sns_topic_policy.cost_alerts]
}

output "cost_alerts_topic_arn" {
  description = "Tópico SNS dos alertas de custo."
  value       = aws_sns_topic.cost_alerts.arn
}

output "next_step" {
  description = "O que fazer depois do apply."
  value       = "Confirme a inscrição enviada para ${var.notification_email} e ative as cost allocation tags Project/Certification/Lab no console de Billing."
}

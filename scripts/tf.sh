#!/usr/bin/env bash
#
# tf.sh — wrapper de Terraform para os labs deste repositório.
#
#   ./scripts/tf.sh bootstrap                  cria o bucket de state remoto (uma vez)
#   ./scripts/tf.sh init      <lab-dir>        init com backend S3 e key derivada do caminho
#   ./scripts/tf.sh fmt       [lab-dir]        terraform fmt -recursive (repo inteiro se omitido)
#   ./scripts/tf.sh validate  <lab-dir>
#   ./scripts/tf.sh lint      <lab-dir>        tflint + checkov (se instalados)
#   ./scripts/tf.sh plan      <lab-dir> [-- <args extras>]
#   ./scripts/tf.sh apply     <lab-dir> [-- <args extras>]
#   ./scripts/tf.sh output    <lab-dir>
#   ./scripts/tf.sh destroy   <lab-dir>
#   ./scripts/tf.sh cost      <lab-dir>        estimativa via infracost (se instalado)
#   ./scripts/tf.sh list                       states existentes no bucket
#   ./scripts/tf.sh orphans                    recursos vivos com Ephemeral=true
#
# <lab-dir> é o caminho do diretório do lab, ex:
#   certifications/sap-c02/labs/lab-01-vpc-base
#
set -euo pipefail

PROJECT="aws-certifications"
DEFAULT_REGION="${AWS_REGION:-us-east-1}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

RED=$'\033[0;31m'; GRN=$'\033[0;32m'; YLW=$'\033[0;33m'; BLU=$'\033[0;34m'; NC=$'\033[0m'
info() { printf '%s==>%s %s\n' "$BLU" "$NC" "$*"; }
ok()   { printf '%s✔%s  %s\n'  "$GRN" "$NC" "$*"; }
warn() { printf '%s!%s  %s\n'  "$YLW" "$NC" "$*"; }
die()  { printf '%s✖%s  %s\n'  "$RED" "$NC" "$*" >&2; exit 1; }

usage() { awk 'NR>1 && /^#/ {sub(/^# ?/,""); print; next} NR>1 {exit}' "$0"; exit "${1:-0}"; }

# --------------------------------------------------------------------------- #
CMD="${1:-}"; shift || true
[[ -z "$CMD" || "$CMD" == "-h" || "$CMD" == "--help" ]] && usage 0

LAB_DIR=""; REGION="$DEFAULT_REGION"; PASSTHRU=()

case "$CMD" in
  bootstrap|list|orphans) ;;
  fmt) LAB_DIR="${1:-.}"; shift || true ;;
  *)
    LAB_DIR="${1:-}"; shift || true
    [[ -z "$LAB_DIR" ]] && die "informe o diretório do lab. Ex: certifications/sap-c02/labs/lab-01-vpc-base"
    ;;
esac
LAB_DIR="${LAB_DIR%/}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --region) REGION="$2"; shift 2 ;;
    --)       shift; PASSTHRU=("$@"); break ;;
    *)        PASSTHRU+=("$1"); shift ;;
  esac
done

command -v terraform >/dev/null || die "terraform não instalado (brew install terraform)"

# --------------------------------------------------------------------------- #
# Convenções derivadas do caminho
# --------------------------------------------------------------------------- #
ACCOUNT_ID=""; STATE_BUCKET=""; STATE_KEY=""; CERT_TAG="shared"; LAB_NAME=""

account_id() {
  [[ -n "$ACCOUNT_ID" ]] || ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
  printf '%s' "$ACCOUNT_ID"
}

state_bucket() {
  [[ -n "$STATE_BUCKET" ]] || STATE_BUCKET="tfstate-${PROJECT}-$(account_id)"
  printf '%s' "$STATE_BUCKET"
}

resolve_lab() {
  [[ -d "$REPO_ROOT/$LAB_DIR" ]] || die "diretório não encontrado: $LAB_DIR"
  compgen -G "$REPO_ROOT/$LAB_DIR/*.tf" >/dev/null || die "nenhum .tf em $LAB_DIR"

  LAB_NAME="$(basename "$LAB_DIR")"
  if [[ "$LAB_DIR" == certifications/* ]]; then
    CERT_TAG="$(echo "$LAB_DIR" | cut -d/ -f2 | tr '[:lower:]' '[:upper:]')"  # SAP-C02
  fi
  STATE_KEY="${LAB_DIR}/terraform.tfstate"
}

# Variáveis injetadas em todo lab (ver modules/README.md)
tf_vars() {
  printf '%s' \
    "-var=certification=${CERT_TAG} -var=lab=${LAB_NAME} -var=aws_region=${REGION}"
}

tf_init() {
  resolve_lab
  info "init      $LAB_DIR"
  info "backend   s3://$(state_bucket)/${STATE_KEY}"
  terraform -chdir="$REPO_ROOT/$LAB_DIR" init -input=false -upgrade \
    -backend-config="bucket=$(state_bucket)" \
    -backend-config="key=${STATE_KEY}" \
    -backend-config="region=${REGION}" \
    -backend-config="encrypt=true" \
    -backend-config="use_lockfile=true"
}

# .terraform/terraform.tfstate só existe quando um BACKEND foi inicializado.
# Checar só o diretório .terraform deixaria passar um `init -backend=false`,
# e o lab acabaria gravando state local sem ninguém perceber.
ensure_init() {
  [[ -f "$REPO_ROOT/$LAB_DIR/.terraform/terraform.tfstate" ]] || tf_init
}

# --------------------------------------------------------------------------- #
# Comandos
# --------------------------------------------------------------------------- #
cmd_bootstrap() {
  info "criando bucket de state remoto"
  terraform -chdir="$REPO_ROOT/bootstrap" init -input=false
  terraform -chdir="$REPO_ROOT/bootstrap" apply -input=false \
    -var="aws_region=${REGION}" "${PASSTHRU[@]}"
  ok "bootstrap concluído — agora todo lab usa backend S3"
}

cmd_fmt() {
  info "terraform fmt -recursive $LAB_DIR"
  terraform -chdir="$REPO_ROOT/$LAB_DIR" fmt -recursive
  ok "formatado"
}

cmd_validate() {
  resolve_lab; ensure_init
  terraform -chdir="$REPO_ROOT/$LAB_DIR" fmt -check -recursive \
    || die "arquivos fora do formato — rode: ./scripts/tf.sh fmt $LAB_DIR"
  terraform -chdir="$REPO_ROOT/$LAB_DIR" validate
  ok "válido"
}

cmd_lint() {
  resolve_lab
  if command -v tflint >/dev/null; then
    info "tflint    $LAB_DIR"
    (cd "$REPO_ROOT/$LAB_DIR" && tflint --config="$REPO_ROOT/.tflint.hcl" --chdir=.) \
      || warn "tflint apontou itens"
  else
    warn "tflint não instalado (brew install tflint)"
  fi
  if command -v checkov >/dev/null; then
    info "checkov   $LAB_DIR"
    checkov -d "$REPO_ROOT/$LAB_DIR" --framework terraform --compact --quiet \
      || warn "checkov apontou itens — em lab é aceitável, mas leia (Domínio 2.3 / 3.2)"
  fi
}

cmd_plan() {
  resolve_lab; ensure_init
  # shellcheck disable=SC2046
  terraform -chdir="$REPO_ROOT/$LAB_DIR" plan -input=false $(tf_vars) "${PASSTHRU[@]}"
}

cmd_apply() {
  resolve_lab; ensure_init
  # shellcheck disable=SC2046
  terraform -chdir="$REPO_ROOT/$LAB_DIR" apply -input=false $(tf_vars) "${PASSTHRU[@]}"
  ok "apply concluído"
  warn "lembre de destruir: ./scripts/tf.sh destroy $LAB_DIR"
}

cmd_output() {
  resolve_lab; ensure_init
  terraform -chdir="$REPO_ROOT/$LAB_DIR" output
}

cmd_destroy() {
  resolve_lab; ensure_init
  # shellcheck disable=SC2046
  terraform -chdir="$REPO_ROOT/$LAB_DIR" destroy $(tf_vars) "${PASSTHRU[@]}"
  ok "destruído"
}

cmd_cost() {
  resolve_lab
  command -v infracost >/dev/null || die "infracost não instalado (brew install infracost)"
  infracost breakdown --path "$REPO_ROOT/$LAB_DIR"
}

cmd_list() {
  info "states em s3://$(state_bucket)"
  aws s3api list-objects-v2 --bucket "$(state_bucket)" \
    --query 'Contents[?ends_with(Key, `terraform.tfstate`)].[Key,LastModified,Size]' \
    --output table 2>/dev/null || warn "bucket ainda não existe — rode ./scripts/tf.sh bootstrap"
  echo
  warn "state existente não significa recurso vivo — confirme com 'orphans'"
}

cmd_orphans() {
  info "recursos com Ephemeral=true em $REGION"
  aws resourcegroupstaggingapi get-resources \
    --region "$REGION" \
    --tag-filters "Key=Ephemeral,Values=true" \
    --query 'ResourceTagMappingList[].ResourceARN' --output table
  echo
  warn "snapshots, EIPs soltos e log groups sem tag não aparecem aqui — ver docs/custos.md"
}

case "$CMD" in
  bootstrap) cmd_bootstrap ;;
  init)      tf_init ;;
  fmt)       cmd_fmt ;;
  validate)  cmd_validate ;;
  lint)      cmd_lint ;;
  plan)      cmd_validate; cmd_plan ;;
  apply)     cmd_apply ;;
  output)    cmd_output ;;
  destroy)   cmd_destroy ;;
  cost)      cmd_cost ;;
  list)      cmd_list ;;
  orphans)   cmd_orphans ;;
  *) die "comando desconhecido: $CMD (use --help)" ;;
esac

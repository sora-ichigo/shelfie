#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# デフォルト値
DEFAULT_PROJECT_ID="shelfie-development-484809"

usage() {
  cat <<EOF
Usage: $0 <command> <secret-name> [options]

Commands:
  create    Create a new secret
  update    Update an existing secret (add new version)
  get       Get the latest secret value
  delete    Delete a secret

Options:
  -p, --project   GCP project ID (default: $DEFAULT_PROJECT_ID)
  -v, --value     Secret value (will prompt if not provided)
  -f, --file      Read secret value from file
  -h, --help      Show this help message

Examples:
  # Create a secret interactively
  $0 create shelfie-api-database-url

  # Create a secret with value
  $0 create shelfie-api-database-url -v "postgres://user:pass@host:5432/db"

  # Update a secret from file
  echo -n "new-value" > /tmp/secret.txt
  $0 update shelfie-api-database-url -f /tmp/secret.txt

  # Get a secret value
  $0 get shelfie-api-database-url

  # Delete a secret
  $0 delete shelfie-api-database-url

Common secrets for this project:
  - shelfie-api-database-url    DATABASE_URL for the API
EOF
  exit 1
}

# 引数パース
COMMAND=""
SECRET_NAME=""
PROJECT_ID="$DEFAULT_PROJECT_ID"
SECRET_VALUE=""
SECRET_FILE=""

while [[ $# -gt 0 ]]; do
  case $1 in
    create|update|get|delete)
      COMMAND="$1"
      shift
      ;;
    -p|--project)
      PROJECT_ID="$2"
      shift 2
      ;;
    -v|--value)
      SECRET_VALUE="$2"
      shift 2
      ;;
    -f|--file)
      SECRET_FILE="$2"
      shift 2
      ;;
    -h|--help)
      usage
      ;;
    -*)
      echo "Error: Unknown option $1"
      usage
      ;;
    *)
      if [[ -z "$SECRET_NAME" ]]; then
        SECRET_NAME="$1"
      fi
      shift
      ;;
  esac
done

if [[ -z "$COMMAND" ]] || [[ -z "$SECRET_NAME" ]]; then
  usage
fi

# gcloud がインストールされているか確認
if ! command -v gcloud &>/dev/null; then
  echo "Error: gcloud CLI is not installed"
  echo "Install it from: https://cloud.google.com/sdk/docs/install"
  exit 1
fi

# シークレット値を取得
get_secret_value() {
  if [[ -n "$SECRET_FILE" ]]; then
    if [[ ! -f "$SECRET_FILE" ]]; then
      echo "Error: File not found: $SECRET_FILE"
      exit 1
    fi
    cat "$SECRET_FILE"
  elif [[ -n "$SECRET_VALUE" ]]; then
    echo -n "$SECRET_VALUE"
  else
    echo -n "Enter secret value: " >&2
    read -rs value
    echo >&2
    echo -n "$value"
  fi
}

case "$COMMAND" in
  create)
    echo "Creating secret '$SECRET_NAME' in project '$PROJECT_ID'..."
    VALUE=$(get_secret_value)
    echo -n "$VALUE" | gcloud secrets create "$SECRET_NAME" \
      --project="$PROJECT_ID" \
      --data-file=-
    echo "Secret '$SECRET_NAME' created successfully"
    ;;

  update)
    echo "Updating secret '$SECRET_NAME' in project '$PROJECT_ID'..."
    VALUE=$(get_secret_value)
    echo -n "$VALUE" | gcloud secrets versions add "$SECRET_NAME" \
      --project="$PROJECT_ID" \
      --data-file=-
    echo "Secret '$SECRET_NAME' updated successfully"
    ;;

  get)
    gcloud secrets versions access latest \
      --secret="$SECRET_NAME" \
      --project="$PROJECT_ID"
    ;;

  delete)
    echo "Are you sure you want to delete secret '$SECRET_NAME'? [y/N]"
    read -r confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      gcloud secrets delete "$SECRET_NAME" \
        --project="$PROJECT_ID" \
        --quiet
      echo "Secret '$SECRET_NAME' deleted"
    else
      echo "Cancelled"
    fi
    ;;
esac

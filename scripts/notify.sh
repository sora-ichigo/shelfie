#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<EOF
Usage: $0 <dev|prod> [-- notify args...]

Examples:
  $0 dev -- --title "テスト" --body "dev環境テスト" --user-ids 1
  $0 prod -- --title "リリース" --body "新機能のお知らせ" --user-ids all
EOF
  exit 1
}

if [[ $# -lt 1 ]]; then
  usage
fi

ENV="$1"
shift

case "$ENV" in
  dev)
    GCP_PROJECT="shelfie-development-484809"
    ;;
  prod)
    GCP_PROJECT="shelfie-production-485714"
    ;;
  *)
    echo "Error: Unknown environment '$ENV'. Use 'dev' or 'prod'."
    usage
    ;;
esac

# Skip "--" separator if present
if [[ "${1:-}" == "--" ]]; then
  shift
fi

export DATABASE_URL
DATABASE_URL="$("$SCRIPT_DIR/manage-secret.sh" get shelfie-api-database-url -p "$GCP_PROJECT")"

export FIREBASE_PROJECT_ID="$GCP_PROJECT"
export FIREBASE_CLIENT_EMAIL="firebase-adminsdk-fbsvc@${GCP_PROJECT}.iam.gserviceaccount.com"

export FIREBASE_PRIVATE_KEY
FIREBASE_PRIVATE_KEY="$("$SCRIPT_DIR/manage-secret.sh" get shelfie-api-firebase-private-key -p "$GCP_PROJECT")"

cd "$SCRIPT_DIR/../apps/api"
exec pnpm vite-node src/scripts/send-notification.ts -- "$@"

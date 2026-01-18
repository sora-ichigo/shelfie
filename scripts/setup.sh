#!/bin/bash

# ログファイルの設定
SETUP_LOG="/tmp/setup_$(date +%Y%m%d_%H%M%S).log"
exec > >(tee -a "$SETUP_LOG") 2>&1

echo "=== Setup started at $(date) ==="
echo "CLAUDE_CODE_REMOTE: ${CLAUDE_CODE_REMOTE:-<not set>}"
echo "Log file: $SETUP_LOG"

# リモート環境（Claude Code on the web）でのみ実行
if [ "$CLAUDE_CODE_REMOTE" != "true" ]; then
  echo "Skipping setup: CLAUDE_CODE_REMOTE is not 'true'"
  exit 0
fi

echo "Setting up Claude Code on the web environment..."

# プロジェクトディレクトリを特定（CLAUDE_PROJECT_DIR が空の場合はスクリプトの場所から計算）
if [ -z "$CLAUDE_PROJECT_DIR" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
  echo "CLAUDE_PROJECT_DIR is empty, using script location: $PROJECT_DIR"
else
  PROJECT_DIR="$CLAUDE_PROJECT_DIR"
fi

# GitHub CLI のインストール（バイナリ直接ダウンロード）
if ! command -v gh &>/dev/null; then
  echo "Installing GitHub CLI..."
  GH_VERSION="2.63.2"
  cd /tmp &&
    curl -sL "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.tar.gz" -o gh.tar.gz &&
    tar -xzf gh.tar.gz &&
    mv "gh_${GH_VERSION}_linux_amd64/bin/gh" /usr/local/bin/ &&
    rm -rf gh.tar.gz "gh_${GH_VERSION}_linux_amd64" &&
    echo "GitHub CLI installed: $(gh --version | head -1)"
fi

# mise のインストール（存在しない場合）
if ! command -v mise &>/dev/null; then
  echo "Installing mise..."
  curl https://mise.run | sh
  export PATH="$HOME/.local/bin:$PATH"
  if [ -n "$CLAUDE_ENV_FILE" ]; then
    echo "PATH=$HOME/.local/bin:\$PATH" >>"$CLAUDE_ENV_FILE"
  fi
  echo "mise installed: $(mise --version)"
fi

# mise trust と install
echo "Setting up mise tools..."
cd "$PROJECT_DIR"
mise trust --all 2>/dev/null || true
mise install

# mise の shim パスを PATH に追加
MISE_SHIMS="$HOME/.local/share/mise/shims"
export PATH="$MISE_SHIMS:$PATH"
if [ -n "$CLAUDE_ENV_FILE" ]; then
  echo "PATH=$MISE_SHIMS:\$PATH" >>"$CLAUDE_ENV_FILE"
fi

# Node.js と pnpm の確認
echo "Verifying Node.js and pnpm..."
echo "Node.js: $(node --version 2>/dev/null || echo 'not found')"
echo "pnpm: $(pnpm --version 2>/dev/null || echo 'not found')"

# PostgreSQL のセットアップ
echo "Setting up PostgreSQL..."

# SSL 秘密鍵のパーミッション修正
SSL_KEY="/etc/ssl/private/ssl-cert-snakeoil.key"
if [ -f "$SSL_KEY" ]; then
  echo "Fixing SSL key permissions..."
  chmod 600 "$SSL_KEY"
fi

# pg_hba.conf を trust 認証に変更
PG_HBA_CONF=$(psql -U postgres -t -P format=unaligned -c "SHOW hba_file" 2>/dev/null || echo "/etc/postgresql/*/main/pg_hba.conf")
if [ -n "$PG_HBA_CONF" ] && [ -f "$PG_HBA_CONF" ]; then
  echo "Updating pg_hba.conf for trust authentication..."
  sed -i 's/scram-sha-256/trust/g' "$PG_HBA_CONF"
  sed -i 's/md5/trust/g' "$PG_HBA_CONF"
elif ls /etc/postgresql/*/main/pg_hba.conf 1>/dev/null 2>&1; then
  for conf in /etc/postgresql/*/main/pg_hba.conf; do
    echo "Updating $conf for trust authentication..."
    sed -i 's/scram-sha-256/trust/g' "$conf"
    sed -i 's/md5/trust/g' "$conf"
  done
fi

# PostgreSQL の起動
echo "Starting PostgreSQL..."
if command -v systemctl &>/dev/null && systemctl is-active --quiet postgresql 2>/dev/null; then
  echo "PostgreSQL is already running via systemd"
  systemctl reload postgresql 2>/dev/null || true
elif command -v service &>/dev/null; then
  service postgresql start 2>/dev/null || service postgresql restart 2>/dev/null || true
elif command -v pg_ctlcluster &>/dev/null; then
  PG_VERSION=$(ls /etc/postgresql/ 2>/dev/null | head -1)
  if [ -n "$PG_VERSION" ]; then
    pg_ctlcluster "$PG_VERSION" main start 2>/dev/null ||
      pg_ctlcluster "$PG_VERSION" main restart 2>/dev/null || true
  fi
fi

# PostgreSQL が起動するまで待機
echo "Waiting for PostgreSQL to start..."
for i in {1..30}; do
  if pg_isready -h localhost -p 5432 >/dev/null 2>&1; then
    echo "PostgreSQL is ready"
    break
  fi
  sleep 1
done

if ! pg_isready -h localhost -p 5432 >/dev/null 2>&1; then
  echo "WARNING: PostgreSQL may not be running properly"
fi

# 認証設定が反映されるまで待機（pg_isready は認証をチェックしないため）
echo "Waiting for PostgreSQL authentication to be ready..."
for i in {1..30}; do
  if psql -h localhost -U postgres -c "SELECT 1" >/dev/null 2>&1; then
    echo "PostgreSQL authentication is ready"
    break
  fi
  sleep 1
done

if ! psql -h localhost -U postgres -c "SELECT 1" >/dev/null 2>&1; then
  echo "WARNING: PostgreSQL authentication may not be configured properly"
fi

# pnpm install
echo "Installing dependencies with pnpm..."
cd "$PROJECT_DIR"
if pnpm install; then
  echo "pnpm install completed successfully"
else
  echo "ERROR: pnpm install failed with exit code $?"
fi

# Flutter pub get（mobile アプリ用）
echo "Installing Flutter dependencies..."
if [ -d "$PROJECT_DIR/apps/mobile" ]; then
  cd "$PROJECT_DIR/apps/mobile"
  if command -v flutter &>/dev/null; then
    if flutter pub get; then
      echo "Flutter pub get completed successfully"
    else
      echo "WARNING: Flutter pub get failed with exit code $?"
    fi
  else
    echo "WARNING: Flutter not found, skipping mobile dependencies"
  fi
else
  echo "WARNING: apps/mobile directory not found"
fi

# プロジェクトルートに戻る
cd "$PROJECT_DIR"

# ビルド確認
echo "Running typecheck..."
if pnpm typecheck; then
  echo "Typecheck passed"
else
  echo "WARNING: Typecheck failed"
fi

echo "=== Setup complete at $(date) ==="
echo "Log saved to: $SETUP_LOG"

# ログファイルへのシンボリックリンクを作成（最新ログへのアクセスを容易にする）
ln -sf "$SETUP_LOG" /tmp/setup_latest.log

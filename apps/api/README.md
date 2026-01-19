# @shelfie/api

GraphQL API サーバー（Express + Apollo Server + Vite）

## セットアップ

### 1. 依存関係のインストール

```bash
pnpm install
```

### 2. ローカル PostgreSQL のセットアップ

ローカルで PostgreSQL が起動している前提で、`shelfie` ユーザーとデータベースを作成します。

```bash
# ユーザー作成
psql -U $(whoami) -d postgres -c "CREATE USER shelfie WITH PASSWORD 'shelfie';"

# 開発用データベース作成
psql -U $(whoami) -d postgres -c "CREATE DATABASE shelfie OWNER shelfie;"

# テスト用データベース作成
psql -U $(whoami) -d postgres -c "CREATE DATABASE shelfie_test OWNER shelfie;"
```

### 3. 環境変数の設定

`.env.example` をコピーして `.env` を作成します。

```bash
cp .env.example .env
```

テスト用の環境変数は `.env.test.local` に設定します（gitignore されます）。
開発用 DB（`shelfie`）とは別のテスト用 DB（`shelfie_test`）を使用します。

```bash
# .env.test.local
DATABASE_URL=postgres://shelfie:shelfie@localhost:5432/shelfie_test
NODE_ENV=test
```

## 開発

```bash
# 開発サーバー起動
pnpm dev

# テスト実行
pnpm test

# 型チェック
pnpm typecheck

# Lint
pnpm lint
```

## テスト

テストは実際の PostgreSQL データベースに接続して実行します（モックは使用しません）。
開発用 DB とは別の `shelfie_test` DB を使用するため、開発中のデータに影響しません。

```bash
pnpm test
```

# Shelfie

読書家のための本棚アプリ

## 必要な環境

- [mise](https://mise.jdx.dev/) （言語バージョン管理）

## セットアップ

```bash
# 言語・ツールのインストール
mise install

# 依存関係のインストール
pnpm install

# モバイルアプリの依存関係インストール
pnpm mobile pub get
```

## 開発

```bash
# API サーバー起動 (http://localhost:4000/graphql)
pnpm dev:api

# Web サーバー起動 (http://localhost:3000)
pnpm dev:web

# モバイルアプリ起動
pnpm dev:mobile
```

## コマンド一覧

| コマンド | 説明 |
|----------|------|
| `pnpm dev:api` | API サーバー起動 |
| `pnpm dev:web` | Web サーバー起動 |
| `pnpm dev:mobile` | モバイルアプリ起動 |
| `pnpm mobile <cmd>` | Flutter コマンド実行 |
| `pnpm build` | 全パッケージビルド |
| `pnpm typecheck` | 型チェック |
| `pnpm lint` | Biome lint |
| `pnpm format` | Biome format |
| `pnpm check` | lint + format チェック |
| `pnpm test` | テスト実行 |

## プロジェクト構成

```
shelfie/
├── apps/
│   ├── api/             # GraphQL API サーバー (Express + Apollo Server)
│   ├── web/             # 閲覧用 Web (Next.js)
│   └── mobile/          # モバイルアプリ (Flutter)
├── packages/
│   └── shared/          # 共有ユーティリティ
├── infra/
│   └── terraform/       # GCP インフラ設定
└── docs/                # ドキュメント
```

## 技術スタック

| カテゴリ | 技術 |
|----------|------|
| 言語 | TypeScript, Dart (Flutter) |
| API | Express, Apollo Server (GraphQL) |
| Web | Next.js, React |
| DB | Supabase (PostgreSQL) |
| インフラ | GCP (Cloud Run), Terraform |
| ビルド | Vite, Turbopack |
| Lint/Format | Biome |
| テスト | Vitest |
| パッケージ管理 | pnpm workspaces |

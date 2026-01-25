# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Development Commands

```bash
# セットアップ
mise install                    # 言語・ツールのインストール
pnpm install                    # 依存関係のインストール
pnpm mobile pub get             # Flutter依存関係のインストール

# 開発サーバー
pnpm dev:api                    # API サーバー起動 (http://localhost:4000/graphql)
pnpm dev:web                    # Web サーバー起動 (http://localhost:3000)
pnpm dev:mobile                 # モバイルアプリ起動

# ビルド・チェック
pnpm build                      # 全パッケージビルド
pnpm typecheck                  # 型チェック
pnpm lint                       # Biome lint
pnpm format                     # Biome format
pnpm check                      # lint + format チェック
pnpm test                       # 全テスト実行

# 個別パッケージ操作
pnpm --filter @shelfie/api <cmd>    # API パッケージ
pnpm --filter @shelfie/web <cmd>    # Web パッケージ
pnpm --filter @shelfie/api test     # API のテストのみ実行
```

## Architecture

pnpm workspaces によるモノレポ構成:

- `apps/api` - GraphQL API サーバー (Express + Apollo Server + Vite)
- `apps/web` - 閲覧用 Web アプリ (Next.js + React)
- `apps/mobile` - モバイルアプリ (Flutter/Dart) ※pnpmワークスペース外
- `packages/shared` - 共有ユーティリティ (TypeScript)
- `infra/terraform` - GCP インフラ設定

## Code Style

- Linter/Formatter: Biome（`biome.json` で設定）
- インデント: スペース2つ
- クォート: ダブルクォート
- セミコロン: あり
- TypeScript strict モード有効
- テストフレームワーク: Vitest (TypeScript) / flutter_test (Dart)

## Testing

### Flutter テスト

- ローカル実行時は関連するテストファイルのみに絞って実行する（全件実行は時間がかかりすぎるため）
- 全テストを実行したい場合は push して CI で確認する

```bash
# 特定のテストファイルのみ実行
pnpm mobile test test/unit/path/to/specific_test.dart

# 特定ディレクトリ配下のテストを実行
pnpm mobile test test/unit/features/some_feature/
```

## CI

GitHub Actions で paths-filter による差分検知を使用。変更されたパッケージのみ CI が実行される。

## Spec-Driven Development

@.claude/SDD.md

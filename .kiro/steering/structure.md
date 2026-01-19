# Project Structure

本ドキュメントは、Shelfie プロジェクトのディレクトリ構成を定義する。

## リポジトリ全体構成

```
shelfie/
├── .claude/                    # Claude Code 設定
│   └── CLAUDE.md
├── .kiro/
│   ├── settings/               # Kiro 設定
│   ├── specs/                  # 仕様ドキュメント
│   └── steering/               # プロジェクトメモリ
│       ├── tech.md             # 技術スタック
│       └── structure.md        # ディレクトリ構成（本ファイル）
├── apps/
│   ├── api/                    # GraphQL API サーバー
│   ├── web/                    # Web アプリケーション
│   └── mobile/                 # モバイルアプリケーション
├── packages/
│   └── shared/                 # 共有ユーティリティ
├── infra/
│   └── terraform/              # GCP インフラ設定
├── docs/                       # 開発者ドキュメント
│   ├── api-architecture.md     # API 技術選定と設計決定
│   └── api-directory-structure.md  # API ディレクトリ構成ガイド
├── biome.json                  # Biome 設定
├── pnpm-workspace.yaml         # pnpm ワークスペース設定
└── package.json                # ルート package.json
```

## API（apps/api）詳細構成

```
apps/api/
├── src/
│   ├── index.ts                 # エントリーポイント
│   │
│   ├── config/                  # 環境変数管理
│   │   └── index.ts             # ConfigManager
│   │
│   ├── db/                      # データベース層
│   │   ├── client.ts            # Drizzle クライアント
│   │   ├── connection.ts        # pg Pool（コネクションプーリング）
│   │   ├── index.ts             # DB モジュール export
│   │   ├── seed.ts              # シードデータ
│   │   ├── test-utils.ts        # テスト用ユーティリティ
│   │   └── schema/              # テーブル定義
│   │       ├── index.ts         # スキーマ集約
│   │       └── users.ts         # users テーブル
│   │
│   ├── graphql/                 # GraphQL 層
│   │   ├── builder.ts           # Pothos SchemaBuilder
│   │   ├── schema.ts            # スキーマ構築
│   │   ├── context.ts           # GraphQL Context 型
│   │   ├── server.ts            # Apollo Server / Express 設定
│   │   └── index.ts             # GraphQL モジュール export
│   │
│   ├── auth/                    # 認証層
│   │   ├── firebase.ts          # Firebase Admin 初期化
│   │   ├── middleware.ts        # 認証ミドルウェア
│   │   ├── scope.ts             # authScope パターン
│   │   └── index.ts             # Auth モジュール export
│   │
│   ├── security/                # セキュリティ層
│   │   ├── graphql-security.ts  # クエリ深度制限
│   │   ├── cors.ts              # CORS 設定
│   │   └── index.ts             # Security モジュール export
│   │
│   ├── logger/                  # ロギング層
│   │   └── index.ts             # Pino ロガー
│   │
│   ├── errors/                  # エラーハンドリング層
│   │   ├── index.ts             # ErrorHandler
│   │   └── result.ts            # Result 型ユーティリティ
│   │
│   ├── features/                # Feature モジュール
│   │   ├── index.ts             # FeatureModule インターフェース
│   │   ├── registry.ts          # FeatureRegistry
│   │   └── users/               # サンプル Feature
│   │       ├── index.ts         # Feature Module export
│   │       ├── types.ts         # Pothos 型定義・Resolver
│   │       ├── service.ts       # ビジネスロジック
│   │       └── repository.ts    # データアクセス
│   │
│   └── __tests__/               # テスト
│       ├── setup.test.ts        # テストセットアップ検証
│       └── integration/         # 統合テスト
│
├── drizzle/                     # マイグレーション
│   └── migrations/
│
├── drizzle.config.ts            # Drizzle Kit 設定
└── .env.example                 # 環境変数テンプレート
```

## Feature モジュール構成

各 Feature は以下の構成に従う:

```
features/[feature-name]/
├── index.ts         # FeatureModule export（公開 API）
├── types.ts         # Pothos 型定義・Resolver
├── service.ts       # ビジネスロジック
├── repository.ts    # データアクセス
├── service.test.ts  # Service のユニットテスト
└── repository.test.ts  # Repository のユニットテスト
```

### レイヤー責務

| File | Layer | Responsibility |
|------|-------|----------------|
| types.ts | GraphQL | 型定義、Query/Mutation Resolver |
| service.ts | Domain | ビジネスロジック、バリデーション |
| repository.ts | Data | Drizzle によるデータアクセス |
| index.ts | Interface | Feature の公開 API |

## 共通モジュールと Feature の関係

```
┌─────────────────────────────────────────────────┐
│                   features/                      │
│  ┌──────────────┐  ┌──────────────┐             │
│  │    users/    │  │    books/    │  ...        │
│  └──────┬───────┘  └──────┬───────┘             │
│         │                 │                      │
└─────────┼─────────────────┼─────────────────────┘
          │                 │
          ▼                 ▼
┌─────────────────────────────────────────────────┐
│               Core Modules                       │
│  ┌────────┐ ┌──────┐ ┌────────┐ ┌───────────┐  │
│  │ config │ │  db  │ │ errors │ │  logger   │  │
│  └────────┘ └──────┘ └────────┘ └───────────┘  │
└─────────────────────────────────────────────────┘
```

- **Feature → Core**: 許可（共通モジュールへの依存）
- **Feature → Feature**: 禁止（直接依存）
- **Feature → Feature（公開 API 経由）**: 許可

## テスト配置規則

| Test Type | Location | Naming |
|-----------|----------|--------|
| ユニットテスト | 対象ファイルと同階層 | `*.test.ts` |
| 統合テスト | `src/__tests__/integration/` | `*.test.ts` |

## 新規 Feature 追加時のチェックリスト

1. `src/features/[name]/` ディレクトリを作成
2. `index.ts`, `types.ts`, `service.ts`, `repository.ts` を作成
3. 必要に応じて `src/db/schema/[name].ts` にテーブル定義を追加
4. `src/db/schema/index.ts` でスキーマを export
5. `src/graphql/schema.ts` で Feature を登録
6. マイグレーションを生成・適用
7. テストを追加

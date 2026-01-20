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
│   │   ├── users/               # Users Feature
│   │   │   ├── index.ts         # 公開 API（Barrel Export）
│   │   │   └── internal/        # 内部実装
│   │   │       ├── graphql.ts   # Pothos 型定義・Resolver
│   │   │       ├── service.ts   # ビジネスロジック
│   │   │       └── repository.ts # データアクセス
│   │   └── auth/                # Auth Feature
│   │       ├── index.ts         # 公開 API（Barrel Export）
│   │       └── internal/        # 内部実装
│   │           ├── graphql.ts   # GraphQL 型定義・Mutation
│   │           └── service.ts   # 認証ビジネスロジック
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

各 Feature は Barrel Export パターンに従い、`internal/` ディレクトリで実装を隔離する:

```
features/[feature-name]/
├── index.ts              # 公開 API の re-export（Barrel Export）
├── index.test.ts         # 公開 API のテスト
└── internal/             # 内部実装（慣習による隔離）
    ├── graphql.ts        # Pothos 型定義・Resolver
    ├── graphql.test.ts   # GraphQL 型のテスト
    ├── service.ts        # ビジネスロジック + インターフェース
    ├── service.test.ts   # Service のユニットテスト
    ├── repository.ts     # データアクセス + インターフェース
    └── repository.test.ts  # Repository のユニットテスト
```

### レイヤー責務

| File | Layer | Responsibility |
|------|-------|----------------|
| graphql.ts | GraphQL | Pothos 型定義、Query/Mutation Resolver |
| service.ts | Domain | ビジネスロジック、バリデーション、インターフェース定義 |
| repository.ts | Data | Drizzle によるデータアクセス、インターフェース定義 |
| index.ts | Interface | 公開 API の re-export |

### Barrel Export パターン

`index.ts` は公開すべき型と関数のみを re-export する:

```typescript
// features/users/index.ts
export type { User, NewUser } from "./internal/repository.js";
export type { UserService } from "./internal/service.js";

export { createUserRepository } from "./internal/repository.js";
export { createUserService } from "./internal/service.js";
export { registerUserTypes } from "./internal/graphql.js";
```

`internal/` 配下のファイルは直接インポートせず、必ず `index.ts` 経由でアクセスする。

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
| Feature ユニットテスト | `features/[name]/internal/` | `*.test.ts` |
| Feature 公開 API テスト | `features/[name]/` | `index.test.ts` |
| コアモジュールテスト | 対象ファイルと同階層 | `*.test.ts` |
| 統合テスト | `src/__tests__/integration/` | `*.test.ts` |

## 新規 Feature 追加時のチェックリスト

1. `src/features/[name]/` と `src/features/[name]/internal/` ディレクトリを作成
2. `internal/` に実装ファイルを作成:
   - `repository.ts` - データアクセス層とインターフェース
   - `service.ts` - ビジネスロジックとインターフェース
   - `graphql.ts` - GraphQL 型定義と Resolver
3. `index.ts` で公開 API を re-export
4. 必要に応じて `src/db/schema/[name].ts` にテーブル定義を追加
5. `src/db/schema/index.ts` でスキーマを export
6. `src/graphql/schema.ts` で Feature の GraphQL 型を登録
7. マイグレーションを生成・適用
8. テストを追加（`internal/` 配下に配置）

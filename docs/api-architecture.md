# API アーキテクチャガイド

本ドキュメントでは、Shelfie API（`apps/api`）の技術選定と設計決定について説明する。

## 技術スタック

| Layer | Technology | Version | Purpose |
|-------|------------|---------|---------|
| Runtime | Node.js | 24+ | サーバー実行環境 |
| Web Framework | Express | 4.x | HTTP サーバー |
| GraphQL Server | Apollo Server | 5.x | GraphQL エンドポイント |
| Schema Builder | Pothos | 4.x | Code-first スキーマ定義 |
| ORM | Drizzle ORM | 0.45+ | 型安全なデータベースアクセス |
| Database | PostgreSQL | 16+ | データ永続化 |
| Logger | Pino | 10.x | 構造化ロギング |
| Build Tool | Vite | 7.x | ビルド・開発サーバー |
| Test Framework | Vitest | 4.x | ユニット・統合テスト |
| Authentication | Firebase Auth | - | 認証基盤（IDaaS） |

## 技術選定の決定と理由

### GraphQL スキーマ定義: Pothos（Code-first）

**選定理由**:

- TypeScript 型から GraphQL スキーマを自動生成し、コード生成が不要
- ランタイムオーバーヘッドがゼロで、標準 GraphQL スキーマを出力
- プラグインシステムで dataloader、validation、auth などの機能を拡張可能
- Airbnb、Netflix での採用実績あり

**代替案との比較**:

| Approach | Strengths | Weaknesses |
|----------|-----------|------------|
| Schema-first (SDL) | 直感的、GraphQL 標準に忠実 | スキーマと Resolver の同期維持が困難 |
| TypeGraphQL | デコレーターベースで簡潔 | 実験的機能（デコレーター）に依存 |
| **Pothos** | 型安全性最高、柔軟なプラグイン | 学習コストあり |

### ORM: Drizzle ORM

**選定理由**:

- クエリ速度が Prisma の 2-3 倍高速
- バンドルサイズが約 7.4KB と軽量（Prisma の 85% 小型化）
- TypeScript 型が常にスキーマと同期し、コード生成不要
- SQL の透明性が高く、生成されるクエリが予測可能

**代替案との比較**:

| ORM | Strengths | Weaknesses |
|-----|-----------|------------|
| Prisma | 成熟した DX、豊富なツール | パフォーマンスオーバーヘッド |
| Kysely | タイプセーフなクエリビルダー | ORM 機能がない |
| **Drizzle** | 高パフォーマンス、軽量、SQL 透明性 | エコシステムがやや小さい |

### ロギング: Pino

**選定理由**:

- JSON 構造化ログがデフォルトで、ログ管理ツールとの統合が容易
- 非同期ロギングで他ロガーの 5-10 倍高速
- OpenTelemetry ネイティブサポートで将来の分散トレーシング統合に対応
- Fastify でデフォルト採用されている実績

**代替案との比較**:

| Logger | Strengths | Weaknesses |
|--------|-----------|------------|
| Winston | 柔軟なトランスポート、複数出力先対応 | パフォーマンスが Pino より劣る |
| Bunyan | JSON ログ、シンプル | 開発が活発でない |
| **Pino** | 最高のパフォーマンス、モダンなデフォルト | 複数出力先への柔軟性は Winston が優位 |

### 認証: Firebase Auth

**選定理由**:

- IDaaS 採用によりセキュリティリスクを軽減（自前実装を回避）
- GCP インフラとの親和性が高い
- 無料枠が大きい（50,000 MAU）
- Email/Password + メール確認フローを標準サポート

## アーキテクチャパターン

### Feature-based Modular Architecture

各機能を独立したモジュールとして構成し、機能単位での開発・テスト・保守を容易にする。

```
features/
├── users/              # ユーザー機能
│   ├── index.ts        # Feature Module export
│   ├── types.ts        # Pothos 型定義
│   ├── service.ts      # ビジネスロジック
│   └── repository.ts   # データアクセス
└── [other-features]/
```

**利点**:

- 高凝集: 関連コードが一箇所に集約
- スケーラビリティ: 新機能追加が既存コードに影響しない
- テスト容易性: 機能単位での独立したテストが可能

**制約**:

- Feature 間の直接依存は禁止
- 他 Feature のデータ参照は公開 API（`getPublicApi()`）経由のみ

### レイヤー構成

各 Feature 内は軽量なレイヤー分離を採用:

| Layer | Responsibility | Example |
|-------|----------------|---------|
| types.ts | GraphQL 型定義、Resolver | Query/Mutation の定義 |
| service.ts | ビジネスロジック | バリデーション、ドメインルール |
| repository.ts | データアクセス | Drizzle ORM によるクエリ |

## エラーハンドリング

### エラーカテゴリ

| Category | Description | Logging Level |
|----------|-------------|---------------|
| USER_ERROR | クライアント起因のエラー（入力バリデーション等） | warn |
| BUSINESS_ERROR | ビジネスルール違反 | info |
| SYSTEM_ERROR | 予期しない技術的エラー | error |

### Result 型パターン

ドメインエラーは Result 型で表現し、期待される失敗ケースを型で明示する:

```typescript
type Result<T, E> = { success: true; data: T } | { success: false; error: E };
```

### 本番環境でのエラーマスキング

- SYSTEM_ERROR のスタックトレースは本番環境で非公開
- エラーメッセージは「Internal server error」に置換
- USER_ERROR と BUSINESS_ERROR はクライアントに詳細を返却

## データベース設計

### スキーマ定義パターン

```typescript
import { integer, pgTable, text, timestamp } from "drizzle-orm/pg-core";

export const users = pgTable("users", {
  id: integer("id").primaryKey().generatedAlwaysAsIdentity(),
  email: text("email").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export type User = typeof users.$inferSelect;
export type NewUser = typeof users.$inferInsert;
```

**パターン**:

- Identity columns（`generatedAlwaysAsIdentity`）を主キーに使用
- `created_at`, `updated_at` を timestamp 型で標準装備
- Drizzle の型推論（`$inferSelect`, `$inferInsert`）を活用

### コネクションプーリング

| Setting | Default | Description |
|---------|---------|-------------|
| DB_POOL_MAX | 20 | 最大接続数 |
| DB_IDLE_TIMEOUT_MS | 30000 | アイドル接続のタイムアウト |
| DB_CONNECTION_TIMEOUT_MS | 5000 | 接続タイムアウト |

## マイグレーション

### コマンド

```bash
pnpm --filter @shelfie/api db:generate  # マイグレーションファイル生成
pnpm --filter @shelfie/api db:migrate   # マイグレーション実行
pnpm --filter @shelfie/api db:push      # 開発時のスキーマ同期
pnpm --filter @shelfie/api db:studio    # Drizzle Studio 起動
pnpm --filter @shelfie/api db:seed      # シードデータ投入
```

### 運用方針

- 開発環境: `db:push` で素早くスキーマ同期
- 本番環境: `db:generate` + `db:migrate` でマイグレーションファイルを経由
- ロールバック: 手動で逆マイグレーションを作成

## セキュリティ

### GraphQL セキュリティ

- クエリ深度制限: ネストクエリによる DoS 攻撃を防止
- イントロスペクション: 開発環境のみ有効

### 認証フロー

1. クライアントで Firebase Auth SDK を使用してログイン
2. Firebase から ID Token（JWT）を取得
3. GraphQL リクエストの Authorization ヘッダーに ID Token を付与
4. API サーバーで firebase-admin SDK を使用して ID Token を検証
5. 検証済みユーザー情報を GraphQL Context に注入

### 環境変数管理

機密情報は環境変数で管理し、`.env.example` でテンプレートを提供:

```env
# Database
DATABASE_URL=postgres://user:password@localhost:5432/shelfie

# Server
NODE_ENV=development
PORT=4000
LOG_LEVEL=info

# Security
CORS_ORIGIN=http://localhost:3000

# Firebase (production)
FIREBASE_PROJECT_ID=your-project-id
```

## 参考資料

- [Pothos GraphQL](https://pothos-graphql.dev/)
- [Drizzle ORM](https://orm.drizzle.team/)
- [Apollo Server](https://www.apollographql.com/docs/apollo-server/)
- [Pino](https://github.com/pinojs/pino)
- [Firebase Authentication](https://firebase.google.com/docs/auth)

# Design Document: API Architecture

## Overview

**Purpose**: Shelfie プロジェクトの API アーキテクチャ基盤を確立し、スケーラブルで保守性の高い GraphQL API サーバーの技術スタックとディレクトリ構成を定義する。

**Users**: 開発者チームが API 機能の実装、テスト、保守を効率的に行うための基盤として利用する。

**Impact**: 既存の最小構成（Apollo Server + Express）を拡張し、本格的な開発に必要な ORM、マイグレーション、ロギング、エラーハンドリング基盤を導入する。

### Goals

- GraphQL ライブラリと Code-first スキーマ定義の確立
- PostgreSQL 接続構成とコネクションプーリングの実装
- TypeScript 型安全な ORM の導入とマイグレーション戦略の確立
- Feature-based ディレクトリ構成の定義
- 一貫したエラーハンドリングとロギング基盤の構築
- アーキテクチャ決定のドキュメント化

### Non-Goals

- 認証・認可機能の実装（設計指針のみ定義）
- 具体的なビジネス機能（本棚、書籍等）の実装
- 本番環境へのデプロイ構成
- CI/CD パイプラインの実装（テスト実行方法の定義のみ）

## Architecture

### Existing Architecture Analysis

現在の `apps/api` は最小構成:
- Express + Apollo Server v5
- インライン SDL でのスキーマ定義
- 単一ファイル構成（`src/index.ts`）
- Vite によるビルド、vite-node による開発時実行

この構成を維持しつつ、Code-first スキーマ、ORM、構造化ロギングを段階的に導入する。

### Architecture Pattern & Boundary Map

```mermaid
graph TB
    subgraph Client
        Mobile[Mobile App]
        Web[Web App]
    end

    subgraph API["apps/api"]
        Express[Express Server]
        Apollo[Apollo Server]

        subgraph Features
            FeatureA[Feature A]
            FeatureB[Feature B]
        end

        subgraph Core
            Schema[Pothos Schema Builder]
            DB[Drizzle ORM]
            Logger[Pino Logger]
            ErrorHandler[Error Handler]
        end
    end

    subgraph Infrastructure
        PostgreSQL[(PostgreSQL)]
    end

    Mobile --> Apollo
    Web --> Apollo
    Express --> Apollo
    Apollo --> Schema
    Schema --> Features
    Features --> DB
    Features --> Logger
    Features --> ErrorHandler
    DB --> PostgreSQL
```

**Architecture Integration**:

- **Selected pattern**: Feature-based Modular + Clean Architecture 原則の軽量適用
- **Domain/feature boundaries**: 各機能は独立した features ディレクトリで管理、共通コンポーネントは core 層に配置
- **Existing patterns preserved**: Express + Apollo Server の統合、Vite ビルドシステム
- **New components rationale**:
  - Pothos: 型安全な Code-first GraphQL スキーマ構築
  - Drizzle: 高パフォーマンスな型安全 ORM
  - Pino: 高速な構造化ロギング
- **Steering compliance**: Biome による lint/format、Vitest によるテスト

### Technology Stack

| Layer | Choice / Version | Role in Feature | Notes |
|-------|------------------|-----------------|-------|
| Runtime | Node.js 24+ | サーバー実行環境 | Vite 設定で target: node24 |
| Web Framework | Express 4.x | HTTP サーバー | 既存構成を維持 |
| GraphQL Server | Apollo Server 5.x | GraphQL エンドポイント | 既存構成を維持 |
| Schema Builder | Pothos 4.x | Code-first スキーマ定義 | 型安全、プラグイン拡張可能 |
| ORM | Drizzle ORM | データベースアクセス | 高パフォーマンス、TypeScript 型同期 |
| Database | PostgreSQL 16+ | データ永続化 | Docker Compose でローカル環境提供 |
| Logger | Pino 9.x | 構造化ロギング | JSON 出力、高パフォーマンス |
| Build Tool | Vite 7.x | ビルド・開発サーバー | 既存構成を維持 |
| Test Framework | Vitest 4.x | ユニット・統合テスト | 既存構成を維持 |
| Authentication | Firebase Auth | 認証基盤（IDaaS） | Email/Password + メール確認、GCP 統合 |

詳細な技術比較は `research.md` を参照。

## System Flows

### GraphQL Request Flow

```mermaid
sequenceDiagram
    participant Client
    participant Express
    participant Apollo
    participant Resolver
    participant Service
    participant Drizzle
    participant PostgreSQL

    Client->>Express: HTTP POST /graphql
    Express->>Apollo: GraphQL Request
    Apollo->>Resolver: Execute Query/Mutation
    Resolver->>Service: Business Logic
    Service->>Drizzle: Database Query
    Drizzle->>PostgreSQL: SQL Query
    PostgreSQL-->>Drizzle: Result Set
    Drizzle-->>Service: Typed Data
    Service-->>Resolver: Domain Result
    Resolver-->>Apollo: GraphQL Response
    Apollo-->>Express: JSON Response
    Express-->>Client: HTTP Response
```

**Key Decisions**:
- Resolver は薄く保ち、ビジネスロジックは Service 層に集約
- Service 層でドメインエラーを Result 型で表現
- Drizzle が型安全なデータアクセスを提供

### Error Handling Flow

```mermaid
flowchart TD
    A[Resolver Execution] --> B{Error Type?}
    B -->|Domain Error| C[Return Result Type]
    B -->|Validation Error| D[GraphQL UserInputError]
    B -->|Technical Error| E[Log with Pino]
    E --> F[formatError Hook]
    F --> G{Environment?}
    G -->|Development| H[Detailed Error Response]
    G -->|Production| I[Masked Error Response]
    C --> J[Client Handles Result]
    D --> J
    H --> J
    I --> J
```

## Requirements Traceability

| Requirement | Summary | Components | Interfaces | Flows |
|-------------|---------|------------|------------|-------|
| 1.1, 1.2, 1.3 | GraphQL ライブラリ選定、Code-first アプローチ | SchemaBuilder | SchemaBuilderService | GraphQL Request |
| 1.4 | Express 互換性確認 | Express Server | - | GraphQL Request |
| 1.5 | GraphQL Playground | Apollo Server Config | - | - |
| 2.1, 2.2, 2.3, 2.4, 2.5 | PostgreSQL 接続構成 | DatabaseConnection | DatabaseService | - |
| 3.1, 3.2, 3.3, 3.4, 3.5 | ORM 選定（Drizzle） | DrizzleClient, Schema | RepositoryInterface | GraphQL Request |
| 4.1, 4.2, 4.3, 4.4, 4.5, 4.6 | ディレクトリ構成 | Feature Modules | FeatureInterface | - |
| 5.1, 5.2, 5.3, 5.4, 5.5, 5.6 | マイグレーション戦略 | DrizzleKit Config | MigrationService | - |
| 6.1, 6.2, 6.3, 6.4, 6.5, 6.6 | 開発環境構成 | Docker Compose, Config | - | - |
| 7.1, 7.2, 7.3, 7.4, 7.5 | エラーハンドリング・ロギング | ErrorHandler, Logger | LoggerService, ErrorService | Error Handling |
| 8.1, 8.2, 8.3, 8.4, 8.5 | セキュリティ基盤 | SecurityConfig | - | - |
| 9.1, 9.2, 9.3, 9.4, 9.5, 9.6 | ドキュメント成果物 | Documentation | - | - |

## Components and Interfaces

### Component Summary

| Component | Domain/Layer | Intent | Req Coverage | Key Dependencies | Contracts |
|-----------|--------------|--------|--------------|------------------|-----------|
| SchemaBuilder | Core/GraphQL | Pothos によるスキーマ構築 | 1.1-1.5 | Pothos (P0) | Service |
| DatabaseConnection | Core/Data | PostgreSQL 接続管理 | 2.1-2.5 | pg Pool (P0) | Service |
| DrizzleClient | Core/Data | ORM クライアント | 3.1-3.5 | Drizzle (P0) | Service |
| Logger | Core/Infrastructure | 構造化ロギング | 7.2-7.5 | Pino (P0) | Service |
| ErrorHandler | Core/Infrastructure | エラー処理 | 7.1, 7.4 | Apollo Server (P0) | Service |
| FeatureModule | Feature/Template | 機能モジュールテンプレート | 4.1-4.6 | Core components (P1) | Service |
| ConfigManager | Core/Infrastructure | 環境変数管理 | 2.3, 6.2, 8.5 | - | Service |

### Core Layer

#### SchemaBuilder

| Field | Detail |
|-------|--------|
| Intent | Pothos を使用した Code-first GraphQL スキーマの構築と管理 |
| Requirements | 1.1, 1.2, 1.3, 1.4, 1.5 |

**Responsibilities & Constraints**
- Pothos SchemaBuilder インスタンスの初期化と設定
- 各 Feature の型定義を統合してスキーマを構築
- プラグイン（validation, dataloader 等）の管理
- Apollo Server に標準 GraphQL スキーマを提供

**Dependencies**
- External: @pothos/core - スキーマビルダー (P0)
- External: graphql - GraphQL コアライブラリ (P0)
- Outbound: Feature resolvers - 各機能の型・リゾルバー定義 (P1)

**Contracts**: Service [x]

##### Service Interface

```typescript
import SchemaBuilder from "@pothos/core";

interface SchemaBuilderConfig {
  plugins: PothosPlugin[];
  defaultFieldNullability: boolean;
}

interface SchemaBuilderService {
  getBuilder(): SchemaBuilder<SchemaTypes>;
  buildSchema(): GraphQLSchema;
  registerFeatureTypes(feature: FeatureTypeDefinition): void;
}

type SchemaTypes = {
  Context: GraphQLContext;
  Scalars: {
    DateTime: {
      Input: Date;
      Output: Date;
    };
  };
};
```

- Preconditions: 全 Feature の型定義が登録済み
- Postconditions: 有効な GraphQL スキーマが生成される
- Invariants: スキーマは TypeScript 型と常に同期

**Implementation Notes**
- Integration: Apollo Server の schema オプションに buildSchema() の結果を渡す
- Validation: Pothos の型システムにより静的検証
- Risks: Feature 追加時のスキーマ競合

#### DatabaseConnection

| Field | Detail |
|-------|--------|
| Intent | PostgreSQL への接続管理とコネクションプーリング |
| Requirements | 2.1, 2.2, 2.3, 2.4, 2.5 |

**Responsibilities & Constraints**
- pg Pool によるコネクションプーリング管理
- 接続文字列の環境変数からの読み込み
- 接続エラー時のリトライとエラーメッセージ
- Graceful shutdown 時の接続クローズ

**Dependencies**
- External: pg - PostgreSQL クライアント (P0)
- Inbound: DrizzleClient - ORM クライアントが接続を使用 (P0)

**Contracts**: Service [x]

##### Service Interface

```typescript
import { Pool, PoolConfig } from "pg";

interface DatabaseConfig {
  connectionString: string;
  max: number;
  idleTimeoutMillis: number;
  connectionTimeoutMillis: number;
}

interface DatabaseService {
  getPool(): Pool;
  connect(): Promise<void>;
  disconnect(): Promise<void>;
  healthCheck(): Promise<boolean>;
}

interface ConnectionError {
  code: "CONNECTION_FAILED" | "TIMEOUT" | "POOL_EXHAUSTED";
  message: string;
  retryable: boolean;
}
```

- Preconditions: DATABASE_URL 環境変数が設定済み
- Postconditions: 有効なコネクションプールが利用可能
- Invariants: max 接続数を超えない

**Implementation Notes**
- Integration: 環境変数 DATABASE_URL から接続文字列を取得
- Validation: 接続時に healthCheck() を実行
- Risks: コネクション枯渇時の待機キュー管理

#### DrizzleClient

| Field | Detail |
|-------|--------|
| Intent | Drizzle ORM による型安全なデータベースアクセス |
| Requirements | 3.1, 3.2, 3.3, 3.4, 3.5 |

**Responsibilities & Constraints**
- Drizzle ORM インスタンスの初期化
- スキーマ定義のロードと型生成
- トランザクション管理
- Raw SQL クエリのサポート

**Dependencies**
- External: drizzle-orm - ORM ライブラリ (P0)
- Inbound: DatabaseConnection - pg Pool の提供 (P0)
- Outbound: Feature repositories - データアクセス層 (P1)

**Contracts**: Service [x]

##### Service Interface

```typescript
import { drizzle, NodePgDatabase } from "drizzle-orm/node-postgres";
import { Pool } from "pg";

type DrizzleDatabase = NodePgDatabase<typeof schema>;

interface DrizzleService {
  getDb(): DrizzleDatabase;
  transaction<T>(
    callback: (tx: DrizzleDatabase) => Promise<T>
  ): Promise<T>;
  rawQuery<T>(sql: string, params?: unknown[]): Promise<T[]>;
}

interface QueryError {
  code: "QUERY_FAILED" | "CONSTRAINT_VIOLATION" | "TRANSACTION_FAILED";
  message: string;
  detail?: string;
}
```

- Preconditions: DatabaseConnection が初期化済み
- Postconditions: 型安全なクエリ結果を返却
- Invariants: トランザクション内の一貫性を保証

**Implementation Notes**
- Integration: Pool インスタンスを drizzle() に渡して初期化
- Validation: Drizzle の型システムによる静的検証
- Risks: 複雑なクエリでの型推論の限界

#### Logger

| Field | Detail |
|-------|--------|
| Intent | Pino による高パフォーマンス構造化ロギング |
| Requirements | 7.2, 7.3, 7.5 |

**Responsibilities & Constraints**
- ログレベル（debug, info, warn, error）の管理
- JSON 構造化フォーマットでの出力
- リクエストコンテキストの付与
- 開発環境での整形出力（pino-pretty）

**Dependencies**
- External: pino - ロギングライブラリ (P0)
- External: pino-pretty - 開発用整形出力 (P2)

**Contracts**: Service [x]

##### Service Interface

```typescript
import pino, { Logger as PinoLogger } from "pino";

type LogLevel = "debug" | "info" | "warn" | "error";

interface LogContext {
  requestId?: string;
  userId?: string;
  feature?: string;
  [key: string]: unknown;
}

interface LoggerService {
  debug(message: string, context?: LogContext): void;
  info(message: string, context?: LogContext): void;
  warn(message: string, context?: LogContext): void;
  error(message: string, error?: Error, context?: LogContext): void;
  child(bindings: LogContext): LoggerService;
}

interface LoggerConfig {
  level: LogLevel;
  prettyPrint: boolean;
}
```

- Preconditions: LOG_LEVEL 環境変数が設定済み（デフォルト: info）
- Postconditions: 構造化されたログが出力される
- Invariants: 本番環境では JSON 形式、開発環境では整形出力

**Implementation Notes**
- Integration: Express middleware で requestId を付与
- Validation: ログレベルの妥当性チェック
- Risks: 高ボリューム時のパフォーマンス影響（Pino の非同期処理で軽減）

#### ErrorHandler

| Field | Detail |
|-------|--------|
| Intent | GraphQL エラーの標準フォーマット化とマスキング |
| Requirements | 7.1, 7.4 |

**Responsibilities & Constraints**
- GraphQL エラーの標準フォーマット定義
- 本番環境でのスタックトレースマスキング
- エラーカテゴリ別の処理（User/System/Business）
- formatError フックの実装

**Dependencies**
- External: @apollo/server - エラー型定義 (P0)
- Inbound: Logger - エラーログ出力 (P1)

**Contracts**: Service [x]

##### Service Interface

```typescript
import { GraphQLFormattedError } from "graphql";
import { ApolloServerErrorCode } from "@apollo/server/errors";

type ErrorCategory = "USER_ERROR" | "SYSTEM_ERROR" | "BUSINESS_ERROR";

interface AppError {
  code: string;
  message: string;
  category: ErrorCategory;
  extensions?: Record<string, unknown>;
}

interface ErrorHandlerService {
  formatError(
    formattedError: GraphQLFormattedError,
    error: unknown
  ): GraphQLFormattedError;
  createUserError(code: string, message: string): AppError;
  createSystemError(code: string, message: string, cause?: Error): AppError;
  createBusinessError(code: string, message: string): AppError;
}

interface FormattedErrorResponse {
  message: string;
  extensions: {
    code: string;
    category: ErrorCategory;
    timestamp: string;
    requestId?: string;
  };
}
```

- Preconditions: Logger が初期化済み
- Postconditions: クライアントに安全なエラー情報のみ返却
- Invariants: 本番環境でスタックトレースは非公開

**Implementation Notes**
- Integration: Apollo Server の formatError オプションに設定
- Validation: エラーコードの一意性
- Risks: 過度なマスキングによるデバッグ困難

#### ConfigManager

| Field | Detail |
|-------|--------|
| Intent | 環境変数の一元管理と型安全なアクセス |
| Requirements | 2.3, 6.2, 8.5 |

**Responsibilities & Constraints**
- 環境変数の読み込みとバリデーション
- 必須変数の存在チェック
- デフォルト値の提供
- 機密情報の安全な管理

**Dependencies**
- External: dotenv - .env ファイル読み込み (P2)

**Contracts**: Service [x]

##### Service Interface

```typescript
interface DatabaseEnvConfig {
  DATABASE_URL: string;
  DB_POOL_MAX?: number;
  DB_IDLE_TIMEOUT_MS?: number;
}

interface ServerEnvConfig {
  PORT?: number;
  NODE_ENV: "development" | "production" | "test";
  LOG_LEVEL?: "debug" | "info" | "warn" | "error";
}

interface SecurityEnvConfig {
  CORS_ORIGIN?: string;
  RATE_LIMIT_MAX?: number;
  FIREBASE_PROJECT_ID: string;
  FIREBASE_CLIENT_EMAIL?: string;
  FIREBASE_PRIVATE_KEY?: string;
}

type AppConfig = DatabaseEnvConfig & ServerEnvConfig & SecurityEnvConfig;

interface ConfigService {
  get<K extends keyof AppConfig>(key: K): AppConfig[K];
  getOrDefault<K extends keyof AppConfig>(
    key: K,
    defaultValue: NonNullable<AppConfig[K]>
  ): NonNullable<AppConfig[K]>;
  validate(): void;
  isDevelopment(): boolean;
  isProduction(): boolean;
}

interface ConfigError {
  code: "MISSING_REQUIRED" | "INVALID_VALUE";
  key: string;
  message: string;
}
```

- Preconditions: .env ファイルまたは環境変数が設定済み
- Postconditions: 型安全な設定値を提供
- Invariants: 必須変数が欠落時はアプリケーション起動を停止

**Implementation Notes**
- Integration: アプリケーション起動時に validate() を実行
- Validation: 型と値域のチェック
- Risks: 機密情報のログ出力防止

### Feature Layer (Template)

#### FeatureModule

| Field | Detail |
|-------|--------|
| Intent | 機能単位のモジュール構成テンプレート |
| Requirements | 4.1, 4.2, 4.3, 4.4, 4.5, 4.6 |

**Responsibilities & Constraints**
- Feature 内の resolver/service/repository レイヤー分離
- Feature 固有の型定義
- 他 Feature との明示的なインターフェース
- 共通コンポーネントへの依存管理

**Dependencies**
- Inbound: SchemaBuilder - 型定義の登録 (P0)
- Inbound: DrizzleClient - データアクセス (P0)
- Inbound: Logger - ロギング (P1)
- Outbound: Other Features - 公開インターフェース経由 (P1)

**Contracts**: Service [x]

##### Service Interface

```typescript
// Feature は Barrel Export パターンで公開 API を定義
// features/[name]/index.ts
export type { Entity } from "./internal/repository.js";
export type { EntityService } from "./internal/service.js";
export { createEntityRepository } from "./internal/repository.js";
export { createEntityService } from "./internal/service.js";
export { registerEntityTypes } from "./internal/graphql.js";

// internal/service.ts - インターフェースと実装を同一ファイルに定義
export interface FeatureService<TInput, TOutput> {
  execute(input: TInput): Promise<Result<TOutput, DomainError>>;
}

// internal/repository.ts - インターフェースと実装を同一ファイルに定義
export interface FeatureRepository<TEntity, TId> {
  findById(id: TId): Promise<TEntity | null>;
  findMany(filter: Partial<TEntity>): Promise<TEntity[]>;
  create(entity: Omit<TEntity, "id">): Promise<TEntity>;
  update(id: TId, data: Partial<TEntity>): Promise<TEntity>;
  delete(id: TId): Promise<void>;
}

// Result 型パターン
type Result<T, E> =
  | { success: true; data: T }
  | { success: false; error: E };

interface DomainError {
  code: string;
  message: string;
}
```

- Preconditions: Core コンポーネントが初期化済み
- Postconditions: Feature の型がスキーマに登録される
- Invariants: Feature 間は公開 API（index.ts）経由のみでアクセス可能

**Implementation Notes**
- Integration: 各 Feature は index.ts で公開 API を Barrel Export
- Validation: 循環依存の静的チェック
- Risks: 公開 API の過度な肥大化

## Data Models

### Domain Model

本設計ではデータモデルの具体的な定義は行わず、Drizzle ORM でのスキーマ定義パターンを確立する。

**Schema Definition Pattern**:

```typescript
// apps/api/src/db/schema/example.ts
import { pgTable, text, timestamp, integer } from "drizzle-orm/pg-core";

export const examples = pgTable("examples", {
  id: integer("id").primaryKey().generatedAlwaysAsIdentity(),
  name: text("name").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

// 型の自動推論
export type Example = typeof examples.$inferSelect;
export type NewExample = typeof examples.$inferInsert;
```

**Aggregates and Boundaries**:
- 各 Feature が独自のテーブル群を管理
- Feature 間の参照は外部キーではなく ID 参照を推奨
- 複雑な集約は Feature 内で完結

### Logical Data Model

**Structure Definition**:
- Identity columns（generatedAlwaysAsIdentity）を主キーに使用
- timestamp 型で created_at, updated_at を標準装備
- 文字列長の制約は text（無制限）または varchar（制限付き）で明示

**Consistency & Integrity**:
- トランザクション境界は Service 層で管理
- Drizzle の transaction() メソッドで ACID を保証
- 楽観的ロック用の version カラムはオプション

### Physical Data Model

**Migration Strategy**:

```typescript
// drizzle.config.ts
import { defineConfig } from "drizzle-kit";

export default defineConfig({
  schema: "./src/db/schema/index.ts",
  out: "./drizzle/migrations",
  dialect: "postgresql",
  dbCredentials: {
    url: process.env.DATABASE_URL!,
  },
});
```

**Migration Commands**:
- `pnpm drizzle-kit generate` - マイグレーションファイル生成
- `pnpm drizzle-kit migrate` - マイグレーション実行
- `pnpm drizzle-kit push` - 開発時のスキーマ同期

**Index Strategy**:
- 主キーには自動でインデックス
- 検索条件となるカラムには明示的にインデックス定義
- 複合インデックスは実際のクエリパターンに基づいて追加

## Error Handling

### Error Strategy

**GraphQL Error Standard Format**:

```typescript
interface GraphQLErrorResponse {
  message: string;
  locations?: ReadonlyArray<{ line: number; column: number }>;
  path?: ReadonlyArray<string | number>;
  extensions: {
    code: string;
    category: "USER_ERROR" | "SYSTEM_ERROR" | "BUSINESS_ERROR";
    timestamp: string;
    requestId?: string;
  };
}
```

### Error Categories and Responses

**User Errors (4xx equivalent)**:
- `BAD_USER_INPUT`: 入力バリデーションエラー - フィールド単位でエラー詳細を返却
- `UNAUTHENTICATED`: 認証エラー - 再認証を促すメッセージ
- `FORBIDDEN`: 認可エラー - 権限不足の説明

**System Errors (5xx equivalent)**:
- `INTERNAL_SERVER_ERROR`: 予期しないエラー - 本番ではマスク、開発では詳細表示
- `DATABASE_ERROR`: DB 接続/クエリエラー - リトライ可能性を示唆

**Business Logic Errors (422 equivalent)**:
- ドメイン固有のエラーコード - Result 型で表現し、クライアントが分岐処理可能

### Monitoring

- Pino でエラーログを構造化出力
- requestId でリクエストトレーシング
- エラー率のメトリクス収集（将来の OpenTelemetry 統合に備え）

## Testing Strategy

### Unit Tests

- SchemaBuilder: スキーマ生成の正常性
- ConfigManager: 環境変数のバリデーション
- ErrorHandler: エラーフォーマットの正確性
- Logger: ログ出力フォーマットの検証

### Integration Tests

- DatabaseConnection: PostgreSQL への接続・切断
- DrizzleClient: CRUD 操作のトランザクション
- GraphQL Resolver: エンドツーエンドのクエリ実行
- Feature Module: 複数コンポーネントの連携

### Test Database Strategy

```typescript
// vitest.config.ts での設定
export default defineConfig({
  test: {
    globalSetup: "./test/setup.ts",
    environmentOptions: {
      DATABASE_URL: "postgres://test:test@localhost:5433/shelfie_test",
    },
  },
});
```

- テスト用 PostgreSQL は Docker Compose で別ポート（5433）に起動
- 各テストスイート前にマイグレーション実行
- テスト後にトランザクションロールバックでデータクリーンアップ

## Security Considerations

### 認証基盤（Firebase Auth）

**選定理由**:
- IDaaS 採用によりセキュリティリスクを軽減（自前実装を回避）
- GCP インフラとの親和性が高い
- 無料枠が大きい（50,000 MAU）
- Email/Password + メール確認フローを標準サポート

**認証フロー**:
1. クライアント（Mobile/Web）で Firebase Auth SDK を使用してログイン
2. Firebase から ID Token（JWT）を取得
3. GraphQL リクエストの Authorization ヘッダーに ID Token を付与
4. API サーバーで firebase-admin SDK を使用して ID Token を検証
5. 検証済みユーザー情報を GraphQL Context に注入

**API サーバー側の実装**:
```typescript
// GraphQL Context に認証情報を注入
interface GraphQLContext {
  user: DecodedIdToken | null;
  requestId: string;
}

// firebase-admin で ID Token を検証
const verifyToken = async (token: string): Promise<DecodedIdToken | null> => {
  try {
    return await admin.auth().verifyIdToken(token);
  } catch {
    return null;
  }
};
```

**認可の設計指針**:
- Pothos の auth plugin で宣言的な認可
- ロールベースアクセス制御（RBAC）パターン
- Context.user の存在チェックで認証状態を判定

### GraphQL セキュリティ

- **Query Depth Limiting**: 深度制限でネストクエリを防止
- **Query Cost Analysis**: コスト分析でリソース消費を制御
- **Rate Limiting**: IP ベースのレート制限（将来実装）

### CORS 設定

```typescript
const corsOptions = {
  origin: config.get("CORS_ORIGIN") || "http://localhost:3000",
  credentials: true,
};
```

### 機密情報管理

- 環境変数で管理、コードにハードコードしない
- .env.example でテンプレート提供
- ConfigManager で起動時に必須変数をチェック

## Performance & Scalability

### Target Metrics

- GraphQL クエリ応答時間: p95 < 100ms（単純クエリ）
- コネクションプール: max 20（スケールに応じて調整）
- コールドスタート: < 500ms（Drizzle の軽量性を活用）

### Caching Strategy

- DataLoader パターンで N+1 問題を解決
- Pothos dataloader plugin の活用
- 将来的に Redis キャッシュ層を追加可能な設計

## Directory Structure

```
apps/api/
├── src/
│   ├── index.ts                 # エントリーポイント
│   ├── server.ts                # Express/Apollo 設定
│   ├── config/
│   │   └── index.ts             # ConfigManager
│   ├── db/
│   │   ├── client.ts            # Drizzle クライアント
│   │   ├── connection.ts        # pg Pool
│   │   └── schema/
│   │       └── index.ts         # スキーマ集約
│   ├── graphql/
│   │   ├── builder.ts           # Pothos SchemaBuilder
│   │   ├── schema.ts            # スキーマ構築
│   │   └── context.ts           # GraphQL Context 型
│   ├── logger/
│   │   └── index.ts             # Pino ラッパー
│   ├── errors/
│   │   ├── index.ts             # ErrorHandler
│   │   └── result.ts            # Result 型ユーティリティ
│   └── features/
│       └── [feature-name]/
│           ├── index.ts         # 公開 API（Barrel Export）
│           └── internal/        # 内部実装
│               ├── graphql.ts   # Pothos 型定義・Resolver
│               ├── service.ts   # ビジネスロジック + インターフェース
│               └── repository.ts # データアクセス + インターフェース
├── drizzle/
│   └── migrations/              # マイグレーションファイル
├── drizzle.config.ts            # Drizzle Kit 設定
├── docker-compose.yml           # ローカル開発用 DB
└── .env.example                 # 環境変数テンプレート
```

## Documentation Outputs

### 成果物一覧（要件 9 対応）

| Document | Location | Purpose |
|----------|----------|---------|
| API Architecture Guide | `docs/api-architecture.md` | 技術選定の決定と理由 |
| Directory Structure Guide | `docs/api-directory-structure.md` | ディレクトリ構成ガイドライン |
| tech.md | `.kiro/steering/tech.md` | API 技術スタック情報 |
| structure.md | `.kiro/steering/structure.md` | apps/api ディレクトリ構成 |

### ドキュメント更新フロー

1. アーキテクチャ決定時に開発者ドキュメント（`docs/`）を更新
2. steering ドキュメント（`.kiro/steering/`）に反映
3. 整合性チェック: 両ドキュメントの技術スタック・構成が一致することを確認

# API ディレクトリ構成ガイド

本ドキュメントでは、Shelfie API（`apps/api`）のディレクトリ構成と新機能追加時のガイドラインを説明する。

## ディレクトリ構成

```
apps/api/
├── src/
│   ├── index.ts                 # エントリーポイント
│   ├── config/
│   │   └── index.ts             # ConfigManager（環境変数管理）
│   ├── db/
│   │   ├── client.ts            # Drizzle クライアント
│   │   ├── connection.ts        # pg Pool（コネクションプーリング）
│   │   ├── index.ts             # DB モジュール export
│   │   ├── seed.ts              # シードデータ
│   │   ├── test-utils.ts        # テスト用ユーティリティ
│   │   └── schema/
│   │       ├── index.ts         # スキーマ集約
│   │       └── users.ts         # users テーブル定義
│   ├── graphql/
│   │   ├── builder.ts           # Pothos SchemaBuilder
│   │   ├── schema.ts            # スキーマ構築（Feature 統合）
│   │   ├── context.ts           # GraphQL Context 型
│   │   ├── server.ts            # Apollo Server / Express 設定
│   │   └── index.ts             # GraphQL モジュール export
│   ├── auth/
│   │   ├── firebase.ts          # Firebase Admin 初期化
│   │   ├── middleware.ts        # 認証ミドルウェア
│   │   ├── scope.ts             # authScope パターン
│   │   └── index.ts             # Auth モジュール export
│   ├── security/
│   │   ├── graphql-security.ts  # クエリ深度制限
│   │   ├── cors.ts              # CORS 設定
│   │   └── index.ts             # Security モジュール export
│   ├── logger/
│   │   └── index.ts             # Pino ロガー
│   ├── errors/
│   │   ├── index.ts             # ErrorHandler
│   │   └── result.ts            # Result 型ユーティリティ
│   ├── features/
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
│   └── __tests__/
│       ├── setup.test.ts        # テストセットアップ検証
│       └── integration/         # 統合テスト
│           ├── database-connection.test.ts
│           ├── drizzle-client.test.ts
│           └── graphql-resolver.test.ts
├── drizzle/
│   └── migrations/              # マイグレーションファイル
├── drizzle.config.ts            # Drizzle Kit 設定
└── .env.example                 # 環境変数テンプレート
```

## 各ディレクトリの責務

### `src/config/`

環境変数の一元管理。起動時のバリデーション機能を提供。

```typescript
import { config } from "./config";

const dbUrl = config.get("DATABASE_URL");
const port = config.getOrDefault("PORT", 4000);

if (config.isDevelopment()) {
  // 開発環境固有の処理
}
```

### `src/db/`

データベース接続とスキーマ定義。

- `connection.ts`: pg Pool によるコネクションプーリング
- `client.ts`: Drizzle ORM クライアント
- `schema/`: テーブル定義（Feature ごとにファイル分割可）

### `src/graphql/`

GraphQL サーバーの設定と Pothos スキーマビルダー。

- `builder.ts`: SchemaBuilder インスタンス（各 Feature で共有）
- `schema.ts`: 全 Feature の型定義を統合してスキーマを構築
- `context.ts`: GraphQL Context 型定義
- `server.ts`: Apollo Server と Express の設定

### `src/auth/`

Firebase Auth による認証機能。

- `firebase.ts`: firebase-admin SDK の初期化
- `middleware.ts`: Authorization ヘッダーから ID Token を検証
- `scope.ts`: 認証が必要な Resolver のための authScope パターン

### `src/security/`

セキュリティ関連の設定。

- `graphql-security.ts`: クエリ深度制限
- `cors.ts`: CORS ポリシー

### `src/logger/`

Pino による構造化ロギング。

```typescript
import { logger } from "./logger";

logger.info("Server started", { port: 4000 });
logger.error("Failed to connect", error, { feature: "db" });
```

### `src/errors/`

エラーハンドリングと Result 型。

- `index.ts`: ErrorHandler（GraphQL エラーのフォーマット）
- `result.ts`: Result 型ユーティリティ（ok, err, mapResult 等）

### `src/features/`

Feature-based モジュール構成。Barrel Export パターンで公開 API を管理。

- `[feature-name]/index.ts`: 公開 API の re-export
- `[feature-name]/internal/`: 内部実装（慣習による隔離）
  - `graphql.ts`: GraphQL 型定義・Resolver
  - `service.ts`: ビジネスロジック + インターフェース
  - `repository.ts`: データアクセス + インターフェース

## 新機能追加ガイドライン

### 1. Feature ディレクトリの作成

```bash
mkdir -p src/features/books/internal
```

### 2. 必要なファイルの作成

```
src/features/books/
├── index.ts              # 公開 API（Barrel Export）
└── internal/
    ├── graphql.ts        # Pothos 型定義・Resolver
    ├── service.ts        # ビジネスロジック + インターフェース
    └── repository.ts     # データアクセス + インターフェース
```

### 3. スキーマ定義（テーブルが必要な場合）

`src/db/schema/books.ts`:

```typescript
import { integer, pgTable, text, timestamp } from "drizzle-orm/pg-core";

export const books = pgTable("books", {
  id: integer("id").primaryKey().generatedAlwaysAsIdentity(),
  title: text("title").notNull(),
  isbn: text("isbn"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export type Book = typeof books.$inferSelect;
export type NewBook = typeof books.$inferInsert;
```

`src/db/schema/index.ts` に追加:

```typescript
export * from "./users";
export * from "./books";
```

### 4. Repository の実装

`src/features/books/internal/repository.ts`:

```typescript
import { eq } from "drizzle-orm";
import type { NodePgDatabase } from "drizzle-orm/node-postgres";
import { books, type Book, type NewBook } from "../../../db/schema";

export type { Book, NewBook } from "../../../db/schema/books.js";

export interface BookRepository {
  findById(id: number): Promise<Book | null>;
  findMany(): Promise<Book[]>;
  create(data: NewBook): Promise<Book>;
}

export function createBookRepository(db: NodePgDatabase): BookRepository {
  return {
    async findById(id: number): Promise<Book | null> {
      const result = await db.select().from(books).where(eq(books.id, id));
      return result[0] ?? null;
    },

    async findMany(): Promise<Book[]> {
      return db.select().from(books);
    },

    async create(data: NewBook): Promise<Book> {
      const result = await db.insert(books).values(data).returning();
      return result[0];
    },
  };
}
```

### 5. Service の実装

`src/features/books/internal/service.ts`:

```typescript
import { ok, err, type Result, type DomainError } from "../../../errors/result.js";
import type { Book, NewBook } from "./repository.js";
import type { BookRepository } from "./repository.js";

export type BookServiceError =
  | { code: "BOOK_NOT_FOUND"; message: string };

export interface BookService {
  getBook(id: number): Promise<Result<Book, BookServiceError>>;
  createBook(data: NewBook): Promise<Result<Book, DomainError>>;
}

export function createBookService(repository: BookRepository): BookService {
  return {
    async getBook(id: number): Promise<Result<Book, BookServiceError>> {
      const book = await repository.findById(id);
      if (!book) {
        return err({ code: "BOOK_NOT_FOUND", message: "Book not found" });
      }
      return ok(book);
    },

    async createBook(data: NewBook): Promise<Result<Book, DomainError>> {
      const book = await repository.create(data);
      return ok(book);
    },
  };
}
```

### 6. GraphQL 型定義

`src/features/books/internal/graphql.ts`:

```typescript
import type { Book } from "../../../db/schema/books.js";
import type { Builder } from "../../../graphql/builder.js";

let BookRef: ReturnType<Builder["objectRef"]<Book>> | null = null;

export { BookRef };

export function registerBookTypes(builder: Builder): void {
  BookRef = builder.objectRef<Book>("Book");

  BookRef.implement({
    fields: (t) => ({
      id: t.exposeInt("id"),
      title: t.exposeString("title"),
      isbn: t.exposeString("isbn", { nullable: true }),
    }),
  });
}

export function registerBookQueries(builder: Builder, service: BookService): void {
  builder.queryFields((t) => ({
    book: t.field({
      type: BookRef,
      nullable: true,
      args: {
        id: t.arg.int({ required: true }),
      },
      resolve: async (_parent, { id }) => {
        const result = await service.getBook(id);
        return result.success ? result.data : null;
      },
    }),
  }));
}
```

### 7. 公開 API の定義（Barrel Export）

`src/features/books/index.ts`:

```typescript
// 型の re-export（公開 API）
export type { Book, NewBook } from "./internal/repository.js";
export type { BookService } from "./internal/service.js";

// ファクトリ関数の re-export
export { createBookRepository } from "./internal/repository.js";
export { createBookService } from "./internal/service.js";
export { registerBookTypes, registerBookQueries } from "./internal/graphql.js";
```

### 8. GraphQL スキーマへの登録

`src/graphql/schema.ts` に追加:

```typescript
import { registerBookTypes, registerBookQueries } from "../features/books";

// 型の登録
registerBookTypes(builder);

// クエリの登録（Service を渡す）
registerBookQueries(builder, bookService);
```

### 9. マイグレーションの生成と適用

```bash
pnpm --filter @shelfie/api db:generate
pnpm --filter @shelfie/api db:migrate
```

## Feature 間依存ルール

### 禁止事項

- 他 Feature の `internal/` への直接インポート
- 循環依存

### 許可される依存

- 共通モジュール（`config`, `db`, `errors`, `logger`）への依存
- 他 Feature の公開 API（`index.ts` からの export）への依存

```typescript
// OK: 公開 API 経由でアクセス
import { createUserService, type UserService } from "../users";

// NG: internal への直接インポート
import { createUserService } from "../users/internal/service";
```

## テストの配置

### ユニットテスト

`internal/` 配下に実装ファイルと同じディレクトリに配置:

```
src/features/books/
├── index.ts              # 公開 API
├── index.test.ts         # 公開 API のテスト
└── internal/
    ├── graphql.ts
    ├── graphql.test.ts   # GraphQL 型のテスト
    ├── service.ts
    ├── service.test.ts   # service のユニットテスト
    ├── repository.ts
    └── repository.test.ts  # repository のユニットテスト
```

### 統合テスト

`src/__tests__/integration/` に配置:

```
src/__tests__/integration/
├── database-connection.test.ts
├── drizzle-client.test.ts
└── graphql-resolver.test.ts
```

## 環境変数

`.env.example` をコピーして `.env` を作成:

```bash
cp .env.example .env
```

必須環境変数:

| Variable | Description | Required |
|----------|-------------|----------|
| DATABASE_URL | PostgreSQL 接続 URL | Yes |
| NODE_ENV | 実行環境（development/production/test） | Yes |
| PORT | サーバーポート（デフォルト: 4000） | No |
| LOG_LEVEL | ログレベル（デフォルト: info） | No |
| CORS_ORIGIN | CORS 許可オリジン | No |
| FIREBASE_PROJECT_ID | Firebase プロジェクト ID | Production |

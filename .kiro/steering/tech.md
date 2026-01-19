# Tech Stack

本ドキュメントは、Shelfie プロジェクトの技術スタックを定義する。

## 全体構成

```
shelfie/
├── apps/
│   ├── api/      # GraphQL API サーバー
│   ├── web/      # Web アプリケーション
│   └── mobile/   # モバイルアプリケーション
├── packages/
│   └── shared/   # 共有ユーティリティ
└── infra/
    └── terraform/  # GCP インフラ設定
```

## API（apps/api）

### ランタイム・フレームワーク

| Technology | Version | Purpose |
|------------|---------|---------|
| Node.js | 24+ | サーバーランタイム |
| Express | 4.x | HTTP サーバー |
| Apollo Server | 5.x | GraphQL エンドポイント |
| Pothos | 4.x | Code-first GraphQL スキーマビルダー |

### データベース

| Technology | Version | Purpose |
|------------|---------|---------|
| PostgreSQL | 16+ | プライマリデータベース |
| Drizzle ORM | 0.45+ | 型安全な ORM |
| pg | 8.x | PostgreSQL クライアント |

### 認証

| Technology | Purpose |
|------------|---------|
| Firebase Auth | IDaaS（認証基盤） |
| firebase-admin | サーバーサイド ID Token 検証 |

### インフラ・ユーティリティ

| Technology | Version | Purpose |
|------------|---------|---------|
| Pino | 10.x | 構造化ロギング |
| Vite | 7.x | ビルドツール |
| vite-node | - | 開発時実行 |
| Vitest | 4.x | テストフレームワーク |

### 技術選定の理由

#### Pothos（Code-first GraphQL）

- TypeScript 型から GraphQL スキーマを自動推論
- ランタイムオーバーヘッドゼロ
- プラグインによる拡張性（dataloader, auth, validation）
- Airbnb, Netflix での採用実績

#### Drizzle ORM

- Prisma 比 2-3 倍のクエリ速度
- バンドルサイズ約 7.4KB（Prisma の 85% 小型化）
- コード生成不要、TypeScript 型が常にスキーマと同期
- SQL の透明性が高く、複雑なクエリも対応可能

#### Pino

- JSON 構造化ログがデフォルト
- 非同期ロギングで 5-10 倍高速
- OpenTelemetry ネイティブサポート

## Web（apps/web）

| Technology | Version | Purpose |
|------------|---------|---------|
| Next.js | 14+ | React フレームワーク |
| React | 18+ | UI ライブラリ |
| TypeScript | 5.x | 型システム |

## Mobile（apps/mobile）

| Technology | Version | Purpose |
|------------|---------|---------|
| Flutter | 3.x | クロスプラットフォームフレームワーク |
| Dart | 3.x | プログラミング言語 |

## 共通ツールチェーン

| Tool | Purpose |
|------|---------|
| pnpm | パッケージマネージャー |
| mise | 言語・ツールバージョン管理 |
| Biome | リンター・フォーマッター |
| GitHub Actions | CI/CD |

## 開発コマンド

### API

```bash
pnpm dev:api                    # 開発サーバー起動
pnpm --filter @shelfie/api test # テスト実行
pnpm --filter @shelfie/api db:generate  # マイグレーション生成
pnpm --filter @shelfie/api db:migrate   # マイグレーション実行
pnpm --filter @shelfie/api db:push      # スキーマ同期（開発用）
```

### 全体

```bash
pnpm build      # 全パッケージビルド
pnpm typecheck  # 型チェック
pnpm lint       # Biome lint
pnpm format     # Biome format
pnpm test       # 全テスト実行
```

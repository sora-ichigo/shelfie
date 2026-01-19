# Research & Design Decisions

---
**Purpose**: Capture discovery findings, architectural investigations, and rationale that inform the technical design.

**Usage**:
- Log research activities and outcomes during the discovery phase.
- Document design decision trade-offs that are too detailed for `design.md`.
- Provide references and evidence for future audits or reuse.
---

## Summary
- **Feature**: `api-architecture`
- **Discovery Scope**: New Feature (greenfield) - API アーキテクチャ基盤の確立
- **Key Findings**:
  - Code-first GraphQL (Pothos) が TypeScript エコシステムで最も型安全なアプローチ
  - Drizzle ORM がパフォーマンスと型安全性の両立で優位
  - Feature-based ディレクトリ構成が中〜大規模 API に最適

## Research Log

### GraphQL ライブラリ選定

- **Context**: 要件 1 - GraphQL ライブラリとスキーマ定義アプローチの選定
- **Sources Consulted**:
  - [Apollo GraphQL Blog - Schema-First vs Code-Only](https://www.apollographql.com/blog/schema-first-vs-code-only-graphql)
  - [LogRocket - Code-first vs Schema-first](https://blog.logrocket.com/code-first-vs-schema-first-development-graphql/)
  - [Pothos GraphQL 公式](https://pothos-graphql.dev/)
  - [GitHub - hayes/pothos](https://github.com/hayes/pothos)
  - [DEV - Pothos Evaluation Report (2026年1月)](https://dev.to/xcfox/pothos-evaluation-report-3d91)
- **Findings**:
  - Schema-first の課題: スキーマと Resolver の同期維持が困難、スキーマ肥大化で実用性低下
  - Code-first の利点: 単一の真実の源、型推論による自動同期、大規模プロジェクトでの保守性向上
  - Pothos は TypeScript で最も型安全な Code-first ライブラリ、Airbnb・Netflix で採用実績
  - Pothos はランタイムオーバーヘッドゼロ、graphql のみを依存関係として持つ
  - 標準 GraphQL Schema を出力し、Apollo Server を含む全ての GraphQL サーバーと互換
- **Implications**:
  - Pothos + Apollo Server の組み合わせで既存構成を維持しつつ型安全性を向上
  - Code-first 採用により TypeScript の型から GraphQL スキーマを自動生成可能

### ORM 選定

- **Context**: 要件 3 - TypeScript と相性の良い ORM の選定
- **Sources Consulted**:
  - [Better Stack - Drizzle vs Prisma](https://betterstack.com/community/guides/scaling-nodejs/drizzle-vs-prisma/)
  - [Medium - Drizzle vs Prisma 2026](https://medium.com/@codabu/drizzle-vs-prisma-choosing-the-right-typescript-orm-in-2026-deep-dive-63abb6aa882b)
  - [Bytebase - Drizzle vs Prisma 2025](https://www.bytebase.com/blog/drizzle-vs-prisma/)
  - [Prisma Documentation - Drizzle 比較](https://www.prisma.io/docs/orm/more/comparisons/prisma-and-drizzle)
  - [Drizzle ORM - PostgreSQL Setup](https://orm.drizzle.team/docs/get-started/postgresql-new)
- **Findings**:
  - Drizzle: バンドルサイズ約7.4KB、クエリ速度2-3倍高速、コールドスタート10倍高速
  - Prisma: 2026年時点で Rust エンジン廃止によりパフォーマンス改善、DX とツールが充実
  - Drizzle: コード生成不要、TypeScript 型が常にスキーマと同期
  - Drizzle Kit: マイグレーション管理ツール、Drizzle Studio: データブラウザ
  - 大規模テーブルでは Prisma の生成型が IDE パフォーマンスで優位な場合あり
- **Implications**:
  - Drizzle ORM を採用: パフォーマンス、型安全性、サーバーレス最適化の観点で優位
  - Drizzle Kit でマイグレーション管理、開発効率と本番運用を両立

### PostgreSQL 接続とコネクションプーリング

- **Context**: 要件 2 - PostgreSQL 接続構成の確立
- **Sources Consulted**:
  - [Drizzle ORM - Database connection](https://orm.drizzle.team/docs/connect-overview)
  - [DEV - Drizzle ORM + PostgreSQL 2025](https://dev.to/sameer_saleem/the-ultimate-guide-to-drizzle-orm-postgresql-2025-edition-22b)
  - [GitHub Gist - Drizzle ORM PostgreSQL Best Practices](https://gist.github.com/productdevbook/7c9ce3bbeb96b3fabc3c7c2aa2abc717)
- **Findings**:
  - node-postgres (pg) との統合がベストプラクティス
  - コネクションプール設定: max, idleTimeoutMillis, connectionTimeoutMillis
  - 推奨設定例: max: 20, idleTimeoutMillis: 30000, connectionTimeoutMillis: 2000
  - 環境変数による DATABASE_URL 管理が標準的
  - Identity columns が serial より推奨（PostgreSQL 2025+ ベストプラクティス）
- **Implications**:
  - pg Pool を使用したコネクションプーリングを実装
  - 環境変数で接続設定を管理、開発・本番で設定を分離

### ディレクトリ構成

- **Context**: 要件 4 - Feature-based ディレクトリ構成の採用
- **Sources Consulted**:
  - [DEV - Scalable Folder Structure 2025](https://dev.to/himanshudevgupta/scalable-folder-structure-for-nodejs-expressjs-projects-2025-edition-571p)
  - [DEV - Recommended Folder Structure for Node(TS) 2025](https://dev.to/pramod_boda/recommended-folder-structure-for-nodets-2025-39jl)
  - [DEV - Clean Architecture in NodeJs API](https://dev.to/nlapointe/introduction-to-the-principles-of-clean-architecture-in-a-nodejs-api-express-13e9)
  - [GitHub - node-express-modular-architecture](https://github.com/sujeet-agrahari/node-express-modular-architecture)
- **Findings**:
  - Feature-based 構成: 機能単位でフォルダ分割、凝集性が高く保守性向上
  - 各 Feature 内: resolver, service, repository のレイヤー分離
  - 共通コンポーネント: config, middleware, utils, db を Feature 外に配置
  - Clean Architecture 原則: コア層は外部依存なし、ポートとアダプターで分離
  - 機能追加時は新フォルダ追加のみ、既存コードへの影響最小化
- **Implications**:
  - features/ ディレクトリで機能単位にコードを整理
  - 共通層（db, config, middleware）は features 外に配置
  - 軽量なレイヤー分離で過度な抽象化を回避

### ロギング

- **Context**: 要件 7 - 構造化ロギングの実装
- **Sources Consulted**:
  - [Better Stack - Pino vs Winston](https://betterstack.com/community/comparisons/pino-vs-winston/)
  - [DEV - Pino vs Winston](https://dev.to/wallacefreitas/pino-vs-winston-choosing-the-right-logger-for-your-nodejs-application-369n)
  - [Dash0 - Top 5 Node.js Logging Frameworks 2025](https://www.dash0.com/faq/the-top-5-best-node-js-and-javascript-logging-frameworks-in-2025-a-complete-guide)
- **Findings**:
  - Pino: JSON 構造化ログがデフォルト、非同期ロギングで5-10倍高速
  - Winston: 柔軟なトランスポート、複数出力先対応、成熟したエコシステム
  - Pino: OpenTelemetry ネイティブサポート、Fastify デフォルト採用
  - 2025年推奨: パフォーマンス重視なら Pino、柔軟性重視なら Winston
- **Implications**:
  - Pino を採用: 高パフォーマンス、JSON 構造化、将来の OpenTelemetry 統合に対応
  - ログレベル設定を環境変数で管理

### エラーハンドリング

- **Context**: 要件 7 - GraphQL エラーハンドリング
- **Sources Consulted**:
  - [Apollo GraphQL Docs - Error Handling](https://www.apollographql.com/docs/apollo-server/data/errors)
  - [CodeSignal - Error Handling Best Practices](https://codesignal.com/learn/courses/securing-and-optimizing-graphql-apis-1/lessons/best-practices-for-error-handling-in-graphql-with-apollo-server-4)
  - [LogRocket - Error Handling with Unions](https://blog.logrocket.com/handling-graphql-errors-like-a-champ-with-unions-and-interfaces/)
- **Findings**:
  - GraphQL エラー: graphQLErrors（リゾルバー内）と networkError（リゾルバー外）の区別
  - formatError フック: エラーのログ出力とマスキングに使用
  - Union Types: 期待結果とエラーケースを型で表現し、クライアントに明確な契約を提供
  - 部分的成功: GraphQL では特定フィールドの失敗を許容、errors 配列で報告
  - ドメインエラー vs 技術エラー: 「見つからない」「権限なし」はドメイン結果として扱う
- **Implications**:
  - formatError でエラーログとクライアント応答を制御
  - ドメインエラーは Result 型パターンで表現、技術エラーは GraphQL エラーとして返却

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| Feature-based Modular | 機能単位でディレクトリ分割、各機能内で resolver/service/repository | 高凝集、スケーラブル、機能単位での開発・テスト可能 | Feature 間依存の管理が必要 | 2025年の Node.js API で最も推奨される構成 |
| Clean Architecture (Hexagonal) | Ports & Adapters、コアドメインの独立性 | テスタビリティ、フレームワーク非依存 | 過度な抽象化のリスク、小規模プロジェクトにはオーバーエンジニアリング | 厳密な実装は避け、原則のみ採用 |
| Layer-based Traditional | controllers/services/repositories で水平分割 | シンプル、理解しやすい | 機能追加時に複数ディレクトリを変更、凝集性低下 | 大規模化で保守性低下 |

**Selected Pattern**: Feature-based Modular + Clean Architecture の原則（軽量適用）

## Design Decisions

### Decision: Code-first GraphQL with Pothos

- **Context**: 要件 1.1-1.5 - GraphQL ライブラリとスキーマ定義アプローチの選定
- **Alternatives Considered**:
  1. Schema-first (Apollo Server + SDL) - 既存構成を維持
  2. Code-first with TypeGraphQL - デコレーターベース
  3. Code-first with Pothos - プラグインベースのスキーマビルダー
- **Selected Approach**: Pothos による Code-first スキーマ定義
- **Rationale**:
  - 既存の Apollo Server を維持しつつ、Pothos でスキーマを構築
  - TypeScript 型からスキーマを推論、コード生成不要
  - デコレーター（実験的機能）に依存しない
  - プラグインシステムで Prisma/Drizzle 統合、Relay 対応など拡張可能
  - Airbnb、Netflix での採用実績
- **Trade-offs**:
  - 利点: 型安全性最高、ランタイムオーバーヘッドなし、柔軟なプラグイン
  - 欠点: TypeGraphQL ほどの知名度なし、学習コストあり
- **Follow-up**: Pothos プラグイン（dataloader, validation）の追加検討

### Decision: Drizzle ORM for Database Access

- **Context**: 要件 3.1-3.5 - TypeScript と相性の良い ORM の選定
- **Alternatives Considered**:
  1. Prisma - 成熟した DX、豊富なツール
  2. Drizzle ORM - パフォーマンス重視、SQL 透明性
  3. Kysely - タイプセーフなクエリビルダー（ORM ではない）
- **Selected Approach**: Drizzle ORM
- **Rationale**:
  - パフォーマンス: クエリ2-3倍高速、バンドル85%小型化
  - 型安全性: TypeScript 型が常にスキーマと同期、コード生成不要
  - SQL 透明性: 生成されるクエリが予測可能、複雑なクエリも対応
  - Drizzle Kit でマイグレーション管理が統合
- **Trade-offs**:
  - 利点: 高パフォーマンス、軽量、サーバーレス最適化
  - 欠点: Prisma Studio ほど GUI が成熟していない、エコシステムがやや小さい
- **Follow-up**: Drizzle Studio の開発環境での活用検討

### Decision: Pino for Structured Logging

- **Context**: 要件 7.2-7.5 - 構造化ロギングの実装
- **Alternatives Considered**:
  1. Winston - 柔軟なトランスポート、成熟したエコシステム
  2. Pino - 高パフォーマンス、JSON ネイティブ
  3. Bunyan - JSON ログ、シンプル
- **Selected Approach**: Pino
- **Rationale**:
  - パフォーマンス: 5-10倍高速、非同期ロギング
  - JSON 構造化: ログ管理ツールとの統合が容易
  - OpenTelemetry 対応: 将来の分散トレーシング統合に備え
- **Trade-offs**:
  - 利点: 最高のパフォーマンス、モダンなデフォルト設定
  - 欠点: 複数出力先への柔軟性は Winston が優位
- **Follow-up**: pino-pretty を開発環境で使用、本番は JSON 出力

### Decision: Feature-based Directory Structure

- **Context**: 要件 4.1-4.6 - ディレクトリ構成の確立
- **Alternatives Considered**:
  1. Layer-based (controllers/services/repositories)
  2. Feature-based (features/user, features/book)
  3. Domain-Driven Design (bounded contexts)
- **Selected Approach**: Feature-based with lightweight layer separation
- **Rationale**:
  - 機能単位の凝集性: 関連コードが一箇所に集約
  - スケーラビリティ: 新機能追加が既存コードに影響しない
  - 2025年のベストプラクティス: 中〜大規模 API での推奨構成
- **Trade-offs**:
  - 利点: 高凝集、保守性、テスト容易性
  - 欠点: Feature 間依存の明示的管理が必要
- **Follow-up**: Feature 間インターフェースのガイドライン策定

## Risks & Mitigations

- **Pothos 学習コスト** - 公式ドキュメントとサンプルコードを整備、段階的に導入
- **Drizzle の若いエコシステム** - Drizzle Kit 安定版を使用、複雑なケースは Raw SQL で対応
- **Feature 間依存の複雑化** - 明示的なインターフェース定義、循環依存の禁止ルール
- **マイグレーションの本番適用リスク** - トランザクション管理、ロールバック手順の文書化

## References

- [Pothos GraphQL](https://pothos-graphql.dev/) - Code-first GraphQL schema builder
- [Drizzle ORM](https://orm.drizzle.team/) - TypeScript ORM
- [Apollo Server](https://www.apollographql.com/docs/apollo-server/) - GraphQL server
- [Pino](https://github.com/pinojs/pino) - High-performance logger
- [Apollo GraphQL Blog - Schema-First vs Code-Only](https://www.apollographql.com/blog/schema-first-vs-code-only-graphql)
- [Better Stack - Drizzle vs Prisma](https://betterstack.com/community/guides/scaling-nodejs/drizzle-vs-prisma/)
- [DEV - Scalable Folder Structure 2025](https://dev.to/himanshudevgupta/scalable-folder-structure-for-nodejs-expressjs-projects-2025-edition-571p)

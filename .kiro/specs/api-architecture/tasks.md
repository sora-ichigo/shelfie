# Implementation Plan

## Tasks

- [ ] 1. Core 環境設定基盤の構築
- [x] 1.1 環境変数管理機能を実装する
  - ConfigManager を作成し、DATABASE_URL, NODE_ENV, LOG_LEVEL 等の環境変数を型安全に読み込む
  - 必須変数の存在チェックとバリデーション機能を実装する
  - デフォルト値の提供と開発・本番環境の判定機能を追加する
  - .env.example ファイルを作成し、必要な環境変数をテンプレート化する
  - _Requirements: 2.3, 6.2, 8.5_

- [x] 1.2 (P) ローカル開発用 Docker Compose を構成する
  - PostgreSQL 16+ コンテナの設定を作成する
  - Unix domain socket 経由での接続を設定する（ホストの 5432 ポート競合を回避）
  - socket ディレクトリ（./tmp/pg-socket）をホストにマウントする
  - ボリュームマウントによるデータ永続化を設定する
  - テスト用データベースを同一コンテナ内に作成する
  - _Requirements: 2.1, 6.1, 6.6_

- [ ] 2. データベース接続基盤の構築
- [x] 2.1 PostgreSQL 接続とコネクションプーリングを実装する
  - pg Pool を使用したコネクションプーリング機能を作成する
  - 接続タイムアウトとリトライ戦略を実装する
  - 接続エラー時の明確なエラーメッセージを定義する
  - ヘルスチェック機能と Graceful shutdown 処理を追加する
  - ConfigManager から接続設定を取得する
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5_

- [x] 2.2 Drizzle ORM クライアントを構築する
  - Drizzle ORM インスタンスの初期化処理を実装する
  - pg Pool との統合を設定する
  - トランザクション管理機能を実装する
  - Raw SQL クエリのサポートを追加する
  - _Requirements: 3.1, 3.2, 3.3, 3.5_

- [x] 2.3 データベーススキーマ定義パターンを確立する
  - Identity columns を使用した主キー定義パターンを作成する
  - timestamp カラム（created_at, updated_at）の標準パターンを定義する
  - サンプルとして users テーブル（id, email）を定義し、型推論の動作を確認する
  - _Requirements: 3.2, 3.4_

- [x] 3. マイグレーション基盤の構築
- [x] 3.1 Drizzle Kit によるマイグレーション環境を構築する
  - drizzle.config.ts を作成し、マイグレーション設定を定義する
  - マイグレーションファイルの生成・実行コマンドを設定する
  - 開発環境でのスキーマ同期（push）コマンドを設定する
  - _Requirements: 5.1, 5.2_

- [x] 3.2 マイグレーション運用戦略を確立する
  - ロールバック手順を文書化し、トランザクション管理を実装する
  - 本番環境へのマイグレーション適用フローを定義する
  - シードデータの管理方法を確立する
  - _Requirements: 5.3, 5.4, 5.5, 5.6_

- [ ] 4. GraphQL スキーマ基盤の構築
- [x] 4.1 Pothos SchemaBuilder を初期化する
  - SchemaBuilder インスタンスの初期化と設定を実装する
  - 基本スカラー型（DateTime 等）の定義を追加する
  - GraphQL Context 型を定義する
  - _Requirements: 1.1, 1.2, 1.3_

- [x] 4.2 Apollo Server との統合を実装する
  - Pothos で構築したスキーマを Apollo Server に接続する
  - 既存の Express 構成との互換性を確認する
  - GraphQL Playground（Apollo Sandbox）を開発環境で有効化する
  - _Requirements: 1.4, 1.5_

- [ ] 5. ロギング基盤の構築
- [x] 5.1 (P) Pino ロガーを実装する
  - Pino インスタンスの初期化と設定を作成する
  - ログレベル（debug, info, warn, error）の管理機能を実装する
  - JSON 構造化フォーマットでの出力を設定する
  - 開発環境での整形出力（pino-pretty）を設定する
  - リクエストコンテキスト（requestId, userId 等）の付与機能を実装する
  - _Requirements: 7.2, 7.3, 7.5_

- [ ] 6. エラーハンドリング基盤の構築
- [ ] 6.1 GraphQL エラーハンドラーを実装する
  - GraphQL エラーの標準フォーマットを定義する
  - エラーカテゴリ（USER_ERROR, SYSTEM_ERROR, BUSINESS_ERROR）を実装する
  - formatError フックを実装し、本番環境でのスタックトレースマスキングを行う
  - 開発環境での詳細エラー情報出力を設定する
  - Logger との統合によるエラーログ出力を実装する
  - _Requirements: 7.1, 7.4_

- [ ] 6.2 (P) Result 型パターンを実装する
  - ドメインエラー用の Result 型ユーティリティを作成する
  - DomainError インターフェースを定義する
  - Service 層での Result 型使用パターンを確立する
  - _Requirements: 7.1_

- [ ] 7. Feature モジュール基盤の構築
- [ ] 7.1 Feature モジュールテンプレートを作成する
  - Feature 内の resolver/service/repository レイヤー構成を定義する
  - FeatureModule インターフェースを実装する
  - Feature の公開 API パターンを確立する
  - _Requirements: 4.1, 4.2, 4.6_

- [ ] 7.2 Feature 間依存ルールを確立する
  - 共通ユーティリティと Feature 固有コードの境界を定義する
  - Feature 間の明示的なインターフェースアクセスパターンを実装する
  - 循環依存を防止する設計ガイドラインを確立する
  - _Requirements: 4.3, 4.5, 4.6_

- [ ] 7.3 サンプル Feature（users）を実装する
  - users Feature を作成し、テンプレートの動作を検証する
  - User 型の Pothos 定義、Resolver、Service、Repository の連携を実装する
  - Task 2.3 で定義した users テーブルと統合する
  - _Requirements: 4.1, 4.2, 4.4_

- [ ] 8. セキュリティ基盤の構築
- [ ] 8.1 (P) GraphQL セキュリティ設定を実装する
  - クエリ深度制限を設定する
  - クエリコスト分析の方針を定義する
  - レート制限の実装方針を文書化する
  - _Requirements: 8.2, 8.4_

- [ ] 8.2 (P) CORS とセキュリティヘッダーを設定する
  - CORS 設定を環境変数から読み込む機能を実装する
  - 開発・本番環境での CORS ポリシーを定義する
  - _Requirements: 8.3_

- [ ] 8.3 Firebase Auth 統合を実装する
  - firebase-admin SDK をインストールし初期化処理を実装する
  - Authorization ヘッダーから ID Token を検証する middleware を作成する
  - GraphQL Context に検証済みユーザー情報（DecodedIdToken）を注入する
  - 認証が必要な Resolver のための authScope パターンを定義する
  - _Requirements: 8.1_

- [ ] 9. テスト基盤の構築
- [ ] 9.1 テスト環境設定を構築する
  - Vitest のグローバルセットアップを作成する
  - テスト用データベース接続設定を定義する
  - テスト前のマイグレーション実行とデータクリーンアップ処理を実装する
  - _Requirements: 6.4, 6.5, 6.6_

- [ ] 9.2 (P) コアコンポーネントのテストを作成する
  - ConfigManager のバリデーションテストを作成する
  - ErrorHandler のエラーフォーマットテストを作成する
  - Logger の出力フォーマットテストを作成する
  - _Requirements: 6.4, 6.5_

- [ ] 9.3 統合テストパターンを確立する
  - DatabaseConnection の接続・切断テストを作成する
  - DrizzleClient の CRUD 操作テストを作成する
  - GraphQL Resolver のエンドツーエンドテストを作成する
  - _Requirements: 6.4, 6.5, 6.6_

- [ ] 10. ドキュメント成果物の作成
- [ ] 10.1 開発者ドキュメントを作成する
  - 技術選定の決定と理由を docs/api-architecture.md に記載する
  - ディレクトリ構成ガイドラインを docs/api-directory-structure.md に記載する
  - 新機能追加時のディレクトリ作成手順を文書化する
  - _Requirements: 9.1, 9.2, 9.4_

- [ ] 10.2 Steering ドキュメントを更新する
  - .kiro/steering/tech.md に API 技術スタック情報を反映する
  - .kiro/steering/structure.md に apps/api ディレクトリ構成を反映する
  - 開発者ドキュメントと steering ドキュメントの整合性を確認する
  - _Requirements: 9.3, 9.4, 9.5, 9.6_

- [ ] 11. システム統合と検証
- [ ] 11.1 全コンポーネントの統合を完了する
  - サーバー起動時の初期化シーケンスを実装する（ConfigManager -> DatabaseConnection -> DrizzleClient -> SchemaBuilder -> Apollo Server）
  - Graceful shutdown 処理を全コンポーネントに適用する
  - 開発サーバー起動（pnpm dev:api）の動作を確認する
  - _Requirements: 1.4, 2.2, 6.1_

- [ ] 11.2 エンドツーエンド検証を実行する
  - GraphQL Playground からのクエリ実行を確認する
  - データベース操作（CRUD）の動作を検証する
  - エラーハンドリングとロギングの動作を確認する
  - 全要件の充足を最終確認する
  - _Requirements: 1.5, 2.4, 7.1, 7.4, 7.5_

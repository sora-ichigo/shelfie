# Tech Steering - Mobile Architecture

Shelfie モバイルアプリケーションの技術的な決定事項とアーキテクチャガイドライン。

## アーキテクチャパターン

### 選定: Feature-first + Clean Architecture

**選定理由**:
- 機能単位でのモジュール化により、チーム間の並行開発が容易
- レイヤー分離により、テスタビリティと保守性が向上
- 依存関係の方向が明確で、変更の影響範囲が限定的

**レイヤー構成**:
| レイヤー | 責務 | 依存先 |
|---------|------|--------|
| Presentation | UI 表示、ユーザー入力処理 | Application, Core |
| Application | ユースケース実行、状態調整 | Domain |
| Domain | ビジネスルール、エンティティ定義 | なし（純粋 Dart） |
| Infrastructure | 外部システム連携、データ永続化 | Domain |

**依存関係ルール**:
- 外側のレイヤーから内側のレイヤーへのみ依存可能
- Domain 層は外部依存を持たない
- Infrastructure 層は Domain のインターフェースを実装

## 採用ライブラリ

### 状態管理: Riverpod

| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| flutter_riverpod | ^2.5.1 | Flutter 統合 |
| riverpod_annotation | ^2.3.5 | コード生成アノテーション |
| riverpod_generator | ^2.3.11 | Provider コード生成 |

**選定理由**:
- コンパイル時の型安全性
- Provider のスコープ分離が容易
- テストでの Provider オーバーライドが簡単
- コード生成によるボイラープレート削減

### データモデリング: freezed

| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| freezed_annotation | ^2.4.4 | アノテーション |
| freezed | ^2.4.7 | コード生成 |
| json_annotation | ^4.9.0 | JSON シリアライゼーション |
| json_serializable | ^6.7.1 | JSON コード生成 |

**選定理由**:
- イミュータブルなデータクラスの自動生成
- copyWith, equality, toString の自動実装
- sealed class によるパターンマッチング
- JSON シリアライゼーションとの統合

### ルーティング: go_router

| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| go_router | ^14.6.2 | 宣言的ルーティング |

**選定理由**:
- Flutter 公式推奨のルーティングパッケージ
- 宣言的なルート定義
- ディープリンク対応
- ShellRoute によるネストナビゲーション
- 認証ガードの実装が容易

### GraphQL クライアント: Ferry

| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| ferry | ^0.16.1+2 | GraphQL クライアント |
| ferry_flutter | ^0.9.1+1 | Flutter 統合 |
| ferry_hive_store | ^0.6.0+1 | オフラインキャッシュ |
| ferry_generator | ^0.12.0 | コード生成 |
| gql_http_link | ^1.2.0 | HTTP 通信 |

**選定理由**:
- 型安全な GraphQL 操作
- スキーマからのコード自動生成
- 組み込みのキャッシュ機能
- オフラインサポート

### エラーハンドリング: fpdart

| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| fpdart | ^1.1.0 | 関数型プログラミング |

**選定理由**:
- Either 型による明示的なエラーハンドリング
- 例外を使わない安全なエラー伝播
- パターンマッチングとの親和性

### ローカルストレージ: Hive

| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| hive_flutter | ^1.1.0 | キー・バリューストレージ |

**選定理由**:
- 高速な読み書き
- Ferry のキャッシュストアとして利用可能
- 軽量で設定が簡単

### Lint: very_good_analysis

| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| very_good_analysis | ^6.0.0 | 静的解析ルール |

**選定理由**:
- VGV（Very Good Ventures）による厳格なルールセット
- Dart/Flutter のベストプラクティスを強制
- プロジェクト全体のコード品質を担保

### テスト

| パッケージ | バージョン | 用途 |
|-----------|----------|------|
| flutter_test | SDK | ユニット・ウィジェットテスト |
| integration_test | SDK | インテグレーションテスト |
| mocktail | ^1.0.4 | モック生成 |

## デザインシステム

### テーマ設定

- **ベース**: Material 3
- **モード**: ダークモードのみ（現時点）
- **カラー**: ColorScheme.fromSeed + カスタム ThemeExtension

### カスタムカラー (AppColors)

| カラー | 用途 | ダーク値 |
|-------|------|---------|
| success | 成功状態 | #81C784 |
| warning | 警告状態 | #FFD54F |
| info | 情報表示 | #64B5F6 |

### スペーシング (AppSpacing)

| 定数 | 値 | 用途 |
|------|-----|------|
| xs | 4.0 | 最小間隔 |
| sm | 8.0 | 小間隔 |
| md | 16.0 | 中間隔 |
| lg | 24.0 | 大間隔 |
| xl | 32.0 | 特大間隔 |
| xxl | 48.0 | 最大間隔 |

## エラーハンドリング戦略

### Failure 型階層

| タイプ | 用途 | ユーザーメッセージ |
|--------|------|------------------|
| NetworkFailure | ネットワーク関連 | ネットワーク接続を確認してください |
| ServerFailure | API エラー | サーバーエラーが発生しました |
| AuthFailure | 認証エラー | 再度ログインしてください |
| ValidationFailure | バリデーション | （カスタムメッセージ） |
| UnexpectedFailure | 予期しないエラー | 予期しないエラーが発生しました |

### エラー報告

- **開発環境**: ConsoleLogger でデバッグ出力
- **本番環境**: Firebase Crashlytics への報告（予定）

## テスト戦略

### 3 層テスト

| 種類 | 対象 | ディレクトリ |
|------|------|------------|
| ユニットテスト | Provider, UseCase, Repository | test/unit/ |
| ウィジェットテスト | 共通ウィジェット、画面 | test/widget/ |
| インテグレーションテスト | ユーザーフロー | integration_test/ |

### テストカバレッジ

```bash
# カバレッジ計測
flutter test --coverage

# レポート生成
genhtml coverage/lcov.info -o coverage/html
```

## コード生成

### build_runner コマンド

```bash
# 一度だけ生成
dart run build_runner build --delete-conflicting-outputs

# ファイル監視モード
dart run build_runner watch --delete-conflicting-outputs
```

### 生成対象

| パッケージ | 生成ファイル |
|-----------|------------|
| freezed | *.freezed.dart |
| json_serializable | *.g.dart |
| riverpod_generator | *.g.dart |
| ferry_generator | __generated__/*.dart |

## 決定履歴

### 2026-01-19: 初期アーキテクチャ決定

- Feature-first + Clean Architecture を採用
- Riverpod + freezed + go_router + Ferry + fpdart の技術スタックを選定
- ダークモードのみをサポート（ライトモード対応は後日検討）
- ThemeModeNotifier はスキップ（ダークモード固定のため）

### 今後の検討事項

- ライトモード対応
- Firebase Crashlytics の本格導入
- E2E テストの拡充
- パフォーマンスモニタリング

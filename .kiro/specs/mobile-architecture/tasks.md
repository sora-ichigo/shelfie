# Implementation Plan

## Task Overview

Feature-first + Clean Architecture を採用した Shelfie モバイルアプリの基盤構築。Riverpod による状態管理、go_router によるルーティング、Ferry による GraphQL 連携、fpdart によるエラーハンドリングを統合する。

## Important Notes

- **依存関係のバージョン**: すべてのパッケージは常に最新バージョンを使用すること。バージョン固定（`^x.y.z`）は避け、インストール時点の最新安定版を採用する。

---

- [ ] 1. プロジェクト基盤の設定
- [x] 1.1 (P) 依存関係の追加とバージョン管理
  - pubspec.yaml に必要なパッケージを追加（riverpod, freezed, go_router, ferry, fpdart 等）
  - Dart SDK バージョンを 3.4.0 以上に更新（環境制約により 3.6.0 から変更）
  - バージョン指定を明示的に行い、互換性を確保
  - dev_dependencies にコード生成ツール（build_runner, freezed, riverpod_generator 等）を追加
  - _Requirements: 1.1, 1.2, 1.5, 6.2, 6.3_

- [x] 1.2 (P) very_good_analysis による Lint ルールの設定
  - analysis_options.yaml を very_good_analysis ベースに移行
  - プロジェクト固有のカスタマイズルールを追加
  - strict-casts, strict-inference, strict-raw-types を有効化
  - _Requirements: 6.4, 6.5_

- [ ] 2. ディレクトリ構成の構築
- [x] 2.1 Feature-first ディレクトリ構造の作成
  - lib/app/ ディレクトリにアプリケーション設定ファイルを配置
  - lib/core/ に共通コンポーネント（error, network, theme, widgets, utils）のサブディレクトリを作成
  - lib/routing/ にルーティング関連ファイルを配置
  - lib/features/ に機能モジュールのテンプレート構造を作成
  - 各機能ディレクトリ内に presentation, application, domain, infrastructure の各レイヤーを配置
  - test/ ディレクトリに unit, widget, integration のサブディレクトリを作成
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5_

- [ ] 3. エラーハンドリング基盤の実装
- [x] 3.1 (P) Failure 型階層の定義
  - freezed を使用して Failure sealed class を定義
  - NetworkFailure, ServerFailure, AuthFailure, ValidationFailure, UnexpectedFailure のサブタイプを実装
  - 各 Failure 型にユーザー向けメッセージを提供する userMessage getter を実装
  - エラーコードとスタックトレースの保持をサポート
  - _Requirements: 8.1, 8.4_

- [x] 3.2 グローバルエラーハンドラの実装
  - ErrorHandler クラスを作成し、未処理例外をキャッチする仕組みを構築
  - FlutterError.onError と PlatformDispatcher.instance.onError を設定
  - Failure タイプに応じた構造化ログ出力を実装
  - Firebase Crashlytics への報告機能を実装（本番環境のみ）
  - 3.1 の Failure 型を使用して例外を分類
  - _Requirements: 8.2, 8.3, 8.5_

- [x] 4. テーマとデザインシステムの実装
- [x] 4.1 (P) カスタムカラースキームの定義
  - ThemeExtension を継承した AppColors クラスを作成
  - ダークモード用のカラー定義を実装（ライトモードは当面サポートしない）
  - lerp メソッドによるアニメーション対応を実装
  - success, warning, info などのセマンティックカラーを定義
  - _Requirements: 4.2_

- [x] 4.2 (P) タイポグラフィとスペーシングの定義
  - AppTypography クラスでカスタムテキストスタイルを定義
  - AppSpacing クラスで一貫したスペーシング定数を定義
  - Material 3 のタイポグラフィシステムとの統合
  - _Requirements: 4.2_

- [x] 4.3 AppTheme の統合
  - Material 3 ベースの ThemeData を生成する AppTheme クラスを作成
  - ダークモードの ThemeData のみを提供（ライトモードは当面サポートしない）
  - カスタム拡張（AppColors, AppTypography）を ThemeData に統合
  - 4.1, 4.2 で作成したコンポーネントを組み込む
  - _Requirements: 4.1, 4.3_

- ~~4.4 テーマモード状態管理の実装~~ **(スキップ: ダークモード固定のため不要)**
  - ~~Riverpod を使用した ThemeModeNotifier を作成~~
  - ~~システムテーマの変更を監視し自動的にテーマを切り替える機能を実装~~
  - ~~SharedPreferences によるテーマ設定の永続化を実装~~
  - ~~4.3 の AppTheme と連携~~
  - ~~_Requirements: 4.5, 1.1_~~

- [x] 5. 状態管理基盤の実装
- [x] 5.1 ProviderScope とルートレベル Provider の設定
  - main.dart で ProviderScope を使用してアプリ全体をラップ
  - runZonedGuarded 内で ErrorHandler を初期化
  - アプリ起動時の初期化処理（Hive, Firebase 等）を構築
  - Provider のスコープを適切に分離する設計を実装
  - 3.2 の ErrorHandler を統合（注: ThemeModeNotifier はスキップ済み、ダークモード固定）
  - _Requirements: 1.1, 1.4, 8.2_

- [x] 5.2 (P) Riverpod コード生成の設定
  - riverpod_annotation を使用した Provider 定義のパターンを確立
  - build_runner による自動生成の設定とコマンドを整備
  - StateNotifier と AsyncNotifier の使い分けガイドラインを確立
  - _Requirements: 1.1, 1.5_

- [x] 6. ルーティングシステムの実装
- [x] 6.1 AppRouter の基本設定
  - go_router を使用した GoRouter インスタンスを Riverpod Provider として提供
  - 初期ルートとエラーハンドリング（onException）を設定
  - デバッグモードでのログ出力を有効化
  - _Requirements: 2.1_

- [x] 6.2 型安全なルートパラメータの定義
  - ルートパスとパラメータを型安全に定義する仕組みを構築
  - pathParameters と queryParameters の型変換を実装
  - ルート定義の一元管理を実現
  - 6.1 の AppRouter に組み込む
  - _Requirements: 2.2_

- [x] 6.3 ネストナビゲーションの実装
  - ShellRoute を使用したタブバーナビゲーションを構築
  - 各タブの状態保持を実現
  - タブ間の遷移とサブルートの管理
  - _Requirements: 2.4_

- [x] 6.4 認証ガードの実装
  - 認証状態を監視する AuthProvider を作成
  - redirect コールバックで認証状態に基づくルートガードを実装
  - 未認証時のログイン画面へのリダイレクトを実装
  - refreshListenable で認証状態変更を監視
  - _Requirements: 2.5_

- [x] 6.5 ディープリンク対応
  - カスタム URL スキームの設定
  - ディープリンク受信時の正しい画面遷移を実装
  - 不正な URL パラメータのバリデーションとフォールバック
  - 6.1-6.4 の基盤上に構築
  - _Requirements: 2.3_

- [x] 7. GraphQL API 連携基盤の実装
- [x] 7.1 Ferry クライアントの設定
  - Ferry Client を Riverpod Provider として構築
  - HttpLink を使用した API エンドポイント設定
  - 認証トークンをヘッダーに含める仕組みを実装
  - デフォルトの FetchPolicy を設定
  - _Requirements: 7.1_

- [x] 7.2 オフラインキャッシュの実装
  - Hive の初期化と HiveStore の設定
  - キャッシュファースト戦略の実装
  - キャッシュクリア機能の提供
  - 7.1 の Ferry クライアントと統合
  - _Requirements: 7.3_

- [x] 7.3 GraphQL コード生成の設定
  - ferry_generator の設定ファイルを作成
  - スキーマ取得とコード生成のスクリプトを整備
  - 生成されるモデルと操作クラスの配置場所を決定
  - _Requirements: 7.2_

- [x] 7.4 BaseRepository の実装
  - Either<Failure, T> を返す共通リポジトリ基底クラスを作成
  - GraphQL 操作（クエリ、ミューテーション）の実行とエラー変換を実装
  - ネットワークエラー、GraphQL エラー、タイムアウトの分類を行う
  - リトライ機能を実装
  - ローディング状態の管理パターンを確立
  - 3.1 の Failure 型、7.1, 7.2 の Ferry 基盤を統合
  - _Requirements: 7.4, 7.5, 8.1_

- [ ] 8. 共通ウィジェットの実装
- [ ] 8.1 (P) ローディングインジケータの作成
  - 再利用可能な LoadingIndicator ウィジェットを実装
  - 全画面ローディングとインライン ローディングの両方をサポート
  - テーマに応じたスタイリングを適用
  - _Requirements: 4.4, 7.5_

- [ ] 8.2 (P) エラー表示ウィジェットの作成
  - Failure 型を受け取り適切なメッセージを表示する ErrorView ウィジェットを実装
  - リトライボタンのコールバックをサポート
  - エラータイプに応じたアイコンと色分けを実装
  - 3.1 の Failure 型を使用
  - _Requirements: 4.4, 8.4_

- [ ] 8.3 (P) 空状態ウィジェットの作成
  - データが存在しない場合の EmptyState ウィジェットを実装
  - カスタマイズ可能なメッセージとアイコンを提供
  - アクションボタンのサポート
  - _Requirements: 4.4_

- [ ] 9. アプリケーション統合
- [ ] 9.1 ShelfieApp ウィジェットの実装
  - MaterialApp.router を使用したアプリルートウィジェットを作成
  - AppRouter、AppTheme、ThemeModeNotifier を統合
  - ProviderScope 内での適切な初期化順序を確保
  - 1-8 の全コンポーネントを統合
  - _Requirements: 1.1, 2.1, 4.1_

- [ ] 9.2 状態変更による UI 再描画の最適化
  - Consumer ウィジェットを使用した選択的リビルドを実装
  - Provider の依存関係を適切に分離
  - 不要な再描画を防ぐための select 使用パターンを確立
  - _Requirements: 1.3, 1.4_

- [ ] 10. テスト基盤の構築
- [ ] 10.1 (P) テストユーティリティの作成
  - テスト用の ProviderContainer ヘルパーを作成
  - mocktail を使用したモック生成パターンを確立
  - registerFallbackValue の設定を整備
  - テスト用の共通フィクスチャを作成
  - _Requirements: 5.2_

- [ ] 10.2 Provider ユニットテストの作成
  - ThemeModeNotifier のユニットテストを作成
  - AuthProvider のユニットテストを作成
  - BaseRepository のエラーハンドリングテストを作成
  - 10.1 のユーティリティを使用
  - _Requirements: 5.1, 5.3_

- [ ] 10.3 共通ウィジェットのウィジェットテストの作成
  - LoadingIndicator のウィジェットテストを作成
  - ErrorView のウィジェットテストを作成
  - EmptyState のウィジェットテストを作成
  - ライト/ダークモードでの表示確認を含める
  - 8.1-8.3 のウィジェットをテスト
  - _Requirements: 5.1, 5.4_

- [ ] 10.4 テーマ適用のウィジェットテストの作成
  - AppTheme のライト/ダークモードでのテストを作成
  - ThemeExtension のアクセスとアニメーション（lerp）のテストを作成
  - 4.1-4.4 のテーマコンポーネントをテスト
  - _Requirements: 5.4_

- [ ] 10.5 ルーターのウィジェットテストの作成
  - AppRouter のナビゲーションテストを作成
  - 認証ガードのリダイレクトテストを作成
  - ディープリンクのルーティングテストを作成
  - 6.1-6.5 のルーティングコンポーネントをテスト
  - _Requirements: 5.4_

- [ ] 10.6 CI テストカバレッジ計測の設定
  - flutter test --coverage コマンドの設定
  - カバレッジレポート生成の設定
  - CI パイプラインでのカバレッジ計測フックを準備
  - _Requirements: 5.6_

- [ ]* 10.7 インテグレーションテストの作成
  - アプリ起動から初画面表示までのテストを作成
  - 認証フローのエンドツーエンドテストを作成
  - エラーリカバリシナリオのテストを作成
  - _Requirements: 5.1, 5.5_

- [ ] 11. ドキュメンテーションの作成
- [ ] 11.1 アーキテクチャドキュメントの作成
  - apps/mobile/README.md にアーキテクチャ概要を記載
  - ディレクトリ構成と各レイヤーの責務を文書化
  - 主要ライブラリの使用方法とパターンを記載
  - _Requirements: 9.1, 9.2_

- [ ] 11.2 コーディング規約の文書化
  - コーディング規約とベストプラクティスを文書化
  - Riverpod、freezed、go_router、Ferry の使用パターンを記載
  - エラーハンドリングのガイドラインを記載
  - _Requirements: 9.3_

- [ ] 11.3 Steering ドキュメントの更新
  - .kiro/steering/tech.md にアーキテクチャの決定事項を反映
  - 採用したライブラリとバージョンを記録
  - アーキテクチャパターンの選定理由を記載
  - _Requirements: 9.4, 9.5_

---

## Requirements Coverage

| Requirement | Tasks |
|-------------|-------|
| 1.1 | 1.1, 4.4, 5.1, 5.2, 9.1 |
| 1.2 | 1.1 |
| 1.3 | 9.2 |
| 1.4 | 5.1, 9.2 |
| 1.5 | 1.1, 5.2 |
| 2.1 | 6.1, 9.1 |
| 2.2 | 6.2 |
| 2.3 | 6.5 |
| 2.4 | 6.3 |
| 2.5 | 6.4 |
| 3.1 | 2.1 |
| 3.2 | 2.1 |
| 3.3 | 2.1 |
| 3.4 | 2.1 |
| 3.5 | 2.1 |
| 4.1 | 4.3, 9.1 |
| 4.2 | 4.1, 4.2 |
| 4.3 | 4.3 |
| 4.4 | 8.1, 8.2, 8.3 |
| 4.5 | 4.4 |
| 5.1 | 10.2, 10.3, 10.7 |
| 5.2 | 10.1 |
| 5.3 | 10.2 |
| 5.4 | 10.3, 10.4, 10.5 |
| 5.5 | 10.7 |
| 5.6 | 10.6 |
| 6.1 | 1.1 |
| 6.2 | 1.1 |
| 6.3 | 1.1 |
| 6.4 | 1.2 |
| 6.5 | 1.2 |
| 7.1 | 7.1 |
| 7.2 | 7.3 |
| 7.3 | 7.2 |
| 7.4 | 7.4 |
| 7.5 | 7.4, 8.1 |
| 8.1 | 3.1 |
| 8.2 | 3.2 |
| 8.3 | 3.2 |
| 8.4 | 3.1, 8.2 |
| 8.5 | 3.2 |
| 9.1 | 11.1 |
| 9.2 | 11.1 |
| 9.3 | 11.2 |
| 9.4 | 11.3 |
| 9.5 | 11.3 |

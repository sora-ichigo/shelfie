# Research & Design Decisions

## Summary

- **Feature**: `mobile-architecture`
- **Discovery Scope**: New Feature (greenfield architecture setup)
- **Key Findings**:
  - Riverpod 2.0+ と freezed 3.0 の組み合わせが Flutter の状態管理とデータモデリングの標準的なアプローチとして確立
  - go_router は Navigation 2 をベースとした宣言的ルーティングと deep linking のデファクトスタンダード
  - Ferry GraphQL クライアントは型安全性とコード生成の面で graphql_flutter より優位

## Research Log

### Riverpod アーキテクチャパターン

- **Context**: 要件 1（状態管理）に対応する最適なアーキテクチャパターンの調査
- **Sources Consulted**:
  - [Flutter App Architecture with Riverpod: An Introduction](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)
  - [Flutter Riverpod Clean Architecture](https://ssoad.github.io/flutter_riverpod_clean_architecture/)
  - [Flutter Clean Architecture with Riverpod and Supabase](https://otakoyi.software/blog/flutter-clean-architecture-with-riverpod-and-supabase)
- **Findings**:
  - 3層アーキテクチャ（Data/Domain/Presentation）が推奨
  - Feature-first ディレクトリ構成により機能単位での分離が容易
  - Provider の依存性注入機能によりテスタビリティが向上
  - Riverpod 2.0+ では ProviderScope による状態のスコープ管理が標準
- **Implications**: 要件 3 のディレクトリ構成と統合し、Feature-first + Layer 構成を採用

### go_router とディープリンク

- **Context**: 要件 2（ルーティング）に対応するナビゲーション戦略の調査
- **Sources Consulted**:
  - [Flutter Deep Linking: The Ultimate Guide](https://codewithandrea.com/articles/flutter-deep-links/)
  - [go_router | Flutter package](https://pub.dev/packages/go_router)
  - [Flutter Deep Linking & Navigation with go_router Made Easy](https://appsgemacht.de/en/insights/deep-linking-navigation-flutter)
- **Findings**:
  - go_router は Navigation 2 のラッパーとして URL ベースのナビゲーションを簡素化
  - ShellRoute によるネストナビゲーション（タブバー等）のサポート
  - redirect によるルートガード（認証状態チェック）の実装が容易
  - カスタム URL スキームより Universal Links/App Links を推奨
- **Implications**: go_router を中心としたルーティング層を設計、認証ガードは Riverpod の Provider と連携

### freezed 3.0 コード生成

- **Context**: 要件 1.2（イミュータブルデータモデル）に対応するコード生成ツールの調査
- **Sources Consulted**:
  - [freezed | Dart package](https://pub.dev/packages/freezed)
  - [GitHub - rrousselGit/freezed](https://github.com/rrousselGit/freezed)
  - [December 2025: Flutter GenUI SDK, Build Runner Speedups](https://codewithandrea.com/newsletter/december-2025/)
- **Findings**:
  - freezed 3.0 で「mixed mode」がサポートされ、extends と非定数デフォルト値が利用可能
  - build_runner 2.10.4+ でキャッシングによるビルド高速化
  - `// dart format off` の自動生成で CI との互換性向上
  - Dart 3.6.0 以上が必要
- **Implications**: freezed 3.0 + json_serializable の組み合わせでドメインモデルと API レスポンスモデルを定義

### GraphQL クライアント選定

- **Context**: 要件 7（API 連携）に対応する GraphQL クライアントの選定
- **Sources Consulted**:
  - [Ferry GraphQL](https://ferrygraphql.com/)
  - [ferry | Dart package](https://pub.dev/packages/ferry)
  - [Personal Thoughts on Popular GraphQL Clients](https://dev.to/maylau/personal-thoughts-on-popular-graphql-clients-32j7)
- **Findings**:
  - Ferry: 完全型付け、コード生成、正規化キャッシュ、オフライン対応（HiveStore）
  - graphql_flutter: インストールが容易だがメンテナンス状況が低い
  - Ferry は Isolate での実行によりUIスレッドの負荷軽減が可能
- **Implications**: Ferry を GraphQL クライアントとして採用。HiveStore によるオフラインキャッシュを実装

### very_good_analysis Lint ルール

- **Context**: 要件 6.4（lint ルール）に対応する静的解析設定の調査
- **Sources Consulted**:
  - [very_good_analysis | Dart package](https://pub.dev/packages/very_good_analysis)
  - [GitHub - VeryGoodOpenSource/very_good_analysis](https://github.com/VeryGoodOpenSource/very_good_analysis)
  - [Flutter Linting and Linter Comparison](https://rydmike.com/blog_flutter_linting.html)
- **Findings**:
  - 188 の lint ルール（利用可能なルールの 86.2%）を有効化
  - strict-inference, strict-raw-types による厳格な型推論
  - 業界で最も厳格な lint ルールセット
- **Implications**: very_good_analysis を採用し、必要に応じて analysis_options.yaml でカスタマイズ

### Mocktail テスト戦略

- **Context**: 要件 5（テスト戦略）に対応するモックライブラリの調査
- **Sources Consulted**:
  - [mocktail | Dart package](https://pub.dev/packages/mocktail)
  - [Flutter Test With Mocktail](https://www.dbestech.com/tutorials/flutter-test-with-mocktail)
  - [A Complete Guide to Testing in Flutter. Part 5: Mocktail](https://medium.com/@MynaviTechTusVietnam/a-complete-guide-to-testing-in-flutter-part-5-mocktail-aaac0d67a1df)
- **Findings**:
  - Mocktail は null-safety 対応で Mockito よりボイラープレートが少ない
  - コード生成不要でシンプルな API
  - カスタム型には registerFallbackValue が必要
  - setUpAll で registerFallbackValue を一度だけ呼び出すのがベストプラクティス
- **Implications**: flutter_test + mocktail をテストスタックとして採用

### fpdart 関数型エラーハンドリング

- **Context**: 要件 8（エラーハンドリング）に対応する Result 型の調査
- **Sources Consulted**:
  - [fpdart | Dart package](https://pub.dev/packages/fpdart)
  - [Functional Error Handling with Either and fpdart in Flutter](https://codewithandrea.com/articles/functional-error-handling-either-fpdart/)
  - [GitHub - SandroMaglione/fpdart](https://github.com/SandroMaglione/fpdart)
- **Findings**:
  - Either<L, R> で例外を明示的に宣言（left=エラー、right=成功）
  - Option で null を安全に扱う
  - Task で非同期処理を合成可能に
  - v2 は pre-release 段階、v1 の安定版を使用推奨
- **Implications**: fpdart の Either を採用し、Repository 層で明示的なエラーハンドリングを実装

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| Clean Architecture | Domain/Data/Presentation の 3 層構成 | 明確な責務分離、テスタビリティ | 小規模アプリには過剰な可能性 | Feature-first と組み合わせて採用 |
| Hexagonal Architecture | Ports & Adapters パターン | 外部依存の抽象化が明確 | 学習コストが高い | Clean Architecture に包含 |
| MVC | Model-View-Controller | シンプル | 大規模アプリでの複雑化 | Flutter の宣言的 UI と相性が悪い |
| Feature-first | 機能単位でディレクトリを分割 | スケーラビリティ、チーム開発に有利 | 共通コンポーネントの管理が必要 | 採用 |

## Design Decisions

### Decision: Feature-first + Clean Architecture の採用

- **Context**: 要件 3 で Feature-first ディレクトリ構成が要求され、各機能内に presentation/application/domain/infrastructure レイヤーを配置する必要がある
- **Alternatives Considered**:
  1. Layer-first (lib/presentation, lib/domain など) - レイヤーごとにディレクトリを分割
  2. Feature-first + Simple (lib/features/xxx/pages, widgets, models のみ) - 軽量構成
- **Selected Approach**: Feature-first + Clean Architecture の階層化ディレクトリ構成
- **Rationale**: 要件で明示されており、チーム開発でのスケーラビリティと機能単位での独立性を両立
- **Trade-offs**: 初期セットアップの複雑さ vs 長期的な保守性向上
- **Follow-up**: 共通コンポーネント（lib/core）の境界を明確に定義

### Decision: Ferry を GraphQL クライアントとして選定

- **Context**: 要件 7.1 で graphql_flutter または ferry の選択が求められている
- **Alternatives Considered**:
  1. graphql_flutter - インストール容易だがメンテナンス状況が低い
  2. artemis - 別の型安全 GraphQL クライアント
- **Selected Approach**: Ferry + ferry_generator + hive_store
- **Rationale**: 型安全性、コード生成、正規化キャッシュ、オフライン対応の要件を全て満たす
- **Trade-offs**: 初期設定の複雑さ vs 型安全性と DX 向上
- **Follow-up**: スキーマ取得と ferry_generator の設定を実装タスクで確認

### Decision: fpdart Either によるエラーハンドリング

- **Context**: 要件 8.1 で Result 型（fpdart または dartz）の選択が求められている
- **Alternatives Considered**:
  1. dartz - 古いが安定している
  2. multiple_result - シンプルな Result 型
- **Selected Approach**: fpdart v1 の Either<Failure, T>
- **Rationale**: 積極的なメンテナンス、豊富な API、Option と Task の統合
- **Trade-offs**: 学習コスト vs 明示的なエラーハンドリングによるコード品質向上
- **Follow-up**: Failure 型の階層構造を設計

### Decision: Material 3 + カスタムテーマシステム

- **Context**: 要件 4 で Material 3 ベースのデザインシステムとテーマ管理が求められている
- **Alternatives Considered**:
  1. Material 2 - レガシー
  2. Cupertino Only - iOS のみ
- **Selected Approach**: Material 3 の ThemeData + カスタム拡張（AppColors, AppTypography, AppSpacing）
- **Rationale**: Flutter 公式推奨、ダイナミックカラーのサポート
- **Trade-offs**: Material 3 の学習コスト vs プラットフォーム一貫性
- **Follow-up**: カスタム拡張の実装パターンを確定

## Risks & Mitigations

- **Risk 1**: Ferry の学習曲線 - Mitigation: サンプルコードと内部ドキュメントを整備
- **Risk 2**: build_runner の実行時間 - Mitigation: watch モード活用と増分ビルドの設定
- **Risk 3**: アーキテクチャの過剰設計 - Mitigation: 初期は最小限のレイヤーから開始し段階的に拡張
- **Risk 4**: パッケージ間の循環依存 - Mitigation: very_good_analysis の lint ルールで検出

## References

- [Flutter App Architecture with Riverpod](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/) - Riverpod アーキテクチャの基礎
- [go_router | Flutter package](https://pub.dev/packages/go_router) - 公式ルーティングパッケージ
- [freezed | Dart package](https://pub.dev/packages/freezed) - イミュータブルデータクラス生成
- [Ferry GraphQL](https://ferrygraphql.com/) - GraphQL クライアント公式ドキュメント
- [fpdart | Dart package](https://pub.dev/packages/fpdart) - 関数型プログラミングライブラリ
- [very_good_analysis | Dart package](https://pub.dev/packages/very_good_analysis) - Lint ルールパッケージ
- [mocktail | Dart package](https://pub.dev/packages/mocktail) - テストモックライブラリ

# Research & Design Decisions

## Summary
- **Feature**: `book-search`
- **Discovery Scope**: Complex Integration
- **Key Findings**:
  - Google Books API は無料で利用可能。デフォルトレートリミットは 1,000 リクエスト/日、1 リクエスト/秒/ユーザー
  - Open Library API は代替として利用可能だが、レガシー Books API は将来廃止予定。Search API への移行推奨
  - Flutter の mobile_scanner パッケージは EAN-13/ISBN-13 のスキャンに対応、クロスプラットフォームで動作

## Research Log

### Google Books API の仕様調査
- **Context**: 要件 5 で外部書籍 API との連携が必要
- **Sources Consulted**:
  - [Using the API | Google Books APIs](https://developers.google.com/books/docs/v1/using)
  - [Getting Started | Google Books APIs](https://developers.google.com/books/docs/v1/getting_started)
  - [Volume Reference | Google Books APIs](https://developers.google.com/books/docs/v1/reference/volumes)
- **Findings**:
  - Base URL: `https://www.googleapis.com/books/v1/volumes`
  - 検索クエリ: `q` パラメータで全文検索、`q=isbn:XXXX` で ISBN 検索、`q=subject:XXXX` でジャンル検索
  - ページネーション: `startIndex`（0始まり）と `maxResults`（デフォルト10、最大40）
  - レスポンス構造: `items[]` に `volumeInfo` (title, authors, publisher, publishedDate, industryIdentifiers, imageLinks)
  - 認証: 公開データは API キーのみで取得可能。OAuth 2.0 は My Library 操作時のみ必要
  - レートリミット: 1,000 リクエスト/日（デフォルト）、1 リクエスト/秒/ユーザー
- **Implications**:
  - 公開データのみを使用するため API キー認証で十分
  - レートリミットを考慮したキャッシュ戦略が必要
  - ジャンル検索は `subject:` キーワードで対応可能

### Open Library API の仕様調査
- **Context**: Google Books API のフォールバック候補として調査
- **Sources Consulted**:
  - [Search API | Open Library](https://openlibrary.org/dev/docs/api/search)
  - [Books API | Open Library](https://openlibrary.org/dev/docs/api/books)
  - [Covers API | Open Library](https://openlibrary.org/dev/docs/api/covers)
- **Findings**:
  - ISBN 検索: `https://openlibrary.org/isbn/{ISBN}.json`
  - 全文検索: `https://openlibrary.org/search.json?q={query}`
  - カバー画像: `https://covers.openlibrary.org/b/isbn/{ISBN}-M.jpg`
  - 認証: 不要（公開 API）
  - レートリミット: 明示的な記載なし
  - レガシー Books API は将来廃止予定
- **Implications**:
  - Google Books API が利用不可時のフォールバックとして採用可能
  - レスポンス形式が異なるため、マッピング層が必要

### Flutter バーコードスキャナー調査
- **Context**: 要件 3 で ISBN バーコードスキャン機能が必要
- **Sources Consulted**:
  - [mobile_scanner | pub.dev](https://pub.dev/packages/mobile_scanner)
  - [GitHub - juliansteenbakker/mobile_scanner](https://github.com/juliansteenbakker/mobile_scanner)
- **Findings**:
  - mobile_scanner パッケージが最適（MLKit/AVFoundation/ZXing 統合）
  - EAN-13（ISBN-13）のスキャンに対応
  - Android: MLKit バンドル版でアプリサイズ 3-10MB 増加
  - iOS: Info.plist に NSCameraUsageDescription 追加が必要
  - 複数バーコードの同時検出に対応
- **Implications**:
  - mobile_scanner パッケージを採用
  - カメラ権限の適切なハンドリングが必要
  - ISBN-13 形式でスキャン結果を取得し、API に送信

### 既存コードベースパターン分析
- **Context**: 既存アーキテクチャとの整合性確認
- **Sources Consulted**:
  - `apps/api/src/features/users/internal/*`
  - `apps/api/src/graphql/builder.ts`
  - `apps/mobile/lib/features/login/*`
- **Findings**:
  - API: Feature モジュール構成（graphql.ts, service.ts, repository.ts）
  - API: Pothos + ScopeAuthPlugin + ErrorsPlugin でスキーマ定義
  - API: Result<T, E> 型によるエラーハンドリング
  - Mobile: Feature-first + Clean Architecture
  - Mobile: Riverpod + freezed + go_router + Ferry
  - Mobile: Either<Failure, T> 型によるエラーハンドリング
- **Implications**:
  - 既存の Feature モジュールパターンに従って実装
  - Pothos の既存プラグイン構成を活用
  - エラー型は既存の DomainError / Failure パターンを拡張

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| 外部 API 直接呼び出し | Service 層から直接 Google Books API を呼び出し | シンプルな実装 | テスト困難、API 変更に脆弱 | 却下 |
| Repository パターン | ExternalBookRepository インターフェースで抽象化 | テスト容易、API 切り替え可能 | 追加の抽象化層 | 採用 |
| Adapter パターン | API 毎に Adapter を実装、統一インターフェースで呼び出し | 複数 API 対応、フォールバック実装容易 | やや複雑 | 採用（Repository 内で使用） |

## Design Decisions

### Decision: 外部書籍 API の選定
- **Context**: 要件 5 で外部書籍データベースとの連携が必要
- **Alternatives Considered**:
  1. Google Books API のみ使用
  2. Open Library API のみ使用
  3. Google Books API をプライマリ、Open Library をフォールバックとして使用
- **Selected Approach**: Google Books API をプライマリとして使用。フォールバックは初期リリースでは実装しない
- **Rationale**:
  - Google Books API は十分なデータ量と安定性を持つ
  - レートリミット（1,000/日）は初期利用には十分
  - Open Library のレガシー API は将来廃止予定のためリスクあり
- **Trade-offs**:
  - 単一 API 依存のリスクあり
  - 将来的にフォールバック実装の余地を残す設計とする
- **Follow-up**: 本番運用後のレートリミット使用状況をモニタリング

### Decision: ジャンルマッピング戦略
- **Context**: 要件 2 でジャンル検索（BUSINESS, FICTION, SELF_HELP, NON_FICTION）が必要
- **Alternatives Considered**:
  1. Google Books API の subject パラメータを直接使用
  2. 独自のジャンルマッピングテーブルを用意
- **Selected Approach**: 独自のジャンルマッピングを実装
- **Rationale**:
  - Google Books API の subject は正規化されていない
  - アプリ要件の 4 ジャンルに対応するサブジェクトを複数マッピング
- **Trade-offs**:
  - マッピングのメンテナンスコスト
  - 検索精度はマッピング品質に依存
- **Follow-up**: マッピング精度の検証とチューニング

### Decision: 検索デバウンス戦略
- **Context**: 要件 1.2 で 300ms デバウンスが必要
- **Alternatives Considered**:
  1. Flutter クライアント側でデバウンス
  2. API 側でデバウンス/スロットリング
- **Selected Approach**: Flutter クライアント側で 300ms デバウンス実装
- **Rationale**:
  - クライアント側デバウンスで不要な API 呼び出しを削減
  - サーバー負荷とレートリミット消費を抑制
  - Riverpod の AsyncNotifier で自然に実装可能
- **Trade-offs**:
  - クライアント側ロジックの増加
  - サーバー側での制御が効かない
- **Follow-up**: UX テストでデバウンス時間の最適化

### Decision: 本棚データ保存戦略
- **Context**: 要件 4 で書籍を本棚に追加する機能が必要
- **Alternatives Considered**:
  1. 外部 API の書籍 ID のみ保存
  2. 書籍メタデータを完全にコピーして保存
  3. 最小限のメタデータを保存し、必要時に外部 API から補完
- **Selected Approach**: 書籍メタデータを完全にコピーして保存
- **Rationale**:
  - 外部 API のデータ変更や削除に影響されない
  - オフライン時でも本棚データを表示可能
  - ユーザーの書籍コレクションは永続的に保持すべき
- **Trade-offs**:
  - データの重複保存によるストレージ増加
  - メタデータ更新の仕組みが必要（将来）
- **Follow-up**: データ同期戦略の検討

## Risks & Mitigations
- **Google Books API レートリミット** - API キー管理の厳格化、キャッシュ戦略の実装、将来的なフォールバック実装
- **外部 API の応答遅延** - 3 秒タイムアウト設定、ユーザーへの適切なフィードバック
- **カメラ権限拒否** - 設定画面への誘導 UI 実装、手動 ISBN 入力の代替手段
- **ジャンルマッピング精度** - 検索結果のモニタリング、マッピングテーブルの継続的改善

## References
- [Google Books API - Using the API](https://developers.google.com/books/docs/v1/using)
- [Google Books API - Getting Started](https://developers.google.com/books/docs/v1/getting_started)
- [Open Library API - Search](https://openlibrary.org/dev/docs/api/search)
- [mobile_scanner | pub.dev](https://pub.dev/packages/mobile_scanner)
- [Pothos GraphQL](https://pothos-graphql.dev/)

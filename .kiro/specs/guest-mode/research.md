# Research & Design Decisions

---
**Purpose**: ゲストモード機能のディスカバリーフェーズで得られた知見、アーキテクチャ調査、設計判断の根拠を記録する。
---

## Summary
- **Feature**: `guest-mode`
- **Discovery Scope**: Extension（既存の認証レイヤー、ルーティングガード、UI コンポーネント、API 認可を横断的に変更）
- **Key Findings**:
  - バックエンド: Pothos scope-auth プラグインの `authScopes` を削除するだけで公開クエリを実現可能。`GraphQLContext.user` は既に `null` を許容しており、context 構造の変更は不要
  - モバイル: `AuthStateData` に `isGuest` フラグを追加し、`guardRoute` のリダイレクトロジックを拡張する方式が最もシンプル。Ferry クライアントの `_AuthLink` は `token` が `null` の場合 Authorization ヘッダーを付与しない実装になっているため、ゲスト時は自動的にトークンなしリクエストになる
  - ゲストモードのセッション永続化は `SecureStorageService` を拡張して `isGuest` フラグを保存する方式が適切。`SharedPreferences` など別のストレージを導入する必要はない

## Research Log

### Pothos scope-auth プラグインの公開クエリ対応
- **Context**: searchBooks、searchBookByISBN、bookDetail の 3 クエリを未認証でもアクセス可能にする方法の調査
- **Sources Consulted**: 既存コード `apps/api/src/graphql/builder.ts`、`apps/api/src/features/books/internal/graphql.ts`
- **Findings**:
  - `builder.ts` の `scopeAuth.authScopes` で `loggedIn: !!context.user` を定義。`context.user` が null の場合 `loggedIn` は `false` となる
  - 各クエリの `authScopes: { loggedIn: true }` を削除するだけで、未認証リクエストでもクエリが実行可能になる
  - Pothos の scope-auth プラグインはフィールドレベルで `authScopes` を省略するとスコープチェックをスキップする設計
  - `GraphQLContext.user` の型は `AuthenticatedUser | null` であり、null 許容が既に組み込まれている
- **Implications**: バックエンド側の変更はクエリ定義の `authScopes` 行を削除するだけで完結する。スキーマ変更やミドルウェア変更は不要

### bookDetail クエリの userBook フィールド処理
- **Context**: 未認証ユーザーが bookDetail を呼んだ時、userBook フィールドをどう扱うか
- **Sources Consulted**: `apps/api/src/features/books/internal/graphql.ts` の bookDetail resolver（行 604-646）
- **Findings**:
  - 現在の resolver は `authenticatedContext.user?.uid` の存在を確認してから userBook を取得している
  - `context` を `AuthenticatedContext` にキャストしているが、実際のロジックは `authenticatedContext.user?.uid` のオプショナルチェーンで null ケースを処理済み
  - `authScopes` を削除した場合、`context.user` が null になるため `authenticatedContext.user?.uid` は `undefined` となり、`userBook` は `null` のまま返される
- **Implications**: bookDetail resolver のロジック変更は不要。`authScopes` 削除のみで要件 4.4 を満たす

### Ferry クライアントの認証トークン制御
- **Context**: ゲストモード時に認証トークンなしで GraphQL リクエストを送信する方法の調査
- **Sources Consulted**: `apps/mobile/lib/core/network/ferry_client.dart`
- **Findings**:
  - `_AuthLink` クラスの `request` メソッドで `if (token != null) 'Authorization': 'Bearer $token'` の条件分岐が既に存在する
  - `authTokenProvider` は `authStateProvider.select((s) => s.token)` でトークンを取得しており、ゲストモード時に `token` が `null` であれば Authorization ヘッダーは付与されない
  - `TokenService.ensureValidToken()` は `authState.isAuthenticated` が `false` の場合 `false` を返して早期リターンするため、ゲストモード時にはトークンリフレッシュも発生しない
- **Implications**: Ferry クライアントの変更は不要。`AuthStateData.isAuthenticated` が `false` かつ `token` が `null` であれば、既存の仕組みでトークンなしリクエストが送信される

### ゲストモードのセッション永続化
- **Context**: アプリ再起動時にゲストモードを復元する方法の調査
- **Sources Consulted**: `apps/mobile/lib/core/storage/secure_storage_service.dart`、`apps/mobile/lib/core/auth/auth_state.dart`
- **Findings**:
  - `SecureStorageService` は `FlutterSecureStorage` を使用し、認証データの保存・読み込み・クリアを管理している
  - `AuthState.restoreSession()` は `storage.loadAuthData()` を呼び、認証データがあれば `isAuthenticated: true` の状態を復元する
  - ゲストモードは認証データとは異なるため、`isGuest` フラグ専用のストレージキーを追加するのが適切
  - `SharedPreferences` は不要。`SecureStorageService` に `isGuest` フラグの保存・読み込み・クリアメソッドを追加する方式が一貫性を保つ
- **Implications**: `SecureStorageService` に 3 メソッド追加（`saveGuestMode`、`loadGuestMode`、`clearGuestMode`）し、`AuthState` に `restoreGuestSession` メソッドを追加する

### guardRoute のリダイレクトロジック
- **Context**: ゲストモード時のルートアクセス制御方法の調査
- **Sources Consulted**: `apps/mobile/lib/routing/app_router.dart` の `guardRoute` 関数（行 201-221）
- **Findings**:
  - 現在のロジックは `isAuthenticated` の二値判定のみ。未認証 + 非認証ルート + 非ウェルカム -> ウェルカムへリダイレクト
  - ゲストモードでは「未認証だが一部ルートへのアクセスを許可する」必要がある
  - `AuthStateData.isGuest` を判定に追加し、ゲスト許可ルート（`/search`、`/books/*`、`/home`、`/`、`/welcome`、`/auth/*`）を定義
  - `/account`、`/account/*`、`/lists/*` はゲスト不可としてウェルカム画面へリダイレクト
- **Implications**: `guardRoute` 関数にゲストモード分岐を追加。認証済み判定の前にゲストモード判定を挿入する

### ScreenHeader のアカウントアイコン制御
- **Context**: ゲストモード時にアカウントアイコンを非表示にする方法の調査
- **Sources Consulted**: `apps/mobile/lib/core/widgets/screen_header.dart`、`apps/mobile/lib/features/book_shelf/presentation/book_shelf_screen.dart`、`apps/mobile/lib/features/book_search/presentation/search_screen.dart`
- **Findings**:
  - `ScreenHeader` は `onProfileTap` コールバックと `avatarUrl` / `isAvatarLoading` プロパティを持つ
  - 本棚画面と検索画面の両方で使用されている
  - ゲストモード時にアバターアイコン領域を非表示にするには、`ScreenHeader` に `showAvatar` パラメータを追加するか、呼び出し元でゲスト判定を行う
- **Implications**: `ScreenHeader` に `showAvatar` パラメータ（デフォルト `true`）を追加し、ゲストモード時に `false` を渡す方式が最もクリーン

### 本棚画面のゲストモード対応
- **Context**: ゲストモード時にホームタブ（本棚画面）で何を表示するかの調査
- **Sources Consulted**: `apps/mobile/lib/features/book_shelf/presentation/book_shelf_screen.dart`
- **Findings**:
  - `BookShelfScreen` は `initState` で `statusSectionNotifierProvider` と `bookListNotifierProvider` を初期化している
  - ゲストモード時はこれらのデータロードをスキップし、ログインを促すメッセージを表示する必要がある
  - 要件 6.4 に従い、ホームタブへのアクセス自体は許可し、画面内でログイン促進を行う
- **Implications**: `BookShelfScreen` にゲストモード判定を追加し、ゲスト時はログイン促進ウィジェットを表示する

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| AuthStateData 拡張 | isGuest フラグを AuthStateData に追加し、既存の認証フローを拡張 | 最小限の変更、既存パターンとの一貫性 | AuthStateData の状態遷移が複雑化する可能性 | **採用**: 既存アーキテクチャとの親和性が最も高い |
| 別 GuestState Provider | ゲストモード専用の Provider を新設 | 関心の分離が明確 | 認証状態の二重管理になり、guardRoute での判定が複雑化 | 不採用: 認証状態は一元管理すべき |
| Firebase Anonymous Auth | Firebase の匿名認証を使用 | バックエンドでもユーザーを識別可能 | Firebase 依存が増す、匿名ユーザーの管理が必要、要件に対してオーバースペック | 不採用: 要件はクライアント側のゲスト判定のみ |

## Design Decisions

### Decision: AuthStateData に isGuest フラグを追加
- **Context**: ゲストモードの状態をどこで管理するか
- **Alternatives Considered**:
  1. AuthStateData に isGuest フラグを追加 -- 既存の認証状態管理を拡張
  2. 別の GuestStateProvider を新設 -- ゲスト専用の状態管理
  3. Firebase Anonymous Auth を使用 -- バックエンドでも匿名ユーザーを識別
- **Selected Approach**: AuthStateData に `isGuest` フラグを追加する。`isAuthenticated: false, isGuest: true` の組み合わせでゲスト状態を表現する
- **Rationale**: 既存の `guardRoute`、`_AuthLink`、`TokenService` が `authStateProvider` を参照しているため、認証状態を一元管理する方が変更箇所が最小限。ゲストモードは認証の代替手段であり、認証レイヤーに統合するのが自然
- **Trade-offs**: AuthStateData の状態遷移パターンが増える（initial -> guest、guest -> authenticated、authenticated -> initial）が、複雑さは限定的
- **Follow-up**: ゲスト -> 認証済み遷移時に `isGuest: false` への更新が正しく行われるかテストで検証

### Decision: バックエンド authScopes 削除方式
- **Context**: searchBooks、searchBookByISBN、bookDetail を公開クエリにする方法
- **Alternatives Considered**:
  1. `authScopes` を削除 -- 最もシンプル
  2. 新しい認可スコープ `public` を追加 -- 明示的だが過剰
- **Selected Approach**: 対象クエリの `authScopes: { loggedIn: true }` を削除する
- **Rationale**: Pothos scope-auth は `authScopes` が省略されたフィールドに対してスコープチェックをスキップする。新しいスコープ定義は不要で、削除のみで公開アクセスを実現できる
- **Trade-offs**: 公開クエリであることが暗黙的になる。コードコメントで意図を明示する
- **Follow-up**: 統合テストで未認証リクエストが成功することを検証

### Decision: ゲストモード時のウェルカム画面遷移方式
- **Context**: ゲストユーザーが保護された操作をタップした時のナビゲーション
- **Alternatives Considered**:
  1. `context.go(AppRoutes.welcome)` -- ナビゲーションスタックを置き換え
  2. `context.push(AppRoutes.welcome)` -- スタックに積む（戻るで元の画面に戻れる）
  3. ダイアログ表示 -- モーダルで案内
- **Selected Approach**: `context.push(AppRoutes.welcome)` でウェルカム画面をスタックに積む
- **Rationale**: ユーザーが「戻る」ボタンでゲストモードの画面に戻れるため、UX が自然。ログイン/登録を完了すれば認証済みとしてアプリ全体にアクセスできるようになり、guardRoute が自動的にリダイレクトを制御する
- **Trade-offs**: ナビゲーションスタックが深くなる可能性があるが、ゲスト -> ウェルカム -> ログイン のフローは最大 3 段程度なので問題なし
- **Follow-up**: ウェルカム画面での「アカウントなしで利用」タップ時に、既にゲストモード中であれば `context.pop()` で元の画面に戻る実装を検証

## Risks & Mitigations
- **Risk 1**: ゲストモード時に保護されたミューテーションを直接呼び出された場合の API エラーハンドリング -- **Mitigation**: 既存の `UNAUTHENTICATED` エラーが返されるため、クライアント側で適切にハンドリング済み。追加対応不要
- **Risk 2**: ゲストモードのセッション復元と認証済みセッション復元の競合 -- **Mitigation**: `restoreSession` の呼び出し順序で認証済みセッションを優先し、認証データがない場合のみゲストモードを確認する
- **Risk 3**: ゲストモードから認証済み状態への遷移時のデータ不整合 -- **Mitigation**: ログイン完了時に `isGuest: false` を設定し、`ShelfVersion` / `BookListVersion` による再取得が自動的に発動する

## References
- Pothos scope-auth plugin: `@pothos/plugin-scope-auth` -- フィールドレベルの認可スコープ制御
- go_router redirect: `go_router ^14.6.2` -- 認証ガードによるルートリダイレクト
- FlutterSecureStorage: `flutter_secure_storage` -- セキュアなキー・バリューストレージ

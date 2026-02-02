# Requirements Document

## Introduction

本ドキュメントは、Shelfie アプリケーションにゲストモード機能を導入するための要件を定義する。ゲストモードは、アカウントを持たないユーザーが本検索と本詳細の閲覧機能を利用できるようにする。本の追加や本棚操作などリソースを作成・変更する操作はログイン必須とし、ゲストユーザーがこれらの操作を試みた場合はウェルカム画面へ誘導する。

## Requirements

### Requirement 1: ゲストモードによるアプリ利用開始

**Objective:** As a 未登録ユーザー, I want アカウントなしでアプリの一部機能を試したい, so that 登録前にアプリの価値を判断できる

#### Acceptance Criteria

1. When ウェルカム画面が表示された時, the WelcomeButtons shall ログインボタンと新規登録ボタンの下に「アカウントなしで利用」リンクを表示する
2. When ユーザーが「アカウントなしで利用」リンクをタップした時, the AuthState shall ゲストモード状態を設定し、検索タブ画面へ遷移する
3. The 「アカウントなしで利用」リンク shall ログインボタン・新規登録ボタンよりも控えめなスタイル（テキストリンク）で表示する

### Requirement 2: ゲストモード時の認証状態管理

**Objective:** As a システム, I want ゲストモードの認証状態を適切に管理したい, so that ゲストユーザーと認証済みユーザーの権限を正しく区別できる

#### Acceptance Criteria

1. The AuthStateData shall ゲストモードかどうかを示すフラグ（isGuest）を保持する
2. While ゲストモードが有効な間, the AuthState shall isAuthenticated を false、isGuest を true として管理する
3. When アプリが再起動された時 and ゲストモード状態がローカルに保存されている場合, the AuthState shall ゲストモードセッションを復元する
4. When ゲストユーザーがログインまたは新規登録を完了した時, the AuthState shall ゲストモード状態を解除し、認証済み状態に遷移する

### Requirement 3: モバイルアプリのルーティングガード変更

**Objective:** As a ゲストユーザー, I want ログインなしで検索画面や本詳細画面にアクセスしたい, so that アプリの主要機能を体験できる

#### Acceptance Criteria

1. While ゲストモードが有効な間, the guardRoute shall 検索タブ（/search）へのアクセスを許可する
2. While ゲストモードが有効な間, the guardRoute shall 本詳細画面（/books/:bookId）へのアクセスを許可する
3. While ゲストモードが有効な間, the guardRoute shall ホームタブ（/home, /）へのアクセスを許可する
4. While ゲストモードが有効な間, the guardRoute shall ウェルカム画面（/welcome）および認証ルート（/auth/*）へのアクセスを許可する
5. While ゲストモードが有効な間, the guardRoute shall アカウント画面（/account, /account/*）へのアクセスをウェルカム画面へリダイレクトする
6. While ゲストモードが有効な間, the guardRoute shall リスト関連画面（/lists/*）へのアクセスをウェルカム画面へリダイレクトする

### Requirement 4: バックエンド API の認可変更（公開クエリ）

**Objective:** As a API, I want 本検索と本詳細の取得を未認証でも許可したい, so that ゲストユーザーが閲覧系機能を利用できる

#### Acceptance Criteria

1. The searchBooks クエリ shall authScopes の loggedIn 制約を解除し、未認証リクエストでも実行可能にする
2. The searchBookByISBN クエリ shall authScopes の loggedIn 制約を解除し、未認証リクエストでも実行可能にする
3. The bookDetail クエリ shall authScopes の loggedIn 制約を解除し、未認証リクエストでも実行可能にする
4. While ユーザーが未認証の間, the bookDetail クエリ shall userBook フィールドを null として返す

### Requirement 5: バックエンド API の認可維持（保護対象操作）

**Objective:** As a API, I want リソース作成・変更操作をログイン必須のままにしたい, so that データの整合性とセキュリティを保てる

#### Acceptance Criteria

1. The addBookToShelf ミューテーション shall authScopes の loggedIn 制約を維持する
2. The updateReadingStatus ミューテーション shall authScopes の loggedIn 制約を維持する
3. The updateReadingNote ミューテーション shall authScopes の loggedIn 制約を維持する
4. The updateBookRating ミューテーション shall authScopes の loggedIn 制約を維持する
5. The removeFromShelf ミューテーション shall authScopes の loggedIn 制約を維持する
6. The myShelf クエリ shall authScopes の loggedIn 制約を維持する
7. The userBookByExternalId クエリ shall authScopes の loggedIn 制約を維持する
8. If 未認証ユーザーが保護対象の操作を実行した場合, the API shall UNAUTHENTICATED エラーを返す

### Requirement 6: ゲストモード時の操作制限（モバイルアプリ）

**Objective:** As a ゲストユーザー, I want ログインが必要な操作をタップした時に案内を受けたい, so that アカウント作成の動機付けを自然に得られる

#### Acceptance Criteria

1. When ゲストユーザーが本詳細画面で「本棚に追加」ボタンをタップした時, the アプリ shall ウェルカム画面を表示する
2. When ゲストユーザーが本詳細画面で読書ステータス変更操作をタップした時, the アプリ shall ウェルカム画面を表示する
3. When ゲストユーザーが本詳細画面で評価・メモ操作をタップした時, the アプリ shall ウェルカム画面を表示する
4. When ゲストユーザーがホームタブ（本棚画面）にアクセスした時, the アプリ shall ログインを促すメッセージを表示する
5. When ゲストユーザーが ISBN スキャン機能をタップした時, the アプリ shall ウェルカム画面を表示する

### Requirement 7: ゲストモード時の UI 要素非表示

**Objective:** As a ゲストユーザー, I want 利用不可能な機能の導線を見せないでほしい, so that 混乱なくアプリを利用できる

#### Acceptance Criteria

1. While ゲストモードが有効な間, the ナビゲーションバー shall ホームタブ（ライブラリ）のアイコンとラベルを表示しつつ、タップ時にログイン促進を行う
2. While ゲストモードが有効な間, the アカウントアイコン/導線 shall 非表示にする
3. While ゲストモードが有効な間, the リスト作成・リスト詳細への導線 shall 非表示にする

### Requirement 8: ゲストモードからの認証済み状態への移行

**Objective:** As a ゲストユーザー, I want いつでもログイン・新規登録できるようにしたい, so that ゲストモードから認証済みユーザーにスムーズに移行できる

#### Acceptance Criteria

1. When ゲストユーザーがウェルカム画面に遷移した時, the WelcomeScreen shall ログインボタンと新規登録ボタンを通常通り表示する
2. When ゲストユーザーがログインを完了した時, the AuthState shall ゲストモードフラグを解除し、認証済み状態に更新する
3. When ゲストユーザーが新規登録を完了した時, the AuthState shall ゲストモードフラグを解除し、認証済み状態に更新する
4. When 認証済み状態への移行が完了した時, the guardRoute shall 全ルートへのアクセスを通常通り許可する
5. When ゲストユーザーがウェルカム画面で「アカウントなしで利用」リンクをタップした時, the アプリ shall 検索タブ画面に戻る（既にゲストモード中のため）

### Requirement 9: ゲストモード時のデータクリーンアップ

**Objective:** As a システム, I want ゲストモード時の不要なデータ操作を防ぎたい, so that アプリのメモリとストレージを適切に管理できる

#### Acceptance Criteria

1. While ゲストモードが有効な間, the アプリ shall 本棚データ（ShelfState）をロードしない
2. While ゲストモードが有効な間, the アプリ shall リストデータ（BookListState）をロードしない
3. While ゲストモードが有効な間, the Ferry クライアント shall 認証トークンを含まない GraphQL リクエストを送信する
4. When ゲストモードから認証済み状態に移行した時, the アプリ shall 本棚データとリストデータを新たにロードする

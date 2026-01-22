# Requirements Document

## Introduction
本機能は、Shelfie アプリにおける書籍検索機能を提供する。ユーザーは全文検索、ISBN スキャンを通じて書籍を検索し、自分の本棚に追加できる。バックエンドは GraphQL API として実装され、外部書籍データベース API（Google Books API / Open Library API）と連携して書籍情報を取得する。

## Requirements

### Requirement 1: 全文検索
**Objective:** ユーザーとして、キーワードで書籍を検索したい。読みたい本を素早く見つけるため。

#### Acceptance Criteria
1. When ユーザーが検索バーにキーワードを入力する, the Book Search API shall 入力されたキーワードを含む書籍の一覧を返却する
2. When ユーザーが検索バーにキーワードを入力し、300ms 以上キー入力がない, the Mobile App shall 検索クエリを API に送信する
3. When 検索結果が取得される, the Mobile App shall 書籍のカバー画像、タイトル、著者名、出版社、出版年を表示する
4. While 検索処理中, the Mobile App shall ローディングインジケーターを表示する
5. If 検索結果が0件, the Book Search API shall 空の配列を返却する
6. If 外部APIからエラーが返却される, the Book Search API shall 適切なエラーメッセージを含む GraphQL エラーを返却する

### Requirement 2: ISBN スキャン
**Objective:** ユーザーとして、本のバーコードをスキャンして書籍を追加したい。手元にある本を簡単に登録するため。

#### Acceptance Criteria
1. When ユーザーが「ISBNスキャン」ボタンをタップする, the Mobile App shall カメラを起動しバーコードスキャン画面を表示する
2. When バーコードが認識される, the Mobile App shall ISBN コードを抽出し API に検索クエリを送信する
3. When ISBN 検索クエリが送信される, the Book Search API shall 指定された ISBN に一致する書籍情報を返却する
4. If 指定された ISBN の書籍が外部APIに存在しない, the Book Search API shall 書籍が見つからないことを示すレスポンスを返却する
5. When 書籍情報が取得される, the Mobile App shall 書籍の詳細情報を表示し、本棚への追加を確認する
6. If カメラへのアクセスが拒否されている, the Mobile App shall 設定画面への誘導メッセージを表示する

### Requirement 3: 本棚への追加
**Objective:** ユーザーとして、検索結果から書籍を本棚に追加したい。読書管理を行うため。

#### Acceptance Criteria
1. When ユーザーが書籍一覧の追加ボタン（+）をタップする, the Mobile App shall 書籍を本棚に追加するリクエストを API に送信する
2. When 書籍追加リクエストが送信される, the Book API shall 書籍情報をユーザーの本棚に保存する
3. When 書籍が正常に追加される, the Mobile App shall 追加完了のフィードバックを表示する
4. If 同じ書籍が既に本棚に存在する, the Book API shall 重複エラーを返却する
5. While 認証されていない状態, the Book API shall 書籍追加リクエストを拒否し認証エラーを返却する

### Requirement 4: 外部書籍API連携
**Objective:** システムとして、外部書籍データベースから書籍情報を取得したい。豊富な書籍データを提供するため。

#### Acceptance Criteria
1. The Book Search API shall 外部書籍API（Google Books API または Open Library API）を使用して書籍情報を取得する
2. When 外部APIから書籍情報を取得する, the Book Search API shall タイトル、著者、出版社、出版年、ISBN、カバー画像URLを含む情報を返却する
3. If 外部APIがタイムアウトする, the Book Search API shall 3秒以内にタイムアウトエラーを返却する
4. If 外部APIのレートリミットに達する, the Book Search API shall リトライまたはフォールバック処理を実行する
5. The Book Search API shall 外部APIのレスポンスを内部の Book 型にマッピングする

### Requirement 5: GraphQL スキーマ
**Objective:** 開発者として、型安全な GraphQL スキーマを提供したい。フロントエンドとの連携を効率化するため。

#### Acceptance Criteria
1. The Book Search API shall 以下の Query を提供する: searchBooks(query: String!, limit: Int, offset: Int), searchBookByISBN(isbn: String!)
2. The Book Search API shall 以下の Mutation を提供する: addBookToShelf(bookInput: AddBookInput!)
3. The Book Search API shall Book 型に以下のフィールドを含める: id, title, authors, publisher, publishedDate, isbn, coverImageUrl
4. The Book Search API shall ページネーション用に SearchBooksResult 型を提供し、items, totalCount, hasMore フィールドを含める
5. The Book Search API shall Pothos を使用して Code-first でスキーマを定義する

### Requirement 6: エラーハンドリング
**Objective:** システムとして、適切なエラーハンドリングを提供したい。ユーザー体験を損なわないため。

#### Acceptance Criteria
1. If 外部APIとの通信に失敗する, the Book Search API shall NetworkError を返却する
2. If リクエストパラメータが不正, the Book Search API shall ValidationError を返却する
3. If 認証が必要な操作で認証されていない, the Book Search API shall AuthenticationError を返却する
4. When エラーが発生する, the Book Search API shall エラーログを構造化フォーマット（Pino）で出力する
5. The Mobile App shall エラー種別に応じた適切なユーザー向けメッセージを表示する

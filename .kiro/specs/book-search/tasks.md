# Implementation Plan

## Task 1: データベーススキーマの定義とマイグレーション

- [x] 1. データベーススキーマの定義とマイグレーション
  - books テーブルを定義する（external_id, title, authors, publisher, published_date, isbn, cover_image_url）
  - user_books テーブルを定義する（user_id, book_id, added_at）
  - ISBN と external_id にユニーク制約を設定する
  - user_id と book_id の組み合わせにユニーク制約を設定する
  - 外部キー制約と適切なインデックスを設定する
  - マイグレーションを生成して適用する
  - _Requirements: 3.2, 3.4, 5.3_

## Task 2: 外部書籍 API 連携の実装

- [ ] 2. 外部書籍 API 連携の実装
- [ ] 2.1 (P) Google Books API クライアントの実装
  - Google Books API への HTTP リクエスト機能を実装する
  - キーワード検索（q パラメータ）に対応する
  - ISBN 検索（q=isbn:XXX）に対応する
  - ページネーション（startIndex, maxResults）に対応する
  - 3 秒のタイムアウトを設定する
  - API キーを環境変数から取得する
  - _Requirements: 4.1, 4.3_

- [ ] 2.2 Google Books API レスポンスを内部 Book 型にマッピングする
  - volumeInfo からタイトル、著者、出版社、出版年を抽出する
  - industryIdentifiers から ISBN-13 または ISBN-10 を抽出する
  - imageLinks からカバー画像 URL を抽出する
  - _Requirements: 4.2, 4.5_

- [ ] 2.3 外部 API エラーハンドリングの実装
  - ネットワークエラーを検出して適切なエラー型に変換する
  - タイムアウトエラーを検出して適切なエラー型に変換する
  - レートリミットエラーを検出して適切なエラー型に変換する
  - API エラー（4xx/5xx）を検出して適切なエラー型に変換する
  - _Requirements: 4.3, 4.4, 6.1_

## Task 3: 書籍検索サービスの実装

- [ ] 3. 書籍検索サービスの実装
- [ ] 3.1 キーワード検索機能の実装
  - 検索クエリを受け取り外部 API を呼び出す
  - 検索結果を SearchBooksResult 型（items, totalCount, hasMore）で返却する
  - 検索クエリが空の場合はバリデーションエラーを返す
  - limit と offset のパラメータバリデーションを行う
  - _Requirements: 1.1, 1.5_

- [ ] 3.2 ISBN 検索機能の実装
  - ISBN を受け取り外部 API で単一書籍を検索する
  - 書籍が見つかった場合は Book 型を返却する
  - 書籍が見つからない場合は null を返却する
  - _Requirements: 2.3, 2.4_

- [ ] 3.3 検索サービスのエラーハンドリングとログ出力
  - 外部 API エラーを適切な DomainError に変換する
  - Pino を使用して構造化ログを出力する
  - エラー種別ごとに適切なログレベルを設定する
  - _Requirements: 1.6, 6.1, 6.4_

## Task 4: 本棚管理サービスの実装

- [ ] 4. 本棚管理サービスの実装
- [ ] 4.1 本棚リポジトリの実装
  - ISBN による書籍検索機能を実装する
  - ユーザーと書籍の関連付け（user_books）の検索機能を実装する
  - 書籍の新規作成または既存書籍の取得（findOrCreate）機能を実装する
  - ユーザーの本棚への書籍追加機能を実装する
  - _Requirements: 3.2_

- [ ] 4.2 本棚サービスの実装
  - 書籍を本棚に追加するビジネスロジックを実装する
  - 同一ユーザーが同一書籍を追加しようとした場合は重複エラーを返す
  - 追加成功時は UserBook 型を返却する
  - 構造化ログを出力する
  - _Requirements: 3.2, 3.4, 6.4_

## Task 5: GraphQL スキーマと Resolver の実装

- [ ] 5. GraphQL スキーマと Resolver の実装
- [ ] 5.1 GraphQL 型定義の実装
  - Pothos を使用して Book 型を定義する（id, title, authors, publisher, publishedDate, isbn, coverImageUrl）
  - SearchBooksResult 型を定義する（items, totalCount, hasMore）
  - AddBookInput 入力型を定義する
  - UserBook 型を定義する（id, book, addedAt）
  - _Requirements: 5.3, 5.4, 5.5_

- [ ] 5.2 検索 Query の実装
  - searchBooks Query を実装する（query, limit, offset パラメータ）
  - searchBookByISBN Query を実装する（isbn パラメータ）
  - 入力バリデーションエラーを GraphQL エラーとして返却する
  - _Requirements: 5.1, 6.2_

- [ ] 5.3 本棚追加 Mutation の実装
  - addBookToShelf Mutation を実装する（bookInput パラメータ）
  - 認証スコープ（ScopeAuth）を設定して未認証ユーザーを拒否する
  - 重複エラーを GraphQL エラーとして返却する
  - 認証エラーを GraphQL エラーとして返却する
  - _Requirements: 3.5, 5.2, 6.2, 6.3_

## Task 6: モバイルアプリ GraphQL クライアントの実装

- [ ] 6. モバイルアプリ GraphQL クライアントの実装
- [ ] 6.1 (P) GraphQL クエリとミューテーションの定義
  - searchBooks クエリを定義する
  - searchBookByISBN クエリを定義する
  - addBookToShelf ミューテーションを定義する
  - Ferry でコード生成を実行する
  - _Requirements: 5.1, 5.2_

- [ ] 6.2 (P) 書籍検索リポジトリの実装
  - Ferry クライアントを使用して GraphQL API と通信する
  - 検索結果を Either<Failure, T> 型で返却する
  - API エラーを適切な Failure 型に変換する
  - _Requirements: 6.5_

## Task 7: モバイルアプリ状態管理の実装

- [ ] 7. モバイルアプリ状態管理の実装
- [ ] 7.1 書籍検索状態モデルの定義
  - freezed を使用して BookSearchState を定義する（initial, loading, success, empty, error）
  - Book モデルを定義する
  - Failure 型を拡張してネットワークエラー、認証エラー、バリデーションエラーに対応する
  - _Requirements: 6.5_

- [ ] 7.2 BookSearchNotifier の実装
  - 300ms のデバウンス付きキーワード検索機能を実装する
  - ISBN 検索機能を実装する
  - 本棚追加機能を実装する
  - ページネーション（loadMore）機能を実装する
  - エラーをユーザー向けメッセージに変換する
  - _Requirements: 1.2, 6.5_

## Task 8: 検索画面 UI の実装

- [ ] 8. 検索画面 UI の実装
- [ ] 8.1 検索バーと ISBN スキャンボタンの実装
  - 検索バーを実装してキーワード入力を受け付ける
  - ISBN スキャンボタンを配置する
  - _Requirements: 1.2_

- [ ] 8.2 検索結果一覧の実装
  - 検索結果を ListView.builder で表示する
  - 書籍のカバー画像、タイトル、著者名、出版社、出版年を表示する
  - 追加ボタン（+）を配置して本棚追加を可能にする
  - ローディングインジケーターを表示する
  - 検索結果が 0 件の場合は空状態を表示する
  - エラー発生時はエラーメッセージを表示する
  - _Requirements: 1.3, 1.4, 3.1, 3.3, 6.5_

## Task 9: ISBN スキャン機能の実装

- [ ] 9. ISBN スキャン機能の実装
- [ ] 9.1 カメラとバーコードスキャナーのセットアップ
  - mobile_scanner パッケージを追加する
  - iOS の Info.plist にカメラ使用説明を追加する
  - Android のカメラ権限を設定する
  - _Requirements: 2.1_

- [ ] 9.2 ISBN スキャン画面の実装
  - カメラプレビューを表示する
  - バーコード（EAN-13）を検出して ISBN を抽出する
  - カメラ権限が拒否されている場合は設定画面への誘導メッセージを表示する
  - _Requirements: 2.1, 2.2, 2.6_

- [ ] 9.3 スキャン結果からの書籍詳細表示と本棚追加
  - スキャンした ISBN で書籍を検索する
  - 書籍の詳細情報を表示する
  - 書籍が見つからない場合はメッセージを表示する
  - 本棚への追加確認ダイアログを表示する
  - 追加完了時はフィードバックを表示する
  - _Requirements: 2.3, 2.4, 2.5, 3.1, 3.3_

## Task 10: API 統合テストの実装

- [ ] 10. API 統合テストの実装
- [ ] 10.1 (P) 検索 Query の統合テスト
  - searchBooks Query のテストを実装する
  - searchBookByISBN Query のテストを実装する
  - 外部 API をモックして正常系・異常系をテストする
  - _Requirements: 1.1, 1.5, 1.6, 2.3, 2.4_

- [ ] 10.2 (P) 本棚追加 Mutation の統合テスト
  - addBookToShelf Mutation の正常系テストを実装する
  - 重複追加時のエラーテストを実装する
  - 未認証時のエラーテストを実装する
  - _Requirements: 3.2, 3.4, 3.5, 6.2, 6.3_

## Task 11: モバイルアプリユニットテストの実装

- [ ] 11. モバイルアプリユニットテストの実装
- [ ] 11.1 (P) BookSearchNotifier のユニットテスト
  - デバウンス動作のテストを実装する
  - 検索状態遷移のテストを実装する
  - エラーハンドリングのテストを実装する
  - _Requirements: 1.2, 6.5_

- [ ]*11.2 (P) 検索画面のウィジェットテスト
  - 検索バーの入力テストを実装する
  - 検索結果表示のテストを実装する
  - ローディング状態のテストを実装する
  - _Requirements: 1.3, 1.4_

## Task 12: 全体統合とルーティング設定

- [ ] 12. 全体統合とルーティング設定
- [ ] 12.1 API Feature 統合
  - books Feature を GraphQL スキーマに登録する
  - 環境変数に Google Books API キーを追加する
  - サービスの依存性注入を設定する
  - _Requirements: 4.1, 5.5_

- [ ] 12.2 モバイルアプリルーティング統合
  - 検索画面へのルートを設定する
  - ISBN スキャン画面へのモーダルルートを設定する
  - 既存のプレースホルダー検索画面を実装で置き換える
  - _Requirements: 2.1_

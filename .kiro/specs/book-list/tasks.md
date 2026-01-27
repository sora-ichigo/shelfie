# Implementation Plan

## Task Overview

リスト機能の実装タスク。API層（Drizzle + Pothos）とMobile層（Flutter + Riverpod + Ferry）を並行開発し、最後に統合テストで検証する。

---

## Tasks

- [ ] 1. データベーススキーマとマイグレーションの作成
- [ ] 1.1 BookList と BookListItem テーブルの Drizzle スキーマを定義する
  - book_lists テーブル（id, userId, title, description, createdAt, updatedAt）を作成する
  - book_list_items テーブル（id, listId, userBookId, position, addedAt）を作成する
  - users テーブルへの外部キー制約（CASCADE DELETE）を設定する
  - user_books テーブルへの外部キー制約（CASCADE DELETE）を設定する
  - listId と userBookId の複合ユニーク制約を設定する
  - 検索パフォーマンス用のインデックスを作成する
  - _Requirements: 10.1, 10.2, 10.3, 10.4, 10.5, 10.6_

- [ ] 1.2 マイグレーションを生成して適用する
  - Drizzle Kit でマイグレーションファイルを生成する
  - 開発環境でマイグレーションを実行して検証する
  - _Requirements: 10.1, 10.2_

- [ ] 2. API リポジトリ層の実装
- [ ] 2.1 (P) BookListRepository を実装する
  - リスト作成機能（userId, title, description を保存）を実装する
  - リスト取得機能（ID指定、ユーザーID指定）を実装する
  - リスト更新機能（title, description, updatedAt を更新）を実装する
  - リスト削除機能（カスケード削除）を実装する
  - _Requirements: 1.5, 2.5, 3.3, 10.1_

- [ ] 2.2 (P) BookListItemRepository を実装する
  - アイテム作成機能（position を末尾に設定）を実装する
  - アイテム取得機能（listId 指定、重複チェック用）を実装する
  - アイテム削除機能を実装する
  - アイテム並べ替え機能（position 再計算）を実装する
  - _Requirements: 4.3, 5.2, 6.3, 10.2_

- [ ] 3. API サービス層の実装
- [ ] 3.1 リスト CRUD のビジネスロジックを実装する
  - リスト作成時のバリデーション（タイトル必須）を実装する
  - リスト編集時の所有者チェックを実装する
  - リスト削除時の確認と関連アイテムのカスケード削除を実装する
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 2.1, 2.2, 2.3, 2.4, 2.5, 3.1, 3.2, 3.3, 3.4_

- [ ] 3.2 本の追加・削除・並べ替えのビジネスロジックを実装する
  - 本の追加時に UserBook の存在確認を行う
  - 重複追加の検知とエラー返却を実装する
  - 本の削除時に UserBook 自体は削除しない制御を実装する
  - 並べ替え時の position 一括更新を実装する
  - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5, 5.1, 5.2, 5.3, 6.1, 6.2, 6.3_

- [ ] 3.3 リスト一覧・詳細取得のビジネスロジックを実装する
  - ユーザーのリスト一覧取得（表紙画像4枚、冊数集計）を実装する
  - リスト詳細取得（アイテム一覧を position 順）を実装する
  - 所有者以外のアクセス時の FORBIDDEN エラーを実装する
  - _Requirements: 8.1, 8.2, 8.3, 8.4, 9.1, 9.4_

- [ ] 4. API GraphQL 層の実装
- [ ] 4.1 GraphQL 型定義を実装する
  - BookList, BookListItem, BookListDetail, BookListSummary 型を定義する
  - CreateBookListInput, UpdateBookListInput 入力型を定義する
  - エラー型（LIST_NOT_FOUND, FORBIDDEN, DUPLICATE_BOOK 等）を定義する
  - _Requirements: 10.1, 10.2_

- [ ] 4.2 Query リゾルバを実装する
  - myBookLists クエリ（認証必須、リスト一覧返却）を実装する
  - bookListDetail クエリ（listId 指定、所有者チェック）を実装する
  - _Requirements: 8.1, 9.1_

- [ ] 4.3 Mutation リゾルバを実装する
  - createBookList ミューテーションを実装する
  - updateBookList ミューテーションを実装する
  - deleteBookList ミューテーションを実装する
  - addBookToList ミューテーションを実装する
  - removeBookFromList ミューテーションを実装する
  - reorderBookInList ミューテーションを実装する
  - _Requirements: 1.1, 1.2, 2.1, 2.2, 3.2, 4.2, 4.8, 5.1, 6.2_

- [ ] 5. API ユニットテストの実装
- [ ] 5.1 (P) リポジトリ層のテストを実装する
  - BookList CRUD 操作のテストを作成する
  - BookListItem 操作のテストを作成する
  - カスケード削除のテストを作成する
  - _Requirements: 10.6_

- [ ] 5.2 (P) サービス層のテストを実装する
  - リスト作成・編集・削除のバリデーションテストを作成する
  - 所有者チェックのテストを作成する
  - 重複追加検知のテストを作成する
  - position 再計算のテストを作成する
  - _Requirements: 1.4, 2.4, 4.5_

- [ ] 6. Mobile GraphQL 定義とコード生成
- [ ] 6.1 GraphQL オペレーション定義を作成する
  - myBookLists クエリの .graphql ファイルを作成する
  - bookListDetail クエリの .graphql ファイルを作成する
  - createBookList, updateBookList, deleteBookList ミューテーションを定義する
  - addBookToList, removeBookFromList, reorderBookInList ミューテーションを定義する
  - _Requirements: 1.2, 2.2, 3.2, 4.2, 5.1, 6.2, 8.1, 9.1_

- [ ] 6.2 Ferry コード生成を実行する
  - build_runner で GraphQL 型と操作クラスを生成する
  - 生成された型が設計と一致することを確認する
  - _Requirements: 10.1, 10.2_

- [ ] 7. Mobile リポジトリ・状態管理層の実装
- [ ] 7.1 BookListRepository を実装する
  - Ferry クライアントを使用した GraphQL 通信を実装する
  - Result 型（Either<Failure, T>）によるエラーハンドリングを実装する
  - 全ての CRUD 操作のメソッドを実装する
  - _Requirements: 1.2, 2.2, 3.2, 4.2, 5.1, 6.2, 8.1, 9.1_

- [ ] 7.2 BookListNotifier を実装する
  - リスト一覧の状態管理（loading, loaded, error）を実装する
  - リスト詳細の状態管理を実装する
  - 楽観的更新（並べ替え時）を実装する
  - リスト作成・編集・削除後の状態リフレッシュを実装する
  - _Requirements: 1.2, 2.2, 3.2, 4.2, 5.1, 6.2_

- [ ] 8. Mobile UI コンポーネントの実装
- [ ] 8.1 (P) BookListCard ウィジェット（縦長バリアント）を実装する
  - 2x2 表紙コラージュレイアウトを実装する
  - タイトル、冊数、説明文の表示を実装する
  - 本が4冊未満の場合の表示調整を実装する
  - 本が0冊の場合のプレースホルダー表示を実装する
  - タップでリスト詳細画面への遷移を実装する
  - _Requirements: 7.6, 8.2, 8.3, 8.4, 8.5_

- [ ] 8.2 (P) BookListCard ウィジェット（横長バリアント）を実装する
  - 単一表紙画像の表示を実装する
  - タイトル、冊数+説明文（1行）の表示を実装する
  - 右矢印アイコンの表示を実装する
  - タップでリスト詳細画面への遷移を実装する
  - _Requirements: 7.7, 8.5_

- [ ] 8.3 BookListDetailScreen を実装する
  - リストヘッダー（タイトル、説明、編集ボタン）を実装する
  - 本一覧を position 順で表示する
  - 本タップで本詳細画面への遷移を実装する
  - _Requirements: 9.1, 9.2, 9.3, 9.4_

- [ ] 8.4 BookListEditScreen を実装する
  - 作成/編集フォーム（タイトル必須、説明任意）を実装する
  - タイトル空欄時のバリデーションエラー表示を実装する
  - リスト削除の確認ダイアログを実装する
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 2.1, 2.2, 2.3, 2.4, 3.1, 3.2_

- [ ] 8.5 本の追加・削除・並べ替え UI を実装する
  - 本の追加ボタンと BookSelectorModal への遷移を実装する
  - 本の削除操作（スワイプまたはボタン）を実装する
  - ドラッグ＆ドロップによる並べ替えを実装する
  - ドラッグ中の視覚的ハイライトを実装する
  - _Requirements: 4.1, 4.2, 5.1, 6.1, 6.2_

- [ ] 8.6 BookSelectorModal を実装する
  - 本棚の本一覧を表示する
  - 既にリストに追加済みの本をグレーアウト表示する
  - 本選択時の追加確定処理を実装する
  - 重複追加防止の通知表示を実装する
  - _Requirements: 4.1, 4.2, 4.5_

- [ ] 8.7 ListSelectorModal を実装する
  - ユーザーのリスト一覧を表示する
  - 既に本が追加済みのリストにチェックマークを表示する
  - 新規リスト作成オプションを提供する
  - リスト選択時の本追加処理を実装する
  - _Requirements: 4.6, 4.7, 4.8_

- [ ] 9. マイライブラリ画面の拡張
- [ ] 9.1 フィルタタブを実装する
  - 「すべて」「本」「リスト」の3つのタブを実装する
  - タブ切り替え時の表示内容変更を実装する
  - _Requirements: 7.1_

- [ ] 9.2 「すべて」タブの表示を実装する
  - 上部にリスト一覧（縦長カード）を水平スクロールで表示する
  - 下部に「最近追加した本」セクションを水平スクロールで表示する
  - 「すべて見る」リンクタップで「本」タブへの切り替えを実装する
  - _Requirements: 7.2, 7.5_

- [ ] 9.3 「本」タブの表示を実装する
  - 従来のマイライブラリ表示（ソート/グループ化機能）を維持する
  - _Requirements: 7.3_

- [ ] 9.4 「リスト」タブの表示を実装する
  - リスト一覧（横長カード）を縦スクロールで表示する
  - 新規作成ボタンを表示する
  - _Requirements: 7.4, 7.7_

- [ ] 10. 既存画面への導線追加
- [ ] 10.1 BookDetailScreen に「リストに追加」ボタンを追加する
  - ボタンタップで ListSelectorModal を表示する
  - 追加完了後のフィードバック表示を実装する
  - _Requirements: 4.6_

- [ ] 10.2 QuickActionSheet に「リストに追加」アクションを追加する
  - 長押しメニューに新規アクションを追加する
  - アクションタップで ListSelectorModal を表示する
  - _Requirements: 4.7_

- [ ] 11. ルーティング設定
- [ ] 11.1 新規画面のルートを設定する
  - BookListDetailScreen のルートを追加する
  - BookListEditScreen のルートを追加する
  - ディープリンク対応を考慮する
  - _Requirements: 8.5, 9.1_

- [ ] 12. 統合テストの実装
- [ ] 12.1 (P) API 統合テストを実装する
  - リスト作成から本追加・並べ替え・削除までの E2E フローをテストする
  - カスケード削除の動作をテストする
  - 認証・認可エラーのテストを作成する
  - _Requirements: 1.1, 1.2, 3.3, 3.4, 4.3, 4.4_

- [ ] 12.2 (P) Mobile ウィジェットテストを実装する
  - BookListCard の表紙コラージュ表示をテストする
  - BookListEditScreen のフォームバリデーションをテストする
  - FilterTabs のタブ切り替えをテストする
  - _Requirements: 1.4, 2.4, 7.1, 8.2, 8.3, 8.4_

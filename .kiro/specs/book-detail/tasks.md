# Implementation Plan

## Task Overview

本詳細画面の実装タスク。API スキーマ拡張、GraphQL Query/Mutation 追加、モバイル Feature モジュール実装を含む。

---

- [x] 1. データベーススキーマ拡張
- [x] 1.1 userBooks テーブルに読書記録フィールドを追加
  - reading_status カラム（enum: backlog, reading, completed, dropped）を追加し、デフォルト値を 'backlog' に設定
  - completed_at カラム（タイムスタンプ、nullable）を追加
  - note カラム（テキスト、nullable）を追加
  - note_updated_at カラム（タイムスタンプ、nullable）を追加
  - マイグレーションを生成・適用し、既存レコードに影響がないことを確認
  - _Requirements: 4.2, 4.3, 4.4, 4.5, 4.6, 5.2_

- [x] 2. API GraphQL スキーマ拡張
- [x] 2.1 ReadingStatus enum と UserBook 型拡張を定義
  - ReadingStatus enum（BACKLOG, READING, COMPLETED, DROPPED）を Pothos で定義
  - UserBook 型に readingStatus、completedAt、note、noteUpdatedAt フィールドを追加
  - _Requirements: 4.2, 5.2_

- [x] 2.2 (P) bookDetail クエリを実装
  - Google Books API から書籍詳細情報を取得するクエリを実装
  - 表紙画像、タイトル、著者、出版社、発売日、ページ数、ジャンル、ISBN、説明文を返却
  - Amazon URL と infoLink を生成して返却
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 7.1, 7.2_

- [x] 2.3 (P) userBookByExternalId クエリを実装
  - externalId（Google Books ID）でユーザーの本棚登録を検索するクエリを実装
  - 認証必須とし、ログインユーザーの登録のみ返却
  - 未登録の場合は null を返却
  - _Requirements: 3.1, 4.1_

- [x] 2.4 updateReadingStatus ミューテーションを実装
  - userBookId と status を受け取り、読書状態を更新
  - status が COMPLETED の場合は completedAt を現在日時に自動設定
  - 所有者チェックを行い、他ユーザーのデータは更新不可
  - _Requirements: 5.3, 5.4, 5.6_

- [x] 2.5 updateReadingNote ミューテーションを実装
  - userBookId と note を受け取り、読書メモを更新
  - noteUpdatedAt を現在日時に自動設定
  - 空文字での保存を許可（メモ削除として扱う）
  - 所有者チェックを行い、他ユーザーのデータは更新不可
  - _Requirements: 6.4, 6.5, 6.7_

- [x] 3. API ビジネスロジック実装
- [x] 3.1 BookShelfService に読書状態更新メソッドを追加
  - updateReadingStatus メソッドを実装し、状態変更時の日時自動設定ロジックを含める
  - COMPLETED 選択時に completedAt を設定、他の状態選択時は completedAt をクリア
  - _Requirements: 5.3, 5.4_

- [x] 3.2 (P) BookShelfService に読書メモ更新メソッドを追加
  - updateReadingNote メソッドを実装し、更新日時の自動設定ロジックを含める
  - メモが空文字でも保存可能とする
  - _Requirements: 6.4, 6.5_

- [x] 3.3 (P) getUserBookByExternalId メソッドを実装
  - externalId とユーザー ID で本棚登録を検索するメソッドを実装
  - 本棚追加状態の判定に使用
  - _Requirements: 3.1, 4.1_

- [x] 4. モバイル GraphQL クエリ・ミューテーション定義
- [x] 4.1 Ferry 用 GraphQL オペレーションファイルを作成
  - bookDetail クエリを定義
  - userBookByExternalId クエリを定義
  - updateReadingStatus ミューテーションを定義
  - updateReadingNote ミューテーションを定義
  - コード生成を実行して型安全なクライアントコードを生成
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 3.2, 4.1, 4.2, 5.3, 6.4_

- [ ] 5. モバイル Domain 層実装
- [ ] 5.1 (P) BookDetail エンティティと ReadingStatus enum を定義
  - freezed で BookDetail モデルを定義（表紙、タイトル、著者、書誌情報、説明文、外部リンク）
  - ReadingStatus enum（backlog, reading, completed, dropped）を定義
  - 欠損フィールドを nullable で表現
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 5.2_

- [ ] 5.2 (P) Failure 型を拡張
  - NotFoundFailure を追加（書籍が見つからない場合）
  - ForbiddenFailure を追加（権限エラー）
  - DuplicateBookFailure を追加（既に本棚に追加済み）
  - _Requirements: 3.4, 5.6, 6.7_

- [ ] 6. モバイル Data 層実装
- [ ] 6.1 BookDetailRepository を実装
  - Ferry クライアントを使用して GraphQL API と通信
  - getBookDetail メソッドで書籍詳細を取得し、Either 型で結果を返却
  - addBookToShelf メソッドで本棚追加を実行（既存の addUserBook ミューテーションを使用）
  - updateReadingStatus メソッドで読書状態を更新
  - updateReadingNote メソッドで読書メモを更新
  - ネットワークエラー・タイムアウトを適切にハンドリング
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 3.2, 3.4, 5.3, 5.6, 6.4, 6.7_

- [ ] 7. モバイル Application 層実装
- [ ] 7.1 BookDetailNotifier を実装
  - @riverpod アノテーションで状態管理プロバイダーを定義
  - loadBookDetail で書籍詳細と本棚追加状態を取得
  - addToShelf で本棚追加処理を実行し、成功時に状態を更新
  - updateReadingStatus で読書状態を更新し、成功時に状態を反映
  - updateReadingNote で読書メモを更新し、成功時に状態を反映
  - エラー発生時は適切な Failure 状態に遷移
  - _Requirements: 3.2, 3.3, 3.4, 5.3, 5.4, 5.5, 5.6, 6.4, 6.5, 6.6, 6.7_

- [ ] 8. モバイル Presentation 層 - 本詳細画面
- [ ] 8.1 BookDetailScreen の基本構造を実装
  - go_router の pathParameters から bookId を取得
  - 画面表示時に BookDetailNotifier 経由でデータを取得
  - ローディング、エラー、データ表示の各状態を実装
  - AppBar に閉じるボタン（x）と共有ボタンを配置
  - _Requirements: 1.1, 2.1, 2.2, 2.3, 2.4_

- [ ] 8.2 書籍基本情報セクションを実装
  - 表紙画像を cached_network_image で表示（中央配置、大きめサイズ）
  - タイトルと著者名を表示
  - 書誌情報（出版社、発売日、ページ数、ジャンル、ISBN）を表示
  - 作品紹介セクションに説明文を表示
  - 各フィールドが null の場合は非表示またはプレースホルダー表示
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5_

- [ ] 8.3 本棚追加状態に応じた UI 分岐を実装
  - 未追加状態: 「+ 本棚に追加」ボタンを目立つ位置に表示
  - 追加済み状態: 読書記録セクションを表示
  - 追加ボタンタップ時に addToShelf を呼び出し、成功時に UI を更新
  - 追加失敗時にエラーメッセージをスナックバーで表示
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 4.1_

- [ ] 8.4 読書記録セクションを実装
  - 現在の読書状態（積読/読書中/読了/読まない）をタップ可能なフィールドで表示
  - 追加日を表示
  - 読了状態の場合は読了日を表示
  - 読書メモセクションをタップ可能な領域で表示
  - メモが存在する場合は最終更新日時を表示
  - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5, 4.6_

- [ ] 8.5 外部リンクセクションを実装
  - 「Amazonで見る」リンクを表示
  - 公式サイト情報がある場合は「公式サイトへ」リンクを表示
  - タップ時に url_launcher で外部ブラウザまたはアプリ内 WebView を開く
  - _Requirements: 7.1, 7.2, 7.3_

- [ ] 9. モバイル Presentation 層 - モーダルシート
- [ ] 9.1 ReadingStatusModal を実装
  - showModalBottomSheet で画面下部からスライドアップ表示
  - 4 つの読書状態（積読/読書中/読了/読まない）をラジオボタンで表示
  - 現在の状態を初期選択として設定
  - 保存ボタンとキャンセルボタンを配置
  - 保存時に BookDetailNotifier.updateReadingStatus を呼び出し
  - 成功時にモーダルを閉じて画面を更新、失敗時にエラーメッセージを表示
  - 変更がない場合は保存ボタンを無効化
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5, 5.6_

- [ ] 9.2 ReadingNoteModal を実装
  - showModalBottomSheet で画面下部からスライドアップ表示（isScrollControlled: true でキーボード対応）
  - 複数行テキストエリアを配置
  - 既存メモがある場合は初期値として表示
  - 保存ボタンとキャンセルボタンを配置
  - 保存時に BookDetailNotifier.updateReadingNote を呼び出し
  - 成功時にモーダルを閉じて画面を更新、失敗時にエラーメッセージを表示
  - 空文字での保存を許可
  - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5, 6.6, 6.7_

- [ ] 10. 画面遷移とルーティング統合
- [ ] 10.1 既存の /books/:bookId ルートを実装に置き換え
  - 書籍検索結果画面からのタップで BookDetailScreen に遷移するよう設定
  - 閉じるボタンで前の画面に戻る処理を実装
  - 共有ボタンで OS 標準の共有シートを表示（share_plus パッケージを使用）
  - _Requirements: 2.1, 2.2, 2.3, 2.4_

- [ ] 11. テスト実装
- [ ] 11.1 (P) API ユニットテストを実装
  - BookShelfService の読書状態更新ロジックをテスト（completedAt の自動設定含む）
  - BookShelfService の読書メモ更新ロジックをテスト（noteUpdatedAt の自動設定含む）
  - ReadingStatus enum のシリアライズ/デシリアライズをテスト
  - _Requirements: 5.3, 5.4, 6.4, 6.5_

- [ ] 11.2 (P) モバイルユニットテストを実装
  - BookDetailNotifier の状態遷移をテスト（loading → loaded → error）
  - BookDetailRepository の GraphQL レスポンスマッピングをテスト
  - エラーハンドリングのテスト（ネットワークエラー、認証エラー、権限エラー）
  - _Requirements: 3.4, 5.6, 6.7_

- [ ] 11.3 モバイルウィジェットテストを実装
  - BookDetailScreen の本棚追加済み/未追加の UI 分岐をテスト
  - ReadingStatusModal のステータス選択、保存/キャンセルをテスト
  - ReadingNoteModal のテキスト入力、保存/キャンセルをテスト
  - フィールド欠損時の表示処理をテスト
  - _Requirements: 1.5, 3.1, 4.1, 5.1, 5.5, 6.1, 6.6_

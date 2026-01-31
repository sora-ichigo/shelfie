# Implementation Plan

- [ ] 1. API: readingStatus フィルタの実装
- [ ] 1.1 Repository 層に readingStatus フィルタを追加する
  - `GetUserBooksInput` に `readingStatus` パラメータを追加し、指定時に WHERE 条件でフィルタする
  - 未指定時は既存動作（全ステータス返却）を維持する
  - `totalCount` もフィルタ条件を反映した正確な件数を返す
  - 既存の `query` 検索やソート条件との AND 結合が正しく動作する
  - ユニットテストで readingStatus 指定時・未指定時・query との組み合わせを検証する
  - _Requirements: 1.1, 1.2, 1.4, 1.5_

- [ ] 1.2 Service 層と GraphQL スキーマに readingStatus フィルタを追加する
  - Service 層で `readingStatus` パラメータを Repository に伝搬する
  - `MyShelfInput` に `ReadingStatus` 型のオプショナルフィールド `readingStatus` を追加する
  - myShelf Resolver で入力値を Service 層に渡す
  - 統合テストで GraphQL クエリ経由の readingStatus フィルタ動作を検証する
  - 1.1 の Repository 変更に依存するため順次実行
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5_

- [ ] 2. Mobile: GraphQL クエリとリポジトリの readingStatus 対応
- [ ] 2.1 GraphQL クエリ定義に readingStatus パラメータを追加する
  - `my_shelf_paginated.graphql` の `MyShelfInput` に `readingStatus` 引数を追加する
  - Ferry コード生成を実行して型定義を更新する
  - タスク 1 の API スキーマ変更が完了している必要がある
  - _Requirements: 1.3, 3.1_

- [ ] 2.2 BookShelfRepository に readingStatus パラメータを追加する
  - `getMyShelf` メソッドにオプショナルな `readingStatus` パラメータを追加する
  - Ferry のリクエストビルダーに `readingStatus` をセットする
  - 2.1 のコード生成が完了している必要がある
  - _Requirements: 3.1_

- [ ] 3. Mobile: StatusSectionNotifier の実装
- [ ] 3.1 StatusSectionState モデルを定義する
  - freezed sealed class で initial / loading / loaded / error の 4 状態を定義する
  - loaded 状態に書籍リスト・残りページ有無・追加読み込み中フラグ・総件数を持たせる
  - error 状態に Failure 型を持たせる
  - _Requirements: 3.2, 3.5, 6.1_

- [ ] 3.2 StatusSectionNotifier を Riverpod ファミリー Provider として実装する
  - ReadingStatus をパラメータに取るファミリー Provider を定義する
  - initialize メソッドで指定ステータスの初回データ取得を行い ShelfState (SSOT) に登録する
  - loadMore メソッドで offset を進めて追加データを既存リストに結合する
  - refresh メソッドで offset をリセットして最新データで状態を更新する
  - removeBook メソッドでローカルリストから書籍を除去し totalCount を減算する
  - retry メソッドでエラー後の再取得を行う
  - ユニットテストで各メソッドの状態遷移とエラーハンドリングを検証する
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 5.1, 5.2, 6.2, 6.3_

- [ ] 4. Mobile: セクション表示 UI の実装
- [ ] 4.1 (P) StatusSection ウィジェットを実装する
  - セクションヘッダーにステータス名と件数を表示する
  - StatusSectionState に応じて書籍グリッド・ローディング・エラー表示を切り替える
  - 既存の BookGrid ウィジェットを再利用して書籍グリッドを描画する
  - エラー時にリトライボタンを表示し、タップで StatusSectionNotifier.retry を呼び出す
  - Sliver ベースで実装し、親の CustomScrollView に統合できるようにする
  - スクロール末尾到達時に loadMore を自動実行する
  - _Requirements: 2.4, 3.3, 3.5, 5.3, 6.1, 6.3_

- [ ] 4.2 (P) StatusSectionList ウィジェットを実装する
  - 4 つのステータスセクションを「読書中 → 積読 → 読了 → 読まない」の固定順で配置する
  - 各セクションの Notifier 状態を監視し、loaded かつ totalCount が 0 のセクションを非表示にする
  - CustomScrollView と SliverList で全セクションを単一スクロール内に配置する
  - _Requirements: 2.1, 2.2, 2.3_

- [ ] 5. Mobile: 既存グループ化機能の削除と画面統合
- [ ] 5.1 クライアント側のグループ化機能を削除する
  - GroupOption 列挙型（none, byStatus, byAuthor）を削除する
  - BookShelfNotifier 内のグループ化ロジック（_groupBooks 等）を削除する
  - グループ化の切り替え UI コンポーネントを削除する
  - 関連するテストやインポートをクリーンアップする
  - _Requirements: 4.1, 4.2, 4.3_

- [ ] 5.2 BookShelfScreen にセクション表示を統合する
  - 既存のフラットリスト表示を StatusSectionList に置き換える
  - ステータス別セクション表示をデフォルトかつ唯一の表示モードとする
  - 画面表示時に 4 セクション分の Notifier を初期化し並行クエリを実行する
  - 5.1 の削除が完了している必要がある
  - _Requirements: 4.4, 2.1, 2.2_

- [ ] 6. Mobile: 読書状態変更時のセクション同期
- [ ] 6.1 読書状態変更時のセクション間書籍移動を実装する
  - ShelfState の読書状態変更を検知し、変更元セクションから書籍を除去する
  - 変更先セクションのデータを再取得して最新状態を反映する
  - セクションの件数表示を更新する
  - 変更失敗時は ShelfState の Optimistic Update ロールバックに従い元の状態に戻す
  - 失敗時にエラーメッセージを SnackBar で表示する
  - ユニットテストで成功時の移動と失敗時のロールバックを検証する
  - _Requirements: 5.1, 5.2, 5.3, 5.4_

- [ ] 7. 結合テストとエラーハンドリングの検証
- [ ] 7.1 (P) API の統合テストを追加する
  - readingStatus フィルタ指定時に該当ステータスの本のみ返却されることを検証する
  - readingStatus と sortBy, limit, offset の組み合わせが正しく動作することを検証する
  - _Requirements: 1.1, 1.4, 1.5_

- [ ] 7.2 (P) Mobile のウィジェットテストを追加する
  - StatusSectionList で 4 セクションが正しい順序で表示されることを検証する
  - 空セクションが非表示になることを検証する
  - StatusSection でヘッダーにステータス名と件数が表示されることを検証する
  - エラー時にリトライボタンが表示され、タップで再取得が行われることを検証する
  - 各セクションのエラーが他セクションに影響しないことを検証する
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 6.1, 6.2, 6.3_

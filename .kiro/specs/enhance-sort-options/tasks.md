# Implementation Plan

- [x] 1. API 側の GraphQL enum とソートロジックを拡張する
- [x] 1.1 ShelfSortField enum に COMPLETED_AT と PUBLISHED_DATE を追加する
  - GraphQL の ShelfSortField enum に読了日と発売日の 2 つの値を追加する
  - ShelfSortFieldValue 型にも新しい値を含める
  - 既存の ADDED_AT、TITLE、AUTHOR の定義は変更しない
  - _Requirements: 1.4, 2.5, 4.1_

- [x] 1.2 BookShelfRepository のソートカラムマッピングに新フィールドを追加する
  - sortColumn マッピングオブジェクトに completedAt と publishedDate のカラム参照を追加する
  - completedAt ソートでは NULLS LAST を使い、null の書籍を末尾に配置する
  - publishedDate ソートでは null と空文字の両方を CASE 式で末尾に配置し、文字列の辞書順で正しい日付順を実現する
  - Drizzle の sql テンプレートを使用して ORDER BY 句を構築する（asc/desc は NULLS LAST を直接サポートしないため）
  - 昇順・降順の両方向で null 値が常に末尾に配置されることを保証する
  - デフォルトソート（ADDED_AT DESC）の動作は変更しない
  - _Requirements: 1.1, 1.2, 1.3, 2.1, 2.2, 2.3, 2.4, 4.1, 4.2_

- [x] 2. API 側のテストを作成する
- [x] 2.1 (P) 読了日ソートのユニットテストを追加する
  - COMPLETED_AT の降順ソートで completedAt が新しい順に返却されることを検証する
  - COMPLETED_AT の昇順ソートで completedAt が古い順に返却されることを検証する
  - completedAt が null の書籍がソート結果の末尾に配置されることを検証する
  - _Requirements: 1.1, 1.2, 1.3_

- [x] 2.2 (P) 発売日ソートのユニットテストを追加する
  - PUBLISHED_DATE の降順ソートで publishedDate が新しい順に返却されることを検証する
  - PUBLISHED_DATE の昇順ソートで publishedDate が古い順に返却されることを検証する
  - publishedDate が null の書籍がソート結果の末尾に配置されることを検証する
  - publishedDate が空文字の書籍がソート結果の末尾に配置されることを検証する
  - _Requirements: 2.1, 2.2, 2.3, 2.4_

- [x] 2.3 (P) 既存ソートオプションの回帰テストを追加する
  - ADDED_AT、TITLE、AUTHOR の各ソートが従来通り動作することを検証する
  - ソートフィールド未指定時に ADDED_AT DESC がデフォルトとして使用されることを検証する
  - _Requirements: 4.1, 4.2_

- [x] 3. モバイル側の GraphQL スキーマ更新とコード生成を行う
- [x] 3.1 モバイル側の schema.graphql を更新する
  - ShelfSortField enum に COMPLETED_AT と PUBLISHED_DATE を追加する
  - API 側の enum 定義と一致させる
  - _Requirements: 1.4, 2.5_

- [x] 3.2 Ferry のコード生成を実行する
  - build_runner で GShelfSortField に新しい値が自動生成されることを確認する
  - GShelfSortField.COMPLETED_AT と GShelfSortField.PUBLISHED_DATE が利用可能になることを確認する
  - _Requirements: 1.4, 2.5_

- [x] 4. モバイル側の SortOption enum を拡張する
- [x] 4.1 SortOption enum に 4 つの新しいソートオプションを追加する
  - completedAtDesc（読了日・新しい順）を追加し、GShelfSortField.COMPLETED_AT と GSortOrder.DESC を設定する
  - completedAtAsc（読了日・古い順）を追加し、GShelfSortField.COMPLETED_AT と GSortOrder.ASC を設定する
  - publishedDateDesc（発売日・新しい順）を追加し、GShelfSortField.PUBLISHED_DATE と GSortOrder.DESC を設定する
  - publishedDateAsc（発売日・古い順）を追加し、GShelfSortField.PUBLISHED_DATE と GSortOrder.ASC を設定する
  - 各値に日本語の displayName を設定する
  - 既存の 4 つのオプションと defaultOption は変更しない
  - SearchFilterBar は SortOption.values を動的にイテレートしているため、UI への反映は自動的に行われる
  - SortOptionNotifier と BookShelfSettingsRepository も汎用的に動作するため、変更不要
  - _Requirements: 1.5, 2.6, 3.1, 3.2, 3.3, 4.3_

- [x] 5. モバイル側のテストを作成する
- [x] 5.1 (P) SortOption enum の新しい値のユニットテストを追加する
  - completedAtDesc の sortField が GShelfSortField.COMPLETED_AT、sortOrder が GSortOrder.DESC であることを検証する
  - completedAtAsc の sortField が GShelfSortField.COMPLETED_AT、sortOrder が GSortOrder.ASC であることを検証する
  - publishedDateDesc の sortField が GShelfSortField.PUBLISHED_DATE、sortOrder が GSortOrder.DESC であることを検証する
  - publishedDateAsc の sortField が GShelfSortField.PUBLISHED_DATE、sortOrder が GSortOrder.ASC であることを検証する
  - 各値の displayName が正しい日本語ラベルであることを検証する
  - _Requirements: 1.5, 2.6_

- [x] 5.2 (P) 既存ソートオプションの復元互換性テストを追加する
  - 既存の 4 つのソートオプション名がローカルストレージから正しく復元されることを検証する
  - 新しいソートオプション名もローカルストレージから正しく保存・復元されることを検証する
  - 未知の値が保存されている場合に defaultOption にフォールバックすることを検証する
  - _Requirements: 3.2, 4.3_

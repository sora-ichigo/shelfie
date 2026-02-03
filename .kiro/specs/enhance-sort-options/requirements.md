# Requirements Document

## Introduction

本棚のソートオプションを拡充する機能の要件定義。現在は「追加日（新しい順/古い順）」「タイトル（A->Z）」「著者名（A->Z）」の4つのソートオプションがあるが、「読了日（completedAt）」と「発売日（publishedDate）」によるソートを新たに追加する。API側（GraphQL enum、リポジトリのソートマッピング）とモバイル側（Dart SortOption enum、UI）の両方を変更する。publishedDate は text 型なので適切なソート処理が必要であり、completedAt が null の書籍の扱いも考慮する。

## Requirements

### Requirement 1: 読了日ソートの追加

**Objective:** ユーザーとして、本棚の書籍を読了日順で並べ替えたい。読了した書籍を時系列で振り返ることができるようにするため。

#### Acceptance Criteria

1. When ユーザーがソートオプション「読了日（新しい順）」を選択した場合, the API shall completedAt の降順で書籍一覧を返却する
2. When ユーザーがソートオプション「読了日（古い順）」を選択した場合, the API shall completedAt の昇順で書籍一覧を返却する
3. While completedAt が null の書籍が存在する場合, the API shall completedAt が null の書籍をソート結果の末尾に配置する
4. The GraphQL ShelfSortField enum shall COMPLETED_AT の値を含む
5. The Dart SortOption enum shall completedAtDesc（読了日・新しい順）と completedAtAsc（読了日・古い順）の値を含む

### Requirement 2: 発売日ソートの追加

**Objective:** ユーザーとして、本棚の書籍を発売日順で並べ替えたい。新刊や古典の書籍を発売時期で整理できるようにするため。

#### Acceptance Criteria

1. When ユーザーがソートオプション「発売日（新しい順）」を選択した場合, the API shall publishedDate の降順で書籍一覧を返却する
2. When ユーザーがソートオプション「発売日（古い順）」を選択した場合, the API shall publishedDate の昇順で書籍一覧を返却する
3. While publishedDate が text 型で格納されている場合, the API shall 文字列としての辞書順ソートにより正しい日付順を実現する
4. While publishedDate が null または空文字の書籍が存在する場合, the API shall 該当書籍をソート結果の末尾に配置する
5. The GraphQL ShelfSortField enum shall PUBLISHED_DATE の値を含む
6. The Dart SortOption enum shall publishedDateDesc（発売日・新しい順）と publishedDateAsc（発売日・古い順）の値を含む

### Requirement 3: モバイルUIでの新ソートオプション表示

**Objective:** ユーザーとして、本棚画面のソート選択UIから新しいソートオプション（読了日・発売日）を選択できるようにしたい。直感的にソート方法を切り替えられるようにするため。

#### Acceptance Criteria

1. The ソート選択UI shall 既存の4つのソートオプションに加えて、読了日（新しい順）、読了日（古い順）、発売日（新しい順）、発売日（古い順）の4つを表示する
2. When ユーザーが新しいソートオプションを選択した場合, the SortOptionNotifier shall 選択されたオプションを状態として保持し、ローカルストレージに永続化する
3. When ソートオプションが変更された場合, the BookShelfNotifier shall 新しいソートパラメータでサーバーから書籍一覧を再取得する

### Requirement 4: 既存ソート機能との互換性

**Objective:** 開発者として、新しいソートオプションの追加が既存のソート機能に影響を与えないことを保証したい。既存ユーザーの体験を損なわないため。

#### Acceptance Criteria

1. The API shall 既存のソートオプション（ADDED_AT、TITLE、AUTHOR）の動作を変更しない
2. The API shall ソートフィールドが指定されない場合、従来通り ADDED_AT の DESC をデフォルトとして使用する
3. While ユーザーのローカルストレージに保存済みのソートオプションが既存の4つのいずれかである場合, the モバイルアプリ shall そのソートオプションを引き続き正しく復元する

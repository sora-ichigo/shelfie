# Requirements Document

## Introduction

本ドキュメントは、Shelfie モバイルアプリケーションの検索タブ機能の改善に関する要件を定義する。ユーザーが過去の検索履歴を簡単に呼び出せるようにし、初期表示時に「最近チェックした本」セクションを表示することで、検索体験を向上させる。

## Requirements

### Requirement 1: 検索履歴の保存と管理

**Objective:** ユーザーとして、過去に検索したクエリを保存してほしい。再度同じ検索を行う際に入力の手間を省くため。

#### Acceptance Criteria

1. When ユーザーが検索を実行した時, the SearchTab shall 検索クエリを検索履歴としてローカルストレージに保存する
2. The SearchTab shall 最大20件の検索履歴を保持する
3. When 検索履歴が20件を超えた時, the SearchTab shall 最も古い履歴を自動的に削除する
4. The SearchTab shall 重複する検索クエリを履歴に追加しない（既存の同一クエリは最新として更新する）

### Requirement 2: 検索履歴の表示と補完

**Objective:** ユーザーとして、検索フィールドをタップした際に過去の検索履歴を候補として表示してほしい。素早く過去の検索を再実行できるようにするため。

#### Acceptance Criteria

1. When ユーザーが検索フィールドをタップした時, the SearchTab shall 検索履歴を候補リストとして表示する
2. While 検索履歴が存在する間, the SearchTab shall 履歴を新しい順に表示する
3. When ユーザーが検索クエリを入力している間, the SearchTab shall 入力内容に部分一致する履歴のみをフィルタリングして表示する
4. When ユーザーが履歴候補をタップした時, the SearchTab shall その検索クエリで検索を実行する
5. If 検索履歴が存在しない場合, the SearchTab shall 候補リストを表示しない

### Requirement 3: 検索履歴の削除

**Objective:** ユーザーとして、不要な検索履歴を削除できるようにしてほしい。履歴リストを整理できるようにするため。

#### Acceptance Criteria

1. When ユーザーが履歴項目を左スワイプした時, the SearchTab shall 削除ボタンを表示する
2. When ユーザーが削除ボタンをタップした時, the SearchTab shall 該当する検索履歴を削除する
3. When ユーザーが「履歴をすべて削除」アクションを実行した時, the SearchTab shall すべての検索履歴をクリアする

### Requirement 4: 最近チェックした本の表示

**Objective:** ユーザーとして、検索タブの初期表示で最近チェックした本を確認したい。興味のあった本に素早くアクセスできるようにするため。

#### Acceptance Criteria

1. When 検索タブが初期表示される時, the SearchTab shall 「最近チェックした本」セクションを表示する
2. The SearchTab shall 最近チェックした本を最大10件表示する
3. When ユーザーが本の詳細画面を閲覧した時, the SearchTab shall その本を「最近チェックした本」リストに追加する
4. When 「最近チェックした本」リストが10件を超えた時, the SearchTab shall 最も古い項目を自動的に削除する
5. If 最近チェックした本が存在しない場合, the SearchTab shall 「最近チェックした本」セクションを非表示にするか、空状態メッセージを表示する

### Requirement 5: 最近チェックした本の操作

**Objective:** ユーザーとして、最近チェックした本のリストから素早く本の詳細にアクセスしたい。閲覧履歴から効率的に本を探せるようにするため。

#### Acceptance Criteria

1. When ユーザーが「最近チェックした本」の項目をタップした時, the SearchTab shall 該当する本の詳細画面に遷移する
2. The SearchTab shall 「最近チェックした本」の各項目に書籍のカバー画像とタイトルを表示する
3. While 書籍のカバー画像が利用できない間, the SearchTab shall プレースホルダー画像を表示する

### Requirement 6: 検索状態の管理

**Objective:** ユーザーとして、検索タブの状態が適切に管理されてほしい。スムーズな検索体験を得るため。

#### Acceptance Criteria

1. When ユーザーが検索フィールド外をタップした時, the SearchTab shall 検索候補リストを非表示にする
2. When ユーザーが検索を実行した時, the SearchTab shall 検索結果を表示し、「最近チェックした本」セクションを非表示にする
3. When ユーザーが検索をクリアした時, the SearchTab shall 初期表示状態（最近チェックした本セクション表示）に戻る

# Requirements Document

## Introduction
本ドキュメントは、Shelfie アプリにおける「リスト」機能の要件を定義する。リスト機能は、ユーザーが本棚の本を自由に分類・整理できる機能であり、Spotify のプレイリストのようなイメージで設計される。マイライブラリ画面に「すべて/本/リスト」のフィルタを追加し、リストの作成・編集・削除、本の追加・削除・並べ替えを可能にする。シェア機能は将来的な拡張として本 MVP には含めない。

## Requirements

### Requirement 1: リストの作成
**Objective:** ユーザーとして、新しいリストを作成したい。これにより、本棚の本を自由にカテゴリ分けして整理できる。

#### Acceptance Criteria
1. When ユーザーがリストタブで新規作成ボタンをタップした時, the モバイルアプリ shall リスト作成画面を表示する
2. When ユーザーがリストタイトルを入力して保存をタップした時, the モバイルアプリ shall 新しいリストを作成してリスト一覧に追加する
3. When ユーザーがリスト作成時に説明を入力した場合, the モバイルアプリ shall 説明をリストのメタデータとして保存する
4. If リストタイトルが空の状態で保存をタップした場合, then the モバイルアプリ shall バリデーションエラーを表示して保存を拒否する
5. The API shall リスト作成時に userId, title, description(任意), createdAt, updatedAt を保存する

### Requirement 2: リストの編集
**Objective:** ユーザーとして、既存のリストのタイトルや説明を編集したい。これにより、リストの内容を正確に反映した名前に変更できる。

#### Acceptance Criteria
1. When ユーザーがリスト詳細画面で編集ボタンをタップした時, the モバイルアプリ shall リスト編集画面を表示する
2. When ユーザーがリストのタイトルを変更して保存をタップした時, the モバイルアプリ shall リストのタイトルを更新する
3. When ユーザーがリストの説明を変更して保存をタップした時, the モバイルアプリ shall リストの説明を更新する
4. If 編集後のタイトルが空の場合, then the モバイルアプリ shall バリデーションエラーを表示して保存を拒否する
5. The API shall リスト編集時に updatedAt を更新する

### Requirement 3: リストの削除
**Objective:** ユーザーとして、不要になったリストを削除したい。これにより、リスト一覧を整理できる。

#### Acceptance Criteria
1. When ユーザーがリストの削除操作を実行した時, the モバイルアプリ shall 削除確認ダイアログを表示する
2. When ユーザーが削除確認ダイアログで確定をタップした時, the モバイルアプリ shall リストを削除してリスト一覧から除去する
3. When リストが削除された時, the API shall リストに含まれる BookListItem も合わせて削除する
4. The API shall リスト削除時に本棚の本自体（UserBook）は削除しない

### Requirement 4: リストへの本の追加
**Objective:** ユーザーとして、本棚にある本をリストに追加したい。これにより、本をテーマやジャンルごとに分類できる。

#### Acceptance Criteria
1. When ユーザーがリスト編集画面で本の追加ボタンをタップした時, the モバイルアプリ shall 本棚の本一覧から選択できる画面を表示する
2. When ユーザーが本を選択して追加を確定した時, the モバイルアプリ shall 選択した本をリストに追加する
3. When 本がリストに追加された時, the API shall BookListItem を作成し position を末尾に設定する
4. The API shall 本棚にある本（UserBook）のみをリストに追加可能とする
5. If 既にリストに追加されている本を再度追加しようとした場合, then the モバイルアプリ shall 重複追加を防止し通知を表示する
6. When ユーザーが本詳細画面で「リストに追加」ボタンをタップした時, the モバイルアプリ shall リスト選択モーダルを表示する
7. When ユーザーが本カードを長押ししてクイックアクションの「リストに追加」をタップした時, the モバイルアプリ shall リスト選択モーダルを表示する
8. When ユーザーがリスト選択モーダルでリストを選択した時, the モバイルアプリ shall 該当の本を選択したリストに追加する

### Requirement 5: リストからの本の削除
**Objective:** ユーザーとして、リストから本を削除したい。これにより、リストの内容を整理できる。

#### Acceptance Criteria
1. When ユーザーがリスト編集画面で本の削除操作を実行した時, the モバイルアプリ shall 該当の本をリストから削除する
2. When 本がリストから削除された時, the API shall BookListItem を削除する
3. The API shall リストから本を削除しても本棚の本自体（UserBook）は削除しない

### Requirement 6: リスト内の本の並べ替え
**Objective:** ユーザーとして、リスト内の本の順序を変更したい。これにより、優先度や読書順を自由に設定できる。

#### Acceptance Criteria
1. When ユーザーがリスト編集画面で本をドラッグした時, the モバイルアプリ shall ドラッグ中の本を視覚的にハイライトする
2. When ユーザーが本を新しい位置にドロップした時, the モバイルアプリ shall 本の順序を更新してリストを再描画する
3. When 本の順序が変更された時, the API shall 影響を受ける BookListItem の position を更新する

### Requirement 7: マイライブラリのフィルタ機能
**Objective:** ユーザーとして、マイライブラリ画面で「すべて/本/リスト」を切り替えたい。これにより、本とリストを効率的に閲覧できる。

#### Acceptance Criteria
1. The モバイルアプリ shall マイライブラリ画面に「すべて」「本」「リスト」のフィルタタブを表示する
2. When ユーザーが「すべて」タブを選択した時, the モバイルアプリ shall 上部にリスト一覧、下部に「最近追加した本」セクションを水平スクロール形式で表示する
3. When ユーザーが「本」タブを選択した時, the モバイルアプリ shall 従来のマイライブラリ表示（ソート/グループ化機能あり）を表示する
4. When ユーザーが「リスト」タブを選択した時, the モバイルアプリ shall リスト一覧と新規作成ボタンを表示する
5. When ユーザーが「すべて」タブの「すべて見る」リンクをタップした時, the モバイルアプリ shall 「本」タブに切り替える
6. The モバイルアプリ shall 「すべて」タブでリストカードを縦長レイアウト（2x2コラージュ）で表示する
7. The モバイルアプリ shall 「リスト」タブでリストカードを横長レイアウト（単一画像 + 右矢印）で表示する

### Requirement 8: リスト一覧の表示
**Objective:** ユーザーとして、作成したリストを一覧で確認したい。これにより、目的のリストにすばやくアクセスできる。

#### Acceptance Criteria
1. The モバイルアプリ shall リスト一覧でリストカードを表示する
2. The モバイルアプリ shall リストカードに 2x2 の表紙コラージュ、タイトル、冊数、説明文（ある場合）を表示する
3. If リストに本が 4 冊未満の場合, then the モバイルアプリ shall 存在する本の表紙のみをコラージュに表示する
4. If リストに本が 0 冊の場合, then the モバイルアプリ shall プレースホルダー画像を表示する
5. When ユーザーがリストカードをタップした時, the モバイルアプリ shall リスト詳細画面に遷移する

### Requirement 9: リスト詳細画面
**Objective:** ユーザーとして、リスト内の本を一覧で確認したい。これにより、リストの内容を把握できる。

#### Acceptance Criteria
1. The モバイルアプリ shall リスト詳細画面にリストのタイトル、説明、本の一覧を表示する
2. The モバイルアプリ shall リスト詳細画面に編集ボタンを表示する
3. When ユーザーがリスト内の本をタップした時, the モバイルアプリ shall 本の詳細画面に遷移する
4. The モバイルアプリ shall リスト内の本を position 順に表示する

### Requirement 10: データモデル
**Objective:** システムとして、リスト機能に必要なデータを永続化したい。これにより、リストと本の関連を管理できる。

#### Acceptance Criteria
1. The API shall BookList テーブルを作成し id, userId, title, description(nullable), coverImageUrl(nullable), createdAt, updatedAt を持つ
2. The API shall BookListItem テーブルを作成し id, listId, userBookId, position, addedAt を持つ
3. The API shall BookList と User を外部キーで関連付ける
4. The API shall BookListItem と BookList を外部キーで関連付ける
5. The API shall BookListItem と UserBook を外部キーで関連付ける
6. The API shall BookList 削除時に関連する BookListItem をカスケード削除する

# Requirements Document

## Project Description (Input)
ライブラリ画面の本一覧を読書状態（読書中・積読・読了・読まない）ごとのセクションに分類表示する機能を実装する。

現状: ライブラリ画面では本がフラットなリスト（ページネーション付き）で表示される。クライアント側の汎用グループ化機能（GroupOption: none/byStatus/byAuthor）があるが、ページネーションとの整合性に問題がある（サーバーがソート順でスライスしたページをクライアントで別軸でグループ化するため、グループの中身が不完全になる）。

目標:
1. API（GraphQL）の MyShelfInput に readingStatus フィルタを追加する
2. クライアント側で読書状態ごとにセクションを表示する（読書中→積読→読了→読まない の固定順）
3. 各セクションが独立してデータを取得するため、ページネーションとの矛盾を解消する
4. 既存の汎用グループ化機能（GroupOption、byAuthor等）を削除し、シンプルにする
5. これをデフォルトの表示モードとする

技術スタック:
- API: TypeScript + GraphQL (Pothos) + Drizzle ORM (apps/api)
- Mobile: Flutter + Riverpod + Ferry GraphQL client (apps/mobile)
- テスト: Vitest (API) / flutter_test (Mobile)

## Introduction

本仕様は、Shelfie モバイルアプリのライブラリ画面における本の表示方法を改善するものである。現在のフラットリスト表示からステータス別セクション表示に移行し、ページネーションとの整合性問題を根本的に解消する。サーバー側で readingStatus フィルタを提供し、クライアント側でセクションごとに独立したデータ取得を行うことで、各ステータスの本を正確に表示する。

## Requirements

### Requirement 1: API readingStatus フィルタの追加

**Objective:** API 開発者として、GraphQL の MyShelfInput に readingStatus フィルタを追加したい。それにより、クライアントが特定の読書状態の本のみを取得できるようにする。

#### Acceptance Criteria

1. When クライアントが MyShelfInput に readingStatus を指定してクエリを送信した場合, the API shall 指定された読書状態に一致する本のみを返却する
2. When クライアントが readingStatus を指定せずにクエリを送信した場合, the API shall 全ての読書状態の本を返却する（既存動作の維持）
3. The API shall readingStatus フィルタとして reading, backlog, finished, dropped の 4 つの値を受け付ける
4. When readingStatus フィルタが指定された場合, the API shall 既存のページネーション（カーソルベース）と組み合わせて正しく動作する
5. The API shall readingStatus フィルタと既存のソート条件を組み合わせて正しい順序で結果を返却する

### Requirement 2: ステータス別セクション表示

**Objective:** ユーザーとして、ライブラリ画面で本を読書状態ごとのセクションに分類して閲覧したい。それにより、読書の進捗を一目で把握できるようにする。

#### Acceptance Criteria

1. The モバイルアプリ shall ライブラリ画面で本を「読書中」「積読」「読了」「読まない」の 4 つのセクションに分類して表示する
2. The モバイルアプリ shall セクションの表示順を「読書中 → 積読 → 読了 → 読まない」の固定順序で表示する
3. When セクション内に本が存在しない場合, the モバイルアプリ shall そのセクションを非表示にする
4. The モバイルアプリ shall 各セクションにステータス名をヘッダーとして表示する

### Requirement 3: セクション独立データ取得

**Objective:** ユーザーとして、各セクションが正確な本のリストを表示してほしい。それにより、ページネーションによるデータの不完全性が解消される。

#### Acceptance Criteria

1. The モバイルアプリ shall 各ステータスセクションごとに独立した GraphQL クエリを発行してデータを取得する
2. The モバイルアプリ shall 各セクションが独立したページネーション状態を保持する
3. When ユーザーが特定のセクションをスクロールして末尾に到達した場合, the モバイルアプリ shall そのセクションの次ページのみを追加読み込みする
4. While あるセクションがデータを読み込み中の場合, the モバイルアプリ shall 他のセクションの表示やインタラクションに影響を与えない
5. While セクションがデータを読み込み中の場合, the モバイルアプリ shall ローディング状態を表示する

### Requirement 4: 既存グループ化機能の削除

**Objective:** 開発者として、クライアント側の汎用グループ化機能（GroupOption）を削除したい。それにより、コードベースを簡素化し保守性を向上させる。

#### Acceptance Criteria

1. The モバイルアプリ shall GroupOption 列挙型（none, byStatus, byAuthor）を削除する
2. The モバイルアプリ shall クライアント側のグループ化ロジックを削除する
3. The モバイルアプリ shall グループ化に関連する UI コンポーネント（切り替えボタン等）を削除する
4. When ライブラリ画面を表示した場合, the モバイルアプリ shall ステータス別セクション表示をデフォルトかつ唯一の表示モードとして使用する

### Requirement 5: データ更新時のセクション同期

**Objective:** ユーザーとして、本の読書状態を変更した際にセクション表示が正しく更新されてほしい。それにより、常に最新の状態を確認できる。

#### Acceptance Criteria

1. When ユーザーが本の読書状態を変更した場合, the モバイルアプリ shall 変更元のセクションから該当書籍を除去する
2. When ユーザーが本の読書状態を変更した場合, the モバイルアプリ shall 変更先のセクションに該当書籍を追加する
3. When ユーザーが本の読書状態を変更した場合, the モバイルアプリ shall セクションの件数表示を更新する
4. If 読書状態の変更に失敗した場合, the モバイルアプリ shall 変更前の状態に戻し、エラーメッセージを表示する

### Requirement 6: エラーハンドリング

**Objective:** ユーザーとして、データ取得に失敗した場合でも適切なフィードバックを受けたい。それにより、問題の把握と再試行が可能になる。

#### Acceptance Criteria

1. If セクションのデータ取得に失敗した場合, the モバイルアプリ shall 該当セクションにエラーメッセージを表示する
2. If セクションのデータ取得に失敗した場合, the モバイルアプリ shall 他のセクションの表示に影響を与えない
3. When エラーが表示されている状態でユーザーがリトライ操作を行った場合, the モバイルアプリ shall 該当セクションのデータを再取得する

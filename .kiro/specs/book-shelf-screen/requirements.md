# Requirements Document

## Introduction
本ドキュメントは、Shelfie モバイルアプリケーションの「本棚画面」に関する要件を定義する。本棚画面は、ユーザーが登録した書籍を一覧表示し、検索・フィルタリング・ソートを通じて効率的に書籍を管理するための中核機能である。

## Requirements

### Requirement 1: 本棚ヘッダー表示
**Objective:** As a ユーザー, I want 本棚画面のヘッダーに画面タイトルとプロフィールアイコンを表示したい, so that 現在の画面を認識し、プロフィールへアクセスできる

#### Acceptance Criteria
1. The 本棚画面 shall 「本棚」タイトルをヘッダー左側に表示する
2. The 本棚画面 shall プロフィールアイコンをヘッダー右側に表示する
3. When ユーザーがプロフィールアイコンをタップする, the 本棚画面 shall プロフィール画面へ遷移する

### ~~Requirement 2: タブ切り替え機能~~ [スコープ外]
> **Note:** コレクション機能は今回のプロジェクトではスコープ外のため、タブ切り替え機能は実装しない。本棚画面は「すべて」タブの表示内容のみを実装する。

### Requirement 3: 書籍検索機能
**Objective:** As a ユーザー, I want 本棚内の書籍を検索したい, so that 目的の書籍を素早く見つけられる

#### Acceptance Criteria
1. The 本棚画面 shall 検索バーを表示し、「本を検索...」プレースホルダーテキストを表示する
2. The 本棚画面 shall 検索バーに虫眼鏡アイコンを表示する
3. When ユーザーが検索キーワードを入力する, the 本棚画面 shall タイトルまたは著者名に一致する書籍をフィルタリングして表示する
4. If 検索結果が0件の場合, the 本棚画面 shall 「検索結果が見つかりません」メッセージを表示する

### Requirement 4: ソート機能
**Objective:** As a ユーザー, I want 書籍の表示順を変更したい, so that 好みの順序で書籍を閲覧できる

#### Acceptance Criteria
1. The 本棚画面 shall ソート選択用ドロップダウンを表示する
2. The 本棚画面 shall デフォルトで「追加日（新しい順）」でソートする
3. When ユーザーがソートドロップダウンをタップする, the 本棚画面 shall ソートオプション一覧を表示する
4. When ユーザーがソートオプションを選択する, the 本棚画面 shall 選択されたソート順で書籍一覧を再表示する
5. The 本棚画面 shall 以下のソートオプションを提供する:
   - 追加日（新しい順）
   - 追加日（古い順）
   - タイトル（A→Z）
   - 著者名（A→Z）

### Requirement 5: グループ化フィルター機能
**Objective:** As a ユーザー, I want 書籍をグループ化して表示したい, so that 特定の切り口で書籍を整理して閲覧できる

#### Acceptance Criteria
1. The 本棚画面 shall グループ化フィルター選択用ドロップダウンを表示する
2. The 本棚画面 shall デフォルトで「すべて」を選択した状態で表示する
3. When ユーザーがグループ化フィルタードロップダウンをタップする, the 本棚画面 shall グループ化オプション一覧を表示する
4. When ユーザーがグループ化オプションを選択する, the 本棚画面 shall 選択されたグループ化方式で書籍を表示する
5. The 本棚画面 shall 以下のグループ化オプションを提供する:
   - すべて（グループ化なし）
   - ステータス別
   - 著者別

### Requirement 6: 書籍グリッド表示
**Objective:** As a ユーザー, I want 書籍を視覚的に分かりやすいグリッド形式で表示したい, so that 本棚を一覧しやすい

#### Acceptance Criteria
1. The 本棚画面 shall 書籍を3列のグリッドレイアウトで表示する
2. The 本棚画面 shall 各書籍カードに書籍カバー画像を表示する
3. The 本棚画面 shall 各書籍カードに星評価（5段階）を表示する
4. If 書籍に評価が設定されていない場合, the 本棚画面 shall 評価エリアを空の状態で表示する
5. The 本棚画面 shall 各書籍カードに書籍タイトルを表示する
6. The 本棚画面 shall 各書籍カードに著者名を表示する
7. If タイトルまたは著者名が長い場合, the 本棚画面 shall テキストを省略して「...」で表示する

### Requirement 7: 書籍詳細への遷移
**Objective:** As a ユーザー, I want 書籍カードをタップして詳細画面に遷移したい, so that 書籍の詳細情報を確認できる

#### Acceptance Criteria
1. When ユーザーが書籍カードをタップする, the 本棚画面 shall 該当書籍の詳細画面へ遷移する

### Requirement 8: ボトムナビゲーション
**Objective:** As a ユーザー, I want ボトムナビゲーションでアプリ内を移動したい, so that 主要機能に素早くアクセスできる

#### Acceptance Criteria
1. The 本棚画面 shall ボトムナビゲーションバーを表示する
2. The 本棚画面 shall 「本棚」タブと「検索」タブをボトムナビゲーションに表示する
3. While 本棚画面が表示されている, the ボトムナビゲーション shall 「本棚」タブを選択状態で表示する
4. When ユーザーが「検索」タブをタップする, the アプリケーション shall 検索画面へ遷移する

### Requirement 9: デザインテーマ適用
**Objective:** As a ユーザー, I want 統一されたダークテーマで画面を表示したい, so that 視覚的に統一感のある体験ができる

#### Acceptance Criteria
1. The 本棚画面 shall ダークテーマ（黒背景）で表示する
2. The 本棚画面 shall アクセントカラーとして緑色を使用する
3. The 本棚画面 shall カードベースのモダンなUIを使用する

### Requirement 10: 空の本棚状態
**Objective:** As a ユーザー, I want 本棚に書籍がない場合に適切なガイダンスを表示したい, so that 次のアクションを理解できる

#### Acceptance Criteria
1. If 本棚に登録された書籍が0件の場合, the 本棚画面 shall 空の状態を示すイラストまたはアイコンを表示する
2. If 本棚に登録された書籍が0件の場合, the 本棚画面 shall 「本を追加してみましょう」などのガイダンスメッセージを表示する

### Requirement 11: ローディング状態
**Objective:** As a ユーザー, I want データ読み込み中に適切なフィードバックを得たい, so that アプリが応答していることを認識できる

#### Acceptance Criteria
1. While 書籍データを読み込み中, the 本棚画面 shall ローディングインジケーターを表示する
2. While 書籍データを読み込み中, the 本棚画面 shall ユーザー操作をブロックしない

### Requirement 12: エラー状態
**Objective:** As a ユーザー, I want エラー発生時に適切なフィードバックとリカバリー手段を得たい, so that 問題を理解し対処できる

#### Acceptance Criteria
1. If データ取得に失敗した場合, the 本棚画面 shall エラーメッセージを表示する
2. If データ取得に失敗した場合, the 本棚画面 shall リトライボタンを表示する
3. When ユーザーがリトライボタンをタップする, the 本棚画面 shall データの再取得を試行する

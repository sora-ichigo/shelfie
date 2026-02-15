# Requirements Document

## Project Description (Input)
全画面のデザイン刷新計画。design.pen ファイルに33フレームの新デザインがあり、現在16のFlutter画面が存在する。前ステップでAppColorsにLegacyサフィックスを付与済み。新しいデザインシステム（Material Design 3ベースの変数: $surface, $on-surface, $primary 等）へ移行する。各画面のデザインを .pen のデザインに合わせて刷新し、Legacy カラーを新カラーに置き換える。

対象画面と対応する .pen フレーム:
1. ProfileScreen → マイページ, マイページ（いいね）, ブックリスト, ブックリスト（グリッド）
2. SearchScreen → さがす v2, さがす（入力中）
3. SearchScreen（結果） → 検索結果（書籍/著者/ブックリスト）
4. BookDetailScreen → 本の詳細（みんな/自分の記録/作品情報/空）
5. UserProfileScreen → 他人のプロフィール, 他人のプロフィール（ロングタップ）
6. NotificationScreen → おしらせ
7. WelcomeScreen → ウェルカム
8. RegistrationScreen → 新規登録
9. LoginScreen → ログイン
10. BookListDetailScreen → ブックリスト詳細（自分/他人）
11. BookListEditScreen → ブックリスト編集
12. 新規画面: ホーム（確定版）, 感想カード詳細, タイムラインカード種別
13. 新規画面: プロフィール入力（名前/アバター）, セットアップ完了
14. 新規画面: 感想を書く, 自分メモを書く, 感想を書く（AI対話中）, 世の中の評判（ソース展開）

## Introduction

本ドキュメントは、Shelfie モバイルアプリケーション全画面のデザインシステム刷新に関する要件を定義する。Material Design 3 ベースの新しいカラートークンへの移行、既存16画面のデザイン刷新、および新規画面・コンポーネントの追加を対象とする。design.pen ファイルの33フレームに基づき、一貫性のあるモダンな UI を実現する。

## Requirements

### Requirement 1: デザイントークン基盤の構築

**Objective:** 開発者として、Material Design 3 に準拠した新しいカラートークン体系およびタイポグラフィ体系を導入したい。これにより、全画面で一貫したデザインシステムを適用し、Legacy トークンからの移行を段階的に進められるようにする。

#### Acceptance Criteria

1. The Shelfie App shall Material Design 3 のカラー変数（`$surface`, `$on-surface`, `$primary`, `$surface-container-low`, `$surface-container-lowest`, `$border-subtle`, `$on-surface-variant` 等）に対応する新しいカラートークンを `AppColors` に定義する
2. The Shelfie App shall 新しいカラートークンを `ColorScheme` および `ThemeExtension` 経由でアプリ全体に提供する
3. The Shelfie App shall 新しいカラートークンと Legacy カラートークンを共存させ、画面単位での段階的移行を可能にする
4. The Shelfie App shall `AppTypography` の既存スタイルに Legacy サフィックスを付与し、design.pen に基づく新しいタイポグラフィトークン（displayLarge: 36px 等）を定義する
5. The Shelfie App shall フォントファミリーは NotoSansJP を維持し、フォントサイズ・ウェイトのみ design.pen の定義に合わせて更新する
6. The Shelfie App shall 新しいタイポグラフィトークンと Legacy タイポグラフィトークンを共存させ、画面単位での段階的移行を可能にする
7. The Shelfie App shall `AppTheme` をライトモードベースの新しいカラートークン・タイポグラフィトークンを基盤として再構築する
8. When 全画面の移行が完了した場合, the Shelfie App shall Legacy サフィックス付きカラー・タイポグラフィトークンを安全に削除できる状態にする

### Requirement 2: 認証・オンボーディング画面の刷新

**Objective:** ユーザーとして、初回起動から登録・ログインまでの体験が洗練されたデザインで提供されてほしい。これにより、アプリの第一印象が向上し、登録完了率が高まる。

#### Acceptance Criteria

1. The Shelfie App shall WelcomeScreen のデザインを design.pen「ウェルカム」フレームに合わせて刷新する
2. The Shelfie App shall RegistrationScreen のデザインを design.pen「新規登録」フレームに合わせて刷新する
3. The Shelfie App shall LoginScreen のデザインを design.pen「ログイン」フレームに合わせて刷新する
4. The Shelfie App shall 認証画面全体で新しいカラートークンを使用し、Legacy カラー参照を排除する

### Requirement 3: オンボーディングフローの新規追加

**Objective:** 新規ユーザーとして、登録直後にプロフィール設定（名前入力・アバター選択）をガイドされたい。これにより、初期プロフィールが充実し、ソーシャル機能の利用促進につながる。

#### Acceptance Criteria

1. The Shelfie App shall design.pen「プロフィール入力（名前）」フレームに基づくプロフィール名前入力画面を新規作成する
2. The Shelfie App shall design.pen「プロフィール入力（アバター）」フレームに基づくアバター選択画面を新規作成する
3. The Shelfie App shall design.pen「セットアップ完了」フレームに基づくセットアップ完了画面を新規作成する
4. When ユーザーが新規登録を完了した場合, the Shelfie App shall オンボーディングフロー（名前入力 → アバター選択 → 完了）へ遷移する
5. When ユーザーがオンボーディングを完了した場合, the Shelfie App shall ホーム画面へ遷移する

### Requirement 4: ホームタイムライン画面の新規追加

**Objective:** ユーザーとして、アプリ起動時にフォロー中の友達の読書活動をタイムラインで閲覧したい。これにより、友達の読書体験を発見し、本との新しい出会いが生まれる。

#### Acceptance Criteria

1. The Shelfie App shall design.pen「ホーム（確定版）」フレームに基づくホームタイムライン画面を新規作成する
2. The Shelfie App shall design.pen「タイムラインカード種別」フレームに基づくタイムラインカードコンポーネント群を新規作成する
3. The Shelfie App shall タイムラインにフォロー中ユーザーの読書活動（本棚追加、ステータス変更、レビュー、評価等）をカード形式で表示する
4. The Shelfie App shall ホームタイムライン画面を新しいカラートークンのみで実装する

### Requirement 5: レビュー・メモ作成画面の新規追加

**Objective:** ユーザーとして、読書の感想やメモを直感的に記録したい。また、AI アシスタントの対話を通じてより深い感想を引き出してほしい。これにより、読書体験の記録が充実する。

#### Acceptance Criteria

1. The Shelfie App shall design.pen「感想を書く」フレームに基づくレビュー作成画面を新規作成する
2. The Shelfie App shall design.pen「自分メモを書く」フレームに基づくメモ作成画面を新規作成する
3. The Shelfie App shall design.pen「感想を書く（AI対話中）」フレームに基づく AI アシスタント付きレビュー作成画面を新規作成する
4. The Shelfie App shall レビュー・メモ作成画面を新しいカラートークンのみで実装する

### Requirement 6: 感想カード詳細画面の新規追加

**Objective:** ユーザーとして、他のユーザーの感想やレビューを詳細に閲覧したい。これにより、本に対する多様な視点を得られる。

#### Acceptance Criteria

1. The Shelfie App shall design.pen「感想カード詳細」フレームに基づくレビューカード詳細画面を新規作成する
2. The Shelfie App shall design.pen「世の中の評判（ソース展開）」フレームに基づく外部評判セクション展開コンポーネントを新規作成する
3. The Shelfie App shall 感想カード詳細画面を新しいカラートークンのみで実装する

### Requirement 7: プロフィール画面の刷新

**Objective:** ユーザーとして、自分の本棚・いいね・ブックリストを見やすく管理したい。これにより、読書活動の全体像が把握しやすくなる。

#### Acceptance Criteria

1. The Shelfie App shall ProfileScreen の本棚タブを design.pen「マイページ」フレームに合わせて刷新する
2. The Shelfie App shall ProfileScreen のいいねタブを design.pen「マイページ（いいね）」フレームに合わせて刷新する
3. The Shelfie App shall ProfileScreen のブックリストタブをリスト表示で design.pen「ブックリスト」フレームに合わせて刷新する
4. The Shelfie App shall ProfileScreen のブックリストタブにグリッド表示を追加し、design.pen「ブックリスト（グリッド）」フレームに合わせて実装する
5. When ユーザーがブックリストタブで表示切替を操作した場合, the Shelfie App shall リスト表示とグリッド表示を切り替える
6. The Shelfie App shall ProfileScreen 全体で新しいカラートークンを使用し、Legacy カラー参照を排除する

### Requirement 8: 検索画面の刷新

**Objective:** ユーザーとして、書籍・著者・ブックリストをスムーズに検索したい。これにより、求める情報に素早くアクセスできる。

#### Acceptance Criteria

1. The Shelfie App shall SearchScreen の初期状態を design.pen「さがす v2」フレームに合わせて刷新する
2. The Shelfie App shall SearchScreen の入力中状態を design.pen「さがす（入力中）」フレームに合わせて刷新する
3. The Shelfie App shall 検索結果の書籍タブを design.pen「検索結果（書籍）」フレームに合わせて刷新する
4. The Shelfie App shall 検索結果の著者タブを design.pen「検索結果（著者）」フレームに合わせて刷新する
5. The Shelfie App shall 検索結果のブックリストタブを design.pen「検索結果（ブックリスト）」フレームに合わせて刷新する
6. The Shelfie App shall SearchScreen 全体で新しいカラートークンを使用し、Legacy カラー参照を排除する

### Requirement 9: 本の詳細画面の刷新

**Objective:** ユーザーとして、本の詳細情報（みんなの感想、自分の記録、作品情報）を見やすく閲覧したい。これにより、本に関する判断材料が充実する。

#### Acceptance Criteria

1. The Shelfie App shall BookDetailScreen のみんなタブを design.pen「本の詳細（みんな）」フレームに合わせて刷新する
2. The Shelfie App shall BookDetailScreen の自分の記録タブを design.pen「本の詳細（自分の記録）」フレームに合わせて刷新する
3. The Shelfie App shall BookDetailScreen の作品情報タブを design.pen「本の詳細（作品情報）」フレームに合わせて刷新する
4. The Shelfie App shall BookDetailScreen のみんなタブ（データなし）を design.pen「本の詳細（みんな・空）」フレームに合わせた空状態デザインで表示する
5. The Shelfie App shall BookDetailScreen の自分の記録タブ（データなし）を design.pen「本の詳細（自分の記録・空）」フレームに合わせた空状態デザインで表示する
6. The Shelfie App shall BookDetailScreen 全体で新しいカラートークンを使用し、Legacy カラー参照を排除する

### Requirement 10: 他人のプロフィール画面の刷新

**Objective:** ユーザーとして、友達や他のユーザーのプロフィール・本棚を快適に閲覧したい。これにより、ソーシャルな読書体験が向上する。

#### Acceptance Criteria

1. The Shelfie App shall UserProfileScreen を design.pen「他人のプロフィール」フレームに合わせて刷新する
2. When ユーザーが UserProfileScreen でコンテンツをロングタップした場合, the Shelfie App shall design.pen「他人のプロフィール（ロングタップ）」フレームに合わせたモーダルを表示する
3. The Shelfie App shall UserProfileScreen 全体で新しいカラートークンを使用し、Legacy カラー参照を排除する

### Requirement 11: おしらせ画面の刷新

**Objective:** ユーザーとして、通知一覧を見やすいデザインで確認したい。これにより、重要な通知を見逃さなくなる。

#### Acceptance Criteria

1. The Shelfie App shall NotificationScreen を design.pen「おしらせ」フレームに合わせて刷新する
2. The Shelfie App shall NotificationScreen で新しいカラートークンを使用し、Legacy カラー参照を排除する

### Requirement 12: ブックリスト関連画面の刷新

**Objective:** ユーザーとして、ブックリストの詳細閲覧・編集を洗練されたデザインで行いたい。これにより、リスト管理の体験が向上する。

#### Acceptance Criteria

1. The Shelfie App shall BookListDetailScreen（自分のリスト）を design.pen「ブックリスト詳細（自分）」フレームに合わせて刷新する
2. The Shelfie App shall BookListDetailScreen（他人のリスト）を design.pen「ブックリスト詳細（他人）」フレームに合わせて刷新する
3. The Shelfie App shall BookListEditScreen を design.pen「ブックリスト編集」フレームに合わせて刷新する
4. The Shelfie App shall ブックリスト関連画面全体で新しいカラートークンを使用し、Legacy カラー参照を排除する

### Requirement 13: Legacy トークンの完全除去

**Objective:** 開発者として、全画面の移行完了後に Legacy カラー・タイポグラフィトークンを完全に除去したい。これにより、デザインシステムの二重管理を解消し、保守性が向上する。

#### Acceptance Criteria

1. When 全画面で新しいトークンへの移行が完了した場合, the Shelfie App shall `AppColors` から Legacy サフィックス付きプロパティ（`primaryLegacy`, `backgroundLegacy`, `surfaceLegacy` 等）を削除する
2. When 全画面で新しいトークンへの移行が完了した場合, the Shelfie App shall `AppTypography` から Legacy サフィックス付きプロパティを削除する
3. When Legacy トークンが削除された場合, the Shelfie App shall プロジェクト内に Legacy カラー・タイポグラフィへの参照が残っていないことを保証する
4. The Shelfie App shall `AppTheme` が Legacy トークンに依存せず、新しいカラー・タイポグラフィトークンのみで構成されている状態にする

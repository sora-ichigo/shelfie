# Requirements Document

## Introduction

本ドキュメントは、Shelfie モバイルアプリケーションにウェルカム画面を追加するための要件を定義する。ウェルカム画面は未ログインユーザーがアプリを起動した際に最初に表示される画面であり、アプリのブランドイメージを伝えると同時に、ログインまたは新規登録への導線を提供する。

## Requirements

### Requirement 1: ウェルカム画面の表示制御

**Objective:** ユーザーとして、未ログイン状態でアプリを起動した際にウェルカム画面が表示されることで、アプリの第一印象を得てログインまたは新規登録を選択できる。

#### Acceptance Criteria

1. When ユーザーが未認証状態でアプリを起動する, the Shelfie App shall ウェルカム画面を初期画面として表示する
2. When ユーザーが認証済み状態でアプリを起動する, the Shelfie App shall ウェルカム画面をスキップしてホーム画面に遷移する
3. While ウェルカム画面が表示されている, the Shelfie App shall 認証状態の変更を監視し、認証完了時に自動的にホーム画面へ遷移する

### Requirement 2: ウェルカム画面のビジュアルデザイン

**Objective:** ユーザーとして、視覚的に魅力的なウェルカム画面を通じてアプリのブランドアイデンティティを認識し、読書アプリとしての価値を理解できる。

#### Acceptance Criteria

1. The Shelfie App shall ダークテーマ（黒背景）でウェルカム画面を表示する
2. The Shelfie App shall 画面上部にアプリロゴ（本のアイコンと星マーク、ターコイズ/緑色）を表示する
3. The Shelfie App shall ロゴの下に「Shelfie」というアプリ名を白い太字で表示する
4. The Shelfie App shall アプリ名の下にキャッチコピー「読書家のための本棚」を表示する
5. The Shelfie App shall 背景に本の画像をぼかし効果を適用して装飾として表示する

### Requirement 3: ログインボタン

**Objective:** 既存ユーザーとして、明確なログインボタンを通じて素早くアカウントにアクセスできる。

#### Acceptance Criteria

1. The Shelfie App shall 「ログイン」ボタンを白背景・黒文字・角丸デザインで表示する
2. When ユーザーがログインボタンをタップする, the Shelfie App shall ログイン画面に遷移する
3. While ログインボタンがタップされている, the Shelfie App shall 視覚的なフィードバック（押下状態）を表示する

### Requirement 4: 新規登録ボタン

**Objective:** 新規ユーザーとして、明確な新規登録ボタンを通じてアカウント作成フローを開始できる。

#### Acceptance Criteria

1. The Shelfie App shall 「新規登録」ボタンを白枠・透明背景・黒文字・角丸デザインで表示する
2. When ユーザーが新規登録ボタンをタップする, the Shelfie App shall 新規登録画面に遷移する
3. While 新規登録ボタンがタップされている, the Shelfie App shall 視覚的なフィードバック（押下状態）を表示する

### Requirement 5: 利用規約・プライバシーポリシーへの同意

**Objective:** ユーザーとして、アプリの利用規約とプライバシーポリシーを確認した上でサービスを利用することで、法的な同意を明確にできる。

#### Acceptance Criteria

1. The Shelfie App shall 画面下部に「続けることで、利用規約とプライバシーポリシーに同意したものとみなされます」というテキストを表示する
2. The Shelfie App shall 「利用規約」をタップ可能なリンクとして表示する
3. The Shelfie App shall 「プライバシーポリシー」をタップ可能なリンクとして表示する
4. When ユーザーが利用規約リンクをタップする, the Shelfie App shall 利用規約ページを表示する
5. When ユーザーがプライバシーポリシーリンクをタップする, the Shelfie App shall プライバシーポリシーページを表示する

### Requirement 6: レスポンシブレイアウト

**Objective:** ユーザーとして、様々な画面サイズのデバイスでウェルカム画面が適切に表示されることで、一貫したユーザー体験を得られる。

#### Acceptance Criteria

1. The Shelfie App shall 異なる画面サイズ（スマートフォン、タブレット）でウェルカム画面を適切にレイアウトする
2. The Shelfie App shall セーフエリア（ノッチ、ホームインジケーター等）を考慮したレイアウトを適用する
3. While デバイスの向きが変更される, the Shelfie App shall レイアウトを自動的に調整する

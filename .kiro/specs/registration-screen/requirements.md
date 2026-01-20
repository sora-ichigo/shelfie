# Requirements Document

## Introduction

本仕様は、Shelfie モバイルアプリケーションにおける新規登録画面のUI実装要件を定義する。ユーザーがメールアドレスとパスワードを入力し、認証コードを送信するためのフォーム画面を実装する。デザインは提供されたスクリーンショットに準拠し、送信処理はモックで対応する。

**スコープ**:
- UI実装に集中（送信処理はモック）
- 既存のデザインシステム（AppColors, AppSpacing）を活用
- Feature-first + Clean Architecture パターンに準拠
- 既存のウェルカム画面のパターンを踏襲

**対象外**:
- 実際の認証API連携
- メール送信処理
- 認証コード検証画面

## Requirements

### Requirement 1: 画面レイアウト構成

**Objective:** ユーザーとして、視覚的に整理された登録画面を表示したい。それにより、必要な情報を直感的に入力できる。

#### Acceptance Criteria

1. The Registration Screen shall ダークモードのグラデーション背景（WelcomeBackground と同様のパターン）を表示する
2. The Registration Screen shall 画面上部に「← 戻る」テキストリンクを表示する
3. The Registration Screen shall 画面中央上部にターコイズ色の円形アイコン内にメールアイコンを表示する
4. The Registration Screen shall アイコン下に「新規登録」タイトルを白色の太字で表示する
5. The Registration Screen shall タイトル下に「アカウントを作成して始めましょう」サブタイトルをグレー色で表示する
6. The Registration Screen shall SafeArea を使用してシステムUIとの重なりを防ぐ

### Requirement 2: 入力フォーム

**Objective:** ユーザーとして、メールアドレスとパスワードを入力するフォームを使用したい。それにより、新規アカウント登録に必要な情報を提供できる。

#### Acceptance Criteria

1. The Registration Screen shall 「メールアドレス」ラベル付きのテキスト入力フィールドを表示する
2. When メールアドレスフィールドが空の場合, the Registration Screen shall プレースホルダーとして「example@email.com」を表示する
3. The Registration Screen shall メールアドレスフィールドの左側にメールアイコン（封筒）を表示する
4. The Registration Screen shall 「パスワード」ラベル付きのパスワード入力フィールドを表示する
5. When パスワードフィールドが空の場合, the Registration Screen shall プレースホルダーとして「8文字以上」を表示する
6. The Registration Screen shall パスワードフィールドの左側にロックアイコンを表示する
7. The Registration Screen shall パスワードフィールドの右側にパスワード表示/非表示切り替えアイコン（目のアイコン）を表示する
8. When パスワード表示切り替えアイコンがタップされた場合, the Registration Screen shall パスワードの表示/非表示状態を切り替える
9. The Registration Screen shall 「パスワード（確認）」ラベル付きの確認用パスワード入力フィールドを表示する
10. When パスワード（確認）フィールドが空の場合, the Registration Screen shall プレースホルダーとして「もう一度入力してください」を表示する
11. The Registration Screen shall パスワード（確認）フィールドの左側にロックアイコンを表示する
12. The Registration Screen shall パスワード（確認）フィールドの右側にパスワード表示/非表示切り替えアイコンを表示する
13. The Registration Screen shall 各入力フィールドに角丸の枠線スタイル（OutlineInputBorder）を適用する

### Requirement 3: 送信ボタン

**Objective:** ユーザーとして、入力完了後に認証コード送信をリクエストしたい。それにより、登録プロセスを進めることができる。

#### Acceptance Criteria

1. The Registration Screen shall フォーム下部に「認証コードを送信」FilledButton を全幅で表示する
2. The FilledButton shall 白色の背景に黒色のテキストを表示する
3. When 「認証コードを送信」ボタンがタップされた場合, the Registration Screen shall モック処理として登録成功のSnackBarを表示する

### Requirement 4: 利用規約・プライバシーポリシー表示

**Objective:** ユーザーとして、登録前に利用規約とプライバシーポリシーへの同意内容を確認したい。それにより、サービス利用条件を理解できる。

#### Acceptance Criteria

1. The Registration Screen shall ボタン下部に「続けることで、利用規約とプライバシーポリシーに同意したものとみなされます」テキストを表示する
2. The Registration Screen shall 「利用規約」と「プライバシーポリシー」をターコイズ色のリンクテキストとして表示する
3. When 「利用規約」リンクがタップされた場合, the Registration Screen shall 準備中である旨のSnackBarを表示する
4. When 「プライバシーポリシー」リンクがタップされた場合, the Registration Screen shall 準備中である旨のSnackBarを表示する

### Requirement 5: ナビゲーション

**Objective:** ユーザーとして、前の画面に戻りたい。それにより、登録をキャンセルしてウェルカム画面に戻ることができる。

#### Acceptance Criteria

1. When 「← 戻る」テキストリンクがタップされた場合, the Registration Screen shall ウェルカム画面（/welcome）に遷移する
2. The Registration Screen shall go_router を使用してナビゲーションを実装する

### Requirement 6: 入力バリデーション（UI フィードバック）

**Objective:** ユーザーとして、入力内容に問題がある場合にフィードバックを受けたい。それにより、正しい情報を入力できる。

#### Acceptance Criteria

1. When メールアドレス形式が不正な場合, the Registration Screen shall エラーメッセージ「有効なメールアドレスを入力してください」を表示する
2. When パスワードが8文字未満の場合, the Registration Screen shall エラーメッセージ「パスワードは8文字以上で入力してください」を表示する
3. When パスワード（確認）がパスワードと一致しない場合, the Registration Screen shall エラーメッセージ「パスワードが一致しません」を表示する
4. While バリデーションエラーが存在する場合, the Registration Screen shall 「認証コードを送信」ボタンを無効化状態で表示する

### Requirement 7: アーキテクチャ準拠

**Objective:** 開発者として、既存のアーキテクチャパターンに準拠した実装をしたい。それにより、コードベースの一貫性と保守性を維持できる。

#### Acceptance Criteria

1. The Registration Screen shall `lib/features/registration/presentation/` ディレクトリに配置する
2. The Registration Screen shall ConsumerWidget を継承して Riverpod との統合を実現する
3. The Registration Screen shall 既存の AppColors ThemeExtension を使用してカラーを適用する
4. The Registration Screen shall 既存の AppSpacing 定数を使用してスペーシングを適用する
5. The Registration Screen shall ウィジェットを適切に分割して単一責務を維持する（例：RegistrationForm, RegistrationHeader, RegistrationBackground）


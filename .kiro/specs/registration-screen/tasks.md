# Implementation Plan

## Tasks

- [x] 1. Feature ディレクトリ構造とルーティング基盤を構築する
- [x] 1.1 登録画面用の Feature ディレクトリを作成し、ルーティングを設定する
  - registration Feature の presentation ディレクトリ構造を作成する
  - AppRoutes に `/register` パスを追加する
  - AppRouter に RegistrationScreen へのルートを追加する
  - ウェルカム画面から登録画面への遷移リンクを確認する
  - _Requirements: 7.1, 5.2_

- [x] 2. 状態管理基盤を実装する
- [x] 2.1 (P) フォーム状態を管理する Provider を作成する
  - RegistrationFormData モデルを freezed で定義する（email, password, passwordConfirmation, isPasswordObscured, isPasswordConfirmationObscured）
  - RegistrationFormState を riverpod_annotation で定義する
  - 入力値更新メソッド（updateEmail, updatePassword, updatePasswordConfirmation）を実装する
  - パスワード表示切り替えメソッド（togglePasswordVisibility, togglePasswordConfirmationVisibility）を実装する
  - build_runner でコード生成を実行する
  - _Requirements: 2.8, 2.12, 6.1, 6.2, 6.3, 6.4_

- [x] 2.2 (P) バリデーションロジックを実装する
  - RegistrationValidators クラスを作成する
  - メールアドレス形式チェック（正規表現）を実装する
  - パスワード長チェック（8文字以上）を実装する
  - パスワード一致チェックを実装する
  - エラーメッセージを日本語で定義する
  - RegistrationFormState に isValid ゲッターとエラーメッセージゲッターを追加する
  - _Requirements: 6.1, 6.2, 6.3, 6.4_

- [x] 3. 画面レイアウトの基礎ウィジェットを実装する
- [x] 3.1 (P) グラデーション背景ウィジェットを実装する
  - WelcomeBackground と同一のグラデーションパターンを使用する
  - RegistrationBackground として独立したウィジェットを作成する
  - AppColors から適切なカラーを取得する
  - _Requirements: 1.1_

- [x] 3.2 (P) ヘッダーウィジェットを実装する
  - 戻るテキストリンクを画面上部に配置する
  - ターコイズ色の円形背景にメールアイコンを配置する
  - 「新規登録」タイトルを白色太字で表示する
  - 「アカウントを作成して始めましょう」サブタイトルをグレー色で表示する
  - onBackPressed コールバックを受け取る
  - AppColors と AppSpacing を使用してスタイリングする
  - _Requirements: 1.2, 1.3, 1.4, 1.5_

- [x] 4. 入力フォームウィジェットを実装する
- [x] 4.1 メールアドレス入力フィールドを実装する
  - 「メールアドレス」ラベルを表示する
  - プレースホルダー「example@email.com」を設定する
  - 左側にメールアイコン（封筒）を配置する
  - OutlineInputBorder で角丸枠線スタイルを適用する
  - ConsumerWidget で状態を監視し、バリデーションエラーを表示する
  - _Requirements: 2.1, 2.2, 2.3, 2.13, 6.1_

- [x] 4.2 パスワード入力フィールドを実装する
  - 「パスワード」ラベルを表示する
  - プレースホルダー「8文字以上」を設定する
  - 左側にロックアイコンを配置する
  - 右側にパスワード表示/非表示切り替えアイコン（目のアイコン）を配置する
  - タップで表示/非表示を切り替える機能を実装する
  - OutlineInputBorder で角丸枠線スタイルを適用する
  - バリデーションエラーを表示する
  - _Requirements: 2.4, 2.5, 2.6, 2.7, 2.8, 2.13, 6.2_

- [x] 4.3 パスワード（確認）入力フィールドを実装する
  - 「パスワード（確認）」ラベルを表示する
  - プレースホルダー「もう一度入力してください」を設定する
  - 左側にロックアイコンを配置する
  - 右側にパスワード表示/非表示切り替えアイコンを配置する
  - タップで表示/非表示を切り替える機能を実装する
  - OutlineInputBorder で角丸枠線スタイルを適用する
  - パスワード不一致エラーを表示する
  - _Requirements: 2.9, 2.10, 2.11, 2.12, 2.13, 6.3_

- [x] 4.4 フォームウィジェットを統合する
  - RegistrationForm ウィジェットを作成し、3つの入力フィールドを統合する
  - SingleChildScrollView でキーボード表示時のレイアウト崩れを防ぐ
  - 適切なスペーシングを AppSpacing から適用する
  - _Requirements: 2.1, 2.4, 2.9, 7.5_

- [x] 5. 送信ボタンと利用規約リンクを実装する
- [x] 5.1 送信ボタンウィジェットを実装する
  - 「認証コードを送信」FilledButton を全幅で配置する
  - 白色背景・黒色テキストのスタイルを適用する
  - フォームバリデーション状態に応じて有効/無効を切り替える
  - RegistrationFormState の isValid を監視する
  - onPressed コールバックを受け取る
  - _Requirements: 3.1, 3.2, 6.4_

- [x] 5.2 (P) 利用規約・プライバシーポリシーリンクを実装する
  - 「続けることで、利用規約とプライバシーポリシーに同意したものとみなされます」テキストを表示する
  - 「利用規約」と「プライバシーポリシー」をターコイズ色のリンクテキストにする
  - RichText と TapGestureRecognizer でリンク機能を実装する
  - onTermsPressed と onPrivacyPressed コールバックを受け取る
  - _Requirements: 4.1, 4.2_

- [x] 6. 画面全体を統合しナビゲーションを実装する
- [x] 6.1 RegistrationScreen を実装し全ウィジェットを統合する
  - Scaffold と Stack で背景とコンテンツを重ね合わせる
  - SafeArea でシステムUIとの重なりを防ぐ
  - RegistrationBackground, RegistrationHeader, RegistrationForm, RegistrationSubmitButton, RegistrationLegalLinks を配置する
  - ConsumerWidget を継承して Riverpod 統合を実現する
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 7.2, 7.3, 7.4, 7.5_

- [x] 6.2 ナビゲーションとフィードバック処理を実装する
  - 戻るリンクタップで context.pop() によりウェルカム画面に戻る
  - 送信ボタンタップで「認証コードを送信しました（モック）」SnackBar を表示する
  - 利用規約リンクタップで「準備中です」SnackBar を表示する
  - プライバシーポリシーリンクタップで「準備中です」SnackBar を表示する
  - _Requirements: 5.1, 3.3, 4.3, 4.4_

- [x] 7. テストを実装する
- [x] 7.1 バリデーションロジックの単体テストを実装する
  - validateEmail の有効/無効パターンをテストする
  - validatePassword の8文字未満/以上をテストする
  - validatePasswordConfirmation の一致/不一致をテストする
  - RegistrationFormState の状態更新と isValid の整合性をテストする
  - _Requirements: 6.1, 6.2, 6.3, 6.4_

- [x] 7.2 ウィジェットテストを実装する
  - RegistrationScreen の全要素表示を確認する
  - RegistrationHeader のアイコン・タイトル・サブタイトル表示を確認する
  - RegistrationForm の入力動作とエラーメッセージ表示を確認する
  - RegistrationSubmitButton の有効/無効状態切り替えを確認する
  - 戻るリンクタップ時のナビゲーションを確認する
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 2.1, 2.4, 2.9, 3.1, 5.1, 6.1, 6.2, 6.3, 6.4_

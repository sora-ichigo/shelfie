# Implementation Plan

## Task Format Template

Use whichever pattern fits the work breakdown:

### Major task only
- [ ] {{NUMBER}}. {{TASK_DESCRIPTION}}{{PARALLEL_MARK}}
  - {{DETAIL_ITEM_1}} *(Include details only when needed. If the task stands alone, omit bullet items.)*
  - _Requirements: {{REQUIREMENT_IDS}}_

### Major + Sub-task structure
- [ ] {{MAJOR_NUMBER}}. {{MAJOR_TASK_SUMMARY}}
- [ ] {{MAJOR_NUMBER}}.{{SUB_NUMBER}} {{SUB_TASK_DESCRIPTION}}{{SUB_PARALLEL_MARK}}
  - {{DETAIL_ITEM_1}}
  - {{DETAIL_ITEM_2}}
  - _Requirements: {{REQUIREMENT_IDS}}_ *(IDs only; do not add descriptions or parentheses.)*

> **Parallel marker**: Append ` (P)` only to tasks that can be executed in parallel. Omit the marker when running in `--sequential` mode.
>
> **Optional test coverage**: When a sub-task is deferrable test work tied to acceptance criteria, mark the checkbox as `- [ ]*` and explain the referenced requirements in the detail bullets.

---

## Tasks

- [x] 1. ログイン入力バリデーションロジックを実装する
  - メールアドレス形式を正規表現 `^[^@]+@[^@]+\.[^@]+$` で検証する
  - 空文字列入力時は null を返し、エラーメッセージを表示しない
  - 無効な形式の場合「有効なメールアドレスを入力してください」を返す
  - `LoginValidators.validateEmail` として静的メソッドを提供する
  - 既存の `RegistrationValidators.validateEmail` と同一ロジックを参考に共通化も検討可
  - _Requirements: 3.1_

- [x] 2. ログインフォーム状態管理を実装する
- [x] 2.1 (P) フォーム状態データモデルを定義する
  - freezed を使用して `LoginFormData` を定義する
  - email、password、isPasswordObscured フィールドを含む
  - イミュータブルなデータクラスとして実装する
  - _Requirements: 2.3_

- [x] 2.2 フォーム状態 Notifier を実装する
  - Riverpod の `@riverpod` アノテーションで `LoginFormState` を定義する
  - `updateEmail`、`updatePassword`、`togglePasswordVisibility` メソッドを実装する
  - `emailError` ゲッターで `LoginValidators.validateEmail` を呼び出す
  - `isValid` ゲッターでメールアドレスとパスワードの両方が入力済みかつエラーなしを判定する
  - Task 1 の LoginValidators に依存
  - _Requirements: 2.3, 3.1, 3.2, 3.3_

- [x] 3. ログイン処理状態管理を実装する
- [x] 3.1 (P) ログイン状態データモデルを定義する
  - freezed の sealed class で `LoginState` を定義する
  - initial、loading、success、error の4状態をパターンマッチング可能に
  - success 時は userId と email を保持する
  - error 時は message と任意の field を保持する
  - _Requirements: 4.1, 4.2, 4.4, 4.5_

- [x] 3.2 ログイン処理 Notifier を実装する
  - Riverpod の `@riverpod` アノテーションで `LoginNotifier` を定義する
  - `login` メソッドでモックのログイン処理を実装する（1秒ディレイ後に成功）
  - 処理開始時に loading 状態、完了時に success または error 状態に遷移
  - `reset` メソッドで初期状態に戻す
  - LoginFormState からフォーム値を取得する
  - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5_

- [x] 4. ログイン画面 UI コンポーネントを実装する
- [x] 4.1 (P) グラデーション背景コンポーネントを実装する
  - `LoginBackground` ウィジェットを作成する
  - RadialGradient による黒からティールへのグラデーション
  - `AppColors.brandPrimary` と `AppColors.brandBackground` を使用
  - 既存の `RegistrationBackground` を参考に実装可
  - _Requirements: 6.1_

- [x] 4.2 (P) ヘッダーコンポーネントを実装する
  - `LoginHeader` ウィジェットを作成する
  - 左上に「← 戻る」ボタンを配置し、onBackPressed コールバックを受け取る
  - ティールカラーの円形背景にロックアイコンを中央表示
  - タイトル「ログイン」とサブタイトル「おかえりなさい」を表示
  - AppColors、AppSpacing を使用したスタイリング
  - 既存の `RegistrationHeader` を参考にアイコンとテキストを変更
  - _Requirements: 1.1, 1.2, 1.3, 1.4_

- [x] 4.3 入力フォームコンポーネントを実装する
  - `LoginForm` ウィジェットを作成する
  - メールアドレス入力フィールド（メールアイコン、プレースホルダー「example@email.com」）
  - パスワード入力フィールド（ロックアイコン、マスク表示、表示切り替えアイコン）
  - 「パスワードを忘れた方」リンクをティールカラーで右寄せ表示
  - 半透明枠線スタイルの入力フィールドデザイン
  - `LoginFormState` を監視して状態を同期
  - バリデーションエラーを入力フィールド下に表示
  - Task 2.2 の LoginFormState に依存
  - _Requirements: 1.5, 1.6, 1.7, 1.8, 2.1, 2.2, 2.3, 3.1, 6.3, 6.4_

- [x] 4.4 送信ボタンコンポーネントを実装する
  - `LoginSubmitButton` ウィジェットを作成する
  - 白背景・角丸のボタンスタイル
  - `LoginFormState.isValid` に基づくボタン有効/無効制御
  - ローディング中は無効化
  - onPressed コールバックでログイン処理を呼び出す
  - Task 2.2 の LoginFormState に依存
  - _Requirements: 1.9, 3.2, 3.3, 4.3_

- [x] 5. ログイン画面全体を統合する
  - `LoginScreen` ウィジェットを作成する
  - Stack + SafeArea + SingleChildScrollView 構造で配置
  - LoginBackground、LoginHeader、LoginForm、LoginSubmitButton を組み合わせる
  - `LoginNotifier` の状態変化を `ref.listen` で監視
  - success 時は成功メッセージを SnackBar で表示
  - error 時はエラーメッセージを SnackBar で表示
  - 戻るボタンタップで前の画面に遷移
  - 「パスワードを忘れた方」タップで未実装通知を SnackBar 表示
  - ローディング中はオーバーレイ表示
  - Task 3.2、4.1-4.4 のコンポーネントに依存
  - _Requirements: 4.2, 4.4, 4.5, 5.1, 5.2, 6.2_

- [x] 6. ルーティング設定を追加する
  - go_router に `/auth/login` ルートを追加する
  - LoginScreen を登録する
  - 戻るボタンのナビゲーション処理を確認
  - Task 5 の LoginScreen に依存
  - _Requirements: 5.1, 5.2_

- [x] 7. コード生成を実行して動作確認する
  - `dart run build_runner build --delete-conflicting-outputs` を実行
  - freezed、riverpod_generator によるコード生成を完了
  - 全体のビルドエラーがないことを確認
  - 画面遷移とフォーム入力の動作を手動確認
  - _Requirements: 6.2_

- [x]* 8. ユニットテストを作成する
  - `LoginValidators.validateEmail` のテスト（有効/無効なメールアドレス形式）
  - `LoginFormState` のテスト（状態更新、バリデーションエラー算出）
  - `LoginNotifier` のテスト（ログイン処理の状態遷移）
  - Acceptance criteria: 3.1（バリデーションエラー表示）の検証
  - _Requirements: 3.1, 3.2, 3.3, 4.1, 4.2, 4.4, 4.5_

- [x]* 9. ウィジェットテストを作成する
  - `LoginScreen` のテスト（全UI要素の表示確認）
  - `LoginForm` のテスト（入力フィールドとパスワード表示切り替え動作）
  - `LoginSubmitButton` のテスト（ボタン有効/無効状態の切り替え）
  - `LoginHeader` のテスト（戻るボタンタップ時のコールバック呼び出し）
  - Acceptance criteria: 1.1-1.9, 2.1-2.3 の検証
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.1, 2.2, 2.3_

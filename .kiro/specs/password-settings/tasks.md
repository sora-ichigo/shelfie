# Implementation Plan

## Task Overview

パスワード設定機能の実装タスク。API サーバーへの GraphQL Mutation 追加と、モバイルアプリのパスワード設定画面実装を行う。

---

- [x] 1. API: Firebase Auth アダプター拡張
- [x] 1.1 (P) パスワード変更機能を Firebase REST API 連携で実装する
  - Firebase REST API の accounts:update エンドポイントを使用
  - idToken と新しいパスワードを受け取り、パスワードを更新
  - 更新成功時に新しい idToken と refreshToken を返却
  - Firebase エラーコードを適切にマッピング
  - _Requirements: 2.2_

- [x] 1.2 (P) パスワードリセットメール送信機能を Firebase REST API 連携で実装する
  - Firebase REST API の accounts:sendOobCode エンドポイントを使用
  - requestType: PASSWORD_RESET でメール送信
  - エラー発生時は適切なエラー型にマッピング
  - _Requirements: 3.2_

- [x] 2. API: GraphQL Mutation 実装
- [x] 2.1 changePassword Mutation を実装する
  - ChangePasswordInput 型（currentPassword, newPassword）を定義
  - ChangePasswordResult Union 型（Success | AuthError）を定義
  - 現在のパスワードで再認証後、新しいパスワードで更新
  - 認証済みユーザーのみアクセス可能に制限
  - 1.1 に依存
  - _Requirements: 2.2, 2.4_

- [x] 2.2 sendPasswordResetEmail Mutation を実装する
  - SendPasswordResetEmailInput 型（email）を定義
  - SendPasswordResetEmailResult Union 型を定義
  - 認証済みユーザーのメールアドレスを使用してリセットメール送信
  - 1.2 に依存
  - _Requirements: 3.2, 3.4_

- [x] 3. Mobile: ドメイン層とバリデーション
- [x] 3.1 (P) パスワードバリデーションルールを実装する
  - 8 文字以上のチェック
  - 英字を含むことのチェック
  - 数字を含むことのチェック
  - 確認用パスワードの一致チェック
  - エラーメッセージの定義
  - _Requirements: 4.1, 4.2, 2.5, 2.6_

- [x] 4. Mobile: データ層
- [x] 4.1 GraphQL スキーマから Dart コードを生成する
  - changePassword Mutation の定義ファイル作成
  - sendPasswordResetEmail Mutation の定義ファイル作成
  - Ferry によるコード生成実行
  - 2.1, 2.2 に依存
  - _Requirements: 2.2, 3.2_

- [x] 4.2 パスワードリポジトリを実装する
  - Ferry クライアントを使用した API 通信
  - changePassword メソッドの実装
  - sendPasswordResetEmail メソッドの実装
  - エラーを Failure 型にマッピング
  - エラーロギングの実装
  - 4.1 に依存
  - _Requirements: 2.2, 3.2, 5.2, 5.3_

- [x] 5. Mobile: アプリケーション層
- [x] 5.1 パスワードフォーム状態管理を実装する
  - 現在のパスワード、新しいパスワード、確認用パスワードの状態保持
  - 各フィールドの表示/非表示状態の管理
  - リアルタイムバリデーションの実行
  - フォーム全体の有効性判定
  - 3.1 に依存
  - _Requirements: 2.5, 2.6, 4.1, 4.2, 4.3_

- [x] 5.2 パスワード設定 Notifier を実装する
  - パスワード変更処理の実行と状態管理
  - パスワードリセットメール送信処理
  - API エラーを Failure 型にマッピング
  - ネットワークエラーのハンドリング
  - ローディング状態の管理
  - 4.2, 5.1 に依存
  - _Requirements: 2.2, 2.4, 3.2, 3.4, 5.1, 5.2_

- [x] 6. Mobile: プレゼンテーション層
- [x] 6.1 パスワード変更フォームウィジェットを実装する
  - 現在のパスワード入力欄
  - 新しいパスワード入力欄
  - 確認用パスワード入力欄
  - 各フィールドの表示/非表示切り替えボタン
  - バリデーションエラーの表示
  - 既存の PasswordField ウィジェットを再利用
  - 5.1 に依存
  - _Requirements: 2.1, 2.8_

- [x] 6.2 パスワードリセットセクションウィジェットを実装する
  - リセット機能の説明文
  - リセットメール送信ボタン
  - 5.2 に依存
  - _Requirements: 3.1_

- [x] 6.3 パスワード設定画面を実装する
  - パスワード変更セクションの表示
  - パスワードリセットセクションの表示
  - ローディング状態のオーバーレイ表示
  - 成功メッセージの SnackBar 表示
  - エラーメッセージの SnackBar 表示
  - バリデーションエラー時の送信ボタン無効化
  - 6.1, 6.2 に依存
  - _Requirements: 1.2, 2.1, 2.3, 2.7, 3.1, 3.3, 3.5, 4.4_

- [x] 7. Mobile: ルーティングと認証ガード
- [x] 7.1 パスワード設定画面へのルートを追加する
  - アカウント画面からパスワード設定画面への遷移
  - 認証ガードの適用
  - 未認証時のログイン画面リダイレクト
  - 6.3 に依存
  - _Requirements: 1.1, 1.3_

- [x] 8. テスト実装
- [x] 8.1 (P) API のユニットテストを実装する
  - FirebaseAuthAdapter のパスワード変更メソッドのテスト
  - FirebaseAuthAdapter のリセットメール送信メソッドのテスト
  - changePassword Mutation の成功/失敗ケース
  - sendPasswordResetEmail Mutation の成功/失敗ケース
  - 2.1, 2.2 に依存
  - _Requirements: 2.2, 2.4, 3.2, 3.4_

- [x] 8.2 (P) Mobile のユニットテストを実装する
  - PasswordValidators の各バリデーションルールのテスト
  - PasswordFormState の状態遷移テスト
  - PasswordSettingsNotifier の成功/失敗ケース
  - 5.1, 5.2 に依存
  - _Requirements: 4.1, 4.2, 2.5, 2.6, 5.1, 5.2_

- [x] 8.3 (P) Mobile のウィジェットテストを実装する
  - PasswordSettingsScreen の初期表示テスト
  - ローディング状態の表示テスト
  - 成功/エラーメッセージ表示テスト
  - パスワード表示切り替えテスト
  - 6.3 に依存
  - _Requirements: 1.2, 2.1, 2.3, 2.7, 2.8, 3.1, 3.3, 3.5, 4.4_

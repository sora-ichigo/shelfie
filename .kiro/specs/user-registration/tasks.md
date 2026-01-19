# Implementation Plan

## Tasks

- [ ] 1. データベーススキーマ拡張
- [ ] 1.1 users テーブルに Firebase UID カラムを追加
  - firebase_uid カラムを NOT NULL、UNIQUE 制約付きで追加
  - firebase_uid にインデックスを作成
  - Drizzle スキーマ定義を更新
  - マイグレーションファイルを生成・適用
  - _Requirements: 1.2_

- [ ] 2. Users Feature 拡張
- [ ] 2.1 UserRepository に Firebase UID 検索機能を追加
  - Firebase UID でユーザーを検索するメソッドを実装
  - 既存の Repository パターンに従って実装
  - _Requirements: 1.2_

- [ ] 2.2 (P) UserService に Firebase 連携ユーザー作成機能を追加
  - Firebase UID 付きでユーザーを作成するメソッドを実装
  - Firebase UID でユーザーを取得するメソッドを実装
  - 既存の Service パターンと Result 型を使用
  - _Requirements: 1.2_

- [ ] 3. Auth Feature 新設
- [ ] 3.1 AuthService のパスワードバリデーション機能を実装
  - パスワードが8文字以上であることを検証するロジックを実装
  - バリデーションエラー時に要件を明示するエラーを返す
  - _Requirements: 3.1, 3.2, 3.3_

- [ ] 3.2 AuthService の Firebase エラーマッピング機能を実装
  - Firebase のエラーコードをドメインエラーに変換するマッピングを実装
  - ネットワークエラー、レート制限エラーなど各種エラーを適切に変換
  - エラーログ記録機能を実装（センシティブ情報を除外）
  - _Requirements: 5.1, 5.2, 5.3, 5.4_

- [ ] 3.3 AuthService のユーザー登録機能を実装
  - メールアドレスとパスワードで Firebase にユーザーを作成する機能を実装
  - 登録成功時にローカルデータベースにユーザー情報を保存
  - Firebase から確認メールを送信する機能を実装
  - メールアドレス重複時に適切なエラーを返す
  - 3.1、3.2 のバリデーションとエラーマッピングを統合
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 2.1_

- [ ] 3.4 AuthService の確認メール再送信機能を実装
  - メールアドレスでユーザーを検索する機能を実装
  - メール検証済みかどうかを確認するロジックを実装
  - 確認メール再送信を Firebase に要求する機能を実装
  - 未登録ユーザー、検証済みユーザー、レート制限のエラーハンドリング
  - _Requirements: 2.3, 2.4, 2.5_

- [ ] 4. GraphQL API 実装
- [ ] 4.1 GraphQL エラー型と入力型を定義
  - AuthError 型と AuthErrorCode enum を定義
  - RegisterUserInput、ResendVerificationEmailInput 入力型を定義
  - RegisterUserPayload、ResendVerificationEmailPayload 出力型を定義
  - _Requirements: 4.4_

- [ ] 4.2 registerUser Mutation を実装
  - Pothos で registerUser Mutation を定義
  - AuthService の register メソッドを呼び出す Resolver を実装
  - 成功時にユーザー情報を返し、失敗時にエラーを返す
  - _Requirements: 4.1, 4.3, 4.4_

- [ ] 4.3 (P) resendVerificationEmail Mutation を実装
  - Pothos で resendVerificationEmail Mutation を定義
  - AuthService の resendVerificationEmail メソッドを呼び出す Resolver を実装
  - 成功時に success: true を返し、失敗時にエラーを返す
  - _Requirements: 4.2, 4.4_

- [ ] 5. 統合テスト
- [ ] 5.1 AuthService のユニットテストを作成
  - パスワードバリデーションの各ケースをテスト
  - Firebase エラーマッピングの各ケースをテスト
  - ユーザー登録の正常系・異常系をテスト（Firebase モック使用）
  - 確認メール再送信の正常系・異常系をテスト
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 2.1, 2.3, 2.4, 2.5, 3.1, 3.2, 3.3, 5.1, 5.2, 5.3, 5.4_

- [ ] 5.2 (P) UserRepository/UserService のユニットテストを作成
  - Firebase UID でのユーザー検索テスト
  - Firebase UID 付きユーザー作成テスト
  - _Requirements: 1.2_

- [ ] 5.3 GraphQL Mutation の統合テストを作成
  - registerUser Mutation の正常系・異常系をテスト
  - resendVerificationEmail Mutation の正常系・異常系をテスト
  - データベースへの保存確認を含む
  - _Requirements: 4.1, 4.2, 4.3, 4.4_

- [ ] 6. Feature モジュール統合
- [ ] 6.1 Auth Feature を GraphQL スキーマに登録
  - FeatureModule インターフェースに従って Auth Feature を実装
  - FeatureRegistry に Auth Feature を登録
  - GraphQL スキーマに Auth 型と Mutation を統合
  - 全体の動作確認
  - _Requirements: 4.1, 4.2, 4.3, 4.4_

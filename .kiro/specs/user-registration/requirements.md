# Requirements Document

## Introduction

本ドキュメントは、Shelfie API（apps/api）におけるユーザー新規登録機能の要件を定義する。Firebase Authentication を使用したメールアドレス/パスワード認証と、メールによる2段階認証（メール認証）を実装する。

## Requirements

### Requirement 1: ユーザー新規登録

**Objective:** As a 新規ユーザー, I want メールアドレスとパスワードでアカウントを作成したい, so that アプリケーションの機能を利用できるようになる

#### Acceptance Criteria

1. When ユーザーがメールアドレスとパスワードを入力して登録を実行した場合, the Auth Service shall Firebase Authentication にユーザーを作成する
2. When ユーザー登録が成功した場合, the Auth Service shall ローカルデータベースにユーザー情報を保存する
3. When ユーザー登録が成功した場合, the Auth Service shall 確認メールを送信する
4. If 既に登録済みのメールアドレスで登録を試みた場合, the Auth Service shall 「このメールアドレスは既に使用されています」というエラーを返す
5. If パスワードがセキュリティ要件を満たさない場合, the Auth Service shall パスワード要件を示すエラーメッセージを返す

### Requirement 2: メールアドレス検証

**Objective:** As a 登録済みユーザー, I want メールアドレスの所有権を確認したい, so that アカウントのセキュリティを確保できる

#### Acceptance Criteria

1. When 新規ユーザーが登録を完了した場合, the Auth Service shall Firebase Authentication を通じて確認メールを自動送信する
2. When ユーザーが確認メールのリンクをクリックした場合, the Auth Service shall Firebase 側でメールアドレスを検証済みとしてマークする
3. While ユーザーのメールアドレスが未検証の状態である場合, the Auth Service shall 認証済みユーザーとして扱うがメール未検証であることを識別可能にする
4. When ユーザーが確認メールの再送信を要求した場合, the Auth Service shall 新しい確認メールを送信する
5. If 確認メールの再送信がレート制限を超えた場合, the Auth Service shall 適切なエラーメッセージを返す

### Requirement 3: パスワードセキュリティ要件

**Objective:** As a システム管理者, I want パスワードのセキュリティ基準を強制したい, so that ユーザーアカウントを不正アクセスから保護できる

#### Acceptance Criteria

1. The Auth Service shall パスワードは最低8文字以上を要求する
2. If パスワードが8文字未満の場合, the Auth Service shall バリデーションエラーを返す
3. When パスワードが要件を満たしている場合, the Auth Service shall 登録処理を続行する

### Requirement 4: GraphQL API エンドポイント

**Objective:** As a クライアントアプリケーション開発者, I want GraphQL 経由でユーザー登録機能にアクセスしたい, so that 統一された API インターフェースを使用できる

#### Acceptance Criteria

1. The API Service shall ユーザー登録用の GraphQL Mutation を提供する
2. The API Service shall 確認メール再送信用の GraphQL Mutation を提供する
3. When GraphQL Mutation が成功した場合, the API Service shall 作成されたユーザー情報を返す
4. If GraphQL Mutation が失敗した場合, the API Service shall 適切なエラーコードとメッセージを返す

### Requirement 5: エラーハンドリング

**Objective:** As a クライアントアプリケーション, I want 明確なエラーメッセージを受け取りたい, so that ユーザーに適切なフィードバックを提供できる

#### Acceptance Criteria

1. If Firebase Authentication でエラーが発生した場合, the Auth Service shall Firebase のエラーコードを適切なユーザー向けメッセージに変換する
2. If ネットワークエラーが発生した場合, the Auth Service shall リトライ可能であることを示すエラーを返す
3. If バリデーションエラーが発生した場合, the Auth Service shall どのフィールドにエラーがあるかを明示する
4. The Auth Service shall エラーをログに記録する（センシティブ情報を除く）

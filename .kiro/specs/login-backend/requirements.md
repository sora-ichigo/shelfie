# Requirements Document

## Introduction

本ドキュメントは、Shelfie アプリケーションのログイン機能バックエンド実装に関する要件を定義する。

Firebase Authentication を IDaaS として使用し、クライアントサイドでのログイン処理後に取得した ID Token を検証し、ローカルデータベースからユーザー情報を取得する GraphQL API を提供する。

既存の新規登録機能（registerUser mutation）との一貫性を保ちつつ、セキュアで使いやすいログイン体験を実現する。

## Requirements

### Requirement 1: ログインユーザー情報取得

**Objective:** As a ログイン済みユーザー, I want ID Token を使用して自分のユーザー情報を取得したい, so that アプリ内で認証済みユーザーとして操作できる

#### Acceptance Criteria

1. When 有効な Firebase ID Token を含む Authorization ヘッダーでリクエストを送信する, the Auth Feature shall ローカルデータベースから該当ユーザーの情報を返す
2. When 有効な ID Token だがローカルデータベースにユーザーが存在しない, the Auth Feature shall USER_NOT_FOUND エラーを返す
3. If 無効または期限切れの ID Token でリクエストを送信する, then the Auth Feature shall INVALID_TOKEN エラーを返す
4. If Authorization ヘッダーが存在しない, then the Auth Feature shall UNAUTHENTICATED エラーを返す

### Requirement 2: GraphQL Query 定義

**Objective:** As a モバイルアプリ開発者, I want ログイン後にユーザー情報を取得する GraphQL Query を使用したい, so that 認証状態を確認しユーザー情報を表示できる

#### Acceptance Criteria

1. The Auth Feature shall `me` Query を提供し、認証済みユーザーの User オブジェクトを返す
2. When `me` Query を実行する, the Auth Feature shall 現在の認証コンテキストに紐づくユーザー情報を返す
3. The Auth Feature shall `me` Query を認証必須（authenticated scope）として定義する

### Requirement 3: エラーハンドリング

**Objective:** As a モバイルアプリ開発者, I want ログイン関連のエラーを適切に識別したい, so that ユーザーに適切なエラーメッセージを表示できる

#### Acceptance Criteria

1. The Auth Feature shall 以下のエラーコードを定義する: INVALID_TOKEN, TOKEN_EXPIRED, USER_NOT_FOUND, UNAUTHENTICATED
2. When エラーが発生する, the Auth Feature shall エラーコード、メッセージ、再試行可能フラグを含むエラーオブジェクトを返す
3. If TOKEN_EXPIRED エラーが発生する, then the Auth Feature shall クライアントがトークン更新後に再試行可能であることを示す

### Requirement 4: Firebase UID とローカルユーザーの関連付け

**Objective:** As a システム管理者, I want Firebase UID とローカルデータベースのユーザーを正確に関連付けたい, so that ユーザーデータの整合性を保てる

#### Acceptance Criteria

1. When ID Token を検証する, the Auth Feature shall Firebase UID を抽出してローカルデータベースのユーザーを検索する
2. The User Service shall Firebase UID によるユーザー検索機能を提供する
3. If 複数のユーザーが同一の Firebase UID を持つ, then the Auth Feature shall INTERNAL_ERROR エラーを返しログに記録する

### Requirement 5: セキュリティ要件

**Objective:** As a セキュリティ担当者, I want ログイン機能が安全に実装されることを確認したい, so that ユーザーアカウントを保護できる

#### Acceptance Criteria

1. The Auth Feature shall すべての ID Token 検証を Firebase Admin SDK を使用して実行する
2. The Auth Feature shall 認証関連の操作をログに記録する（ID Token 自体は記録しない）
3. While ID Token を検証中, the Auth Feature shall トークンの発行者（issuer）と対象者（audience）を検証する
4. The Auth Feature shall 認証失敗時に詳細なエラー情報を外部に公開しない（ログには記録する）

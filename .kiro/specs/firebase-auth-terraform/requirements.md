# Requirements Document

## Project Description (Input)
terraform の dev で開発用の Firebase Authentication (メールアドレス/パスワード認証、メール送信して確認コードも使う)を使えるようにリソースを準備したい

## Introduction

本ドキュメントは、Shelfie プロジェクトの dev 環境において Firebase Authentication をメールアドレス/パスワード認証（メール確認付き）で利用可能にするための Terraform リソース要件を定義する。既存の GCP/Terraform インフラ構成（`infra/terraform/environments/dev/`）に Firebase プロジェクトと Identity Platform の設定を追加する。

## Requirements

### Requirement 1: Firebase プロジェクトの有効化

**Objective:** インフラ管理者として、Terraform で Firebase プロジェクトを有効化したい。そうすることで、Firebase Authentication を含む Firebase サービスを GCP プロジェクト上で利用できるようになる。

#### Acceptance Criteria
1. The Terraform configuration shall enable the Firebase API (`firebase.googleapis.com`) on the GCP project.
2. The Terraform configuration shall create or enable a Firebase project resource linked to the existing GCP project.
3. When `terraform apply` is executed, the Terraform configuration shall provision Firebase project resources without manual console operations.

### Requirement 2: Identity Platform API の有効化

**Objective:** インフラ管理者として、Terraform で Identity Platform API を有効化したい。そうすることで、Firebase Authentication の機能を利用できるようになる。

#### Acceptance Criteria
1. The Terraform configuration shall enable the Identity Platform API (`identitytoolkit.googleapis.com`) on the GCP project.
2. The Terraform configuration shall configure the Identity Platform tenant settings for the dev environment.

### Requirement 3: メールアドレス/パスワード認証の設定

**Objective:** 開発者として、メールアドレスとパスワードによる認証方式を利用したい。そうすることで、ユーザーがメールアドレスでサインアップ・サインインできるようになる。

#### Acceptance Criteria
1. The Terraform configuration shall enable the email/password sign-in provider in Identity Platform.
2. The Terraform configuration shall configure password policy settings (minimum length, complexity requirements as needed).
3. When a user signs up with email and password, the Identity Platform shall accept the registration with valid credentials.

### Requirement 4: メール確認（Email Verification）の設定

**Objective:** 開発者として、ユーザー登録時にメール確認を必須にしたい。そうすることで、有効なメールアドレスを持つユーザーのみがサービスを利用できるようになる。

#### Acceptance Criteria
1. The Terraform configuration shall enable email verification requirement in Identity Platform settings.
2. When a new user signs up, the Identity Platform shall send a verification email to the registered email address.
3. The Terraform configuration shall configure email template settings for verification emails (if customization is supported).

### Requirement 5: Terraform モジュール構成

**Objective:** インフラ管理者として、Firebase Authentication の設定を再利用可能なモジュールとして構成したい。そうすることで、stg/prod 環境への展開が容易になる。

#### Acceptance Criteria
1. The Terraform configuration shall create a new module under `infra/terraform/modules/firebase-auth/`.
2. The module shall expose configurable variables for environment-specific settings (email templates, password policies, etc.).
3. The dev environment (`infra/terraform/environments/dev/main.tf`) shall reference the firebase-auth module.
4. The Terraform configuration shall follow the existing module pattern used in `api-cloud-run` and `github-actions-wif` modules.

### Requirement 6: 既存インフラとの統合

**Objective:** インフラ管理者として、Firebase Authentication の設定が既存の Cloud Run API と連携できるようにしたい。そうすることで、API サーバーが Firebase Auth のトークン検証を行えるようになる。

#### Acceptance Criteria
1. The Terraform configuration shall ensure the Cloud Run service account has permissions to verify Firebase Auth tokens.
2. If additional IAM roles are required, the Terraform configuration shall grant them to the existing service account (`shelfie-api-runner`).
3. The Terraform configuration shall output the Firebase project configuration values needed by the API application (project ID, API key, etc.).

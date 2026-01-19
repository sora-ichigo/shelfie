# Implementation Plan

## Task Format Template

- [ ] {{NUMBER}}. {{TASK_DESCRIPTION}}{{PARALLEL_MARK}}

## Tasks

- [x] 1. firebase-auth モジュールの基盤作成
- [x] 1.1 モジュールディレクトリと変数定義を作成する
  - `infra/terraform/modules/firebase-auth/` ディレクトリを作成
  - `variables.tf` を作成し、モジュールの入力変数を定義（project_id, environment, authorized_domains, allow_duplicate_emails, enable_anonymous_auth, autodelete_anonymous_users）
  - 各変数に適切なバリデーションブロックを追加（environment は dev/stg/prod のみ許可）
  - 既存モジュール（api-cloud-run, github-actions-wif）のパターンに従ったセクションコメントを使用
  - _Requirements: 5.1, 5.2, 5.4_

- [x] 1.2 モジュールの出力定義を作成する
  - `outputs.tf` を作成し、モジュールの出力値を定義
  - Firebase プロジェクト ID、API キー（sensitive 属性付き）、authorized_domains を出力
  - API サーバーが必要とする設定値が取得可能であることを確認
  - _Requirements: 5.2, 6.3_

- [x] 2. Firebase および Identity Platform リソースの実装
- [x] 2.1 (P) 必要な GCP API を有効化するリソースを実装する
  - `main.tf` に `google_project_service` リソースを追加
  - `firebase.googleapis.com` と `identitytoolkit.googleapis.com` を有効化
  - `disable_on_destroy = false` で API の無効化を防止
  - _Requirements: 1.1, 2.1_

- [x] 2.2 Firebase プロジェクトリソースを実装する
  - `google_firebase_project` リソースを追加（google-beta プロバイダを使用）
  - API 有効化リソースへの `depends_on` を設定
  - GCP プロジェクトとの連携が正しく設定されていることを確認
  - _Requirements: 1.2, 1.3_

- [x] 2.3 Identity Platform 設定リソースを実装する
  - `google_identity_platform_config` リソースを追加
  - `sign_in.email` ブロックでメール/パスワード認証を有効化
  - `password_required = true` でパスワード必須を設定
  - `authorized_domains` で許可ドメインを設定
  - Firebase プロジェクトリソースへの `depends_on` を設定
  - _Requirements: 2.2, 3.1, 3.2, 3.3, 4.1, 4.2, 4.3_

- [x] 3. dev 環境への統合
- [x] 3.1 google-beta プロバイダを dev 環境に追加する
  - `dev/main.tf` の `required_providers` ブロックに `google-beta` を追加
  - `provider "google-beta"` ブロックを追加し、project と region を設定
  - 既存リソースへの影響がないことを確認
  - _Requirements: 5.3_

- [x] 3.2 firebase-auth モジュールを dev 環境から参照する
  - `module "firebase_auth"` ブロックを追加
  - `source` パスを正しく設定（`../../modules/firebase-auth`）
  - providers エイリアスを設定（google-beta プロバイダを渡す）
  - 環境固有の変数を設定（authorized_domains に localhost とプロジェクトドメインを追加）
  - api-cloud-run モジュールとの依存関係を明示
  - _Requirements: 5.3, 6.1, 6.2_

- [x] 3.3 モジュール出力を環境から公開する
  - `output` ブロックを追加して firebase_auth モジュールの出力を公開
  - firebase_project_id と firebase_api_key を出力
  - API アプリケーションで利用可能な形式で設定値を提供
  - _Requirements: 6.3_

- [x] 4. Terraform 検証と適用
- [x] 4.1 Terraform の構文検証を実行する
  - `terraform init` でプロバイダをダウンロード
  - `terraform validate` で構文エラーがないことを確認
  - 変数バリデーションが正しく機能することをテスト
  - _Requirements: 1.3, 5.4_

- [x] 4.2 Terraform plan で変更内容を確認する
  - `terraform plan` を実行して作成されるリソースを確認
  - Firebase プロジェクト、Identity Platform 設定、API 有効化が含まれることを検証
  - 既存リソースへの予期しない変更がないことを確認
  - _Requirements: 1.3, 2.2, 3.3, 4.2_

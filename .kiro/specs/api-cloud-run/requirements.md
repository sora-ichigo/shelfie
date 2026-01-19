# Requirements Document

## Introduction

本ドキュメントは、Shelfie プロジェクトの GraphQL API (`apps/api`) を Google Cloud Run 上でホストするための Terraform インフラストラクチャ要件を定義する。既存の Terraform 基盤（`infra/terraform/main.tf`）を拡張し、本番環境で API を安全かつスケーラブルに運用するためのリソースを構築する。

## Requirements

### Requirement 1: Cloud Run サービス定義

**Objective:** インフラ管理者として、API コンテナを Cloud Run 上で実行したい。これにより、サーバーレスでスケーラブルな本番環境を実現できる。

#### Acceptance Criteria

1. The Terraform configuration shall API サービス用の Cloud Run サービスリソースを定義する
2. The Cloud Run service shall Artifact Registry からコンテナイメージを参照する
3. The Cloud Run service shall コンテナポート 4000 を公開する
4. The Cloud Run service shall `asia-northeast1` リージョンにデプロイされる
5. When コンテナイメージタグが変更された場合, the Cloud Run service shall 新しいリビジョンを自動作成する

### Requirement 2: リソース設定とスケーリング

**Objective:** インフラ管理者として、適切なリソース制限とスケーリング設定を行いたい。これにより、コスト効率と可用性のバランスを取れる。

#### Acceptance Criteria

1. The Cloud Run service shall CPU とメモリの制限値を設定可能にする
2. The Cloud Run service shall 最小・最大インスタンス数を設定可能にする
3. The Cloud Run service shall リクエストタイムアウト値を設定可能にする
4. The Cloud Run service shall コールドスタート削減のため最小インスタンス数をデフォルト 0 に設定する
5. The Terraform configuration shall 変数を通じてリソース設定をカスタマイズ可能にする

### Requirement 3: Artifact Registry リポジトリ

**Objective:** インフラ管理者として、API コンテナイメージを保存するレジストリを用意したい。これにより、Cloud Run がイメージを取得できる。

#### Acceptance Criteria

1. The Terraform configuration shall Docker イメージ用の Artifact Registry リポジトリを作成する
2. The Artifact Registry shall Cloud Run サービスと同じリージョンに配置される
3. The Artifact Registry shall 適切な IAM ポリシーを持ち、Cloud Run がイメージを読み取り可能にする

### Requirement 4: IAM とサービスアカウント

**Objective:** セキュリティ管理者として、最小権限の原則に基づくサービスアカウントを設定したい。これにより、セキュリティリスクを最小化できる。

#### Acceptance Criteria

1. The Terraform configuration shall Cloud Run 用の専用サービスアカウントを作成する
2. The service account shall Cloud Run 実行に必要な最小限のロールのみを持つ
3. If サービスが外部公開される場合, the Cloud Run service shall 未認証アクセスを許可する IAM ポリシーを設定する
4. The Terraform configuration shall サービスアカウント設定を変数でカスタマイズ可能にする

### Requirement 5: ネットワークとアクセス設定

**Objective:** インフラ管理者として、API への外部アクセスを制御したい。これにより、適切なネットワーク境界を設定できる。

#### Acceptance Criteria

1. The Cloud Run service shall 外部からの HTTPS アクセスを受け付ける
2. The Cloud Run service shall ingress 設定（全許可/内部のみ/ロードバランサー経由）を変数で制御可能にする
3. The Terraform configuration shall Cloud Run が生成する URL を出力する

### Requirement 6: 環境変数とシークレット管理

**Objective:** 開発者として、API に必要な環境変数を安全に設定したい。これにより、設定値とシークレットを適切に管理できる。

#### Acceptance Criteria

1. The Cloud Run service shall 環境変数を設定可能にする
2. The Cloud Run service shall PORT 環境変数を 4000 に設定する
3. The Terraform configuration shall 追加の環境変数をマップ形式で受け取る変数を提供する
4. Where Secret Manager が利用可能な場合, the Cloud Run service shall シークレットを環境変数としてマウント可能にする

### Requirement 7: Terraform 出力

**Objective:** インフラ管理者として、デプロイ後の重要な情報を確認したい。これにより、他システムとの連携やドキュメント化が容易になる。

#### Acceptance Criteria

1. The Terraform configuration shall Cloud Run サービス URL を出力する
2. The Terraform configuration shall Cloud Run サービス名を出力する
3. The Terraform configuration shall Artifact Registry リポジトリ URL を出力する
4. The Terraform configuration shall 作成したサービスアカウントのメールアドレスを出力する

# Shelfie Terraform Infrastructure

Shelfie API を Google Cloud Run 上でホストするための Terraform インフラストラクチャ。

## ディレクトリ構成

```
infra/terraform/
├── modules/
│   ├── api-cloud-run/          # Cloud Run サービス
│   │   ├── main.tf             # Cloud Run, Artifact Registry, IAM リソース
│   │   ├── variables.tf        # 変数定義
│   │   └── outputs.tf          # 出力定義
│   └── github-actions-wif/     # GitHub Actions 用 Workload Identity Federation
│       ├── main.tf             # WIF Pool, Provider, Service Account
│       ├── variables.tf        # 変数定義
│       └── outputs.tf          # 出力定義
├── environments/
│   ├── dev/                    # development 環境
│   ├── stg/                    # staging 環境
│   └── prod/                   # production 環境
│       ├── main.tf             # モジュール呼び出し
│       ├── variables.tf        # 環境変数定義
│       ├── terraform.tfvars    # 環境固有の値
│       └── backend.tf          # State 管理設定
└── README.md
```

## 前提条件

- Terraform >= 1.11.0
- GCP プロジェクト（環境ごとに分離）
  - `shelfie-development-484809` (development)
  - `shelfie-stg` (staging)
  - `shelfie-prod` (production)
- 必要な GCP API の有効化:
  - `run.googleapis.com`
  - `artifactregistry.googleapis.com`
- `gcloud` CLI で認証済み

## クイックスタート

### 1. GCP 認証

```bash
gcloud auth application-default login
```

### 2. 環境ディレクトリに移動

```bash
cd infra/terraform/environments/dev
```

### 3. 初期化

```bash
terraform init
```

### 4. 計画確認

```bash
terraform plan
```

### 5. デプロイ

```bash
terraform apply
```

## 環境別設定

各環境の `terraform.tfvars` で設定をカスタマイズできます。

| 設定項目                | dev                        | stg         | prod         |
| ----------------------- | -------------------------- | ----------- | ------------ |
| `project_id`            | shelfie-development-484809 | shelfie-stg | shelfie-prod |
| `min_instances`         | 0                          | 0           | 1            |
| `max_instances`         | 2                          | 5           | 10           |
| `cpu_limit`             | 1                          | 1           | 2            |
| `memory_limit`          | 512Mi                      | 512Mi       | 1Gi          |
| `allow_unauthenticated` | true                       | true        | false        |

## モジュール変数

### 必須変数

| 変数           | 型     | 説明                      |
| -------------- | ------ | ------------------------- |
| `project_id`   | string | GCP プロジェクト ID       |
| `environment`  | string | 環境名 (dev, stg, prod)   |
| `github_owner` | string | GitHub リポジトリオーナー |
| `github_repo`  | string | GitHub リポジトリ名       |

### オプション変数

| 変数                    | 型          | デフォルト          | 説明                         |
| ----------------------- | ----------- | ------------------- | ---------------------------- |
| `region`                | string      | asia-northeast1     | GCP リージョン               |
| `service_name`          | string      | shelfie-api         | Cloud Run サービス名         |
| `image_name`            | string      | api                 | コンテナイメージ名           |
| `image_tag`             | string      | latest              | イメージタグ                 |
| `cpu_limit`             | string      | 1                   | CPU 制限                     |
| `memory_limit`          | string      | 512Mi               | メモリ制限                   |
| `min_instances`         | number      | 0                   | 最小インスタンス数           |
| `max_instances`         | number      | 10                  | 最大インスタンス数           |
| `request_timeout`       | number      | 300                 | リクエストタイムアウト（秒） |
| `service_account_id`    | string      | shelfie-api-runner  | サービスアカウント ID        |
| `allow_unauthenticated` | bool        | true                | 未認証アクセス許可           |
| `ingress`               | string      | INGRESS_TRAFFIC_ALL | Ingress 設定                 |
| `environment_variables` | map(string) | {}                  | 追加環境変数                 |

## 出力値

| 出力                                        | 説明                                         |
| ------------------------------------------- | -------------------------------------------- |
| `cloud_run_service_url`                     | Cloud Run サービス URL                       |
| `cloud_run_service_name`                    | Cloud Run サービス名                         |
| `artifact_registry_repository_url`          | Artifact Registry リポジトリ URL             |
| `service_account_email`                     | サービスアカウントのメールアドレス           |
| `github_actions_workload_identity_provider` | GitHub Actions 用 Workload Identity Provider |
| `github_actions_service_account_email`      | GitHub Actions 用サービスアカウント          |

## GitHub Actions CD セットアップ

master ブランチへの push で自動的に Cloud Run へデプロイする CD パイプラインを構築できます。

### 1. 必要な GCP API の有効化

```bash
cd infra/terraform/environments/dev
gcloud services enable iamcredentials.googleapis.com --project=shelfie-development-484809
```

### 2. Terraform で Workload Identity Federation を構築

```bash
terraform apply
```

※ `github_owner` と `github_repo` は `terraform.tfvars` に設定済み

### 3. GitHub リポジトリ変数の設定

Terraform の出力値を使って GitHub リポジトリの変数を設定します。

| 変数名                               | 取得方法                                                     |
| ------------------------------------ | ------------------------------------------------------------ |
| `DEV_GCP_PROJECT_ID`                 | プロジェクト ID（例: `shelfie-development-484809`）          |
| `DEV_GCP_WORKLOAD_IDENTITY_PROVIDER` | `terraform output github_actions_workload_identity_provider` |
| `DEV_GCP_SERVICE_ACCOUNT`            | `terraform output github_actions_service_account_email`      |

**設定場所**: GitHub リポジトリ → Settings → Secrets and variables → Actions → Variables

### 4. CD ワークフロー

`.github/workflows/deploy-api.yml` が以下のトリガーで実行されます:

- master ブランチへの push（`apps/api/` の変更時）
- 手動実行（workflow_dispatch）

## 開発ワークフロー

### コンテナイメージのビルドとプッシュ

```bash
# Artifact Registry URL を取得
AR_URL=$(cd infra/terraform/environments/dev && terraform output -raw artifact_registry_repository_url)

# Docker イメージをビルド
docker build -t ${AR_URL}/api:latest -f apps/api/Dockerfile .

# Artifact Registry に認証
gcloud auth configure-docker asia-northeast1-docker.pkg.dev

# イメージをプッシュ
docker push ${AR_URL}/api:latest
```

### Cloud Run の更新

イメージタグを変更してデプロイする場合:

```bash
cd infra/terraform/environments/dev
terraform apply -var="image_tag=v1.0.0"
```

### 環境変数の追加

`terraform.tfvars` に追加:

```hcl
environment_variables = {
  DATABASE_URL = "postgres://..."
  API_KEY      = "xxx"
}
```

## 検証コマンド

```bash
# フォーマット検証
terraform fmt -check -recursive

# 構文検証
terraform validate

# 計画確認（dry-run）
terraform plan

# 全環境の検証
for env in dev stg prod; do
  echo "=== Validating $env ==="
  (cd infra/terraform/environments/$env && terraform init -backend=false && terraform validate)
done
```

## 注意事項

- **State 管理**: 現在はローカル state を使用。本番運用前に GCS バックエンドへの移行を推奨
- **シークレット管理**: 環境変数は Terraform state に保存される。機密情報は Secret Manager の使用を検討
- **イメージ更新**: `lifecycle.ignore_changes` により、イメージ変更は Terraform 管理外。CI/CD でのデプロイを想定

## トラブルシューティング

### API が有効化されていない

```
Error: Error creating Service: googleapi: Error 403: Cloud Run Admin API has not been used
```

解決策:

```bash
gcloud services enable run.googleapis.com --project=shelfie-development-484809
gcloud services enable artifactregistry.googleapis.com --project=shelfie-development-484809
```

### 権限エラー

```
Error: Error creating Service: googleapi: Error 403: Permission denied
```

解決策:

```bash
# 必要なロールを付与
gcloud projects add-iam-policy-binding shelfie-development-484809 \
  --member="user:your-email@example.com" \
  --role="roles/run.admin"
```

### イメージが見つからない

```
Error: The user-provided container failed to start
```

解決策: Artifact Registry にイメージが存在することを確認

```bash
gcloud artifacts docker images list asia-northeast1-docker.pkg.dev/shelfie-development-484809/shelfie-api
```

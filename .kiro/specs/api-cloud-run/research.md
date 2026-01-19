# Research & Design Decisions

## Summary
- **Feature**: `api-cloud-run`
- **Discovery Scope**: Extension（既存 Terraform 基盤への Cloud Run リソース追加）
- **Key Findings**:
  - Cloud Run v2 API (`google_cloud_run_v2_service`) を使用すべき（v1 は Knative 互換だが v2 は GCP ネイティブで新機能サポート）
  - Artifact Registry は Cloud Run と同一リージョンに配置し、IAM で適切なアクセス権を設定する必要がある
  - 最小権限の原則に基づき、専用サービスアカウントを作成し必要なロールのみ付与する

## Research Log

### Cloud Run v2 vs v1 API
- **Context**: Terraform で Cloud Run サービスを定義する際、v1 (`google_cloud_run_service`) と v2 (`google_cloud_run_v2_service`) のどちらを使用すべきか
- **Sources Consulted**:
  - [Google Cloud Blog - Migrating to Cloud Run API v2](https://cloud.google.com/blog/products/devops-sre/migrating-terraform-resources-stablely-to-cloud-run-api-version-2/)
  - [Terraform Registry - google_cloud_run_v2_service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service)
- **Findings**:
  - v2 API は GCP ネイティブスタイルで設計されており、新機能が優先的にサポートされる
  - v1 から v2 への主な変更点: `timeout_seconds` → `timeout`（文字列）、`container_concurrency` → `max_container_request_concurrency`、`service_account` → `service_account_name`
  - v2 では `run.googleapis.com` 等の名前空間を持つラベルは拒否される
- **Implications**: `google_cloud_run_v2_service` を使用し、将来の機能追加に備える

### Artifact Registry 設定
- **Context**: API コンテナイメージを保存するレジストリの構成
- **Sources Consulted**:
  - [Google Cloud - Provision Artifact Registry with Terraform](https://docs.cloud.google.com/artifact-registry/docs/repositories/terraform)
  - [Terraform Registry - google_artifact_registry_repository](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository)
- **Findings**:
  - `format = "DOCKER"` で Docker イメージ用リポジトリを作成
  - `docker_config.immutable_tags = true` でタグの不変性を強制可能（本番環境向け推奨）
  - `cleanup_policies` でイメージの自動クリーンアップを設定可能
  - terraform-provider-google 5.0.0 以上が必要
- **Implications**: 既存の provider バージョン (~> 7.0) は要件を満たす

### IAM とサービスアカウント構成
- **Context**: Cloud Run サービスの実行 ID と必要な権限
- **Sources Consulted**:
  - [Cloud Run IAM Roles](https://docs.cloud.google.com/run/docs/reference/iam/roles)
  - [Configure Service Identity](https://cloud.google.com/run/docs/configuring/services/service-identity)
- **Findings**:
  - Cloud Run サービスには専用のユーザー管理サービスアカウントを使用すべき
  - 最小権限の原則: サービスが必要とする権限のみを付与
  - 外部公開時は `roles/run.invoker` を `allUsers` に付与（未認証アクセス許可）
  - Artifact Registry からイメージを取得するには `roles/artifactregistry.reader` が必要
- **Implications**: 専用サービスアカウントを作成し、必要最小限のロールを付与する設計とする

### Cloud Run デプロイ要件
- **Context**: コンテナデプロイ時の設定要件
- **Sources Consulted**:
  - [Cloud Run Deploying Documentation](https://docs.cloud.google.com/run/docs/deploying)
- **Findings**:
  - コンテナイメージは Artifact Registry から取得推奨
  - デフォルトポートは 8080 だが、API は 4000 を使用するため明示的に設定が必要
  - 最小インスタンス数のデフォルトは 0（コールドスタート許容）
  - リクエストタイムアウトのデフォルトは 300 秒
- **Implications**: PORT 環境変数と container port を 4000 に設定

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| Terraform モジュール化 | Cloud Run リソースを別モジュールとして分離 | 再利用性、環境分離が容易 | 初期セットアップの複雑さ | 将来のスケール時に有効 |
| 単一 main.tf 拡張 | 既存 main.tf にリソースを追加 | シンプル、即時適用可能 | ファイル肥大化の可能性 | 現時点では最適 |
| Google 公式モジュール使用 | GoogleCloudPlatform/cloud-run/google | ベストプラクティス内蔵 | カスタマイズ性の制限 | バージョン依存リスク |

**選択**: 単一 main.tf 拡張 + 将来のモジュール化を見据えた変数設計

## Design Decisions

### Decision: Cloud Run v2 API の採用
- **Context**: Terraform で Cloud Run を定義するリソースタイプの選択
- **Alternatives Considered**:
  1. `google_cloud_run_service` (v1) — Knative 互換、既存ドキュメント豊富
  2. `google_cloud_run_v2_service` (v2) — GCP ネイティブ、新機能優先サポート
- **Selected Approach**: `google_cloud_run_v2_service` を使用
- **Rationale**: v2 は GCP の標準 API スタイルに準拠し、今後の新機能が優先的にサポートされる。プロジェクトは新規構築であり、v1 からの移行コストが不要
- **Trade-offs**: v1 より情報が少ないが、公式ドキュメントで十分対応可能
- **Follow-up**: provider バージョンが v2 サポート要件を満たすことを確認済み (~> 7.0)

### Decision: 専用サービスアカウントの作成
- **Context**: Cloud Run サービスの実行 ID 設計
- **Alternatives Considered**:
  1. デフォルトの Compute Engine サービスアカウント — 設定不要だが過剰権限
  2. 専用ユーザー管理サービスアカウント — 最小権限の原則に準拠
- **Selected Approach**: 専用サービスアカウント `shelfie-api-runner` を作成
- **Rationale**: セキュリティベストプラクティスに準拠し、必要な権限のみを明示的に付与
- **Trade-offs**: 管理対象のリソースが増加するが、セキュリティ上のメリットが上回る
- **Follow-up**: 将来的に Secret Manager 連携時は追加ロール付与が必要

### Decision: Ingress 設定の変数化
- **Context**: API へのネットワークアクセス制御方法
- **Alternatives Considered**:
  1. 固定で全許可 (`INGRESS_TRAFFIC_ALL`) — シンプルだが柔軟性なし
  2. 変数で制御可能 — 環境ごとのカスタマイズが可能
- **Selected Approach**: `ingress` 設定を変数化し、デフォルトは `INGRESS_TRAFFIC_ALL`
- **Rationale**: 開発初期は外部アクセスを許可し、将来的なロードバランサー経由への移行を容易にする
- **Trade-offs**: 設定の複雑さが若干増加
- **Follow-up**: 本番環境では `INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER` の検討

## Risks & Mitigations
- **Risk 1**: コンテナイメージが存在しない状態での `terraform apply` 失敗
  - **Mitigation**: 初回は dummy イメージ参照、または lifecycle ignore_changes で対応
- **Risk 2**: 未認証アクセス許可によるセキュリティリスク
  - **Mitigation**: 変数 `allow_unauthenticated` でコントロール、本番では認証必須を検討
- **Risk 3**: リソース制限設定不足によるコスト増大
  - **Mitigation**: 適切なデフォルト値と max_instances 制限を設定

## References
- [Terraform GCP Provider - Cloud Run v2 Service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service)
- [Terraform GCP Provider - Artifact Registry Repository](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository)
- [Google Cloud Run Documentation](https://docs.cloud.google.com/run/docs)
- [Google Cloud IAM Roles for Cloud Run](https://docs.cloud.google.com/run/docs/reference/iam/roles)
- [Best Practices for Terraform on GCP](https://docs.cloud.google.com/docs/terraform/best-practices/general-style-structure)

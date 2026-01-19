# Research & Design Decisions

## Summary

- **Feature**: `firebase-auth-terraform`
- **Discovery Scope**: Extension（既存 Terraform インフラへの Firebase Authentication 追加）
- **Key Findings**:
  - Firebase Authentication の Terraform 設定には `google_identity_platform_config` リソースを使用し、これは Identity Platform（GCIP）を有効化する
  - `google-beta` プロバイダが必要であり、既存の `google` プロバイダ設定に追加が必要
  - Cloud Run サービスアカウントが Firebase Auth トークンを検証するために追加の IAM ロールは不要（Admin SDK がプロジェクト ID のみで検証可能）

## Research Log

### Terraform Firebase/Identity Platform リソース調査

- **Context**: Firebase Authentication を Terraform で設定するために必要なリソースと設定方法の調査
- **Sources Consulted**:
  - [Firebase Terraform Getting Started](https://firebase.google.com/docs/projects/terraform/get-started)
  - [google_identity_platform_config Terraform Registry](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/identity_platform_config)
  - [Managing Identity Platform with Terraform](https://www.thecloudpanda.com/blog/gcp-identity-terraform/)
- **Findings**:
  - `google_firebase_project` リソースで Firebase を GCP プロジェクトに有効化
  - `google_identity_platform_config` リソースで認証設定（メール/パスワード、メール確認等）を構成
  - 必要な API: `firebase.googleapis.com`, `identitytoolkit.googleapis.com`
  - `google-beta` プロバイダが必須（Firebase サポートがベータ版のため）
  - Blaze プラン（課金アカウント連携）が必要
- **Implications**:
  - 既存の `google` プロバイダに加えて `google-beta` プロバイダを追加する必要がある
  - API 有効化を先に行い、依存関係を明示する必要がある

### Email/Password 認証の Terraform サポート状況

- **Context**: メールアドレス/パスワード認証と確認メール機能の Terraform 設定可否の調査
- **Sources Consulted**:
  - [GitHub Issue #8288 - Email/Password authentication](https://github.com/hashicorp/terraform-provider-google/issues/8288)
  - [google_identity_platform_config examples](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/identity_platform_config)
- **Findings**:
  - `sign_in.email.enabled = true` でメール認証を有効化
  - `sign_in.email.password_required = true` でパスワード必須を設定
  - メール確認（Email Verification）は Firebase Console または Identity Platform の設定で管理され、Terraform での直接設定は限定的
  - メールテンプレートのカスタマイズは `google_identity_platform_tenant_default_supported_idp_config` で可能だが、テナント使用時のみ
- **Implications**:
  - 基本的なメール/パスワード認証は Terraform で完全に設定可能
  - メール確認の強制は Firebase Console での追加設定が必要な可能性あり
  - 開発環境では `authorized_domains` に `localhost` を追加する必要がある

### Cloud Run と Firebase Auth 連携の IAM 要件

- **Context**: Cloud Run サービスアカウントが Firebase Auth トークンを検証するために必要な権限の調査
- **Sources Consulted**:
  - [Firebase Authentication IAM Roles](https://cloud.google.com/iam/docs/roles-permissions/firebaseauth)
  - [Verify ID Tokens - Firebase Documentation](https://firebase.google.com/docs/auth/admin/verify-id-tokens)
  - [Cloud Run End User Authentication](https://cloud.google.com/run/docs/authenticating/end-users)
- **Findings**:
  - Firebase Admin SDK での ID トークン検証はプロジェクト ID のみで動作
  - サービスアカウントに特別な IAM ロールは不要（トークン検証は公開鍵で行われる）
  - `GOOGLE_CLOUD_PROJECT` 環境変数または明示的なプロジェクト ID 設定が必要
  - カスタムトークン生成時のみ `iam.serviceAccounts.signBlob` 権限が必要
  - `roles/firebaseauth.viewer` は読み取り専用アクセス用だが、トークン検証には不要
- **Implications**:
  - 既存の Cloud Run サービスアカウント（`shelfie-api-runner`）に追加の IAM ロールは不要
  - API サーバーには Firebase プロジェクト ID を環境変数として渡す必要がある

### 既存 Terraform モジュールパターンの分析

- **Context**: 新規モジュールの構成パターンを既存モジュールに合わせるための分析
- **Sources Consulted**:
  - `infra/terraform/modules/api-cloud-run/`
  - `infra/terraform/modules/github-actions-wif/`
- **Findings**:
  - モジュール構成: `main.tf`, `variables.tf`, `outputs.tf` の 3 ファイル構成
  - 変数にはセクションコメントで分類（`# ===...===`）
  - `validation` ブロックで入力値を検証
  - 環境固有の設定は変数で外部化
  - `depends_on` で依存関係を明示
- **Implications**:
  - `firebase-auth` モジュールも同じ 3 ファイル構成で作成
  - 環境固有の変数（パスワードポリシー、authorized_domains 等）を外部化

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| 単一リソースモジュール | Firebase + Identity Platform を 1 モジュールに統合 | シンプル、依存関係が明確 | 将来の拡張性が限定的 | 現時点では十分 |
| 分離モジュール | Firebase Project と Identity Platform を別モジュールに | 柔軟性が高い | 過剰な分離、管理コスト増 | 要件に対してオーバーエンジニアリング |

**選定**: 単一リソースモジュール - 要件に対して適切な粒度であり、既存パターンと一致

## Design Decisions

### Decision: `google-beta` プロバイダの追加方法

- **Context**: Firebase/Identity Platform リソースには `google-beta` プロバイダが必要
- **Alternatives Considered**:
  1. 既存の `google` プロバイダを `google-beta` に置き換え
  2. `google-beta` を追加プロバイダとして併用
- **Selected Approach**: Option 2 - `google-beta` を追加プロバイダとして併用
- **Rationale**: 既存リソース（Cloud Run, Artifact Registry 等）は `google` プロバイダで動作しており、変更リスクを最小化
- **Trade-offs**: プロバイダが 2 つになり設定が複雑化するが、既存インフラへの影響がない
- **Follow-up**: 将来的に全リソースを `google-beta` に統一することを検討

### Decision: メール確認（Email Verification）の設定方法

- **Context**: Terraform でメール確認を必須にする設定の可否
- **Alternatives Considered**:
  1. Terraform の `google_identity_platform_config` のみで設定
  2. Terraform + Firebase Console での手動設定
  3. Firebase Admin SDK でのプログラム的な設定
- **Selected Approach**: Option 1 を基本とし、不足があれば Option 2 で補完
- **Rationale**: `sign_in.email` ブロックで基本設定は可能。メール確認の強制は Firebase プロジェクト設定で自動的に有効になる場合がある
- **Trade-offs**: 一部手動設定が必要になる可能性があるが、IaC の範囲を明確に保てる
- **Follow-up**: 実装時にメール確認の動作を検証し、追加設定が必要か確認

### Decision: モジュールの変数設計

- **Context**: 環境間で異なる設定をどこまで変数化するか
- **Alternatives Considered**:
  1. 最小限の変数（project_id, environment のみ）
  2. 中程度の変数化（パスワードポリシー、ドメイン設定を含む）
  3. 完全な変数化（全設定項目を変数に）
- **Selected Approach**: Option 2 - 中程度の変数化
- **Rationale**: stg/prod 展開時に変更が予想される項目を変数化し、変更されない項目はデフォルト値で固定
- **Trade-offs**: 柔軟性と複雑性のバランス
- **Follow-up**: stg/prod 展開時に追加の変数化が必要か評価

## Risks & Mitigations

- **Risk 1**: Identity Platform の有効化により、Firebase Authentication が Identity Platform 版にアップグレードされ、コスト増加の可能性
  - **Mitigation**: 開発環境（dev）での使用量は無料枠内に収まる見込み。本番展開前にコスト見積もりを実施
- **Risk 2**: `google-beta` プロバイダの API 変更による破壊的変更
  - **Mitigation**: バージョンを `~> 7.0` で固定し、定期的なアップデートで対応
- **Risk 3**: メール確認機能が Terraform で完全に設定できない可能性
  - **Mitigation**: 実装時に検証し、必要に応じて手動設定のドキュメントを作成

## References

- [Firebase Terraform Getting Started](https://firebase.google.com/docs/projects/terraform/get-started) - Firebase の Terraform セットアップガイド
- [google_identity_platform_config Resource](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/identity_platform_config) - Identity Platform 設定リファレンス
- [Google Provider Configuration Reference](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference) - Google プロバイダ設定ガイド
- [Verify ID Tokens](https://firebase.google.com/docs/auth/admin/verify-id-tokens) - Firebase トークン検証ドキュメント

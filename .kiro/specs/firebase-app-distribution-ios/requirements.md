# Requirements Document

## Introduction

本ドキュメントは Firebase App Distribution を用いた iOS アプリ (Shelfie) の配信機能に関する要件を定義する。開発チーム向けにテストビルドを配信し、迅速なフィードバックサイクルを実現することを目的とする。

既存インフラ構成:
- GCP プロジェクト: `infra/terraform/environments/dev` で管理
- GitHub Actions Workload Identity Federation: 既存モジュール `github-actions-wif` を活用可能
- Firebase Auth: 既存モジュール `firebase-auth` で iOS Bundle ID `app.shelfie.shelfie` が設定済み

## Requirements

### Requirement 1: Firebase App Distribution 有効化

**Objective:** As a 開発者, I want Firebase App Distribution が GCP プロジェクトで有効化されていること, so that iOS アプリのテスト配信が可能になる

#### Acceptance Criteria

1. The Firebase App Distribution shall Firebase プロジェクト内で iOS アプリ向けに有効化されていること
2. The Terraform 構成 shall Firebase App Distribution API の有効化を管理すること
3. The Firebase Console shall iOS アプリ (Bundle ID: `app.shelfie.shelfie`) が登録されていることを表示すること

### Requirement 2: iOS アプリ署名設定

**Objective:** As a 開発者, I want iOS アプリが Ad Hoc または Development 配布用に署名されていること, so that テスターのデバイスにインストール可能になる

#### Acceptance Criteria

1. The iOS ビルド設定 shall Ad Hoc 配布用の Provisioning Profile を使用すること
2. The Xcode プロジェクト shall コード署名設定が CI 環境で自動的に適用されるよう構成されていること
3. If Provisioning Profile が期限切れの場合, then CI ワークフロー shall 明確なエラーメッセージを出力すること
4. The iOS ビルド shall テスターのデバイス UDID が Provisioning Profile に含まれていること

### Requirement 3: CI/CD パイプライン構築

**Objective:** As a 開発者, I want GitHub Actions で iOS ビルドと配信が自動化されていること, so that 手動作業なしにテストビルドを配信できる

#### Acceptance Criteria

1. When master ブランチにプッシュされた場合, the GitHub Actions ワークフロー shall iOS アプリをビルドすること
2. When iOS ビルドが成功した場合, the GitHub Actions ワークフロー shall Firebase App Distribution にアップロードすること
3. The GitHub Actions ワークフロー shall macOS ランナーを使用して iOS ビルドを実行すること
4. The GitHub Actions ワークフロー shall Flutter SDK を mise 経由でセットアップすること
5. While ビルド実行中, the GitHub Actions ワークフロー shall キャッシュを活用して依存関係のインストール時間を短縮すること
6. The GitHub Actions ワークフロー shall Workload Identity Federation を使用して GCP 認証を行うこと

### Requirement 4: シークレット管理

**Objective:** As a 開発者, I want 署名に必要な証明書とキーが安全に管理されていること, so that セキュリティリスクなく CI/CD を運用できる

#### Acceptance Criteria

1. The iOS 配布証明書 shall GitHub Secrets に Base64 エンコードで保存されること
2. The Provisioning Profile shall GitHub Secrets に Base64 エンコードで保存されること
3. The 証明書パスワード shall GitHub Secrets に保存されること
4. While CI 実行中, the ワークフロー shall シークレットを一時的な Keychain に展開すること
5. When CI 実行完了後, the ワークフロー shall 一時的な Keychain を削除すること

### Requirement 5: テスターグループ管理

**Objective:** As a プロジェクト管理者, I want テスターグループを設定してビルドを配信できること, so that 適切な関係者にのみテストビルドが配布される

#### Acceptance Criteria

1. The Firebase App Distribution shall テスターグループを作成できること
2. The CI ワークフロー shall 指定したテスターグループにビルドを配信すること
3. When 新しいビルドが配信された場合, the Firebase App Distribution shall テスターにメール通知を送信すること
4. The テスターグループ設定 shall Terraform または Firebase Console で管理されること

### Requirement 6: ビルドメタデータ

**Objective:** As a テスター, I want ビルドにバージョン情報とリリースノートが含まれていること, so that どのビルドをテストしているか把握できる

#### Acceptance Criteria

1. The iOS ビルド shall Git コミットハッシュをビルド番号に含めること
2. The Firebase App Distribution アップロード shall リリースノートを含めること
3. When PR がマージされた場合, the リリースノート shall PR タイトルまたはコミットメッセージを含むこと
4. The Firebase Console shall ビルドのバージョン情報とリリースノートを表示すること

### Requirement 7: Terraform 管理範囲

**Objective:** As a インフラ管理者, I want Firebase App Distribution 関連リソースの管理方針が明確であること, so that インフラの一貫性が保たれる

#### Acceptance Criteria

1. The Terraform 構成 shall Firebase App Distribution API の有効化を管理すること
2. The Terraform 構成 shall GitHub Actions 用サービスアカウントの IAM 権限を管理すること
3. The GitHub Actions サービスアカウント shall `roles/firebaseappdistribution.admin` 権限を持つこと
4. The テスターグループ shall Firebase Console または Terraform で管理されること（管理方法は設計フェーズで決定）

### Requirement 8: 手動配信オプション

**Objective:** As a 開発者, I want 任意のタイミングで手動ビルドと配信を実行できること, so that 特定のブランチやコミットからテストビルドを作成できる

#### Acceptance Criteria

1. The GitHub Actions ワークフロー shall `workflow_dispatch` によって手動実行できること
2. When 手動実行する場合, the ワークフロー shall ブランチを選択できること
3. When 手動実行する場合, the ワークフロー shall カスタムリリースノートを入力できること

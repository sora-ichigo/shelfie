# Research & Design Decisions

## Summary

- **Feature**: `firebase-app-distribution-ios`
- **Discovery Scope**: Complex Integration
- **Key Findings**:
  - Workload Identity Federation を使用した Firebase App Distribution への認証は Firebase CLI 経由でサポートされている
  - Terraform では Firebase App Distribution の完全な管理は未サポート（API 有効化と IAM 権限のみ管理可能）
  - iOS コード署名は GitHub Secrets を使用した Base64 エンコード方式が標準的アプローチ

## Research Log

### Firebase App Distribution と Terraform

- **Context**: Terraform で Firebase App Distribution を管理できるか調査
- **Sources Consulted**:
  - [Terraform Google Provider - Firebase Project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/firebase_project)
  - [GitHub Issue #16604 - Allow configuring Firebase App Distribution](https://github.com/hashicorp/terraform-provider-google/issues/16604)
- **Findings**:
  - Firebase App Distribution の完全な Terraform サポートは未実装（2023年11月の Feature Request）
  - API の有効化（`firebaseappdistribution.googleapis.com`）は `google_project_service` リソースで可能
  - テスターグループやリリースの管理は Terraform では不可
- **Implications**: API 有効化と IAM 権限のみ Terraform で管理し、テスターグループは Firebase Console で手動管理

### Firebase App Distribution IAM ロール

- **Context**: GitHub Actions サービスアカウントに必要な権限を特定
- **Sources Consulted**:
  - [Firebase IAM Roles Documentation](https://firebase.google.com/docs/projects/iam/roles)
  - [Firebase Product-level Predefined Roles](https://firebase.google.com/docs/projects/iam/roles-predefined-product)
  - [GCP IAM - Firebase App Distribution](https://docs.cloud.google.com/iam/docs/roles-permissions/firebaseappdistro)
- **Findings**:
  - `roles/firebaseappdistro.admin` が必要（リリース管理、テスター管理、グループ管理の完全な読み書き権限）
  - 含まれる権限: `firebaseappdistro.releases.list`, `firebaseappdistro.releases.update`, `firebaseappdistro.testers.list`, `firebaseappdistro.testers.update`, `firebaseappdistro.groups.list`, `firebaseappdistro.groups.update`
- **Implications**: 既存の `github-actions-wif` モジュールに Firebase App Distribution Admin 権限を追加

### Workload Identity Federation と Firebase CLI

- **Context**: Workload Identity Federation を使用して Firebase App Distribution に認証できるか
- **Sources Consulted**:
  - [Medium - Distribute apps to Firebase App Distribution with GitHub Actions using Workload Identity Federation](https://medium.com/@CORDEA/distribute-apps-to-firebase-app-distribution-with-github-actions-using-workload-identity-federation-d064eb22b18a)
  - [Firebase CLI - Distribute iOS apps](https://firebase.google.com/docs/app-distribution/ios/distribute-cli)
- **Findings**:
  - Firebase CLI は Application Default Credentials（ADC）をサポート
  - `google-github-actions/auth` で認証後、Firebase CLI が ADC を自動検出
  - Fastlane の Firebase App Distribution プラグインは Workload Identity Federation を未サポート
  - Firebase CLI コマンド: `firebase appdistribution:distribute test.ipa --app APP_ID --groups GROUP_ALIAS`
- **Implications**: Firebase CLI を直接使用し、Fastlane は使用しない

### iOS コード署名の GitHub Actions 設定

- **Context**: Ad Hoc 配布用の iOS コード署名を GitHub Actions で実現する方法
- **Sources Consulted**:
  - [GitHub Marketplace - Import Code-Signing Certificates](https://github.com/marketplace/actions/import-code-signing-certificates)
  - [Medium - iOS CI/CD with GitHub Actions](https://medium.com/@vedantshirke/ios-ci-cd-with-github-actions-firebase-deployment-on-push-trigger-part-1-d85ba9d68bfe)
  - [How to build an iOS app with GitHub Actions](https://www.andrewhoog.com/posts/how-to-build-an-ios-app-with-github-actions-2023/)
- **Findings**:
  - 配布証明書（Distribution Certificate）を `.p12` 形式でエクスポートし、Base64 エンコードして GitHub Secrets に保存
  - Provisioning Profile も Base64 エンコードして GitHub Secrets に保存
  - `apple-actions/import-codesign-certs@v3` で一時 Keychain にインポート
  - CI 終了時に一時 Keychain を自動削除
- **Implications**: 標準的な GitHub Actions パターンを採用

### Flutter iOS ビルドコマンド

- **Context**: Flutter で Ad Hoc 配布用 IPA をビルドする方法
- **Sources Consulted**:
  - [GitHub Issue #97179 - flutter build ipa export options](https://github.com/flutter/flutter/issues/97179)
  - [Medium - The easiest way to build a Flutter iOS app using GitHub Actions](https://medium.com/team-rockstars-it/the-easiest-way-to-build-a-flutter-ios-app-using-github-actions-plus-a-key-takeaway-for-developers-48cf2ad7c72a)
- **Findings**:
  - `flutter build ipa --export-options-plist=path/to/ExportOptions.plist` で IPA を生成
  - ExportOptions.plist で `method: ad-hoc` を指定
  - ビルド番号に Git コミットハッシュを含めるには `--build-number` オプションを使用
- **Implications**: ExportOptions.plist をリポジトリに追加し、GitHub Actions で参照

### macOS ランナーのコスト考慮

- **Context**: GitHub Actions の macOS ランナー使用時のコスト
- **Sources Consulted**:
  - [GitHub Actions Billing Documentation](https://docs.github.com/en/billing/managing-billing-for-github-actions/about-billing-for-github-actions)
- **Findings**:
  - macOS ランナーは Linux ランナーの 10 倍のクレジットを消費
  - ビルド最適化（キャッシュ活用）がコスト削減に重要
  - wzieba/Firebase-Distribution-Github-Action は Linux のみサポート（Container Action のため）
- **Implications**: ビルドと配布を同一 macOS ジョブで実行し、アーティファクト転送を回避

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| Direct Firebase CLI | Firebase CLI でビルド後直接アップロード | シンプル、Workload Identity Federation サポート | 追加 CLI インストールが必要 | 推奨 |
| Fastlane + Plugin | Fastlane の firebase_app_distribution プラグイン | iOS ビルドワークフローとの統合が容易 | Workload Identity Federation 未サポート | 非推奨 |
| wzieba GitHub Action | サードパーティ GitHub Action | 設定が簡単 | Linux のみ、macOS からアーティファクト転送が必要 | 非推奨 |

## Design Decisions

### Decision: Firebase CLI を直接使用

- **Context**: Firebase App Distribution へのアップロード方法の選択
- **Alternatives Considered**:
  1. Fastlane + firebase_app_distribution plugin - iOS ビルドと統合しやすいが Workload Identity Federation 未サポート
  2. wzieba/Firebase-Distribution-Github-Action - Linux 専用のため macOS でビルド後にアーティファクト転送が必要
  3. Firebase CLI 直接使用 - Workload Identity Federation サポート、シンプル
- **Selected Approach**: Firebase CLI を直接使用
- **Rationale**: 既存の Workload Identity Federation インフラを活用でき、セキュリティ面でサービスアカウントキーの管理が不要
- **Trade-offs**: Firebase CLI のインストールが必要だが、npm 経由で簡単にインストール可能
- **Follow-up**: Firebase CLI のバージョン固定を検討

### Decision: 既存 github-actions-wif モジュールの拡張

- **Context**: Firebase App Distribution 用の IAM 権限をどこで管理するか
- **Alternatives Considered**:
  1. 新規 Terraform モジュール作成 - 責務分離は良いが、サービスアカウントが複数になり複雑
  2. 既存 github-actions-wif モジュール拡張 - 単一サービスアカウントで管理、シンプル
- **Selected Approach**: 既存 github-actions-wif モジュールに `roles/firebaseappdistro.admin` 権限を追加
- **Rationale**: 既に Workload Identity Pool とサービスアカウントが存在し、権限追加のみで対応可能
- **Trade-offs**: モジュールの責務が広がるが、GitHub Actions 関連という括りで許容範囲
- **Follow-up**: モジュール名を `github-actions-wif` から `github-actions-ci` への変更を検討（将来）

### Decision: テスターグループは Firebase Console で管理

- **Context**: テスターグループをどこで管理するか
- **Alternatives Considered**:
  1. Terraform 管理 - 未サポートのため不可
  2. Firebase CLI で管理 - 可能だが CI/CD での管理は複雑
  3. Firebase Console で手動管理 - シンプル、GUI で直感的
- **Selected Approach**: Firebase Console で手動管理し、グループエイリアスを GitHub Variables に設定
- **Rationale**: Terraform 未サポートのため、最もシンプルな方法を選択
- **Trade-offs**: IaC の一貫性は損なわれるが、頻繁に変更されるリソースではない
- **Follow-up**: Terraform サポートが追加されたら移行を検討

### Decision: Ad Hoc 配布方式の採用

- **Context**: iOS アプリの配布方式の選択
- **Alternatives Considered**:
  1. Development - 開発者のみ、台数制限あり
  2. Ad Hoc - 登録デバイス向け、Firebase App Distribution に適合
  3. Enterprise - 企業向け、Apple Developer Enterprise Program が必要
- **Selected Approach**: Ad Hoc 配布方式
- **Rationale**: Firebase App Distribution の標準的な配布方式、テスターのデバイス UDID を Provisioning Profile に登録して配布
- **Trade-offs**: テスターデバイスの追加時に Provisioning Profile の更新が必要
- **Follow-up**: テスターデバイス管理のワークフロー文書化

## Risks & Mitigations

- **Provisioning Profile 期限切れ** - CI ワークフローで有効期限チェックを実装し、期限切れ前に通知
- **macOS ランナーのコスト増加** - キャッシュ最適化でビルド時間短縮、トリガー条件を限定
- **Firebase App Distribution API の変更** - Firebase CLI バージョンを固定し、定期的に更新
- **シークレット漏洩リスク** - GitHub Secrets の監査ログ確認、最小権限の原則を適用

## References

- [Firebase App Distribution - Distribute iOS apps using CLI](https://firebase.google.com/docs/app-distribution/ios/distribute-cli)
- [Firebase IAM Roles](https://firebase.google.com/docs/projects/iam/roles)
- [GitHub Actions - Import Code-Signing Certificates](https://github.com/marketplace/actions/import-code-signing-certificates)
- [Workload Identity Federation with GitHub Actions](https://medium.com/@CORDEA/distribute-apps-to-firebase-app-distribution-with-github-actions-using-workload-identity-federation-d064eb22b18a)
- [Flutter build ipa command](https://docs.flutter.dev/deployment/ios)

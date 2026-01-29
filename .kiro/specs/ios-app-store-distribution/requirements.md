# Requirements Document

## Introduction

本ドキュメントは、Shelfie iOS アプリの Apple App Store 公開配信に関する要件を定義する。現在 Firebase App Distribution（Ad-hoc）で配信している iOS アプリを、Apple App Store に掲載して一般ユーザーがダウンロードできる状態にする。Fastlane の App Store 用レーン追加、コード署名の変更、CI/CD パイプラインの構築、App Store Connect メタデータ管理を対象範囲とする。ベータ配信は引き続き Firebase App Distribution を使用し、TestFlight は本スコープに含まない。

## Requirements

### Requirement 1: App Store 用コード署名の構成

**Objective:** As a 開発者, I want Fastlane match で App Store Distribution 用の証明書とプロビジョニングプロファイルを管理できること, so that Ad-hoc と App Store の両方の署名方式を一元管理できる

#### Acceptance Criteria

1. The CI/CD パイプライン shall Fastlane match を使用して App Store Distribution 用の証明書とプロビジョニングプロファイルを取得できること
2. When App Store 用ビルドが要求された場合, the Fastlane shall `appstore` タイプの証明書とプロビジョニングプロファイルを読み取り専用モードで取得すること
3. The Matchfile shall `adhoc` と `appstore` の両方のタイプをサポートする構成を持つこと
4. The App Store 用 ExportOptions.plist shall 署名方式として `app-store` メソッドと `match AppStore app.shelfie.shelfie` プロファイルを指定すること
5. The 既存の Ad-hoc 署名設定 shall 変更されず、引き続き Firebase App Distribution 配信に使用できること

### Requirement 2: App Store 提出用 Fastlane レーン

**Objective:** As a 開発者, I want App Store 提出に必要な Fastlane レーンが用意されていること, so that ローカルおよび CI 環境から App Store への IPA アップロードとメタデータ提出を自動化できる

#### Acceptance Criteria

1. The Fastfile shall `deliver` を使用して App Store Connect へ IPA とメタデータをアップロードするレーンを持つこと
2. When App Store アップロードレーンが実行された場合, the Fastlane shall App Store Connect API キーを使用して認証すること
3. The App Store アップロードレーン shall IPA のアップロードと審査提出を行うこと
4. If App Store Connect への接続に失敗した場合, the Fastlane shall エラー内容を明示的に出力して処理を中断すること
5. The Fastlane レーン shall ビルド番号の自動インクリメントまたは外部指定に対応すること

### Requirement 3: App Store 配信用 CI/CD パイプライン

**Objective:** As a 開発者, I want GitHub Actions で App Store への提出ワークフローが構成されていること, so that 手動トリガーで App Store 向けビルドの作成と提出を実行できる

#### Acceptance Criteria

1. The GitHub Actions ワークフロー shall 手動トリガー（workflow_dispatch）で App Store 用 IPA のビルドと App Store Connect へのアップロードを実行すること
2. The ワークフロー shall リリースノートとバージョン情報の入力パラメータを持つこと
3. The ワークフロー shall Fastlane match で App Store Distribution 用の証明書を取得してビルドに使用すること
4. The ワークフロー shall App Store Connect API キーを GitHub Secrets から安全に取得して使用すること
5. While ワークフロー実行中, the パイプライン shall 同一ブランチでの重複実行を concurrency 制御で防止すること
6. The 既存の Firebase App Distribution 配信ワークフロー shall 引き続き独立して動作すること
7. The ワークフロー shall 本番環境用 API URL（`PROD_API_BASE_URL`）を Dart define でビルドに渡すこと

### Requirement 4: App Store Connect メタデータ管理

**Objective:** As a 開発者, I want App Store Connect のメタデータをリポジトリ内でコード管理できること, so that アプリの説明文やスクリーンショット等のメタデータをバージョン管理し、レビュー可能にする

#### Acceptance Criteria

1. The Fastlane shall App Store Connect メタデータ（アプリ名、サブタイトル、説明文、キーワード、カテゴリ、プライバシーポリシー URL 等）をローカルファイルとして管理する仕組みを持つこと
2. The メタデータディレクトリ shall 日本語（ja）ロケールの情報を含むこと
3. The Fastlane shall `deliver` を使用してメタデータを App Store Connect へアップロードできること
4. The メタデータ shall リポジトリの `apps/mobile/ios/fastlane/metadata/` ディレクトリに格納されること
5. The メタデータディレクトリ shall App Store 審査に必要な情報（審査用メモ、連絡先等）を含む `review_information` を管理できること

### Requirement 5: 既存配信との共存

**Objective:** As a 開発者, I want 既存の Firebase App Distribution 配信と新規の App Store 配信が互いに干渉せず共存できること, so that テスト配信と本番配信を並行して運用できる

#### Acceptance Criteria

1. The 既存の Ad-hoc ビルド・配信フロー shall App Store 配信の追加後も変更なく動作すること
2. The Firebase App Distribution 配信ワークフロー（deploy-ios.yml） shall App Store 配信ワークフローと独立して実行されること
3. The Fastfile shall Ad-hoc 用レーンと App Store 用レーンを明確に分離して定義すること
4. The match 設定 shall `adhoc` と `appstore` の証明書リポジトリを同一の Git リポジトリで管理すること

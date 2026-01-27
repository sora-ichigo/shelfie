# Implementation Plan

## Tasks

- [ ] 1. Terraform で Firebase App Distribution インフラを構築する
- [x] 1.1 (P) Firebase App Distribution API の有効化を Terraform で定義する
  - firebase-auth モジュール内で `firebaseappdistribution.googleapis.com` API を有効化するリソースを追加
  - `disable_on_destroy = false` で API 無効化時のリソース保護を設定
  - Firebase プロジェクト初期化後に実行されるよう依存関係を設定
  - `terraform plan` で変更内容を確認し、API 有効化が正しく計画されることを検証
  - _Requirements: 1.1, 1.2, 7.1_

- [x] 1.2 (P) GitHub Actions サービスアカウントに Firebase App Distribution 管理権限を付与する
  - github-actions-wif モジュールで既存サービスアカウントに `roles/firebaseappdistro.admin` ロールを追加
  - 最小権限の原則を維持し、必要な権限のみを付与
  - `terraform plan` で IAM 変更を確認し、権限付与が正しく計画されることを検証
  - _Requirements: 7.2, 7.3_

- [ ] 2. Fastlane 証明書管理環境をセットアップする
- [ ] 2.1 Fastlane 設定ファイルを作成する
  - `apps/mobile/ios/fastlane/` ディレクトリを作成
  - Matchfile で証明書リポジトリ URL (`https://github.com/sora-ichigo/shelfie-certificates`)、storage_mode、app_identifier を設定
  - Appfile で app_identifier (`app.shelfie.shelfie`) を設定
  - Fastfile で `fetch_certificates` lane（match adhoc --readonly）と `register_new_devices` lane を定義
  - Gemfile に fastlane 依存関係を追加
  - _Requirements: 2.1, 2.2, 4.1, 4.2, 4.4, 4.5_

- [ ] 2.2 証明書リポジトリを初期化する
  - Apple Developer Portal で Ad Hoc 配布用の証明書と Provisioning Profile を準備
  - `fastlane match init` で証明書リポジトリ構成を初期化
  - `fastlane match adhoc` で証明書と Provisioning Profile を暗号化してリポジトリに保存
  - MATCH_PASSWORD を安全に記録（GitHub Secrets 設定用）
  - 証明書リポジトリが Private に設定されていることを確認
  - _Requirements: 2.1, 4.1, 4.2_

- [ ] 3. iOS Ad Hoc 配布用のエクスポート設定を作成する
  - `apps/mobile/ios/` に ExportOptions.plist を作成
  - Ad Hoc 配布方式 (`method: ad-hoc`) を指定
  - 手動署名スタイル (`signingStyle: manual`) を設定
  - Bundle ID `app.shelfie.shelfie` に対応する Provisioning Profile を指定
  - Bitcode 無効化 (`compileBitcode: false`) を設定
  - ローカルビルドで IPA 生成が正常に動作することを確認
  - _Requirements: 2.1, 2.2_

- [ ] 4. GitHub Actions iOS ビルド・配信ワークフローを実装する
- [ ] 4.1 ワークフロー基本構成を定義する
  - `.github/workflows/deploy-ios.yml` を作成
  - master ブランチへのプッシュと `apps/mobile/**` パスの変更をトリガーに設定
  - `workflow_dispatch` による手動実行を有効化し、ブランチ選択とカスタムリリースノート入力を設定
  - macOS ランナー (`macos-latest`) を指定
  - `id-token: write` 権限を設定して Workload Identity Federation 認証を有効化
  - `working-directory: apps/mobile` をデフォルトに設定
  - 環境変数（`FIREBASE_APP_ID`, `TESTER_GROUPS`, `MATCH_PASSWORD`, `MATCH_GIT_BASIC_AUTHORIZATION`）を定義
  - _Requirements: 3.1, 3.3, 8.1, 8.2, 8.3_

- [ ] 4.2 環境セットアップステップを実装する
  - コードのチェックアウトステップを追加
  - `jdx/mise-action` を使用して Flutter SDK をセットアップ
  - `ruby/setup-ruby` を使用して Ruby 環境をセットアップし、Bundler キャッシュを有効化
  - Flutter 依存関係 (`~/.pub-cache`, `.dart_tool`) のキャッシュを設定
  - `flutter pub get` で依存関係をインストール
  - _Requirements: 3.4, 3.5_

- [ ] 4.3 Fastlane match による証明書取得ステップを実装する
  - working-directory を `apps/mobile/ios` に設定
  - `bundle exec fastlane match adhoc --readonly` で証明書と Provisioning Profile を取得
  - Fastlane match が自動的に一時 Keychain を作成し、証明書をインポート
  - 証明書取得失敗時に明確なエラーメッセージを出力
  - _Requirements: 2.2, 2.3, 4.3, 4.4, 4.5_

- [ ] 4.4 iOS ビルドステップを実装する
  - `flutter build ipa --export-options-plist=ios/ExportOptions.plist` でビルド実行
  - `--build-number=${{ github.run_number }}` でビルド番号を設定
  - ビルド成功時に IPA ファイルパスを後続ステップで使用可能にする
  - Provisioning Profile 期限切れ時に明確なエラーメッセージを出力
  - _Requirements: 2.4, 6.1_

- [ ] 4.5 Firebase App Distribution アップロードステップを実装する
  - `google-github-actions/auth` で Workload Identity Federation 認証を実行
  - GitHub Variables (`DEV_GCP_WORKLOAD_IDENTITY_PROVIDER`, `DEV_GCP_SERVICE_ACCOUNT`) を参照
  - npm 経由で Firebase CLI をインストール
  - `firebase appdistribution:distribute` コマンドで IPA をアップロード
  - GitHub Variables (`FIREBASE_IOS_APP_ID`, `FIREBASE_TESTER_GROUPS`) を参照してアプリ ID とテスターグループを指定
  - リリースノートに PR タイトルまたはコミットメッセージを自動挿入（手動実行時はカスタムリリースノートを使用）
  - _Requirements: 3.2, 3.6, 5.2, 6.2, 6.3_

- [ ] 5. GitHub Secrets と Variables を設定する
  - Fastlane match 暗号化パスワードを `MATCH_PASSWORD` シークレットに設定
  - 証明書リポジトリアクセス用 GitHub PAT を Base64 エンコードして `MATCH_GIT_BASIC_AUTHORIZATION` シークレットに設定（`echo -n "username:PAT" | base64`）
  - Firebase iOS アプリ ID を `FIREBASE_IOS_APP_ID` 変数に設定
  - テスターグループエイリアスを `FIREBASE_TESTER_GROUPS` 変数に設定
  - 既存の `DEV_GCP_WORKLOAD_IDENTITY_PROVIDER` と `DEV_GCP_SERVICE_ACCOUNT` 変数が設定されていることを確認
  - _Requirements: 4.1, 4.2, 4.3_

- [ ] 6. Firebase Console でテスターグループを設定する
  - Firebase Console の App Distribution セクションで `internal-testers` グループを作成
  - テスターのメールアドレスをグループに追加
  - 新規ビルド配信時のメール通知を有効化
  - グループエイリアスが GitHub Variables の `FIREBASE_TESTER_GROUPS` と一致することを確認
  - _Requirements: 5.1, 5.3, 5.4, 7.4_

- [ ] 7. デバイス登録の半自動化フローを整備する
  - `apps/mobile/ios/fastlane/` に devices.txt テンプレートファイルを作成
  - Fastfile の `register_new_devices` lane が devices.txt を読み込んでデバイス登録できることを確認
  - Firebase Console からテスターデバイス UDID を CSV エクスポートする手順を検証
  - `fastlane register_new_devices` 実行後に Provisioning Profile が再生成されることを確認
  - _Requirements: 2.4_

- [ ] 8. 統合テストを実施する
- [ ] 8.1 Terraform 変更を適用してインフラをプロビジョニングする
  - `terraform apply` で Firebase App Distribution API の有効化と IAM 権限の付与を実行
  - Firebase Console で iOS アプリ (`app.shelfie.shelfie`) が登録されていることを確認
  - GCP IAM で `roles/firebaseappdistro.admin` 権限が正しく付与されていることを確認
  - _Requirements: 1.3, 7.3_

- [ ] 8.2 ワークフローを手動実行して E2E 動作を検証する
  - GitHub Actions で `workflow_dispatch` を使用してワークフローを手動実行
  - Fastlane match による証明書取得が正常に完了することを確認
  - 全ステップ（セットアップ、署名、ビルド、アップロード）が正常に完了することを確認
  - Firebase Console でリリースが表示され、バージョン情報とリリースノートが正しいことを確認
  - テスターにメール通知が送信されることを確認
  - テスターデバイスでアプリがインストール・起動できることを確認
  - _Requirements: 5.3, 6.4_

## Requirements Coverage

| Requirement | Tasks |
|-------------|-------|
| 1.1 | 1.1 |
| 1.2 | 1.1 |
| 1.3 | 8.1 |
| 2.1 | 2.1, 2.2, 3 |
| 2.2 | 2.1, 3, 4.3 |
| 2.3 | 4.3 |
| 2.4 | 4.4, 7 |
| 3.1 | 4.1 |
| 3.2 | 4.5 |
| 3.3 | 4.1 |
| 3.4 | 4.2 |
| 3.5 | 4.2 |
| 3.6 | 4.5 |
| 4.1 | 2.1, 5 |
| 4.2 | 2.1, 2.2, 5 |
| 4.3 | 4.3, 5 |
| 4.4 | 2.1, 4.3 |
| 4.5 | 2.1, 4.3 |
| 5.1 | 6 |
| 5.2 | 4.5 |
| 5.3 | 6, 8.2 |
| 5.4 | 6 |
| 6.1 | 4.4 |
| 6.2 | 4.5 |
| 6.3 | 4.5 |
| 6.4 | 8.2 |
| 7.1 | 1.1 |
| 7.2 | 1.2 |
| 7.3 | 1.2, 8.1 |
| 7.4 | 6 |
| 8.1 | 4.1 |
| 8.2 | 4.1 |
| 8.3 | 4.1 |

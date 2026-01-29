# Implementation Plan

- [ ] 1. App Store 用コード署名の構成
- [ ] 1.1 (P) App Store 用 ExportOptions.plist を作成する
  - 既存の Ad-hoc 用 `ExportOptions.plist` を参考に、App Store 配信用のエクスポート設定ファイルを新規作成する
  - 署名方式として `app-store` メソッド、手動署名スタイル、`match AppStore app.shelfie.shelfie` プロファイルを指定する
  - 既存の Ad-hoc 用 `ExportOptions.plist` は一切変更しない
  - _Requirements: 1.4, 1.5_

- [ ] 1.2 (P) Fastfile に App Store 用証明書取得レーンを追加する
  - `fetch_appstore_certificates` レーンを Fastfile に追加し、App Store Connect API キーで認証した上で `match(type: "appstore", readonly: true)` を呼び出す
  - キーチェーン名とパスワードをオプション引数で受け取れるようにする（CI 環境での利用を想定）
  - 既存の `fetch_certificates`（adhoc）、`sync_devices`、`register_new_devices` レーンは変更しない
  - Matchfile のデフォルト type（`adhoc`）は変更せず、レーン内で `appstore` をオーバーライドする
  - _Requirements: 1.1, 1.2, 1.3, 1.5, 5.3, 5.4_

- [ ] 2. App Store 提出用 Fastlane 設定
- [ ] 2.1 Deliverfile を作成する
  - `deliver` の共通設定（`metadata_path`、`force`、`submit_for_review: false`、`precheck_include_in_app_purchases` 等）を定義する
  - 審査提出は App Store Connect 上で手動実行する方針のため、`submit_for_review` を `false` に固定する
  - メタデータディレクトリのパス（`metadata/`）を指定する
  - タスク 1.2 の証明書取得レーンが完了している前提で実装する
  - _Requirements: 2.1, 2.3, 4.3_

- [ ] 2.2 Fastfile に App Store アップロードレーンを追加する
  - `release_appstore` レーンを追加し、App Store Connect API キーで認証した上で `deliver` を呼び出す
  - IPA ファイルパスを Flutter ビルドの出力ディレクトリから自動取得する
  - `Deliverfile` の共通設定を活用しつつ、レーン内で `api_key` と `ipa` パスをオーバーライドする
  - App Store Connect への接続や IPA アップロードに失敗した場合、Fastlane 標準のエラーハンドリングでエラー内容を出力して処理を中断する
  - タスク 2.1 の Deliverfile が完了している前提で実装する
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 5.3_

- [ ] 3. App Store Connect メタデータをリポジトリ内で管理する
- [ ] 3.1 (P) メタデータディレクトリ構造を作成する
  - `apps/mobile/ios/fastlane/metadata/` に Fastlane deliver 標準のディレクトリ構造を配置する
  - 共通メタデータ（`copyright.txt`、`primary_category.txt`）をルートに作成する
  - 日本語ロケール用のサブディレクトリ（`ja/`）を作成し、`name.txt`、`subtitle.txt`、`description.txt`、`keywords.txt`、`privacy_url.txt`、`support_url.txt`、`marketing_url.txt`、`release_notes.txt`、`promotional_text.txt` をプレースホルダーとして作成する
  - _Requirements: 4.1, 4.2, 4.4_

- [ ] 3.2 (P) 審査用情報ファイルを作成する
  - `metadata/review_information/` ディレクトリに審査用情報ファイル（`email_address.txt`、`first_name.txt`、`last_name.txt`、`notes.txt`、`phone_number.txt`）を作成する
  - デモアカウント情報（`demo_user`、`demo_password`）は機密情報のためリポジトリにはコミットせず、`Deliverfile` 内で環境変数から読み込む設計とする
  - _Requirements: 4.5_

- [ ] 4. App Store 配信用 GitHub Actions ワークフローを構築する
  - `deploy-appstore.yml` を新規作成し、`workflow_dispatch` による手動トリガーで App Store 向けビルドと App Store Connect へのアップロードを実行するワークフローを構成する
  - 入力パラメータとして `build_number`（デフォルト: `github.run_number`）と `release_notes` を定義する
  - ランナーを `macos-15` にバージョン固定し、本番リリースビルドの再現性を確保する
  - 既存の `deploy-ios.yml` のステップ構成（mise セットアップ、Ruby セットアップ、Flutter キャッシュ、Keychain セットアップ）を踏襲する
  - `fetch_appstore_certificates` レーンで App Store 用の証明書を取得し、`flutter build ipa` で `ExportOptionsAppStore.plist` を使用してビルドする
  - `--dart-define=API_BASE_URL` で本番環境 API URL（`PROD_API_BASE_URL`）をビルドに注入する
  - `--build-number` にワークフロー入力パラメータまたはデフォルト値を使用する
  - `release_appstore` レーンで IPA とメタデータを App Store Connect にアップロードする
  - App Store Connect API キーを GitHub Secrets から安全に取得して環境変数に設定する
  - `concurrency` グループで同一ブランチの重複実行を防止する
  - 既存の `deploy-ios.yml`（Firebase App Distribution 配信）は一切変更しない
  - タスク 1、2、3 の成果物（ExportOptionsAppStore.plist、Fastfile レーン、Deliverfile、メタデータ）が完了している前提で実装する
  - _Requirements: 2.5, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 5.1, 5.2_

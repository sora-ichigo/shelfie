# Research & Design Decisions

---
**Purpose**: ios-app-store-distribution 機能のディスカバリーで得られた調査結果と設計判断の根拠を記録する。

**Usage**:
- 設計フェーズで実施した調査内容とその成果を時系列で記録
- design.md に記載するには詳細すぎるトレードオフや比較を文書化
- 将来の監査や再利用のための参照元とエビデンスを提供
---

## Summary
- **Feature**: `ios-app-store-distribution`
- **Discovery Scope**: Extension（既存の Firebase App Distribution 配信システムに App Store 配信を追加）
- **Key Findings**:
  - Fastlane match の Matchfile は単一の `type` のみ定義可能。複数タイプ（adhoc / appstore）の切り替えは Fastfile 内で `match(type: "appstore")` のように都度指定する方式が推奨
  - Fastlane `deliver`（`upload_to_app_store`）は IPA アップロードとメタデータ管理を統合的に処理し、App Store Connect API キー認証を標準サポート
  - 既存の App Store Connect API キー設定（`APP_STORE_CONNECT_API_KEY_KEY_ID` / `ISSUER_ID` / `KEY`）は `sync_devices` レーンで既に使用されており、追加の認証情報は不要

## Research Log

### Fastlane match の複数タイプ管理
- **Context**: 要件 1 で adhoc と appstore の両方の証明書管理が求められている
- **Sources Consulted**:
  - [match - fastlane docs](https://docs.fastlane.tools/actions/match/)
  - [Handle multiple types in a Matchfile - Issue #9437](https://github.com/fastlane/fastlane/issues/9437)
- **Findings**:
  - Matchfile は `type` フィールドを1つしか持てない（設計上の制約）
  - 推奨パターン: Matchfile にはデフォルト（adhoc）を設定し、Fastfile の各レーンで `match(type: "appstore")` のようにオーバーライド
  - 同一の Git リポジトリ（`shelfie-certificates`）で adhoc と appstore の証明書を管理可能（match が自動的にディレクトリを分離）
  - 証明書リポジトリのディレクトリ構造: `certs/distribution/`（共通）、`profiles/adhoc/` と `profiles/appstore/` で分離
- **Implications**: Matchfile の `type` は既存の `adhoc` のまま維持し、App Store レーンでのみ `type: "appstore"` をオーバーライドする設計

### Fastlane deliver（upload_to_app_store）の動作
- **Context**: 要件 2 で App Store Connect への IPA アップロードとメタデータ提出の自動化が求められている
- **Sources Consulted**:
  - [deliver - fastlane docs](https://docs.fastlane.tools/actions/deliver/)
  - [upload_to_app_store - fastlane docs](https://docs.fastlane.tools/actions/upload_to_app_store/)
  - [App Store Deployment - fastlane docs](https://docs.fastlane.tools/getting-started/ios/appstore-deployment/)
- **Findings**:
  - `deliver`（`upload_to_app_store`）は IPA のアップロードとメタデータの同時提出をサポート
  - `ipa` パラメータで IPA ファイルパスを指定、`metadata_path` でメタデータディレクトリを指定
  - `submit_for_review: true` で審査提出まで自動化可能
  - `force: true` で HTML レポートの確認をスキップ（CI 環境向け）
  - iTunes Transporter を内部的に使用してバイナリをアップロード
- **Implications**: Fastfile の App Store レーンで `deliver` を呼び出し、IPA パスとメタデータパスを明示的に指定する

### App Store Connect API キー認証
- **Context**: 要件 2.2 および 3.4 で App Store Connect API キーによる認証が求められている
- **Sources Consulted**:
  - [Using App Store Connect API - fastlane docs](https://docs.fastlane.tools/app-store-connect-api/)
  - [app_store_connect_api_key - fastlane docs](https://docs.fastlane.tools/actions/app_store_connect_api_key/)
- **Findings**:
  - 既存の `sync_devices` レーンで `app_store_connect_api_key` アクションが既に使用されている
  - 環境変数 `APP_STORE_CONNECT_API_KEY_KEY_ID`、`APP_STORE_CONNECT_API_KEY_ISSUER_ID`、`APP_STORE_CONNECT_API_KEY_KEY` が GitHub Secrets に設定済み
  - `key_content` パラメータにより .p8 ファイルなしで CI 環境で認証可能
  - `app_store_connect_api_key` を一度呼び出すと、以降の `deliver`、`match` 等のアクションで自動的に API キーが共有される（SharedValues 経由）
  - API キーのロールは「App Manager」以上が必要（ビルド情報の更新とテスター管理のため）
- **Implications**: 既存の GitHub Secrets をそのまま再利用可能。新規シークレットの追加は不要

### メタデータディレクトリ構造
- **Context**: 要件 4 で App Store Connect メタデータのコード管理が求められている
- **Sources Consulted**:
  - [deliver - fastlane docs](https://docs.fastlane.tools/actions/deliver/)
  - [Deliver/Supply Metadata Folder Structure - Issue #13587](https://github.com/fastlane/fastlane/issues/13587)
- **Findings**:
  - `deliver init` で標準的なメタデータディレクトリ構造が生成される
  - ロケール別ディレクトリ（`ja/`）にローカライズ対象ファイルを配置
  - `review_information/` はロケール非依存でメタデータルートに配置
  - ローカライズ対象ファイル: `name.txt`、`subtitle.txt`、`description.txt`、`keywords.txt`、`privacy_url.txt`、`release_notes.txt` 等
  - 非ローカライズファイル: `copyright.txt`、`primary_category.txt` 等
- **Implications**: `apps/mobile/ios/fastlane/metadata/` に標準構造を配置し、`ja` ロケールを初期構成

### flutter build ipa の App Store 対応
- **Context**: 要件 1.4 で App Store 用 ExportOptions.plist の構成が求められている
- **Sources Consulted**:
  - [Build and release an iOS app - Flutter docs](https://docs.flutter.dev/deployment/ios)
  - [Flutter build IPA with --export-options-plist - Issue #113977](https://github.com/flutter/flutter/issues/113977)
- **Findings**:
  - `flutter build ipa --export-options-plist=path/to/ExportOptions.plist` で署名方式を指定
  - App Store 用は `method: app-store`、`signingStyle: manual` を設定
  - `provisioningProfiles` で `match AppStore app.shelfie.shelfie` を指定
  - 既存の Ad-hoc 用 `ExportOptions.plist` と並行して App Store 用を別ファイルとして管理
- **Implications**: `ExportOptionsAppStore.plist` を新規作成し、既存の `ExportOptions.plist`（Ad-hoc 用）は変更しない

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| レーン分離パターン | 既存 Fastfile に App Store 用レーンを追加 | 既存構造を維持、変更範囲が最小 | Fastfile の肥大化 | 採用: 既存パターンと一致 |
| Fastfile 分割パターン | App Store 用に別 Fastfile を作成 | 関心の分離 | import の複雑さ、Fastlane の標準構成から逸脱 | 不採用: 過剰な分離 |

## Design Decisions

### Decision: App Store 用 ExportOptions.plist の分離

- **Context**: 要件 1.4 で App Store 用の署名設定が必要。既存の `ExportOptions.plist` は Ad-hoc 用
- **Alternatives Considered**:
  1. 既存 `ExportOptions.plist` を環境変数で切り替え
  2. 別ファイル `ExportOptionsAppStore.plist` を新規作成
- **Selected Approach**: 別ファイル `ExportOptionsAppStore.plist` を新規作成
- **Rationale**: 既存の Ad-hoc フローに一切影響を与えず、各署名方式の設定が明確に分離される。CI/CD ワークフローで参照先を切り替えるだけで済む
- **Trade-offs**: ファイルが増えるが、設定の競合リスクがゼロになる
- **Follow-up**: Xcode プロジェクトの signing 設定が Automatic/Manual のどちらでも動作することを検証

### Decision: Matchfile のデフォルト type は adhoc を維持

- **Context**: 要件 1.3 で adhoc と appstore の両方をサポートする構成が必要
- **Alternatives Considered**:
  1. Matchfile の type をレーン実行時に動的変更
  2. Matchfile は adhoc のまま、appstore レーンで type をオーバーライド
- **Selected Approach**: Matchfile は `type("adhoc")` を維持し、Fastfile 内で `match(type: "appstore")` を呼び出す
- **Rationale**: Fastlane の推奨パターンに従い、既存の adhoc フローへの影響をゼロにする
- **Trade-offs**: Fastfile 内で type を明示する必要があるが、可読性は向上する
- **Follow-up**: なし（Fastlane 公式の推奨パターン）

### Decision: ビルド番号の管理方式

- **Context**: 要件 2.5 でビルド番号の自動インクリメントまたは外部指定への対応が必要
- **Alternatives Considered**:
  1. `app_store_build_number` アクションで最新番号を取得し自動インクリメント
  2. GitHub Actions の `run_number` を使用
  3. ワークフロー入力パラメータで手動指定（デフォルトは `run_number`）
- **Selected Approach**: ワークフロー入力パラメータで指定可能にし、デフォルトは `github.run_number` を使用
- **Rationale**: 既存の Firebase 配信ワークフローと同じパターン（`--build-number=${{ github.run_number }}`）を踏襲しつつ、手動でのオーバーライドも可能にする
- **Trade-offs**: `run_number` は App Store 用と Firebase 用で共有されるため、番号が飛ぶ可能性がある。ただし App Store ではビルド番号の単調増加のみが要求され、連番は不要
- **Follow-up**: 将来的にビルド番号の重複が問題になる場合、`app_store_build_number` による自動インクリメントへ移行を検討

### Decision: ワークフロートリガー方式

- **Context**: 要件 3.1 で手動トリガー（workflow_dispatch）が求められている
- **Alternatives Considered**:
  1. tag プッシュトリガー（`v*` タグ）
  2. workflow_dispatch のみ
  3. workflow_dispatch + tag プッシュの併用
- **Selected Approach**: `workflow_dispatch` のみ
- **Rationale**: App Store への提出は意図的なリリース行為であり、自動トリガーは望ましくない。要件にも明示的に「手動トリガー」と記載されている
- **Trade-offs**: リリースのたびに手動でワークフローを実行する必要がある
- **Follow-up**: 将来的にリリースプロセスが成熟した段階で tag トリガーの追加を検討

## Risks & Mitigations

- **App Store Connect API キーの権限不足**: 既存のキーが `App Manager` 以上のロールを持つことを事前確認する。不足の場合は Apple Developer Portal でロールを更新
- **ビルド番号の重複**: Firebase 配信と App Store 配信で `run_number` を共有するため、異なるワークフローの実行順序により番号が前後する可能性がある。App Store は単調増加のみ要求するため、実運用上の問題は低い
- **メタデータ審査リジェクト**: 初回提出時はメタデータの不備によるリジェクトリスクがある。`review_information` の事前準備と、`deliver` の `precheck` 機能による事前検証で軽減

## References
- [deliver - fastlane docs](https://docs.fastlane.tools/actions/deliver/) -- IPA アップロードとメタデータ管理の公式ドキュメント
- [match - fastlane docs](https://docs.fastlane.tools/actions/match/) -- 証明書管理の公式ドキュメント
- [Using App Store Connect API - fastlane docs](https://docs.fastlane.tools/app-store-connect-api/) -- API キー認証の公式ガイド
- [App Store Deployment - fastlane docs](https://docs.fastlane.tools/getting-started/ios/appstore-deployment/) -- App Store デプロイのクイックスタート
- [Build and release an iOS app - Flutter docs](https://docs.flutter.dev/deployment/ios) -- Flutter iOS リリースの公式ドキュメント
- [Handle multiple types in a Matchfile - Issue #9437](https://github.com/fastlane/fastlane/issues/9437) -- Matchfile の複数タイプ制約に関する議論

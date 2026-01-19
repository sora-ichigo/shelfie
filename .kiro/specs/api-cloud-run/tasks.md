# Implementation Plan

## Task 1: Terraform モジュールの基盤構築

- [x] 1.1 (P) モジュールディレクトリ構造を作成する
  - `modules/api-cloud-run/` 配下に `main.tf`、`variables.tf`、`outputs.tf` の空ファイルを作成
  - 既存の `infra/terraform/main.tf` との整合性を確認
  - _Requirements: 2.5_

- [x] 1.2 (P) 環境別ディレクトリ構造を作成する
  - `environments/dev/`、`environments/stg/`、`environments/prod/` ディレクトリを作成
  - 各環境に `main.tf`、`variables.tf`、`terraform.tfvars`、`backend.tf` の雛形を配置
  - _Requirements: 2.5_

## Task 2: モジュール変数定義

- [x] 2. 全ての設定可能な変数をモジュールに定義する
  - 環境識別子、プロジェクト ID、リージョンの基本変数を定義
  - サービス名、イメージ名、イメージタグのコンテナ設定変数を定義
  - CPU 制限、メモリ制限、最小/最大インスタンス数、リクエストタイムアウトのリソース変数を定義
  - サービスアカウント ID、未認証アクセス許可フラグの IAM 変数を定義
  - Ingress 設定の選択肢をバリデーション付きで定義
  - 追加環境変数を受け取るマップ型変数を定義
  - デフォルト値は設計書に従い環境ごとの上書きを可能にする
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 4.4, 5.2, 6.3_

## Task 3: Artifact Registry リポジトリ

- [x] 3. Docker イメージ保存用の Artifact Registry リポジトリを定義する
  - Docker フォーマットのリポジトリを作成
  - Cloud Run と同一リージョン（asia-northeast1）に配置
  - 本番環境のみタグ不変性を有効化する条件分岐を実装
  - _Requirements: 3.1, 3.2_

## Task 4: サービスアカウントと IAM

- [x] 4.1 Cloud Run 用の専用サービスアカウントを作成する
  - 最小権限の原則に基づく専用サービスアカウントを定義
  - 表示名と説明を適切に設定
  - アカウント ID を変数で制御可能にする
  - _Requirements: 4.1, 4.2, 4.4_

- [x] 4.2 IAM バインディングを設定する
  - サービスアカウントに Artifact Registry 読み取り権限を付与
  - 未認証アクセス許可時のみ Cloud Run Invoker ロールを allUsers に付与する条件付きリソースを作成
  - _Requirements: 3.3, 4.3_

## Task 5: Cloud Run サービス定義

- [x] 5. Cloud Run v2 サービスリソースを定義する
  - Artifact Registry からコンテナイメージを参照する設定
  - コンテナポート 4000 を公開
  - asia-northeast1 リージョンにデプロイ
  - 専用サービスアカウントを実行 ID として設定
  - CPU/メモリ制限、最小/最大インスタンス数、リクエストタイムアウトの設定を変数から取得
  - PORT 環境変数を 4000 に固定設定
  - 追加環境変数を動的に設定する仕組みを実装
  - Ingress 設定を変数で制御
  - イメージタグ変更時の新リビジョン自動作成を確認（lifecycle 設定で CI/CD 対応）
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 2.1, 2.2, 2.3, 2.4, 5.1, 5.2, 6.1, 6.2, 6.3, 6.4_

## Task 6: Terraform 出力定義

- [x] 6. デプロイ情報を出力する output を定義する
  - Cloud Run サービス URL を出力
  - Cloud Run サービス名を出力
  - Artifact Registry リポジトリ URL を出力
  - サービスアカウントのメールアドレスを出力
  - _Requirements: 7.1, 7.2, 7.3, 7.4_

## Task 7: 環境別設定ファイルの作成

- [x] 7.1 (P) development 環境の設定を作成する
  - モジュールを呼び出す main.tf を作成
  - 環境固有の変数定義（min_instances=0, max_instances=2 等）を terraform.tfvars に設定
  - 環境用の variables.tf を作成
  - _Requirements: 2.4, 2.5_

- [x] 7.2 (P) staging 環境の設定を作成する
  - モジュールを呼び出す main.tf を作成
  - 環境固有の変数定義（min_instances=0, max_instances=5 等）を terraform.tfvars に設定
  - 環境用の variables.tf を作成
  - _Requirements: 2.4, 2.5_

- [x] 7.3 (P) production 環境の設定を作成する
  - モジュールを呼び出す main.tf を作成
  - 環境固有の変数定義（min_instances=1, max_instances=10, cpu_limit=2 等）を terraform.tfvars に設定
  - 環境用の variables.tf を作成
  - _Requirements: 2.4, 2.5_

## Task 8: Terraform 検証

- [x] 8.1 構文とフォーマットの検証を行う
  - terraform fmt でフォーマット検証
  - terraform validate で構文検証
  - 各環境ディレクトリで検証を実行
  - _Requirements: 1.1, 2.5_

- [x] 8.2 リソース作成計画を確認する
  - development 環境で terraform plan を実行
  - 期待通りのリソースが作成されることを確認
  - 変数のデフォルト値と上書きが正しく動作することを確認
  - _Requirements: 1.1, 2.5, 3.1, 4.1, 5.3, 7.1, 7.2, 7.3, 7.4_

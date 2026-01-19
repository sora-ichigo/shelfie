# Requirements Document

## Introduction
本ドキュメントは、apps/api の Docker コンテナ化と CI での Docker イメージビルド検証に関する要件を定義する。将来的に Cloud Run へデプロイすることを見据え、Dockerfile を作成し、CI パイプラインで継続的にビルド可能性を検証する仕組みを構築する。

## Requirements

### Requirement 1: Dockerfile の作成
**Objective:** As a 開発者, I want apps/api 用の Dockerfile を用意する, so that Cloud Run へのデプロイ準備ができる

#### Acceptance Criteria
1. The Dockerfile shall be placed at `apps/api/Dockerfile`.
2. The Dockerfile shall use a Node.js 24 以上のベースイメージを使用する.
3. The Dockerfile shall pnpm を使用して依存関係をインストールする.
4. The Dockerfile shall モノレポ構造を考慮し、必要なワークスペースパッケージ（packages/shared 等）を含める.
5. The Dockerfile shall ビルド成果物（dist/）を生成し、本番用イメージに含める.
6. The Dockerfile shall マルチステージビルドを採用し、最終イメージのサイズを最小化する.
7. The Dockerfile shall 非 root ユーザーでアプリケーションを実行する.
8. The Dockerfile shall ポート 4000 を EXPOSE する.

### Requirement 2: CI での Docker ビルド検証
**Objective:** As a 開発者, I want CI で Docker イメージが正しくビルドできることを検証する, so that デプロイ前にビルドエラーを検知できる

#### Acceptance Criteria
1. When apps/api または Dockerfile に変更がある場合, the CI shall Docker イメージのビルドを実行する.
2. The CI shall Docker ビルドステップを既存の api ジョブに追加する.
3. If Docker ビルドが失敗した場合, then the CI shall ジョブを失敗ステータスで終了する.
4. The CI shall ビルドしたイメージをレジストリにプッシュしない（ビルド検証のみ）.

### Requirement 3: ローカル開発サポート
**Objective:** As a 開発者, I want ローカル環境で Docker イメージをビルド・実行できる, so that 本番環境と同等の動作確認ができる

#### Acceptance Criteria
1. When 開発者が `docker build` を実行した場合, the ビルドプロセス shall 追加の設定なしで正常に完了する.
2. When 開発者がビルドしたイメージを実行した場合, the コンテナ shall ポート 4000 で GraphQL エンドポイントを公開する.
3. The Dockerfile shall .dockerignore ファイルを参照し、不要なファイルをビルドコンテキストから除外する.

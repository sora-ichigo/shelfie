# Implementation Plan

## Task 1: Dockerfile 基盤の作成

- [x] 1. (P) .dockerignore ファイルを作成する
  - ビルドコンテキストから除外するパターンを定義する
  - node_modules、.git、dist、IDE 設定ファイルを除外する
  - 不要なアプリケーション（apps/mobile、apps/web）を除外する
  - 環境変数ファイル（.env*）を除外する
  - _Requirements: 3.3_

- [x] 2. (P) マルチステージ Dockerfile を作成する
  - base ステージで Node.js 24-slim ベースイメージと corepack を設定する
  - deps ステージで pnpm install --frozen-lockfile を実行し依存関係をインストールする
  - build ステージで pnpm --filter @shelfie/api build を実行しビルド成果物を生成する
  - production ステージで dist と本番依存関係のみをコピーする
  - pnpm workspaces のモノレポ構成に対応する
  - BuildKit キャッシュマウントを活用しビルド時間を短縮する
  - 非 root ユーザー（node）でアプリケーションを実行する
  - ポート 4000 を EXPOSE する
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 3.1, 3.2_

## Task 2: CI パイプラインの更新

- [x] 3. 既存の api ジョブに Docker ビルド検証ステップを追加する
  - docker/build-push-action を使用して Docker ビルドを実行する
  - push: false を設定しレジストリへのプッシュを無効化する
  - apps/api/Dockerfile を paths-filter のトリガー対象に追加する
  - ビルド失敗時にジョブが失敗ステータスで終了することを確保する
  - _Requirements: 2.1, 2.2, 2.3, 2.4_

## Task 3: ローカル環境での動作検証

- [x] 4. ローカル環境で Docker イメージのビルドと起動を検証する
  - docker build コマンドでイメージが正常にビルドできることを確認する
  - ビルドしたイメージでコンテナが起動しポート 4000 で応答することを確認する
  - GraphQL エンドポイント（/graphql）へのリクエストが成功することを確認する
  - _Requirements: 3.1, 3.2_

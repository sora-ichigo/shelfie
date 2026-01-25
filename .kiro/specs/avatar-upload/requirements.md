# Requirements Document

## Introduction

本ドキュメントは、プロフィール編集画面でのアバター画像アップロード機能の要件を定義する。ユーザーは自身のプロフィール画像を変更でき、ImageKitを画像配信サービスとして使用する。将来的なサービス差し替えを考慮し、サーバー側にはInfraレイヤを新設してImageKit連携を抽象化する。

## Requirements

### Requirement 1: アバター画像の選択

**Objective:** ユーザーとして、プロフィール編集画面でアバター画像を選択したい。それにより、自分のプロフィールをカスタマイズできる。

#### Acceptance Criteria

1. When ユーザーがプロフィール編集画面でアバター変更ボタンをタップした時, the Mobile App shall 画像選択UIを表示する
2. When ユーザーがデバイスのギャラリーから画像を選択した時, the Mobile App shall 選択された画像をプレビュー表示する
3. If ユーザーが未対応のファイル形式を選択した場合, then the Mobile App shall 対応形式のエラーメッセージを表示する
4. The Mobile App shall JPEG、PNG、WebP形式の画像をサポートする
5. If 選択された画像が上限サイズを超えている場合, then the Mobile App shall ファイルサイズ制限のエラーメッセージを表示する

### Requirement 2: 署名付きURL取得

**Objective:** モバイルアプリとして、サーバーから署名付きアップロードURLを取得したい。それにより、ImageKitへ安全に画像をアップロードできる。

#### Acceptance Criteria

1. When モバイルアプリがアップロードURLを要求した時, the API Server shall ImageKitの署名付きアップロードパラメータを生成して返却する
2. While ユーザーが認証済みの場合, the API Server shall そのユーザー専用のアップロードパラメータを発行する
3. If ユーザーが未認証の場合, then the API Server shall 認証エラーを返却する
4. The API Server shall 署名付きパラメータに有効期限を設定する

### Requirement 3: ImageKit連携のインフラレイヤ

**Objective:** 開発者として、ImageKit連携をInfraレイヤで抽象化したい。それにより、将来的な画像配信サービスの差し替えが容易になる。

#### Acceptance Criteria

1. The API Server shall 画像アップロードサービスのインターフェースをInfraレイヤで定義する
2. The API Server shall ImageKit固有の実装をInfraレイヤ内に隔離する
3. The API Server shall 環境変数からImageKitの認証情報（Public Key、Private Key、URL Endpoint）を取得する
4. If ImageKitへの接続に失敗した場合, then the API Server shall 適切なエラーをログ出力し、クライアントにサーバーエラーを返却する

### Requirement 4: 画像アップロード実行

**Objective:** ユーザーとして、選択した画像をImageKitにアップロードしたい。それにより、アバター画像がクラウドに保存される。

#### Acceptance Criteria

1. When モバイルアプリが署名付きパラメータを受け取った時, the Mobile App shall ImageKitのアップロードAPIに画像を直接送信する
2. While アップロード中の場合, the Mobile App shall プログレスインジケーターを表示する
3. If アップロードが失敗した場合, then the Mobile App shall エラーメッセージを表示しリトライオプションを提供する
4. When アップロードが成功した時, the Mobile App shall ImageKitから返却された配信URLを取得する

### Requirement 5: プロフィールへのURL保存

**Objective:** ユーザーとして、アップロードした画像のURLをプロフィールに保存したい。それにより、アバター画像が永続化される。

#### Acceptance Criteria

1. When アップロードが成功した時, the Mobile App shall 配信URLをサーバーに送信してプロフィールを更新する
2. When プロフィール更新リクエストを受信した時, the API Server shall ユーザーのアバターURLをデータベースに保存する
3. If プロフィール更新に失敗した場合, then the Mobile App shall エラーメッセージを表示する
4. When プロフィール更新が成功した時, the Mobile App shall 新しいアバター画像をUIに反映する

### Requirement 6: アバター画像の表示

**Objective:** ユーザーとして、保存されたアバター画像を各画面で確認したい。それにより、プロフィールの変更が反映されていることを確認できる。

#### Acceptance Criteria

1. When プロフィール画面を表示した時, the Mobile App shall ImageKitのURLからアバター画像を取得して表示する
2. While アバター画像を読み込み中の場合, the Mobile App shall プレースホルダー画像を表示する
3. If アバター画像の取得に失敗した場合, then the Mobile App shall デフォルトのアバター画像を表示する
4. The Mobile App shall ImageKitのURL変換機能を使用して適切なサイズの画像を取得する

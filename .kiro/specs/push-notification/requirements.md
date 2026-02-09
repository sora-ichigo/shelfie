# Requirements Document

## Introduction

本ドキュメントは、Shelfie アプリケーションにおけるプッシュ通知機能の要件を定義する。任意のユーザー群に対してプッシュ通知を送信する機能を実現し、ユーザーエンゲージメントの向上とタイムリーな情報伝達を可能にする。送信手段は CLI スクリプトを使用し、Web 管理画面は初期スコープに含めない。

## Requirements

### Requirement 1: デバイストークン管理

**Objective:** ユーザーとして、自分のデバイスでプッシュ通知を受信できるように、デバイストークンをサーバーに登録したい。

#### Acceptance Criteria

1. When ユーザーがモバイルアプリにログインした時, the Push Notification Service shall デバイスの FCM トークンをサーバーに登録する
2. When FCM トークンが更新された時, the Push Notification Service shall 最新のトークンでサーバー上の登録情報を更新する
3. When ユーザーがログアウトした時, the Push Notification Service shall 該当デバイスのトークン登録を解除する
4. The Push Notification Service shall 1ユーザーに対して複数デバイスのトークンを管理できる

### Requirement 2: ユーザーグループ選択

**Objective:** 運営者として、CLI スクリプトを通じて通知を送信する対象ユーザー群を柔軟に指定したい。

#### Acceptance Criteria

1. The CLI Script shall 全ユーザーを対象としたプッシュ通知の送信をサポートする
2. The CLI Script shall 特定のユーザー ID リストを引数で指定してプッシュ通知を送信できる
3. When 送信対象のユーザーが指定された時, the Push Notification Service shall 有効なデバイストークンを持つユーザーのみに通知を送信する

### Requirement 3: 通知メッセージ構成

**Objective:** 運営者として、CLI スクリプトの引数で通知のタイトルと本文を指定したい。

#### Acceptance Criteria

1. The CLI Script shall `--title` と `--body` 引数で通知のタイトルと本文テキストを指定できる
2. The CLI Script shall タイトルと本文を必須引数としてバリデーションする
3. If タイトルまたは本文が未指定の場合, the CLI Script shall エラーメッセージを表示して終了する

### Requirement 4: 通知送信実行

**Objective:** 運営者として、設定した通知を対象ユーザー群に確実に送信したい。これにより、ユーザーへの情報伝達を実現する。

#### Acceptance Criteria

1. When 通知送信がリクエストされた時, the Push Notification Service shall FCM を介して対象デバイスにプッシュ通知を送信する
2. When 大量のデバイスに通知を送信する時, the Push Notification Service shall バッチ処理を使用して効率的に配信する
3. If FCM への送信が失敗した場合, the Push Notification Service shall エラー情報をログに記録する
4. If デバイストークンが無効であった場合, the Push Notification Service shall 該当トークンをデータベースから削除する

### Requirement 5: 通知送信結果の出力

**Objective:** 運営者として、通知送信の結果をスクリプト実行時に確認したい。

#### Acceptance Criteria

1. When 通知送信が完了した時, the CLI Script shall 送信成功数・失敗数をコンソールに出力する
2. If 送信に失敗したデバイスがある場合, the CLI Script shall 失敗したユーザー ID とエラー理由を出力する

### Requirement 6: モバイルアプリ通知受信

**Objective:** ユーザーとして、アプリがバックグラウンドまたはフォアグラウンドのどちらの状態でもプッシュ通知を受信したい。

#### Acceptance Criteria

1. While アプリがバックグラウンドにある状態で, when プッシュ通知を受信した時, the Shelfie Mobile App shall システム通知として表示する
2. While アプリがフォアグラウンドにある状態で, when プッシュ通知を受信した時, the Shelfie Mobile App shall アプリ内通知として表示する
3. When ユーザーが初めてアプリを起動した時, the Shelfie Mobile App shall プッシュ通知の許可をリクエストする

### ~~Requirement 7: 通知送信の認可~~ (スコープ外)

> CLI スクリプト方式のため、スクリプト実行者 = 管理者とみなす。API レベルの認可は初期スコープに含めない。

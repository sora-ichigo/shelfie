# Requirements Document

## Introduction

本ドキュメントは、Shelfie アプリケーションにおけるフォローシステムの要件を定義する。ユーザーが他のユーザーにフォローリクエストを送り、相手が承認した場合にのみフォロー関係が成立する相互承認制のフォローモデルを採用する。

プロダクト方針に基づき、プライベートな友人ネットワーク（Phase 2）として設計する。フォロー関係のないユーザーのプロフィールは閲覧できず、つながった友達にだけ本棚が見える体験を実現する。

フォローリクエスト受信時にはプッシュ通知で即座にユーザーに知らせ、アプリ内の「お知らせ」タブでフォロー関連の通知履歴を確認できるようにする。

## Requirements

### Requirement 1: フォローリクエスト送信

**Objective:** ユーザーとして、他のユーザーにフォローリクエストを送りたい。それにより、つながりたい相手に承認を依頼できる。

#### Acceptance Criteria

1. When ユーザーが他のユーザーに対してフォローリクエストを送信する, the Follow Service shall フォローリクエスト（送信者ID、受信者ID、ステータス: pending、作成日時）を作成する
2. If 自分自身にフォローリクエストを送信しようとした場合, the Follow Service shall リクエストを拒否し、エラーを返す
3. If 既にフォロー関係が成立しているユーザーにリクエストを送信しようとした場合, the Follow Service shall リクエストを拒否し、既にフォロー済みである旨のエラーを返す
4. If 既に pending 状態のリクエストが存在するユーザーに再度リクエストを送信しようとした場合, the Follow Service shall リクエストを拒否し、リクエスト送信済みである旨のエラーを返す
5. When フォローリクエストの送信が成功した場合, the Shelfie App shall 送信先ユーザーの表示状態を「リクエスト送信済み」に更新する

### Requirement 2: フォローリクエスト承認・拒否

**Objective:** ユーザーとして、受信したフォローリクエストを承認または拒否したい。それにより、誰とつながるかを自分で管理できる。

#### Acceptance Criteria

1. When ユーザーが受信したフォローリクエストを承認する, the Follow Service shall リクエストのステータスを approved に更新し、双方向のフォロー関係を成立させる
2. When ユーザーが受信したフォローリクエストを拒否する, the Follow Service shall リクエストのステータスを rejected に更新し、フォロー関係を成立させない
3. When フォローリクエストが承認された場合, the Follow Service shall 送信者と受信者の両方のフォロー数・フォロワー数を更新する
4. If 存在しないリクエストまたは自分宛てでないリクエストを操作しようとした場合, the Follow Service shall 操作を拒否し、エラーを返す
5. If 既に処理済み（approved または rejected）のリクエストを再度操作しようとした場合, the Follow Service shall 操作を拒否し、処理済みである旨のエラーを返す

### Requirement 3: フォローリクエスト一覧表示

**Objective:** ユーザーとして、自分が受信したフォローリクエストの一覧を確認したい。それにより、承認待ちのリクエストに対応できる。

#### Acceptance Criteria

1. The Shelfie App shall お知らせ画面の上部にフォローリクエスト一覧画面への導線（未処理件数を含む）を表示する
2. When ユーザーがお知らせ画面のフォローリクエスト導線をタップする, the Shelfie App shall フォローリクエスト一覧画面に遷移する
3. The Shelfie App shall フォローリクエスト一覧画面で受信リクエストの各ユーザーについて、アバター、表示名、ハンドルを表示する
4. The Shelfie App shall フォローリクエスト一覧画面の各項目に承認ボタンと拒否ボタンを表示する
5. While フォローリクエスト一覧を表示している間, the Shelfie App shall ページネーション（無限スクロール）でリクエスト一覧を読み込む
6. If 未処理のフォローリクエストが0件の場合, the Shelfie App shall お知らせ画面のフォローリクエスト導線を非表示にする

### Requirement 4: フォロー解除

**Objective:** ユーザーとして、フォロー中のユーザーとのフォロー関係を解除したい。それにより、つながりを管理できる。

#### Acceptance Criteria

1. When ユーザーがフォロー中のユーザーに対してフォロー解除を実行する, the Follow Service shall 双方のフォロー関係を削除する
2. When フォロー解除が成功した場合, the Follow Service shall 双方のフォロー数・フォロワー数を更新する
3. When フォロー解除が成功した場合, the Shelfie App shall 対象ユーザーの表示状態を未フォロー状態に更新する
4. If フォロー関係が存在しないユーザーに対してフォロー解除を実行しようとした場合, the Follow Service shall 操作を拒否し、エラーを返す

### Requirement 5: フォロー/フォロワー一覧表示

**Objective:** ユーザーとして、自分のフォロー/フォロワー一覧を確認したい。それにより、つながりの状況を把握できる。

#### Acceptance Criteria

1. When ユーザーがプロフィール画面のフォロー数をタップする, the Shelfie App shall そのユーザーのフォロー中ユーザー一覧画面に遷移する
2. When ユーザーがプロフィール画面のフォロワー数をタップする, the Shelfie App shall そのユーザーのフォロワー一覧画面に遷移する
3. The Shelfie App shall フォロー/フォロワー一覧の各ユーザーについて、アバター、表示名、ハンドルを表示する
4. While フォロー/フォロワー一覧を表示している間, the Shelfie App shall ページネーション（無限スクロール）でユーザー一覧を読み込む

### Requirement 6: フォロー/フォロワー数の表示

**Objective:** ユーザーとして、プロフィール画面でフォロー数とフォロワー数を確認したい。それにより、自分のつながりの規模がわかる。

#### Acceptance Criteria

1. The Shelfie App shall 自分のプロフィール画面にフォロー数とフォロワー数を表示する
2. When フォローリクエストの承認が成功した場合, the Shelfie App shall 関連するフォロー数/フォロワー数の表示を即座に更新する
3. When フォロー解除が成功した場合, the Shelfie App shall 関連するフォロー数/フォロワー数の表示を即座に更新する

### Requirement 7: 招待リンク

**Objective:** ユーザーとして、招待リンクを通じて他のユーザーとつながりたい。それにより、プライベートな友人ネットワークで信頼できる相手にのみフォローリクエストを送れる。

#### Acceptance Criteria

1. The Follow Service shall 各ユーザーに対して一意のプロフィールリンク（Universal Links / App Links 形式、例: `https://shelfie.app/u/{handle}`）を生成する
2. When ユーザーが自分のプロフィール画面で招待リンクの共有ボタンをタップする, the Shelfie App shall OSのシェアシート（LINE、メッセージ等）を表示し、プロフィールリンクを共有できるようにする
3. When ログイン済みのユーザーが招待リンクを開く, the Shelfie App shall リンク先ユーザーの制限付きプロフィール（アバター、表示名、ハンドルのみ）とフォローリクエスト送信ボタンを表示する
4. If 招待リンクを開いたユーザーがアプリ未インストールの場合, the Web中間ページ（Next.js）shall アプリの紹介とApp Store/Google Playへのダウンロードリンクを表示する
5. If 既にフォロー関係が成立しているユーザーの招待リンクを開いた場合, the Shelfie App shall そのユーザーの通常のプロフィール画面（フル情報）に遷移する
6. If 自分自身の招待リンクを開いた場合, the Shelfie App shall 自分のプロフィール画面に遷移する

#### Non-Goals（初期スコープ外）

- QRコード表示・スキャンによるユーザー発見（将来対応）
- ディファードディープリンク（アプリ未インストール → インストール後にプロフィール画面へ自動遷移）

### Requirement 8: プロフィール閲覧のアクセス制御

**Objective:** ユーザーとして、フォロー関係があるユーザーのプロフィールのみ閲覧したい。それにより、プライベートな友人ネットワークが維持される。

#### Acceptance Criteria

1. While ユーザーが対象ユーザーとフォロー関係にある場合, the Shelfie App shall 対象ユーザーのプロフィール画面にアバター、表示名、ハンドル、自己紹介、フォロー数、フォロワー数、本棚情報を表示する
2. While ユーザーが対象ユーザーとフォロー関係にある場合, the Shelfie App shall プロフィール画面にフォロー解除ボタンを表示する
3. If フォロー関係のないユーザーのプロフィールにアクセスしようとした場合, the Shelfie App shall 制限付きの情報（アバター、表示名、ハンドルのみ）を表示し、詳細な本棚情報を非表示にする
4. If フォロー関係のないユーザーのプロフィールにアクセスした場合, the Shelfie App shall フォローリクエスト送信ボタンを表示する
5. While 自分のプロフィール画面を表示している場合, the Shelfie App shall フォロー関連の操作ボタンを表示しない

### Requirement 9: フォロー関係のデータ管理

**Objective:** システムとして、フォローリクエストとフォロー関係を永続化し、一貫性のあるデータ管理を行いたい。それにより、信頼性の高いソーシャル機能を提供できる。

#### Acceptance Criteria

1. The Follow Service shall フォローリクエスト（送信者ID、受信者ID、ステータス、作成日時、更新日時）を永続化する
2. The Follow Service shall フォロー関係（ユーザーA ID、ユーザーB ID、成立日時）を永続化する
3. The Follow Service shall 同一ユーザーペア間の重複リクエストおよび重複フォロー関係をデータベースレベルで防止する
4. When ユーザーアカウントが削除された場合, the Follow Service shall そのユーザーに関連する全てのフォローリクエストとフォロー関係を自動的に削除する
5. The Follow Service shall フォロー数・フォロワー数を効率的に取得できるようにする

### Requirement 10: エラーハンドリングとネットワーク対応

**Objective:** ユーザーとして、操作中にエラーが発生した場合に適切なフィードバックを受けたい。それにより、次にどうすべきか判断できる。

#### Acceptance Criteria

1. If フォローリクエスト送信中にネットワークエラーが発生した場合, the Shelfie App shall エラーメッセージを表示し、リクエスト状態を操作前の状態に戻す
2. If フォローリクエストの承認/拒否中にネットワークエラーが発生した場合, the Shelfie App shall エラーメッセージを表示し、リクエスト状態を操作前の状態に戻す
3. If フォロー解除中にネットワークエラーが発生した場合, the Shelfie App shall エラーメッセージを表示し、フォロー状態を操作前の状態に戻す
4. If フォロー/フォロワー一覧の取得中にエラーが発生した場合, the Shelfie App shall エラーメッセージとリトライ手段を表示する
5. If 招待リンクの解析に失敗した場合, the Shelfie App shall エラーメッセージを表示し、ホーム画面に遷移する
6. While フォロー関連の API リクエストが処理中, the Shelfie App shall ローディング状態を表示し、重複操作を防止する

### Requirement 11: フォローリクエスト受信時のプッシュ通知

**Objective:** ユーザーとして、フォローリクエストを受信した際にプッシュ通知を受け取りたい。それにより、リクエストに気づいて素早く対応できる。

#### Acceptance Criteria

1. When フォローリクエストの送信が成功した場合, the Follow Service shall 既存の NotificationService を使用して受信者にプッシュ通知を送信する
2. The Follow Service shall プッシュ通知に送信者の表示名を含むタイトルと本文を設定する
3. When ユーザーがフォローリクエストのプッシュ通知をタップする, the Shelfie App shall お知らせ画面に遷移する
4. If プッシュ通知の送信に失敗した場合, the Follow Service shall エラーをログに記録し、フォローリクエスト自体の作成には影響を与えない

### Requirement 12: お知らせタブ

**Objective:** ユーザーとして、アプリ内でフォロー関連の通知をまとめて確認したい。それにより、自分に関するアクティビティを見逃さない。

#### Acceptance Criteria

1. The Shelfie App shall ボトムナビゲーションバーに「お知らせ」タブを追加する
2. The Shelfie App shall お知らせ画面にフォロー関連の通知一覧を時系列（新しい順）で表示する
3. The Shelfie App shall お知らせの各項目について、通知種別に応じたアイコン、相手ユーザーのアバター、通知内容テキスト、経過時間を表示する
4. The Shelfie App shall 以下の種別の通知をお知らせ一覧に表示する: フォローリクエスト受信、フォローリクエスト承認
5. While お知らせ一覧を表示している間, the Shelfie App shall ページネーション（無限スクロール）で通知一覧を読み込む
6. When 未読のお知らせが存在する場合, the Shelfie App shall ボトムナビゲーションバーのお知らせタブにバッジ（未読件数）を表示する
7. When ユーザーがお知らせ画面を開く, the Shelfie App shall 未読のお知らせを既読状態に更新する
8. If お知らせが0件の場合, the Shelfie App shall 通知がない旨の空状態メッセージを表示する

### Requirement 13: お知らせデータの管理

**Objective:** システムとして、フォロー関連の通知データを永続化・管理したい。それにより、ユーザーがお知らせ履歴を確認できる。

#### Acceptance Criteria

1. The Notification Service shall お知らせデータ（受信者ID、送信者ID、通知種別、既読フラグ、作成日時）を永続化する
2. When フォローリクエストが作成された場合, the Follow Service shall 受信者向けに「フォローリクエスト受信」のお知らせレコードを作成する
3. When フォローリクエストが承認された場合, the Follow Service shall 送信者向けに「フォローリクエスト承認」のお知らせレコードを作成する
4. The Notification Service shall 指定ユーザーの未読お知らせ件数を効率的に取得できるようにする
5. When ユーザーアカウントが削除された場合, the Notification Service shall そのユーザーに関連する全てのお知らせレコードを自動的に削除する

### Requirement 14: Web中間ページとインフラ

**Objective:** システムとして、招待リンクの受け口となるWeb中間ページをホスティングし、Universal Links / App Links が正しく機能するインフラを整備したい。それにより、招待リンク経由でのアプリ起動やストア誘導が実現する。

#### Acceptance Criteria

1. The Web App shall カスタムドメイン（例: `shelfie.app`）で公開する
2. The Web App shall Vercel にデプロイする（GitHub連携による自動デプロイ）
3. The Web App shall `/.well-known/apple-app-site-association` を配信し、iOS Universal Links を有効化する
4. The Web App shall `/.well-known/assetlinks.json` を配信し、Android App Links を有効化する
5. The Web App shall `/u/{handle}` パスで招待リンクの中間ページを表示し、アプリで開くボタンとApp Store/Google Playへのダウンロードリンクを提供する
6. The Infrastructure shall カスタムドメインの取得とVercelへのDNS設定を行う（SSL証明書はVercelが自動発行）

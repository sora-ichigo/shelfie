# プッシュ通知

## 概要

Firebase Cloud Messaging (FCM) を使ったプッシュ通知機能。
API サーバーから iOS / Android 端末に通知を送信する。

## アーキテクチャ

```
CLI (send-notification.ts)
  → NotificationService
    → DeviceTokenRepository (DB からトークン取得)
    → FCMAdapter (Firebase Admin SDK で送信)
```

## 初期セットアップ（一度だけ）

### 1. APNs Authentication Key の作成

iOS 端末に通知を送るために必要。

1. [Apple Developer Keys](https://developer.apple.com/account/resources/authkeys/list) を開く
2. 「+」ボタン → キー名を入力（例: `Shelfie APNs Key`）
3. **Apple Push Notifications service (APNs)** にチェック → Continue → Register
4. `.p8` ファイルをダウンロード（一度しかダウンロードできないので保管すること）
5. Key ID を控えておく

### 2. Firebase Console に APNs キーをアップロード

1. [Firebase Console](https://console.firebase.google.com/) → プロジェクト設定 → Cloud Messaging タブ
2. 「Apple アプリの設定」→ APNs 認証キーのアップロード
3. `.p8` ファイル、Key ID、Team ID を入力
4. **dev / prod 両方の Firebase プロジェクトに同じキーをアップロードする**

### 3. GCP Secret Manager にシークレットを登録

`notify:dev` / `notify:prod` が参照するシークレット:

| シークレット名 | 説明 |
|---|---|
| `shelfie-api-database-url` | PostgreSQL 接続 URL（既存） |
| `shelfie-api-firebase-private-key` | Firebase Admin SDK の秘密鍵 |

Firebase 秘密鍵の登録がまだの場合:

```bash
# dev
./scripts/manage-secret.sh create shelfie-api-firebase-private-key -p shelfie-development-484809

# prod
./scripts/manage-secret.sh create shelfie-api-firebase-private-key -p shelfie-production-485714
```

Firebase コンソール → プロジェクト設定 → サービスアカウント → 新しい秘密鍵の生成 で取得した JSON 内の `private_key` の値を入力する。

## 通知の送信

### ローカル（.env ベース）

```bash
pnpm --filter @shelfie/api notify -- --title "タイトル" --body "本文" --user-ids 1
```

### dev / prod 環境

GCP Secret Manager から認証情報を取得して送信する。

```bash
# dev 環境
pnpm --filter @shelfie/api notify:dev -- --title "タイトル" --body "本文" --user-ids 1

# prod 環境
pnpm --filter @shelfie/api notify:prod -- --title "タイトル" --body "本文" --user-ids 1
```

### オプション

| オプション | 必須 | 説明 |
|---|---|---|
| `--title` | Yes | 通知タイトル |
| `--body` | Yes | 通知本文 |
| `--user-ids` | Yes | 送信対象のユーザー ID（カンマ区切り、または `all`） |

### 例

```bash
# 特定ユーザーに送信
pnpm --filter @shelfie/api notify:dev -- --title "テスト" --body "動作確認" --user-ids 1,2,3

# 全ユーザーに送信
pnpm --filter @shelfie/api notify:dev -- --title "お知らせ" --body "新機能リリース" --user-ids all
```

## 環境変数

`send-notification.ts` が参照する環境変数:

| 変数名 | 説明 |
|---|---|
| `DATABASE_URL` | PostgreSQL 接続 URL |
| `FIREBASE_PROJECT_ID` | Firebase プロジェクト ID |
| `FIREBASE_CLIENT_EMAIL` | Firebase サービスアカウントメール |
| `FIREBASE_PRIVATE_KEY` | Firebase Admin SDK 秘密鍵 |

ローカル開発では `.env` に設定。`notify:dev` / `notify:prod` では `scripts/notify.sh` が自動で注入する。

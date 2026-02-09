# Push Notification Architecture

本ドキュメントは、Shelfie アプリケーションのプッシュ通知機能のアーキテクチャと運用ガイドラインを定義する。

## 概要

FCM（Firebase Cloud Messaging）を介したプッシュ通知の送受信基盤。運営者が CLI スクリプトで通知を送信し、モバイルアプリがフォアグラウンド・バックグラウンドの両状態で通知を受信・表示する。

## アーキテクチャ

```
CLI Script ──→ NotificationService ──→ FCMAdapter ──→ FCM ──→ Mobile App
                     │
                     ▼
              DeviceTokenRepository ──→ PostgreSQL
                     ▲
                     │
Mobile App ──→ GraphQL API (registerDeviceToken / unregisterDeviceToken)
```

### コンポーネント構成

| コンポーネント | 場所 | 責務 |
|--------------|------|------|
| DeviceTokenRepository | `apps/api/src/features/device-tokens/internal/repository.ts` | デバイストークンの CRUD（UPSERT で冪等性確保） |
| DeviceTokenService | `apps/api/src/features/device-tokens/internal/service.ts` | トークン管理ビジネスロジック |
| DeviceTokenGraphQL | `apps/api/src/features/device-tokens/internal/graphql.ts` | GraphQL Mutation（registerDeviceToken / unregisterDeviceToken） |
| NotificationService | `apps/api/src/features/device-tokens/internal/notification-service.ts` | 通知送信ロジック（バッチ分割、無効トークン削除） |
| FCMAdapter | `apps/api/src/features/device-tokens/internal/fcm-adapter.ts` | firebase-admin messaging API ラッパー |
| CLI Script | `apps/api/src/scripts/send-notification.ts` | 通知送信 CLI ツール |
| DeviceTokenNotifier | `apps/mobile/lib/features/push_notification/application/device_token_notifier.dart` | FCM トークンの取得・同期・解除 |
| PushNotificationInitializer | `apps/mobile/lib/features/push_notification/application/push_notification_initializer.dart` | Firebase Messaging 初期化、通知許可リクエスト |
| ForegroundNotificationHandler | `apps/mobile/lib/features/push_notification/application/foreground_notification_handler.dart` | フォアグラウンド通知表示 |

## データモデル

### device_tokens テーブル

```sql
device_tokens (
  id          SERIAL PRIMARY KEY,
  user_id     INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  token       TEXT NOT NULL,
  platform    TEXT NOT NULL,  -- 'ios' | 'android'
  created_at  TIMESTAMP DEFAULT NOW(),
  updated_at  TIMESTAMP DEFAULT NOW(),
  UNIQUE(user_id, token)
)
```

- ユニーク制約: `(user_id, token)` で重複登録を防止
- カスケード削除: ユーザー削除時にトークンも自動削除
- マイグレーション: `apps/api/drizzle/migrations/0009_amused_mimic.sql`

## 環境構成

### Firebase プロジェクト

| 環境 | Firebase Project ID | 用途 |
|------|-------------------|------|
| dev | `shelfie-development-484809` | 開発・テスト用 |
| prod | `shelfie-production-485714` | 本番用 |

### API 側の環境変数

```
FIREBASE_PROJECT_ID       # Firebase プロジェクト ID
FIREBASE_CLIENT_EMAIL     # サービスアカウントメール
FIREBASE_PRIVATE_KEY      # サービスアカウント秘密鍵
FIREBASE_WEB_API_KEY      # Firebase Web API キー
```

- `firebase-admin` は環境変数の Firebase 認証情報で初期化される
- 環境変数を切り替えることで dev/prod を切り替え可能

### モバイル側の Firebase 設定

- `apps/mobile/lib/firebase_options.dart` で dev/prod 両方の設定を定義
- `kReleaseMode` で自動切り替え（Debug → dev、Release → prod）
- ネイティブ設定ファイル（`GoogleService-Info.plist` / `google-services.json`）は不要（Dart レベルで `Firebase.initializeApp(options:)` に明示的に渡すため削除済み）

## CLI 通知送信

### 実行方法

```bash
# 全ユーザーに送信
pnpm --filter @shelfie/api notify -- --title "タイトル" --body "本文" --all

# 特定ユーザーに送信
pnpm --filter @shelfie/api notify -- --title "タイトル" --body "本文" --user-ids 1,2,3
```

### 引数

| フラグ | 必須 | 説明 |
|--------|------|------|
| `--title` | Yes | 通知タイトル |
| `--body` | Yes | 通知本文 |
| `--all` | No | 全ユーザー対象（`--user-ids` と排他） |
| `--user-ids` | No | ユーザー ID カンマ区切り（`--all` と排他） |

### バッチ処理

- FCM API の制限に基づき **500 件ずつ**バッチ送信
- 無効トークン（`messaging/registration-token-not-registered`）は送信後に自動削除
- 送信結果（成功数・失敗数・削除トークン数）をコンソール出力

## モバイル側のライフサイクル

### トークン登録フロー

1. アプリ起動 → `Firebase.initializeApp()` → `requestPermission()`
2. ログイン成功 → `DeviceTokenNotifier.syncToken()` → FCM トークン取得 → `registerDeviceToken` Mutation
3. トークン更新 → `onTokenRefresh` ストリーム → 自動再登録
4. ログアウト → `DeviceTokenNotifier.unregisterCurrentToken()` → `unregisterDeviceToken` Mutation

### 通知受信

| 状態 | 処理方法 |
|------|---------|
| バックグラウンド | FCM が OS ネイティブ通知として自動表示 |
| フォアグラウンド（iOS） | `setForegroundNotificationPresentationOptions` で OS 通知として表示 |
| フォアグラウンド（Android） | `flutter_local_notifications` で手動表示（高優先度チャネル） |

### 依存パッケージ（Mobile）

| パッケージ | 用途 |
|-----------|------|
| `firebase_core` | Firebase 初期化 |
| `firebase_messaging` | FCM トークン取得・メッセージ受信 |
| `flutter_local_notifications` | フォアグラウンド通知表示（Android） |

## テスト方針

### API 側

| テスト種別 | 対象 | ファイル |
|-----------|------|---------|
| Unit | Repository CRUD | `repository.test.ts` |
| Unit | Service ロジック | `service.test.ts` |
| Unit | FCM Adapter | `fcm-adapter.test.ts` |
| Unit | GraphQL Mutation | `graphql.test.ts` |
| Unit | CLI 引数パース | `parse-notification-args.test.ts` |
| Unit | NotificationService | `notification-service.test.ts` |
| Integration | 送信フロー全体（FCM モック） | `notification-integration.test.ts` |

### Mobile 側

| テスト種別 | 対象 | ファイル |
|-----------|------|---------|
| Unit | DeviceTokenNotifier | `device_token_notifier_test.dart` |
| Unit | PushNotificationInitializer | `push_notification_initializer_test.dart` |
| Unit | ForegroundNotificationHandler | `foreground_notification_handler_test.dart` |

## 制約と Non-Goals

- Web 管理画面による通知送信は初期スコープ外（CLI のみ）
- 通知の開封率トラッキングは未実装
- 通知履歴の保存・閲覧機能は未実装
- スケジュール送信・定期送信は未実装
- API レベルの認可は未実装（CLI 実行者 = 管理者とみなす）

## 今後の拡張ポイント

- **通知テンプレート**: よく使う通知パターンのテンプレート化
- **Web 管理画面**: NotificationService を GraphQL エンドポイントとして公開
- **通知履歴**: 送信ログの DB 保存と閲覧 API
- **セグメント配信**: ユーザー属性に基づく対象絞り込み

## 決定履歴

### 2026-02 : 初期実装

- FCM + CLI スクリプト方式を採用
- firebase-admin（既存依存）で FCM 送信
- GraphQL Mutation でデバイストークン管理
- flutter_local_notifications で Android フォアグラウンド通知対応
- バッチサイズ 500 件で逐次送信

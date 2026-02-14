# フォローシステム 状態遷移図

## 概要

フォローシステムは **双方向の状態管理** を採用しており、各ユーザー間の関係を `outgoing`（自分→相手）と `incoming`（相手→自分）の2軸で独立に管理する。

## 状態一覧（FollowStatusType）

| 状態 | 説明 |
|------|------|
| `none` | 関係なし |
| `pendingSent` | フォローリクエスト送信済み（承認待ち） |
| `pendingReceived` | フォローリクエスト受信済み（承認待ち） |
| `following` | フォロー中 |
| `followedBy` | 相手が自分をフォロー中（自分は相手をフォローしていない） |

> **補足**: `followedBy` は API の `getFollowStatusBatch` が返す状態で、クライアント側では incoming の `following` として扱われ、「フォローバック」ボタンの表示に使われる。

## Outgoing（自分 → 相手）の状態遷移

```
                sendFollowRequest()
    ┌──────┐ ──────────────────────> ┌─────────────┐
    │ none │                         │ pendingSent  │
    └──────┘ <────────────────────── └─────────────┘
                cancelFollowRequest()       │
       ▲                                    │ 相手が承認
       │ unfollow()                         ▼
       │                             ┌───────────┐
       └──────────────────────────── │ following  │
                                     └───────────┘
```

### アクション詳細

| アクション | 遷移 | トリガー |
|-----------|-------|---------|
| `sendFollowRequest()` | `none` → `pendingSent` | 「フォロー」ボタンタップ |
| `cancelFollowRequest()` | `pendingSent` → `none` | 「リクエスト送信済み」ボタンタップ |
| 相手が承認 | `pendingSent` → `following` | 相手が `approveFollowRequest()` を実行 |
| `unfollow()` | `following` → `none` | 「フォロー解除」ボタンタップ |

## Incoming（相手 → 自分）の状態遷移

```
                相手がsendFollowRequest()
    ┌──────┐ ──────────────────────────────> ┌──────────────────┐
    │ none │                                 │ pendingReceived  │
    └──────┘ <────────────────────────────── └──────────────────┘
       ▲        rejectFollowRequest()               │
       │                                            │ approveFollowRequest()
       │ 相手がunfollow()                            ▼
       │                                     ┌───────────┐
       └──────────────────────────────────── │ following  │
                                             └───────────┘
```

### アクション詳細

| アクション | 遷移 | トリガー |
|-----------|-------|---------|
| 相手が `sendFollowRequest()` | `none` → `pendingReceived` | 相手がフォローリクエスト送信 |
| `approveFollowRequest()` | `pendingReceived` → `following` | 通知画面で「承認」ボタンタップ |
| `rejectFollowRequest()` | `pendingReceived` → `none` | 通知画面で「削除」ボタンタップ |
| 相手が `unfollow()` | `following` → `none` | 相手がフォロー解除 |

## 双方向の状態の組み合わせとUI表示

### プロフィール画面（UserProfileScreen）

`outgoing` の値で分岐し、`incoming` の値でラベルを決定する。

| outgoing | incoming | 表示ボタン |
|----------|----------|-----------|
| `none` / `followedBy` | `following` | 「フォローバック」 |
| `none` / `followedBy` | その他 | 「フォロー」 |
| `pendingSent` | any | 「リクエスト送信済み」 |
| `following` | any | 「フォロー解除」 |

### 通知画面（NotificationScreen）

通知画面では `_deriveDisplayStatus()` で `outgoing` / `incoming` の組み合わせから単一の表示用ステータスを導出し、さらに **通知タイプ別** にボタン表示を分岐する。

#### displayStatus 判定ロジック

```
1. incoming == pendingReceived → pendingReceived
2. outgoing == following       → following
3. outgoing == pendingSent     → pendingSent
4. incoming == following       → followedBy
5. いずれにも該当しない         → none
```

#### 通知タイプ: `followRequestReceived`（フォローリクエスト受信）

| displayStatus | 表示 |
|---------------|------|
| `pendingReceived` | 「承認」+「削除」ボタン |
| `following` | 「フォロー中」ボタン |
| `followedBy` | 「フォローバック」ボタン |
| `none` / `pendingSent` | ボタンなし |

#### 通知タイプ: `followRequestApproved`（フォローリクエスト承認）

| displayStatus | 表示 |
|---------------|------|
| `following` | 「フォロー中」ボタン |
| `none` / `followedBy` | 「フォロー」ボタン |
| `pendingSent` | 「リクエスト済み」ボタン |
| `pendingReceived` | ボタンなし |

## 全体像（ユーザーA → ユーザーB のフォロー）

```
ユーザーA                                    ユーザーB
─────────                                   ─────────

[フォロー] タップ
    │
    ├─ A.outgoing: none → pendingSent
    │                                        B.incoming: none → pendingReceived
    │                                            │
    │                                        [承認] タップ
    │                                            │
    ├─ A.outgoing: pendingSent → following
    │                                        B.incoming: pendingReceived → following
    │
    │                                        （B が A をフォローバックしたい場合）
    │                                        [フォローバック] タップ
    │                                            │
    │                                        B.outgoing: none → pendingSent
    ├─ A.incoming: none → pendingReceived
    │
[承認] タップ
    │
    ├─ A.incoming: pendingReceived → following
    │                                        B.outgoing: pendingSent → following
    │
    ▼
相互フォロー状態
  A.outgoing=following, A.incoming=following
  B.outgoing=following, B.incoming=following
```

## 通知システム

### 通知タイプ（NotificationType）

| タイプ | トリガー | 受信者 |
|------|--------|------|
| `followRequestReceived` | ユーザーA → B に `sendFollowRequest()` | B（リクエスト受信者） |
| `followRequestApproved` | B が A のリクエストを `approveFollowRequest()` | A（リクエスト送信者） |

### 通知モデル（NotificationModel）

| フィールド | 型 | 説明 |
|-----------|------|------|
| `id` | `int` | 通知ID |
| `sender` | `UserSummary` | 通知のトリガーとなったユーザー |
| `type` | `NotificationType` | 通知タイプ |
| `outgoingFollowStatus` | `FollowStatusType` | 通知受信者 → sender への follow status |
| `incomingFollowStatus` | `FollowStatusType` | sender → 通知受信者への follow status |
| `followRequestId` | `int?` | 対応する follow_request レコードの ID |
| `isRead` | `bool` | 既読フラグ |
| `createdAt` | `DateTime` | 作成日時 |

### 通知テキスト

| タイプ | テキスト |
|------|--------|
| `followRequestReceived` | `{sender名} からフォローリクエストがありました。` |
| `followRequestApproved` | `{sender名} がフォローリクエストを承認しました。` |

## DB スキーマ

| テーブル | 説明 |
|---------|------|
| `follows` | 確定済みのフォロー関係（`follower_id` → `followee_id`） |
| `follow_requests` | フォローリクエスト（`sender_id` → `receiver_id`、status: pending/approved/rejected） |

### `follows` テーブル

| カラム | 型 | 説明 |
|--------|------|------|
| `id` | integer (PK) | 自動採番 |
| `follower_id` | integer (FK → users) | フォローしている側 |
| `followee_id` | integer (FK → users) | フォローされている側 |
| `created_at` | timestamp | 作成日時 |

- ユニーク制約: `(follower_id, followee_id)`
- チェック制約: `follower_id != followee_id`（自己フォロー禁止）

### `follow_requests` テーブル

| カラム | 型 | 説明 |
|--------|------|------|
| `id` | integer (PK) | 自動採番 |
| `sender_id` | integer (FK → users) | リクエスト送信者 |
| `receiver_id` | integer (FK → users) | リクエスト受信者 |
| `status` | text | `pending` / `approved` / `rejected` |
| `created_at` | timestamp | 作成日時 |
| `updated_at` | timestamp | 更新日時 |

- ユニーク制約: `(sender_id, receiver_id)`
- チェック制約: `sender_id != receiver_id`（自己リクエスト禁止）

## FollowStatus と DB レコードの対応

自分（`me`）から相手（`target`）を見たときの状態判定ロジック。

### `none` — 関係なし

| テーブル | 条件 |
|---------|------|
| `follows` | `(me → target)` のレコードが **存在しない** |
| `follow_requests` | `(me → target)` の `status=pending` レコードが **存在しない** |

DB 上にこのペアに関するレコードが一切ないか、あっても `follow_requests.status` が `approved` / `rejected` のみ。

### `pendingSent` — フォローリクエスト送信済み（承認待ち）

| テーブル | 条件 |
|---------|------|
| `follows` | `(me → target)` のレコードが **存在しない** |
| `follow_requests` | `sender_id=me, receiver_id=target, status='pending'` のレコードが **存在する** |

自分がリクエストを送り、相手がまだ承認も拒否もしていない状態。

### `pendingReceived` — フォローリクエスト受信済み（承認待ち）

| テーブル | 条件 |
|---------|------|
| `follows` | `(target → me)` のレコードが **存在しない** |
| `follow_requests` | `sender_id=target, receiver_id=me, status='pending'` のレコードが **存在する** |

相手からリクエストが来ていて、自分がまだ承認も拒否もしていない状態。

### `following` — フォロー中

| テーブル | 条件 |
|---------|------|
| `follows` | `follower_id=me, followee_id=target` のレコードが **存在する** |

`follows` テーブルにレコードがある = フォロー確定済み。承認時に `follow_requests.status` は `approved` に更新され、同時に `follows` レコードが作成される。

### `followedBy` — 相手にフォローされている

| テーブル | 条件 |
|---------|------|
| `follows` | `follower_id=target, followee_id=me` のレコードが **存在する** |
| `follows` | `follower_id=me, followee_id=target` のレコードが **存在しない** |

相手が自分をフォローしているが、自分は相手をフォローしていない状態。

### 判定の優先順位

`getFollowStatusBatch` では以下の優先順位で判定される：

```
1. follows に (me → target) がある         → FOLLOWING
2. follow_requests に送信済みpendingがある  → PENDING_SENT
3. follow_requests に受信済みpendingがある  → PENDING_RECEIVED
4. follows に (target → me) がある         → FOLLOWED_BY
5. いずれにも該当しない                     → NONE
```

## 状態管理アーキテクチャ（モバイル）

### FollowStateNotifier

画面横断でフォロー状態を一元管理する `keepAlive` な Riverpod notifier。

- **状態**: `Map<int, FollowDirectionalStatus>`（userId → outgoing/incoming のペア）
- **楽観的更新**: 各アクションで即座にUIを更新し、API 失敗時にロールバック
- **重複操作防止**: `_operatingUsers` セットで同一ユーザーへの同時操作を防止
- **バージョニング**: 操作成功時に `followVersion` をインクリメントし、依存画面の再取得をトリガー

| メソッド | outgoing の変化 | incoming の変化 |
|---------|----------------|----------------|
| `sendFollowRequest()` | → `pendingSent` | 変化なし |
| `cancelFollowRequest()` | → `none` | 変化なし |
| `unfollow()` | → `none` | 変化なし |
| `approveRequest()` | 変化なし | → `following` |
| `rejectRequest()` | 変化なし | → `none` |

## 関連ファイル

| レイヤー | ファイル |
|---------|---------|
| Domain | `lib/features/follow/domain/follow_status_type.dart` |
| Data | `lib/features/follow/data/follow_repository.dart` |
| State | `lib/core/state/follow_state_notifier.dart` |
| Application | `lib/features/follow/application/follow_counts_notifier.dart` |
| Application | `lib/features/follow/application/follow_list_notifier.dart` |
| Presentation | `lib/features/follow/presentation/user_profile_screen.dart` |
| Notification Domain | `lib/features/notification/domain/notification_model.dart` |
| Notification Domain | `lib/features/notification/domain/notification_type.dart` |
| Notification Presentation | `lib/features/notification/presentation/notification_screen.dart` |

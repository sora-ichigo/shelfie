# Implementation Plan

## Task List

### Phase 1: 初期実装（完了済み）

- [x] 1. データベーススキーマとマイグレーションの作成
- [x] 1.1 follow_requests テーブルと follows テーブルの Drizzle スキーマを定義する
- [x] 1.2 (P) notifications テーブルの Drizzle スキーマを定義する

- [x] 2. Follow Feature の API バックエンド実装
- [x] 2.1 FollowRepository を実装する
- [x] 2.2 FollowService を実装する
- [x] 2.3 FollowGraphQL を実装する

- [x] 3. Notification Feature の API バックエンド実装
- [x] 3.1 (P) NotificationRepository を実装する
- [x] 3.2 NotificationAppService を実装する
- [x] 3.3 NotificationGraphQL を実装する

- [x] 4. API 統合テスト
- [x] 4.1 フォローシステムのエンドツーエンド統合テストを作成する

- [x] 5. モバイル ドメインモデルとリポジトリの実装
- [x] 5.1 (P) フォロー関連のドメインモデルを定義する
- [x] 5.2 (P) フォロー関連の GraphQL オペレーションファイルを作成する
- [x] 5.3 FollowMobileRepository を実装する
- [x] 5.4 (P) NotificationMobileRepository を実装する

- [x] 6. モバイル状態管理（Notifier）の実装
- [x] 6.1 FollowVersion Provider を実装する
- [x] 6.2 FollowRequestNotifier を実装する
- [x] 6.3 FollowRequestListNotifier を実装する
- [x] 6.4 (P) FollowListNotifier を実装する
- [x] 6.5 (P) NotificationListNotifier を実装する
- [x] 6.6 (P) UnreadNotificationCount Provider を実装する

- [x] 7. モバイル UI 画面の実装
- [x] 7.1 お知らせ画面を実装する
- [x] 7.2 フォローリクエスト一覧画面を実装する
- [x] 7.3 (P) フォロー/フォロワー一覧画面を実装する
- [x] 7.4 他ユーザープロフィール画面を実装する
- [x] 7.5 既存プロフィール画面にフォロー数・招待リンクを統合する

- [x] 8. ボトムナビゲーションとルーティングの統合
- [x] 8.1 ボトムナビゲーションにお知らせタブを追加する
- [x] 8.2 フォロー関連画面のルーティングを設定する

### Phase 2: 一方向フォローモデルへの移行（完了済み）

- [x] M. 一方向フォローモデルへの移行（follows テーブルの方向付きモデル化）

- [x] M.1 follows テーブルの Drizzle スキーマを方向付きモデルに変更する
  - `user_id_a` / `user_id_b` カラムを `follower_id` / `followee_id` に変更する
  - `CHECK(user_id_a < user_id_b)` 制約を `CHECK(follower_id != followee_id)` に変更する
  - `UNIQUE(user_id_a, user_id_b)` を `UNIQUE(follower_id, followee_id)` に変更する
  - インデックスを `idx_follows_follower` / `idx_follows_followee` に変更する
  - マイグレーションを生成する（既存データの変換: 旧 1 レコード → 新 2 レコード（双方向だったため））
  - _Requirements: 9.2, 9.3_

- [x] M.2 FollowRepository を一方向フォローモデルに対応させる（タスク M.1 の完了が前提）
  - `createFollow(followerId, followeeId)` に変更する（正規化ロジック削除）
  - `deleteFollow(followerId, followeeId)` を方向付き削除に変更する
  - `findFollow(followerId, followeeId)` を方向付き検索に変更する
  - `findFollowing(userId)` を `WHERE follower_id = userId` に変更する（OR 条件削除）
  - `findFollowers(userId)` を `WHERE followee_id = userId` に変更する（OR 条件削除）
  - `countFollowing` / `countFollowers` を同様に変更する
  - 既存テストを更新する
  - _Requirements: 9.2, 9.5_

- [x] M.3 FollowService を一方向フォローモデルに対応させる（タスク M.2 の完了が前提）
  - `approveRequest`: `createFollow(sender, receiver)` のみ呼び出す（一方向フォロー成立）
  - `unfollow(userId, targetUserId)`: `deleteFollow(userId, targetUserId)` のみ削除する（逆方向は維持）
  - `getFollowStatus` を `{ outgoing: FollowStatus, incoming: FollowStatus }` を返すように変更する
    - outgoing: userId → targetUserId の方向（NONE / PENDING / FOLLOWING）
    - incoming: targetUserId → userId の方向（NONE / PENDING / FOLLOWING）
  - `sendRequest` のバリデーション: 既存フォローチェックを outgoing 方向のみに変更する
  - 既存テストを更新し、一方向フォローの振る舞いを検証する新テストを追加する
  - _Requirements: 2.1, 2.3, 4.1, 4.2_

- [x] M.4 FollowGraphQL の型定義とリゾルバを更新する（タスク M.3 の完了が前提）
  - `FollowStatus` enum を `NONE | PENDING | FOLLOWING` に変更する（PENDING_SENT / PENDING_RECEIVED を削除）
  - `UserProfile` 型に `outgoingFollowStatus` と `incomingFollowStatus` を追加する（旧 `followStatus` を置き換え）
  - `userProfile` Query のリゾルバを更新する
  - 既存テストを更新する
  - _Requirements: 8.1, 8.4, 8.5_

- [x] M.5 API 統合テストを一方向フォローモデルに対応させる（タスク M.4 の完了が前提）
  - 承認後に一方向フォローのみ成立することを検証するテストを追加する
  - フォロー解除が逆方向のフォローに影響しないことを検証するテストを追加する
  - 相互フォロー（双方がリクエスト → 承認）のフローをテストする
  - プロフィール閲覧制御が outgoing 方向に基づくことをテストする（自分がフォローしている場合のみフル表示）
  - _Requirements: 2.1, 4.1, 8.1, 8.3_

- [x] M.6 モバイルのドメインモデルを一方向フォローモデルに対応させる（タスク M.4 の完了が前提）
  - `FollowStatusType` enum を `{ none, pending, following }` に変更する（pendingSent / pendingReceived を削除）
  - `UserProfileModel` の `followStatus` を `outgoingFollowStatus` / `incomingFollowStatus` の2フィールドに変更する
  - build_runner でコード再生成する
  - _Requirements: 8.1, 8.4_

- [x] M.7 (P) モバイルの GraphQL オペレーションを更新する（タスク M.4 の完了が前提）
  - `userProfile` クエリの `followStatus` を `outgoingFollowStatus` / `incomingFollowStatus` に変更する
  - Ferry のコード生成を再実行する
  - _Requirements: 8.1_

- [x] M.8 FollowMobileRepository のレスポンス変換を更新する（タスク M.6, M.7 の完了が前提）
  - `getUserProfile` のレスポンス変換で `outgoingFollowStatus` / `incomingFollowStatus` をマッピングする
  - 既存テストを更新する
  - _Requirements: 8.1_

- [x] M.9 FollowRequestNotifier を一方向フォローモデルに対応させる（タスク M.8 の完了が前提）
  - 状態モデルを `(outgoing: FollowStatusType, incoming: FollowStatusType)` に変更する
  - フォローリクエスト送信: outgoing を `pending` に更新する
  - フォロー解除: outgoing を `none` に更新する（incoming は維持）
  - フォローバック送信: incoming が `following` のまま outgoing を `pending` に更新する
  - 楽観的 UI 更新とロールバックを両方向で正しく動作するよう更新する
  - 既存テストを更新する
  - _Requirements: 1.5, 4.3, 10.1, 10.3_

- [x] M.10 他ユーザープロフィール画面のアクションボタンを更新する（タスク M.9 の完了が前提）
  - outgoing/incoming の組み合わせに応じたボタン表示ロジックを実装する:
    - outgoing=NONE, incoming=NONE → 「フォローする」ボタン
    - outgoing=NONE, incoming=FOLLOWING → 「フォローバックする」ボタン
    - outgoing=PENDING → 「リクエスト送信済み」（キャンセル可能）
    - outgoing=FOLLOWING → 「フォロー中」（フォロー解除可能）
  - プロフィール表示切替を outgoing に基づくよう変更する（FOLLOWING → フル表示、それ以外 → 制限付き表示）
  - 既存テストを更新する
  - _Requirements: 8.1, 8.2, 8.3, 8.4, 8.5, 8.6_

### Phase 3: 残りの機能実装

- [ ] 9. 招待リンク（ディープリンク）の実装
- [ ] 9.1 (P) Web アプリに Well-Known ファイルと招待中間ページを実装する
  - apple-app-site-association ファイルを配信し、`/u/*` パスの Universal Links を有効化する
  - assetlinks.json ファイルを配信し、Android App Links を有効化する
  - `/u/[handle]` パスで中間ページを実装する（アプリで開くボタン、App Store/Google Play リンク）
  - OGP メタタグを設定する
  - _Requirements: 14.1, 14.2, 14.3, 14.4, 14.5_

- [ ] 9.2 モバイルアプリにディープリンク処理を実装する（タスク 7.4, 8.2 の完了が前提）
  - go_router でディープリンク（`/u/{handle}`）のルートを設定する
  - ディープリンク受信時にハンドルからユーザープロフィールを取得し、適切な画面に遷移する
  - 自分がフォローしている場合はフルプロフィール画面に遷移する
  - 自分がフォローしていない場合は制限付きプロフィール画面に遷移する（相手がフォローしている場合はフォローバックボタン表示）
  - 自分自身のリンクの場合は自分のプロフィール画面に遷移する
  - リンク解析失敗時にエラーメッセージを表示しホーム画面に遷移する
  - _Requirements: 7.3, 7.4, 7.5, 7.6, 10.5_

- [ ] 10. プッシュ通知タップ時のルーティング拡張
- [ ] 10.1 フォローリクエスト通知タップでお知らせ画面に遷移する処理を追加する（タスク 8.2 の完了が前提）
  - 既存の NotificationTapHandler にフォローリクエスト通知の route 処理を追加する
  - プッシュ通知の data フィールドに通知種別（follow_request_received）を含める
  - 通知タップ時にお知らせ画面に遷移する
  - _Requirements: 11.3_

- [ ] 11. インフラ設定
- [ ] 11.1 (P) カスタムドメインの DNS 設定と Vercel デプロイを設定する
  - カスタムドメインを取得する（または既存ドメインを確認する）
  - Vercel にカスタムドメインの DNS 設定を行う
  - SSL 証明書の自動発行を確認する
  - GitHub 連携による自動デプロイを設定する
  - _Requirements: 14.1, 14.2, 14.6_

- [ ] 12. ログアウト時のクリーンアップ
- [ ] 12.1 ログアウト時にフォロー関連の状態をクリアする処理を追加する（タスク 6.1, 6.6 の完了が前提）
  - AuthState.logout() で FollowVersion と UnreadNotificationCount の状態をリセットする
  - keepAlive な Provider のデータが残留しないことを保証する
  - _Requirements: 9.4_

- [ ] 13. エンドツーエンド結合確認
- [ ] 13.1 フォローシステム全体の結合テストを実施する（全タスク完了が前提）
  - 招待リンク共有 → ディープリンクでアプリ起動 → 制限付きプロフィール表示 → フォローリクエスト送信 → プッシュ通知受信 → お知らせ画面でリクエスト確認 → 承認 → 一方向フォロー成立 → 送信者のみフルプロフィール表示の一連のフローを確認する
  - フォローバック: 承認後に受信者が送信者へフォローリクエスト → 承認 → 相互フォロー成立を確認する
  - フォロー解除 → 自分からの一方向フォローのみ削除され、相手からのフォローは維持されることを確認する
  - お知らせタブの未読バッジが通知受信で増え、画面を開くと消えることを確認する
  - 各種エラーケース（ネットワークエラー、二重送信等）のフィードバックを確認する
  - _Requirements: 1.1, 1.5, 2.1, 2.3, 2.6, 4.1, 4.3, 6.2, 6.3, 7.1, 7.2, 7.3, 7.5, 8.1, 8.3, 8.4, 10.1, 10.2, 10.3, 10.4, 10.5, 10.6, 11.1, 11.3, 12.1, 12.4, 12.6, 12.7_

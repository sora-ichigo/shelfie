# Implementation Plan

## Task List

- [ ] 1. データベーススキーマとマイグレーションの作成
- [ ] 1.1 follow_requests テーブルと follows テーブルの Drizzle スキーマを定義する
  - follow_requests テーブル（id, sender_id, receiver_id, status, created_at, updated_at）を定義する
  - follows テーブル（id, user_id_a, user_id_b, created_at）を定義する
  - UNIQUE 制約、CHECK 制約（自己フォロー防止、user_id_a < user_id_b の正規化）を設定する
  - users テーブルへの外部キー（ON DELETE CASCADE）を設定する
  - receiver_id + status、sender_id、user_id_a、user_id_b のインデックスを作成する
  - スキーマ集約ファイルに export を追加する
  - マイグレーションを生成・適用する
  - _Requirements: 9.1, 9.2, 9.3_

- [ ] 1.2 (P) notifications テーブルの Drizzle スキーマを定義する
  - notifications テーブル（id, recipient_id, sender_id, type, is_read, created_at）を定義する
  - users テーブルへの外部キー（ON DELETE CASCADE）を設定する
  - recipient_id + is_read、recipient_id + created_at DESC のインデックスを作成する
  - スキーマ集約ファイルに export を追加する
  - マイグレーションを生成・適用する
  - _Requirements: 13.1, 13.5_

- [ ] 2. Follow Feature の API バックエンド実装
- [ ] 2.1 FollowRepository を実装する
  - フォローリクエストの作成・検索・ステータス更新の CRUD 操作を実装する
  - sender_id + receiver_id の組み合わせによるリクエスト検索を実装する
  - receiver_id による pending リクエスト一覧取得（カーソルベースページネーション）を実装する
  - pending リクエスト件数カウントを実装する
  - フォロー関係の作成（user_id_a < user_id_b 正規化）・削除・検索を実装する
  - フォロー中ユーザー一覧・フォロワー一覧のページネーション付き取得を実装する
  - フォロー数・フォロワー数のカウント取得を実装する
  - 各操作のユニットテストを作成する（UNIQUE 制約違反、CHECK 制約違反を含む）
  - _Requirements: 9.1, 9.2, 9.3, 9.5_

- [ ] 2.2 FollowService を実装する（タスク 2.1 の完了が前提）
  - フォローリクエスト送信のバリデーション（自分自身チェック、既存フォローチェック、既存リクエストチェック）を実装する
  - フォローリクエスト送信成功時にアプリ内通知レコードを作成し、プッシュ通知を非同期送信する
  - フォローリクエスト承認をトランザクションで実装する（request ステータス更新 + follow 関係作成を原子的に実行）
  - フォローリクエスト承認成功時に送信者向けのアプリ内通知レコードを作成する
  - フォローリクエスト拒否のステータス更新を実装する
  - 承認・拒否時のバリデーション（存在チェック、本人チェック、処理済みチェック）を実装する
  - フォロー解除の双方向削除を実装する
  - フォロー状態の取得（NONE, PENDING_SENT, PENDING_RECEIVED, FOLLOWING）を実装する
  - フォロー数・フォロワー数の取得を実装する
  - プッシュ通知送信失敗時はエラーログのみでリクエスト作成に影響しないことを保証する
  - Result 型によるエラーハンドリングを実装する
  - 全バリデーションパスのユニットテストを作成する
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 2.1, 2.2, 2.3, 2.4, 2.5, 4.1, 4.2, 4.4, 8.1, 8.3, 11.1, 11.2, 11.4, 13.2, 13.3_

- [ ] 2.3 FollowGraphQL（型定義・Query・Mutation リゾルバ）を実装する（タスク 2.2 の完了が前提）
  - Pothos で FollowRequest, FollowStatus, FollowCounts, UserProfile の GraphQL 型を定義する
  - sendFollowRequest, approveFollowRequest, rejectFollowRequest, unfollow の各 Mutation を実装する
  - pendingFollowRequests, pendingFollowRequestCount, following, followers, followCounts, userProfile の各 Query を実装する
  - 全 Query/Mutation に loggedIn 認証スコープを適用する
  - ErrorsPlugin による Result 型エラーレスポンスを実装する
  - Feature の公開 API（index.ts barrel export）を構成する
  - GraphQL スキーマファイルに Follow 型を登録する
  - GraphQL リゾルバのユニットテストを作成する
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 2.1, 2.2, 2.3, 2.4, 2.5, 3.1, 3.5, 4.1, 4.4, 5.1, 5.2, 5.4, 6.1, 8.1, 8.2, 8.3, 8.4, 8.5_

- [ ] 3. Notification Feature の API バックエンド実装
- [ ] 3.1 (P) NotificationRepository を実装する（タスク 1.2 の完了が前提）
  - 通知レコードの作成を実装する
  - 受信者IDによる通知一覧取得（カーソルベースページネーション、created_at 降順）を実装する
  - 未読件数のカウント取得を実装する
  - 受信者IDによる一括既読更新を実装する
  - ユニットテストを作成する
  - _Requirements: 13.1, 13.4_

- [ ] 3.2 NotificationAppService を実装する（タスク 3.1 の完了が前提）
  - 通知作成（種別: follow_request_received, follow_request_approved）のロジックを実装する
  - 通知一覧取得（ページネーション付き）を実装する
  - 未読件数の取得を実装する
  - 一括既読更新を実装する
  - Result 型によるエラーハンドリングを実装する
  - ユニットテストを作成する
  - _Requirements: 12.2, 12.5, 12.7, 13.1, 13.2, 13.3, 13.4_

- [ ] 3.3 NotificationGraphQL（型定義・Query・Mutation リゾルバ）を実装する（タスク 3.2 の完了が前提）
  - Pothos で AppNotification, NotificationType の GraphQL 型を定義する
  - notifications Query（ページネーション付き通知一覧）を実装する
  - unreadNotificationCount Query（未読件数）を実装する
  - markNotificationsAsRead Mutation（一括既読更新）を実装する
  - 全 Query/Mutation に loggedIn 認証スコープを適用する
  - Feature の公開 API（index.ts barrel export）を構成する
  - GraphQL スキーマファイルに Notification 型を登録する
  - ユニットテストを作成する
  - _Requirements: 12.2, 12.5, 12.6, 12.7, 12.8, 13.4_

- [ ] 4. API 統合テスト
- [ ] 4.1 フォローシステムのエンドツーエンド統合テストを作成する（タスク 2.3, 3.3 の完了が前提）
  - フォローリクエスト送信 → 承認 → フォロー関係成立 → フォロー解除の完全フローをテストする
  - フォローリクエスト送信 → 通知レコード作成の連携フローをテストする
  - フォローリクエスト承認 → 送信者向け通知レコード作成の連携フローをテストする
  - ユーザー削除時のカスケード削除（フォロー関係、リクエスト、通知の全削除）をテストする
  - プロフィール閲覧のアクセス制御（フォロー関係あり/なしでの情報量の違い）をテストする
  - _Requirements: 1.1, 2.1, 2.2, 4.1, 8.1, 8.3, 9.4, 11.1, 13.2, 13.3, 13.5_

- [ ] 5. モバイル ドメインモデルとリポジトリの実装
- [ ] 5.1 (P) フォロー関連のドメインモデルを定義する
  - freezed で FollowRequestModel（id, sender, receiver, status, createdAt）を定義する
  - FollowRequestStatus enum（pending, approved, rejected）を定義する
  - UserSummary モデル（id, name, avatarUrl, handle）を定義する（既存モデルがあれば再利用を検討）
  - FollowStatusType enum（none, pendingSent, pendingReceived, following）を定義する
  - freezed で FollowCounts（followingCount, followerCount）を定義する
  - freezed で UserProfileModel（user, followStatus, followCounts, isOwnProfile, bio, bookCount 等）を定義する
  - freezed で NotificationModel（id, sender, type, isRead, createdAt）を定義する
  - NotificationType enum（followRequestReceived, followRequestApproved）を定義する
  - build_runner でコード生成を実行する
  - _Requirements: 1.1, 3.3, 5.3, 8.1, 8.3, 12.3_

- [ ] 5.2 (P) フォロー関連の GraphQL オペレーションファイルを作成する
  - sendFollowRequest, approveFollowRequest, rejectFollowRequest, unfollow の Mutation を定義する
  - pendingFollowRequests, pendingFollowRequestCount, following, followers, followCounts, userProfile の Query を定義する
  - notifications, unreadNotificationCount の Query を定義する
  - markNotificationsAsRead の Mutation を定義する
  - Ferry のコード生成を実行して型安全なリクエストクラスを生成する
  - _Requirements: 1.1, 2.1, 3.5, 4.1, 5.4, 6.1, 8.1, 12.2, 12.6_

- [ ] 5.3 FollowMobileRepository を実装する（タスク 5.1, 5.2 の完了が前提）
  - Ferry Client を使用したフォローリクエスト送信・承認・拒否・解除の実装
  - 受信リクエスト一覧・件数取得の実装（ページネーション対応）
  - フォロー中ユーザー一覧・フォロワー一覧の取得（ページネーション対応）
  - フォロー数の取得の実装
  - ハンドルによるユーザープロフィール取得の実装
  - GraphQL レスポンスからドメインモデルへの変換
  - Either<Failure, T> 型によるエラーハンドリング
  - Mutation 系は NetworkOnly ポリシーを使用
  - Riverpod Provider で DI を構成する
  - ユニットテストを作成する
  - _Requirements: 1.1, 2.1, 3.5, 4.1, 5.4, 6.1, 8.1_

- [ ] 5.4 (P) NotificationMobileRepository を実装する（タスク 5.1, 5.2 の完了が前提）
  - Ferry Client を使用した通知一覧取得（ページネーション対応）の実装
  - 未読件数の取得の実装
  - 一括既読更新の実装
  - GraphQL レスポンスからドメインモデルへの変換
  - Either<Failure, T> 型によるエラーハンドリング
  - Riverpod Provider で DI を構成する
  - ユニットテストを作成する
  - _Requirements: 12.2, 12.6, 12.7, 13.4_

- [ ] 6. モバイル状態管理（Notifier）の実装
- [ ] 6.1 FollowVersion Provider を実装する
  - keepAlive: true の int カウンター Provider を作成する
  - ShelfVersion / BookListVersion と同パターンで状態変更を伝播する仕組みを構築する
  - _Requirements: 6.2, 6.3_

- [ ] 6.2 FollowRequestNotifier を実装する（タスク 5.3, 6.1 の完了が前提）
  - フォローリクエスト送信時の楽観的 UI 更新（即座にボタン状態を変更し、失敗時にロールバック）を実装する
  - フォロー解除時の楽観的 UI 更新（即座に状態を更新し、失敗時にロールバック）を実装する
  - 操作成功時に FollowVersion を increment する
  - isLoading 中の重複操作を防止する
  - ユニットテストを作成する（楽観的 UI、ロールバック、FollowVersion increment の検証）
  - _Requirements: 1.5, 4.3, 10.1, 10.3, 10.6_

- [ ] 6.3 FollowRequestListNotifier を実装する（タスク 5.3, 6.1 の完了が前提）
  - 受信フォローリクエスト一覧のページネーション管理（無限スクロール）を実装する
  - 承認操作の実行と一覧からの即時削除を実装する
  - 拒否操作の実行と一覧からの即時削除を実装する
  - 操作成功時に FollowVersion を increment する
  - エラー時のロールバックを実装する
  - ユニットテストを作成する
  - _Requirements: 2.1, 2.2, 3.5, 10.2_

- [ ] 6.4 (P) FollowListNotifier を実装する（タスク 5.3, 6.1 の完了が前提）
  - ユーザーIDをパラメータとしたフォロー中/フォロワー一覧取得を実装する
  - 無限スクロールのページネーション管理を実装する
  - FollowVersion を listen して一覧を自動更新する
  - エラー時のリトライ手段を提供する
  - ユニットテストを作成する
  - _Requirements: 5.1, 5.2, 5.4, 10.4_

- [ ] 6.5 (P) NotificationListNotifier を実装する（タスク 5.4, 6.1 の完了が前提）
  - お知らせ一覧のページネーション管理（無限スクロール）を実装する
  - 未読件数の管理を実装する
  - 画面表示時の自動既読更新を実装する（1画面表示あたり1回のみ実行）
  - エラー時のリトライ手段を提供する
  - ユニットテストを作成する
  - _Requirements: 12.2, 12.5, 12.7, 10.4_

- [ ] 6.6 (P) UnreadNotificationCount Provider を実装する（タスク 5.4, 6.1 の完了が前提）
  - keepAlive: true の Provider として未読件数を保持する
  - FollowVersion を listen し、フォロー操作後に未読件数を自動再取得する
  - ボトムナビゲーションバーのバッジ表示と連携する
  - ユニットテストを作成する
  - _Requirements: 12.6_

- [ ] 7. モバイル UI 画面の実装
- [ ] 7.1 お知らせ画面を実装する（タスク 6.5, 6.6 の完了が前提）
  - お知らせ一覧を時系列（新しい順）で表示する
  - 各項目に通知種別アイコン、送信者アバター、通知内容テキスト、経過時間を表示する
  - 画面上部にフォローリクエスト導線（未処理件数バッジ付き）を表示する
  - 未処理リクエストが0件の場合はフォローリクエスト導線を非表示にする
  - 無限スクロールでページネーションを実装する
  - お知らせが0件の場合に空状態メッセージを表示する
  - 画面を開いた際に未読を既読状態に更新する
  - _Requirements: 3.1, 3.2, 3.6, 12.2, 12.3, 12.5, 12.7, 12.8_

- [ ] 7.2 フォローリクエスト一覧画面を実装する（タスク 6.3 の完了が前提）
  - 受信リクエストの各ユーザーについてアバター、表示名、ハンドルを表示する
  - 各項目に承認ボタンと拒否ボタンを配置する
  - 承認/拒否操作中のローディング状態を表示し重複操作を防止する
  - 無限スクロールでページネーションを実装する
  - エラー発生時のフィードバック表示を実装する
  - _Requirements: 3.3, 3.4, 3.5, 10.2, 10.6_

- [ ] 7.3 (P) フォロー/フォロワー一覧画面を実装する（タスク 6.4 の完了が前提）
  - フォロー中またはフォロワーのユーザー一覧を表示する（アバター、表示名、ハンドル）
  - タップで対象ユーザーのプロフィール画面に遷移する
  - 無限スクロールでページネーションを実装する
  - エラー発生時のリトライ手段を表示する
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 10.4_

- [ ] 7.4 他ユーザープロフィール画面を実装する（タスク 6.2 の完了が前提）
  - フォロー関係がある場合にフルプロフィール（アバター、表示名、ハンドル、自己紹介、フォロー数、フォロワー数、本棚情報）を表示する
  - フォロー関係がある場合にフォロー解除ボタンを表示する
  - フォロー関係がない場合に制限付きプロフィール（アバター、表示名、ハンドルのみ）を表示し、本棚情報を非表示にする
  - フォロー関係がない場合にフォローリクエスト送信ボタンを表示する
  - リクエスト送信済み状態の表示を実装する
  - 自分のプロフィールの場合はフォロー関連の操作ボタンを表示しない
  - フォローリクエスト送信中・フォロー解除中のローディング状態を表示する
  - ネットワークエラー時のフィードバック表示とロールバックを実装する
  - _Requirements: 7.3, 7.5, 7.6, 8.1, 8.2, 8.3, 8.4, 8.5, 10.1, 10.3, 10.6_

- [ ] 7.5 既存プロフィール画面にフォロー数・招待リンクを統合する（タスク 6.1 の完了が前提）
  - プロフィール画面のヘッダーにフォロー数・フォロワー数を表示する
  - フォロー数タップでフォロー中ユーザー一覧画面に遷移する導線を追加する
  - フォロワー数タップでフォロワー一覧画面に遷移する導線を追加する
  - 招待リンク共有ボタンを追加し、OS シェアシートでプロフィールリンク（例: `https://shelfie.app/u/{handle}`）を共有できるようにする
  - フォロー操作後にフォロー数/フォロワー数の表示を即座に更新する
  - _Requirements: 5.1, 5.2, 6.1, 6.2, 6.3, 7.1, 7.2_

- [ ] 8. ボトムナビゲーションとルーティングの統合
- [ ] 8.1 ボトムナビゲーションにお知らせタブを追加する（タスク 7.1, 6.6 の完了が前提）
  - ボトムナビゲーションバーに「お知らせ」タブ（ベルアイコン）を追加する
  - タブ構成を [本棚, 検索, +追加, お知らせ, プロフィール] に変更する
  - 未読件数のバッジを表示する
  - _Requirements: 12.1, 12.6_

- [ ] 8.2 フォロー関連画面のルーティングを設定する（タスク 7.1, 7.2, 7.3, 7.4 の完了が前提）
  - お知らせ画面、フォローリクエスト一覧画面、フォロー/フォロワー一覧画面、他ユーザープロフィール画面への go_router ルートを追加する
  - お知らせ画面からフォローリクエスト一覧画面への遷移を設定する
  - プロフィール画面からフォロー/フォロワー一覧画面への遷移を設定する
  - フォロー/フォロワー一覧から他ユーザープロフィール画面への遷移を設定する
  - _Requirements: 3.2, 5.1, 5.2_

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
  - フォロー関係がある場合はフルプロフィール画面に遷移する
  - フォロー関係がない場合は制限付きプロフィール画面にフォローリクエスト送信ボタン付きで遷移する
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
  - 招待リンク共有 → ディープリンクでアプリ起動 → 制限付きプロフィール表示 → フォローリクエスト送信 → プッシュ通知受信 → お知らせ画面でリクエスト確認 → 承認 → フォロー関係成立 → フルプロフィール表示の一連のフローを確認する
  - フォロー解除 → 制限付きプロフィールに戻ることを確認する
  - お知らせタブの未読バッジが通知受信で増え、画面を開くと消えることを確認する
  - 各種エラーケース（ネットワークエラー、二重送信等）のフィードバックを確認する
  - _Requirements: 1.1, 1.5, 2.1, 2.3, 4.1, 4.3, 6.2, 6.3, 7.1, 7.2, 7.3, 7.5, 8.1, 8.3, 10.1, 10.2, 10.3, 10.4, 10.5, 10.6, 11.1, 11.3, 12.1, 12.4, 12.6, 12.7_

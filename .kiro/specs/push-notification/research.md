# Research & Design Decisions

---
**Purpose**: プッシュ通知機能の設計に必要な調査結果と意思決定の根拠を記録する。
---

## Summary
- **Feature**: push-notification
- **Discovery Scope**: New Feature（FCM 連携、DB スキーマ追加、CLI スクリプト、Flutter 側の通知受信）
- **Key Findings**:
  - `firebase-admin` は既に API の依存に含まれており、`admin.messaging().sendEachForMulticast()` で FCM 送信可能
  - モバイル側に `firebase_core` / `firebase_messaging` が未導入のため、新規セットアップが必要
  - `sendEachForMulticast` は最大 500 トークンまでのバッチ制限がある

## Research Log

### FCM 送信 API（firebase-admin Node.js SDK）
- **Context**: CLI スクリプトから FCM 経由でプッシュ通知を送信する方式を調査
- **Sources Consulted**:
  - [Firebase Admin SDK - Send a Message](https://firebase.google.com/docs/cloud-messaging/send/admin-sdk)
  - [firebase-admin-node GitHub Issues #2488](https://github.com/firebase/firebase-admin-node/issues/2488)
- **Findings**:
  - `sendMulticast()` は非推奨、`sendEachForMulticast()` に移行済み
  - 1 回の呼び出しで最大 500 トークンまで対応
  - 500 超のトークンは 500 件ずつチャンクに分割してバッチ送信が必要
  - レスポンスに `successCount` / `failureCount` と各トークンごとの結果が含まれる
  - `messaging/registration-token-not-registered` エラーで無効トークンを検出可能
- **Implications**:
  - `firebase-admin` ^13.6.0 は既に `package.json` に存在するため、追加依存は不要
  - バッチサイズ 500 でのチャンク処理をサービス層で実装する
  - 無効トークンの自動削除ロジックをレスポンスハンドリングに組み込む

### Flutter 側 FCM セットアップ
- **Context**: モバイルアプリでの通知受信と FCM トークン取得の方式を調査
- **Sources Consulted**:
  - [firebase_messaging pub.dev](https://pub.dev/packages/firebase_messaging)
  - [FlutterFire FCM Overview](https://firebase.flutter.dev/docs/messaging/overview/)
  - [Firebase Cloud Messaging Flutter Client Setup](https://firebase.google.com/docs/cloud-messaging/flutter/client)
- **Findings**:
  - `firebase_core` と `firebase_messaging` の両方が必要
  - `google-services.json`（Android）と `GoogleService-Info.plist`（iOS）は既にプロジェクトに存在
  - `FlutterFire CLI` (`flutterfire configure`) で `firebase_options.dart` を生成する必要がある
  - iOS では Xcode で Push Notifications capability と Background Modes（Remote notifications）の有効化が必要
  - Android 13+ と iOS では通知許可のリクエストが必要
  - フォアグラウンドでの通知表示には `firebase_messaging` の `setForegroundNotificationPresentationOptions`（iOS）と `flutter_local_notifications`（Android）が必要
- **Implications**:
  - 新規パッケージ依存: `firebase_core`, `firebase_messaging`, `flutter_local_notifications`
  - main.dart での Firebase 初期化処理追加
  - プラットフォーム固有の設定（Xcode, AndroidManifest）が必要

### フォアグラウンド通知の表示方式
- **Context**: アプリがフォアグラウンド時のプッシュ通知表示方法を調査
- **Sources Consulted**:
  - [FlutterFire Notifications](https://firebase.flutter.dev/docs/messaging/notifications/)
  - [flutter_local_notifications pub.dev](https://pub.dev/packages/flutter_local_notifications)
- **Findings**:
  - iOS: `setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true)` で OS レベルの通知表示が可能
  - Android: フォアグラウンドでは FCM が自動表示しないため、`flutter_local_notifications` で手動表示が必要
  - `flutter_local_notifications` で高優先度チャネルを作成し、heads-up 通知を実現
- **Implications**:
  - Android / iOS で異なるフォアグラウンド処理が必要
  - `flutter_local_notifications` の Android チャネル設定を初期化時に行う

### デバイストークン管理の API 設計
- **Context**: モバイルアプリからデバイストークンを登録・更新・削除する API 方式を調査
- **Sources Consulted**: 既存コードベース（GraphQL Mutation パターン）
- **Findings**:
  - 既存の Feature パターン（repository.ts + service.ts + graphql.ts）に従う
  - GraphQL Mutation で `registerDeviceToken` / `unregisterDeviceToken` を提供
  - 認証済みユーザーのみがトークン登録可能（`authScopes: { loggedIn: true }`）
  - 1 ユーザーが複数デバイスを持つため、user_id + device_token のユニーク制約
- **Implications**:
  - 新規テーブル `device_tokens` を Drizzle スキーマに追加
  - 既存の Feature モジュールパターンに沿った実装

### CLI スクリプトの実行方式
- **Context**: プッシュ通知送信用 CLI スクリプトの実装方式を調査
- **Sources Consulted**: 既存プロジェクト構成（`scripts/` ディレクトリ、`vite-node` 使用）
- **Findings**:
  - 既存の `scripts/` ディレクトリにはシェルスクリプトのみ存在
  - `vite-node` が dev 依存にあり、TypeScript スクリプトの直接実行が可能（`db:seed` タスクで `vite-node src/db/seed.ts` の前例あり）
  - CLI 引数パースには Node.js 組み込みの `parseArgs`（Node 18+）が利用可能
  - スクリプトは API サーバーと同じ DB 接続・Firebase 初期化コードを再利用できる
- **Implications**:
  - `apps/api/src/scripts/send-notification.ts` として TypeScript で実装
  - `vite-node` で実行、追加の CLI フレームワーク依存は不要
  - DB 接続と Firebase Admin の初期化コードを共有

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| 既存 Feature パターン拡張 | repository + service + graphql の 3 層構成を踏襲 | 一貫性、学習コスト低 | 特になし | 推奨 |
| 独立マイクロサービス | 通知専用サービスを分離 | スケーラビリティ | 運用コスト過大、現段階では不要 | 却下 |

## Design Decisions

### Decision: CLI スクリプト方式での通知送信
- **Context**: 通知送信のインターフェースとして CLI スクリプトを採用（Web 管理画面は初期スコープ外）
- **Alternatives Considered**:
  1. Web 管理画面 -- 開発コストが高く、初期フェーズでは不要
  2. API エンドポイント + cURL -- 認可の仕組みが必要
  3. CLI スクリプト -- スクリプト実行者 = 管理者とみなせる
- **Selected Approach**: TypeScript CLI スクリプトを `vite-node` で実行
- **Rationale**: 既存の `vite-node` 実行パターンがあり、DB・Firebase の初期化コードを再利用可能。認可不要でシンプル。
- **Trade-offs**: GUI がないため非エンジニアには使いにくい（将来的に管理画面を追加可能）
- **Follow-up**: 将来的な管理画面対応時は Service 層を共有して GraphQL エンドポイントを追加

### Decision: フォアグラウンド通知に flutter_local_notifications を使用
- **Context**: Android でフォアグラウンド中の通知表示が FCM 単体では不可能
- **Alternatives Considered**:
  1. アプリ内バナー（SnackBar / Overlay）-- OS 通知トレイに残らない
  2. `flutter_local_notifications` -- OS ネイティブ通知として表示
- **Selected Approach**: `flutter_local_notifications` を使用
- **Rationale**: OS ネイティブ通知として表示されるため、バックグラウンド時と一貫した UX を提供
- **Trade-offs**: 追加パッケージ依存、Android チャネル設定が必要
- **Follow-up**: なし

### Decision: GraphQL Mutation でデバイストークンを管理
- **Context**: モバイルアプリからデバイストークンをサーバーに登録する方式
- **Alternatives Considered**:
  1. REST API エンドポイント -- 既存アーキテクチャと不整合
  2. GraphQL Mutation -- 既存パターンに沿う
- **Selected Approach**: GraphQL Mutation（`registerDeviceToken` / `unregisterDeviceToken`）
- **Rationale**: 既存の認証ミドルウェア、Feature モジュールパターンをそのまま活用
- **Trade-offs**: 特になし
- **Follow-up**: なし

## Risks & Mitigations
- **FCM トークンの無効化検出遅延**: 通知送信時にのみ検出 → 送信時の自動削除で対応
- **大量ユーザーへの一斉送信パフォーマンス**: 500 件バッチ制限 → チャンク分割 + 逐次処理で対応
- **Firebase 未初期化でのモバイル起動失敗**: `Firebase.initializeApp()` の失敗ハンドリングを実装
- **iOS 通知許可の拒否**: 許可拒否時もアプリ機能に影響なし（通知が届かないだけ）

## References
- [Firebase Admin SDK - Send Messages](https://firebase.google.com/docs/cloud-messaging/send/admin-sdk)
- [firebase_messaging Flutter Package](https://pub.dev/packages/firebase_messaging)
- [FlutterFire FCM Overview](https://firebase.flutter.dev/docs/messaging/overview/)
- [flutter_local_notifications Package](https://pub.dev/packages/flutter_local_notifications)
- [Firebase Cloud Messaging Flutter Client Setup](https://firebase.google.com/docs/cloud-messaging/flutter/client)

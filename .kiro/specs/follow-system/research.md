# Research & Design Decisions

## Summary
- **Feature**: follow-system
- **Discovery Scope**: Complex Integration（新規フォロー機能 + 通知基盤拡張 + Web中間ページ + ディープリンク）
- **Key Findings**:
  - 既存の NotificationService / FCMAdapter をそのまま活用してフォローリクエスト通知を実装可能
  - 双方向フォロー関係は follows テーブル1行で表現し、正規化された user_id_a < user_id_b 制約で重複を防止
  - Universal Links / App Links は既存 Next.js Web アプリに `.well-known` 静的ファイルを追加するだけで対応可能

## Research Log

### フォロー関係のデータモデル設計
- **Context**: 双方向フォロー（承認制）の効率的なデータモデル検討
- **Sources Consulted**: PostgreSQL ドキュメント、ソーシャルグラフ設計パターン
- **Findings**:
  - **follow_requests テーブル**: sender_id, receiver_id, status (pending/approved/rejected), created_at, updated_at で管理。UNIQUE(sender_id, receiver_id) で重複防止
  - **follows テーブル**: follower_id, followee_id, created_at で一方向関係を表現。UNIQUE(follower_id, followee_id) で同方向の重複防止。CHECK(follower_id != followee_id) で自己フォロー防止
  - A→BとB→Aは独立したレコードとして管理（Instagram/X 型）
  - フォロー数は follows テーブルの COUNT で取得。初期スコープではカウンタキャッシュ不要（ユーザー規模が限定的）
- **Implications**: follows テーブルのクエリは方向付き（`WHERE follower_id = ?` / `WHERE followee_id = ?`）で OR 条件不要。旧モデルよりクエリ効率が向上

### 通知データモデル（お知らせタブ）
- **Context**: アプリ内通知履歴の永続化方式
- **Sources Consulted**: 既存 device-tokens Feature、push-notification steering
- **Findings**:
  - 既存の NotificationService はプッシュ通知送信のみ。アプリ内通知（お知らせ）は新規テーブルが必要
  - **notifications テーブル**: recipient_id, sender_id, type (follow_request_received/follow_request_approved), is_read, created_at で管理
  - 未読件数は `COUNT(*) WHERE recipient_id = ? AND is_read = false` で取得
  - ユーザー削除時のカスケード削除は FK 制約で自動対応
- **Implications**: notifications Feature を新設し、Follow Feature から呼び出す構成

### Universal Links / App Links
- **Context**: 招待リンク `https://shelfie.app/u/{handle}` でアプリを起動する仕組み
- **Sources Consulted**: Apple Developer Documentation (Universal Links)、Android Developer Documentation (App Links)、Next.js 静的ファイル配信
- **Findings**:
  - iOS: `/.well-known/apple-app-site-association` (AASA) ファイルを JSON 形式で配信。`applinks` セクションにドメインとパスパターンを定義
  - Android: `/.well-known/assetlinks.json` ファイルを配信。パッケージ名と署名フィンガープリントを記載
  - Next.js: `public/.well-known/` ディレクトリに静的ファイルを配置するか、API Route で動的に返す
  - Vercel: カスタムドメイン設定でSSL自動発行。`/.well-known` パスのキャッシュヘッダー設定が必要
- **Implications**: Web アプリ側の実装は最小限。モバイル側で go_router のディープリンク処理を追加

### 既存コードベースとの統合ポイント
- **Context**: 新規 Feature が既存パターンにどう適合するか
- **Sources Consulted**: コードベース分析（features/, graphql/, db/schema/）
- **Findings**:
  - API: Feature モジュールパターン（repository.ts, service.ts, graphql.ts + index.ts barrel export）に従う
  - GraphQL: Pothos の objectRef/inputRef パターン、ErrorsPlugin による Result 型エラーハンドリング
  - Mobile: Feature-first + Clean Architecture（domain/, data/, application/, presentation/）
  - 状態管理: Version Provider パターン（FollowVersion を新設し、フォロー操作後の画面更新を自動化）
  - Result 型: API 側は `Result<T, E>` 型、Mobile 側は `Either<Failure, T>` 型で統一されている
- **Implications**: 既存パターンを厳守。新規 Feature 追加時のチェックリスト（structure.md）に従う

### プッシュ通知連携
- **Context**: フォローリクエスト受信時のプッシュ通知送信方法
- **Sources Consulted**: 既存 push-notification steering、NotificationService 実装
- **Findings**:
  - `NotificationService.sendNotification()` に `userIds` と `title/body` を渡すだけで送信可能
  - `data` フィールドでカスタムペイロード（通知タイプ、リクエストID等）を送信可能
  - 無効トークンの自動削除、バッチ分割は既存実装が処理
  - 通知タップ時のルーティングは `NotificationTapHandler` で `data.route` を見て遷移
- **Implications**: Follow Service が NotificationService を直接呼び出す構成で十分。非同期キュー等の追加インフラは不要

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| Feature Module（採用） | 既存パターンに従い follows, notifications を独立 Feature として実装 | 既存パターンとの一貫性、並行開発が容易 | Feature 間の依存が follows → notifications で発生 | follows が notifications の公開 API 経由で呼び出す |
| 単一 Feature | フォロー + 通知を1つの Feature にまとめる | 依存関係が内部で完結 | 責務が肥大化、将来の通知拡張時に影響範囲が広い | 不採用 |

## Design Decisions

### Decision: 一方向フォロー関係のデータモデル

- **Context**: Instagram/X 型の一方向フォローモデルの関係データをどう格納するか
- **Alternatives Considered**:
  1. 1行正規化方式（user_id_a < user_id_b の1レコード）: 双方向前提。一方向フォローを表現不可能
  2. 方向付き2行方式（follower_id, followee_id）: A→BとB→Aを独立レコードで管理。一方向フォローを自然に表現
- **Selected Approach**: 方向付き2行方式（follower_id, followee_id）
- **Rationale**: Instagram/X 型の一方向フォローモデルを実現するには方向付きが必須。クエリも `WHERE follower_id = ?`（フォロー中一覧）/ `WHERE followee_id = ?`（フォロワー一覧）と単純で、OR 条件が不要になりパフォーマンスも向上
- **Trade-offs**: 相互フォロー時に2レコード必要。しかしストレージコストは無視できるレベル
- **Follow-up**: 既存データのマイグレーション（旧 user_id_a/user_id_b → 新 follower_id/followee_id）が必要

### Decision: お知らせ機能の Feature 分離

- **Context**: フォロー通知データの管理を Follow Feature 内に含めるか、独立 Feature にするか
- **Alternatives Considered**:
  1. Follow Feature 内に通知ロジックを含める
  2. 独立した Notifications Feature を新設
- **Selected Approach**: 独立した Notifications Feature を新設
- **Rationale**: 将来的にフォロー以外の通知種別（例: 本のレコメンド、アクティビティ通知）が追加される可能性が高い。Single Responsibility の原則に従い分離
- **Trade-offs**: Feature 間の依存が発生するが、公開 API（barrel export）経由のアクセスで疎結合を維持
- **Follow-up**: なし

### Decision: ボトムナビゲーション「お知らせ」タブの追加位置

- **Context**: 現在のタブ構成は [本棚, 検索, +追加, プロフィール] の4つ。お知らせタブをどこに追加するか
- **Alternatives Considered**:
  1. プロフィールの左（+追加の右）に配置: [本棚, 検索, +追加, お知らせ, プロフィール]
  2. 検索の右（+追加の左）に配置
- **Selected Approach**: プロフィールの左に配置（index 3→お知らせ, index 4→プロフィール）
- **Rationale**: SNSアプリの標準的なパターン（Instagram, Twitter等）に合致。お知らせはソーシャル機能の中核であり、プロフィール近くに配置することでユーザーの導線が自然
- **Trade-offs**: タブ数が5つになり、+追加ボタンが中央（index 2）に残る
- **Follow-up**: なし

### Decision: フォロー数の取得方式

- **Context**: フォロー数・フォロワー数を効率的に取得する方法
- **Alternatives Considered**:
  1. users テーブルにカウンタカラムを追加（follow_count, follower_count）
  2. follows テーブルの COUNT クエリで都度算出
- **Selected Approach**: follows テーブルの COUNT クエリで都度算出
- **Rationale**: 初期ユーザー規模（Phase 2）ではカウンタキャッシュの複雑性に見合わない。COUNT クエリはインデックスで十分高速
- **Trade-offs**: 大規模化時にパフォーマンス問題が顕在化する可能性
- **Follow-up**: ユーザー数が数万を超えた段階でカウンタキャッシュを検討

## Risks & Mitigations

- **データ整合性**: follow_requests の承認後に follows テーブルへの挿入が失敗するリスク → トランザクションで原子的に処理
- **通知の欠損**: プッシュ通知送信失敗時にアプリ内通知が作成されないリスク → アプリ内通知（notifications テーブル）を先に作成し、プッシュ通知送信は後続処理（失敗してもリクエスト自体には影響しない）
- **ディープリンクの未対応端末**: Universal Links / App Links 未対応ブラウザ → Web 中間ページでフォールバック表示（ストアリンク）
- **カスタムドメイン未取得**: shelfie.app ドメインの取得と DNS 設定が前提条件 → ドメイン取得を先行タスクとして管理

## References

- [Apple Universal Links](https://developer.apple.com/documentation/xcode/supporting-universal-links-in-your-app)
- [Android App Links](https://developer.android.com/training/app-links)
- [Next.js Static File Serving](https://nextjs.org/docs/app/building-your-application/optimizing/static-assets)
- [Drizzle ORM Documentation](https://orm.drizzle.team/docs/overview)
- [Pothos GraphQL Documentation](https://pothos-graphql.dev/)

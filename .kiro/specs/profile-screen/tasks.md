# Implementation Plan

- [x] 1. API: ステータス別冊数の一括取得メソッドを実装する
  - BookShelfRepository にステータス別冊数を1回の DB クエリで取得するメソッドを追加する
  - user_books テーブルに対して reading_status で GROUP BY し、全ステータスの冊数を非負整数で返却する
  - 該当ステータスの本がない場合は 0 を返す
  - ユニットテストで各ステータスの冊数が正確に返ること、本がないユーザーで全て 0 になることを検証する
  - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5_

- [x] 2. API: GraphQL User 型にステータス別冊数フィールドを追加する
  - User 型に readingCount, backlogCount, completedCount, interestedCount の4フィールドを Int! 型で追加する
  - 既存の bookCount リゾルバと同様のパターンで、countUserBooksByStatus の結果から各値を返却する
  - 同一リクエスト内で複数フィールドがクエリされても DB クエリが1回で済むよう、リゾルバ内キャッシュを実装する
  - GraphQL リゾルバのテストで正しい値が返ることを検証する
  - タスク 1 のメソッドに依存する
  - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5_

- [x] 3. Mobile: UserProfile エンティティにステータス別冊数フィールドを追加する
- [x] 3.1 (P) UserProfile の freezed クラスにステータス別冊数プロパティを追加する
  - readingCount, backlogCount, completedCount, interestedCount の4フィールドを追加する
  - guest() ファクトリの全カウントを 0 で初期化する
  - 既存の bookCount フィールドはそのまま維持する
  - freezed コード生成を再実行する
  - _Requirements: 3.1, 3.2, 3.3, 3.4_

- [x] 3.2 (P) GraphQL クエリとマッピングを更新する
  - GetMyProfile クエリに readingCount, backlogCount, completedCount, interestedCount を追加する
  - モバイル側の schema.graphql にステータス別冊数フィールドを追加する
  - AccountRepository の _mapToUserProfile を更新して新フィールドをマッピングする
  - Ferry のコード生成を再実行する
  - タスク 2 の API フィールド追加が完了している前提で、スキーマ定義に合わせる
  - _Requirements: 4.1, 4.2, 4.3, 4.4, 5.1_

- [x] 4. Mobile: ProfileNotifier を実装する
  - AsyncNotifier として ProfileNotifier を作成し、AccountRepository からプロフィールデータを取得する
  - build() 内で shelfVersionProvider を watch し、本棚変更時に自動再取得を行う
  - API エラー時は Failure を throw して AsyncValue.error にする
  - riverpod_annotation によるコード生成を実行する
  - ユニットテストで初回データ取得、ShelfVersion 変更時の再取得、エラー時の状態遷移を検証する
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 6.1_

- [x] 5. Mobile: プロフィール画面の UI コンポーネントを実装する
- [x] 5.1 (P) ProfileHeader ウィジェットを実装する
  - UserProfile を受け取り、アバター画像、表示名、@username 形式のユーザー名を表示する
  - アバター画像が未設定（null）の場合はデフォルトのアバターアイコンを表示する
  - 既存の UserAvatar ウィジェットを活用する
  - 純粋なプレゼンテーションウィジェットとして、状態管理に依存しない設計にする
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 6.3_

- [x] 5.2 (P) ReadingStatsSection ウィジェットを実装する
  - UserProfile を受け取り、読了・読書中・積読・気になるの4ステータスの冊数を数字+ラベルの横並び形式で表示する
  - 読書開始情報はプロフィール画面に表示しない
  - 既存の _StatItem パターンを参考にする
  - 純粋なプレゼンテーションウィジェットとして、状態管理に依存しない設計にする
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5, 6.3_

- [x] 6. Mobile: ProfileScreen を実装して既存のプレースホルダーを置換する
  - ConsumerWidget として ProfileNotifier を watch し、AsyncValue の when でローディング・エラー・データの3状態を切り分ける
  - データ取得成功時に ProfileHeader と ReadingStatsSection を描画する
  - ローディング中はローディングインジケーターを表示する
  - エラー時はエラー状態を表示する
  - 設定アイコンを配置し、タップでアカウント画面（/account）へ遷移する
  - userId が自分自身の場合のみ設定アイコンを表示する構造にする（Phase 2 対応準備）
  - 既存の ProfileScreen プレースホルダーを完全に置換する
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 2.1, 2.2, 3.1, 3.2, 3.3, 3.4, 3.5, 5.2, 5.3, 6.2_

- [x] 7. 結合テストとウィジェットテストで全体の動作を検証する
- [x] 7.1 ProfileScreen のウィジェットテストを実装する
  - ローディング時にインジケーターが表示されることを検証する
  - データ取得後にヘッダーと統計セクションが正しく描画されることを検証する
  - 設定アイコンタップで /account へ遷移することを検証する
  - _Requirements: 1.1, 1.2, 1.3, 2.1, 2.2, 5.2, 5.3_

- [ ]* 7.2 ProfileHeader のウィジェットテストを実装する
  - アバター、名前、@username が表示されることを検証する
  - アバター未設定時にデフォルトアイコンが表示されることを検証する
  - _Requirements: 1.1, 1.2, 1.3, 1.4_

- [ ]* 7.3 ReadingStatsSection のウィジェットテストを実装する
  - 4つのステータス別冊数が数字+ラベルで表示されることを検証する
  - _Requirements: 3.1, 3.2, 3.3, 3.4_

# Implementation Plan

- [x] 1. API 側の読了日更新ビジネスロジックを実装する
- [x] 1.1 (P) 読了日更新のサービスメソッドを追加する
  - BookShelfService に読了日を更新するメソッドを追加する
  - 対象の本の存在確認を行い、存在しない場合は BOOK_NOT_FOUND エラーを返す
  - 対象の本が認証ユーザーの所有であることを検証し、所有者でない場合は FORBIDDEN エラーを返す
  - 検証通過後、指定された日付で completedAt を更新し、更新後の UserBook を返す
  - 既存の updateRating / updateReadingNote と同一のパターン（所有者検証 + リポジトリ呼び出し + Result 型）を踏襲する
  - ユニットテストで正常系・BOOK_NOT_FOUND・FORBIDDEN の各ケースを検証する
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5_

- [x] 1.2 (P) 読書状態変更時の completedAt 保護ロジックを改修する
  - resolveCompletedAt 関数を改修し、現在の completedAt 値を引数として受け取るようにする
  - 読書状態を「読了」に変更する際、completedAt が null なら現在日時を自動設定する
  - 読書状態を「読了」に変更する際、completedAt が null でなければ既存値をそのまま保持する
  - 読書状態を「読了」以外に変更する際、completedAt をクリアせず保持する
  - updateReadingStatus 内の resolveCompletedAt 呼び出しに現在の completedAt を渡す
  - addBookToShelf 内の resolveCompletedAt 呼び出しにも同様の変更を適用する（新規追加時は null）
  - 既存テストを修正し、completedAt 保護の各パターンを検証する
  - _Requirements: 4.1, 4.2, 4.3_

- [x] 2. API 側の読了日更新 GraphQL Mutation を定義する
  - updateCompletedAt Mutation を GraphQL スキーマに追加する
  - 入力として userBookId（Int!）と completedAt（DateTime!）を受け取る
  - 認証済みユーザーのみアクセス可能にする（authScopes: loggedIn）
  - Firebase UID からユーザー ID を解決し、サービスメソッドに委譲する
  - 成功時は更新後の UserBook を返す
  - 既存の updateRating / updateReadingNote Mutation と同一の Resolver パターンを踏襲する
  - 統合テストで Mutation の E2E 動作を検証する
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 3.3_

- [x] 3. モバイル側の読了日更新データ層を実装する
- [x] 3.1 読了日更新の GraphQL Mutation 定義とコード生成を行う
  - update_completed_at.graphql ファイルを作成し、updateCompletedAt Mutation を定義する
  - 既存の update_rating.graphql / update_reading_status.graphql と同一のレスポンスフィールド構成にする
  - Ferry コード生成を実行して GUpdateCompletedAtReq / GUpdateCompletedAtData を生成する
  - _Requirements: 2.1_

- [x] 3.2 リポジトリに読了日更新メソッドを追加する
  - BookDetailRepository に updateCompletedAt メソッドを追加する
  - Ferry Client 経由で GraphQL Mutation を実行し、レスポンスを UserBook ドメインモデルに変換する
  - 既存の updateRating / updateReadingNote メソッドと同一のパターンを踏襲する
  - エラー時は適切な Failure 型に変換して Either で返す
  - _Requirements: 2.1, 2.5_

- [x] 4. モバイル側の状態管理とビジネスロジックを実装する
- [x] 4.1 ShelfState に読了日更新メソッドを追加する
  - updateCompletedAtWithApi メソッドを追加し、Optimistic Update パターンを実装する
  - API 呼び出し前に ShelfEntry の completedAt を即座に更新する
  - API 失敗時に元の状態にロールバックする
  - ShelfVersion の increment は不要（completedAt の変更は本棚の構成に影響しないため）
  - 既存の updateRatingWithApi / updateReadingNoteWithApi と同一のパターンを踏襲する
  - ユニットテストで成功時の状態更新と失敗時のロールバックを検証する
  - _Requirements: 1.2, 1.3_

- [x] 4.2 ShelfState の completedAt 解決ロジックを改修する
  - _resolveCompletedAt メソッドを改修し、現在の completedAt 値を引数として受け取るようにする
  - 読書状態を「読了」に変更する際、completedAt が null なら現在日時を設定する
  - 読書状態を「読了」に変更する際、completedAt が null でなければ既存値を保持する
  - 読書状態を「読了」以外に変更する際、completedAt を保持する
  - API 側の resolveCompletedAt と一貫したロジックにする
  - ユニットテストで各パターンを検証する
  - _Requirements: 4.1, 4.2, 4.3_

- [x] 4.3 BookDetailNotifier に読了日更新メソッドを追加する
  - updateCompletedAt メソッドを追加し、ShelfState の updateCompletedAtWithApi を呼び出す
  - ShelfState の存在確認後に操作を実行する
  - 既存の updateRating / updateReadingNote と同一のパターンを踏襲する
  - ユニットテストで ShelfState 経由の呼び出しを検証する
  - _Requirements: 1.2_

- [x] 5. モバイル側の読書記録セクション UI を改修する
  - 読書状態が「読了」の場合のみ、読了日行をタップ可能にする
  - 読書状態が「読了」以外の場合、読了日の編集機能を表示しない
  - 読了日行をタップした際に日付選択 UI（showDatePicker）を表示する
  - 日付選択 UI の最大日付を今日に設定し、未来の日付を選択できないようにする
  - 日付選択 UI の最小日付を十分過去の日付に設定し、追加日より前の日付も選択可能にする
  - 日付選択 UI の初期値を現在の読了日に設定する
  - 日付のみを対象とし、時刻の入力は求めない
  - 日付選択後に BookDetailNotifier の updateCompletedAt を呼び出す
  - 更新失敗時にエラーメッセージ（SnackBar）を表示する
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 3.1, 3.2, 3.3_

- [x]* 6. ウィジェットテストで読了日編集 UI の動作を検証する
  - 読了状態で読了日行がタップ可能であることを検証する
  - 読了以外の状態で読了日の編集機能が表示されないことを検証する
  - 日付選択後にコールバックが正しく呼び出されることを検証する
  - _Requirements: 1.1, 1.4_

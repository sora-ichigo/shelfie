# Implementation Plan

## Tasks

- [x] 1. 認証エラーコードの拡張
- [x] 1.1 (P) ログイン関連エラーコードを追加する
  - 既存の AuthErrorCode enum に INVALID_TOKEN, TOKEN_EXPIRED, USER_NOT_FOUND, UNAUTHENTICATED を追加
  - 各エラーコードに対応するメッセージと retryable フラグを定義
  - TOKEN_EXPIRED は retryable: true、その他は retryable: false として設定
  - _Requirements: 3.1, 3.2, 3.3_

- [x] 2. AuthService にログインユーザー取得機能を追加
- [x] 2.1 getCurrentUser メソッドを実装する
  - Firebase UID を受け取り、ローカルデータベースからユーザーを検索するロジックを追加
  - 既存の UserService.getUserByFirebaseUid() を呼び出してユーザー情報を取得
  - ユーザーが存在しない場合は USER_NOT_FOUND エラーを返却
  - 複数ユーザーが同一 Firebase UID を持つ異常ケースでは INTERNAL_ERROR を返却しログに記録
  - 認証操作のログ記録を追加（Firebase UID のみ、トークン自体は記録しない）
  - _Requirements: 1.1, 1.2, 4.1, 4.2, 4.3, 5.2_

- [x] 3. me Query の GraphQL 定義と Resolver 実装
- [x] 3.1 me Query を登録する関数を作成する
  - Pothos builder を使用して me Query を定義
  - MeResult union 型（User | AuthError）を返却するように設定
  - loggedIn スコープによる認可制御を適用（認証必須）
  - GraphQL Context から認証済みユーザー情報を取得
  - AuthService.getCurrentUser() を呼び出してユーザー情報を返却
  - 認証コンテキストが存在しない場合は UNAUTHENTICATED エラーを返却
  - _Requirements: 1.3, 1.4, 2.1, 2.2, 2.3, 5.4_

- [x] 4. GraphQL スキーマへの統合
- [x] 4.1 Auth Feature の GraphQL 型を スキーマビルドプロセスに登録する
  - 新規作成した registerAuthQueries 関数をスキーマ構築時に呼び出す
  - 拡張した AuthErrorCode が正しくスキーマに反映されることを確認
  - me Query がスキーマに含まれることを確認
  - _Requirements: 2.1_

- [x] 5. ユニットテストの実装
- [x] 5.1 (P) AuthService.getCurrentUser のユニットテストを作成する
  - 正常系: ユーザーが存在する場合に User オブジェクトを返却することを検証
  - 異常系: ユーザーが存在しない場合に USER_NOT_FOUND エラーを返却することを検証
  - 異常系: 複数ユーザーが同一 UID を持つ場合に INTERNAL_ERROR を返却することを検証
  - ログ記録が適切に行われることを検証（トークンが含まれていないこと）
  - _Requirements: 1.1, 1.2, 4.3, 5.2_

- [x] 5.2 (P) エラーコードマッピングのユニットテストを作成する
  - 新規追加した各エラーコードが正しく定義されていることを検証
  - retryable フラグが正しく設定されていることを検証（TOKEN_EXPIRED のみ true）
  - _Requirements: 3.1, 3.2, 3.3_

- [x] 6. 統合テストの実装
- [x] 6.1 me Query の統合テストを作成する
  - 有効なトークンでリクエストした場合にユーザー情報が返却されることを検証
  - Authorization ヘッダーなしでリクエストした場合に UNAUTHENTICATED エラーが返却されることを検証
  - 有効なトークンだがユーザーが存在しない場合に USER_NOT_FOUND エラーが返却されることを検証
  - Firebase ID Token のモック設定と GraphQL エンドポイントへのリクエスト実行
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 5.1, 5.3_

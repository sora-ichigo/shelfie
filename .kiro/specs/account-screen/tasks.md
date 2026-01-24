# Implementation Plan

## Tasks

- [ ] 1. API: データベーススキーマ拡張
- [x] 1.1 users テーブルにプロフィールカラムを追加するマイグレーション作成
  - `name` カラム（TEXT, NULL 許可）を追加
  - `avatar_url` カラム（TEXT, NULL 許可）を追加
  - Drizzle スキーマ定義を更新
  - マイグレーションファイルを生成して適用
  - _Requirements: 1.2, 2.4, 2.5_

- [x] 2. API: GraphQL スキーマ拡張
- [x] 2.1 User 型にプロフィールフィールドを追加
  - `name` フィールド（String, nullable）を追加
  - `avatarUrl` フィールド（String, nullable）を追加
  - 既存の me クエリで新フィールドが返却されることを確認
  - _Requirements: 1.2, 2.4, 2.5_

- [x] 2.2 プロフィール更新 Mutation を実装
  - `UpdateProfileInput` 入力型を定義（name: String!, avatar: Upload?）
  - `updateProfile` Mutation を実装
  - 氏名の空文字バリデーションを実装
  - 画像アップロード処理を実装（ファイルサイズ上限 5MB、形式バリデーション）
  - 成功時は更新された User を返却、失敗時は ValidationError を返却
  - _Requirements: 3.1, 4.4, 4.5_

- [x] 2.3 (P) メールアドレス変更リクエスト Mutation を実装
  - `RequestEmailChangeInput` 入力型を定義（newEmail: String!）
  - `requestEmailChange` Mutation を実装
  - メールアドレス形式バリデーションを実装
  - 既存メールアドレスとの重複チェックを実装
  - 確認メール送信処理を実装
  - 成功時は `EmailChangeRequested` を返却、失敗時は適切なエラー型を返却
  - _Requirements: 5.1, 5.3, 5.4_

- [x] 3. Mobile: Domain 層実装
- [x] 3.1 (P) UserProfile エンティティを作成
  - freezed によるイミュータブルクラスを定義
  - id, email, name, avatarUrl, username, bookCount, readingStartYear, createdAt フィールドを含める
  - `account` feature ディレクトリ配下に配置
  - _Requirements: 1.2, 2.4, 2.5_

- [x] 3.2 (P) ProfileValidators バリデーションルールを実装
  - `validateName` メソッドを実装（空文字チェック）
  - `validateEmail` メソッドを実装（形式バリデーション）
  - Pure Dart 関数として外部依存なしで実装
  - _Requirements: 3.6, 5.3_

- [x] 4. Mobile: Data 層実装
- [x] 4.1 GraphQL 操作定義ファイルを作成
  - `getMyProfile` クエリを定義（拡張された User 型を取得）
  - `updateProfile` Mutation を定義
  - `requestEmailChange` Mutation を定義
  - Ferry コード生成を実行
  - _Requirements: 1.2, 3.1, 5.1_

- [x] 4.2 AccountRepository を実装
  - BaseRepository を継承
  - `getMyProfile` メソッドを実装（Either<Failure, UserProfile> を返却）
  - `updateProfile` メソッドを実装（画像アップロード対応）
  - `requestEmailChange` メソッドを実装
  - Ferry 生成型から Domain 型への変換を実装
  - Riverpod Provider として公開
  - _Requirements: 1.2, 3.1, 4.4, 5.1_

- [x] 4.3 (P) ImagePickerService を実装
  - image_picker パッケージのラッパークラスを作成
  - `pickFromGallery` メソッドを実装
  - `pickFromCamera` メソッドを実装
  - Riverpod Provider として公開
  - _Requirements: 4.1, 4.2, 4.3_

- [x] 4.4 (P) プラットフォーム権限設定を追加
  - iOS: Info.plist に `NSPhotoLibraryUsageDescription`, `NSCameraUsageDescription` を追加
  - Android: AndroidManifest.xml に `CAMERA`, `READ_MEDIA_IMAGES` パーミッションを追加
  - _Requirements: 4.1, 4.2, 4.3_

- [x] 5. Mobile: Application 層実装
- [x] 5.1 ProfileFormState を実装
  - freezed による ProfileFormData クラスを定義（name, email, pendingAvatarImage, hasChanges）
  - ProfileFormState Notifier を実装
  - `initialize`, `updateName`, `updateEmail`, `setAvatarImage` メソッドを実装
  - バリデーション状態計算（nameError, emailError, isValid, hasEmailChanged）を実装
  - _Requirements: 2.4, 2.5, 2.6, 3.6_

- [x] 5.2 AccountNotifier を実装
  - AccountRepository からプロフィール情報を取得
  - AsyncValue<UserProfile> による状態管理を実装
  - `refresh` メソッドを実装
  - authStateProvider との連携を実装
  - _Requirements: 1.2_

- [x] 5.3 ProfileEditNotifier を実装
  - freezed による ProfileEditState sealed クラスを定義（initial, loading, success, error）
  - `save` メソッドを実装（バリデーション実行、API 呼び出し、結果ハンドリング）
  - `setAvatarImage` メソッドを実装
  - `reset` メソッドを実装
  - メールアドレス変更時は確認メール送信処理を呼び出す
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5, 4.4, 5.1, 5.2_

- [x] 6. Mobile: Presentation 層 - 共通ウィジェット
- [x] 6.1 (P) AccountHeader ウィジェットを実装
  - 「アカウント」タイトルを表示
  - 閉じるボタン（×）を配置し、タップで前画面に戻る
  - _Requirements: 1.1, 1.7_

- [x] 6.2 (P) ProfileCard ウィジェットを実装
  - ユーザーアバター、氏名、ユーザー名（@形式）を表示
  - 登録冊数、読書開始年を表示
  - UserProfile を受け取り表示に変換
  - _Requirements: 1.2_

- [x] 6.3 (P) AccountMenuSection ウィジェットを実装
  - セクションタイトルとメニュー項目リストを表示
  - 各メニュー項目に右矢印アイコン（>）を表示
  - バッジ表示に対応（プレミアムプラン、テーマ設定）
  - タップコールバックを受け取る
  - _Requirements: 1.3, 1.4, 1.5, 1.6, 6.5_

- [x] 6.4 (P) ProfileEditHeader ウィジェットを実装
  - 「プロフィール編集」タイトルを表示
  - 閉じるボタン（×）と保存ボタン（チェックマーク）を配置
  - 保存ボタンの有効/無効状態を制御可能にする
  - _Requirements: 2.2_

- [x] 6.5 (P) AvatarEditor ウィジェットを実装
  - 編集可能なアバター表示（鉛筆アイコン付き）
  - タップでボトムシート表示をトリガー
  - 選択済み画像のプレビュー表示
  - _Requirements: 2.3, 4.1_

- [x] 6.6 (P) ImageSourceBottomSheet ウィジェットを実装
  - カメラ撮影オプションを表示
  - ギャラリーから選択オプションを表示
  - 選択結果をコールバックで返却
  - _Requirements: 4.1_

- [x] 6.7 (P) ProfileEditForm ウィジェットを実装
  - 氏名入力フィールド（現在の氏名を初期値として表示）
  - メールアドレス入力フィールド（現在のメールアドレスを初期値として表示）
  - メールアドレス変更に関する注意書きを表示
  - バリデーションエラーメッセージを表示
  - _Requirements: 2.4, 2.5, 2.6_

- [ ] 7. Mobile: Presentation 層 - 画面実装
- [ ] 7.1 AccountScreen を実装
  - AccountHeader、ProfileCard、AccountMenuSection を組み合わせて画面を構築
  - AccountNotifier の AsyncValue を監視し、ローディング/エラー/データ表示を切り替え
  - 「アカウント」セクションに「プロフィール編集」「プレミアムプラン」を配置
  - 「設定」セクションに「通知設定」「パスワード設定」「テーマ」を配置
  - 各メニュー項目のタップで適切な画面に遷移（未実装画面はスタブ表示）
  - 既存の `_AccountScreen` プレースホルダーを置き換え
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 6.1, 6.2, 6.3, 6.4, 6.5_

- [ ] 7.2 ProfileEditScreen を実装
  - ProfileEditHeader、AvatarEditor、ProfileEditForm を組み合わせて画面を構築
  - ProfileEditNotifier と ProfileFormState を監視
  - ローディング中は保存ボタンを無効化し、インジケーターを表示
  - 保存成功時は画面を閉じてアカウント画面に戻る
  - エラー時はスナックバーでエラーメッセージを表示
  - 氏名が空の場合は保存ボタンを無効化
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 3.4, 3.5, 3.6, 4.2, 4.3_

- [ ] 7.3 アバター選択フローを統合
  - AvatarEditor タップで ImageSourceBottomSheet を表示
  - カメラ/ギャラリー選択後に ImagePickerService を呼び出し
  - 選択された画像を ProfileFormState に反映
  - アバタープレビューを更新
  - _Requirements: 4.1, 4.2, 4.3_

- [ ] 8. Mobile: ルーティング統合
- [ ] 8.1 プロフィール編集画面へのルートを追加
  - go_router に `/account/edit` ルートを追加
  - AccountScreen からの遷移を実装
  - プロフィール編集画面から戻る際の状態更新を処理
  - _Requirements: 2.1, 3.2, 3.3_

- [ ] 9. テスト実装
- [ ] 9.1 Domain 層のユニットテストを作成
  - ProfileValidators.validateName のテスト（空文字、有効な名前）
  - ProfileValidators.validateEmail のテスト（無効な形式、有効な形式）
  - _Requirements: 3.6, 5.3_

- [ ] 9.2 Application 層のユニットテストを作成
  - ProfileFormState のテスト（初期化、更新、バリデーション状態計算）
  - AccountNotifier のテスト（プロフィール取得成功/失敗）
  - ProfileEditNotifier のテスト（保存成功/失敗、メールアドレス変更）
  - _Requirements: 1.2, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 5.1, 5.2_

- [ ] 9.3 (P) 共通ウィジェットのウィジェットテストを作成
  - ProfileCard のテスト（プロフィール情報表示）
  - AccountMenuSection のテスト（メニュー項目表示、タップイベント）
  - AvatarEditor のテスト（タップでボトムシート表示）
  - ImageSourceBottomSheet のテスト（オプション表示、選択イベント）
  - _Requirements: 1.2, 1.3, 1.4, 1.5, 1.6, 4.1, 6.5_

- [ ] 9.4 画面のウィジェットテストを作成
  - AccountScreen のテスト（プロフィールカード表示、メニュー項目表示、ナビゲーション）
  - ProfileEditScreen のテスト（フォーム入力、バリデーションエラー表示、保存ボタン状態）
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 3.4, 3.5, 3.6_

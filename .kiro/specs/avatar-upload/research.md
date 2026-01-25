# Research & Design Decisions: Avatar Upload

## Summary

- **Feature**: avatar-upload
- **Discovery Scope**: Complex Integration
- **Key Findings**:
  - ImageKitはクライアントサイドアップロードをサポートし、署名付きパラメータで安全なアップロードが可能
  - 既存のusersテーブルにavatarUrlカラムが存在し、スキーマ変更不要
  - モバイルアプリにimage_pickerが導入済みで、画像選択UIは既存実装を活用可能

## Research Log

### ImageKit Client-Side Upload API

- **Context**: モバイルアプリからの画像アップロード方式の調査
- **Sources Consulted**:
  - [ImageKit Upload File API](https://imagekit.io/docs/api-reference/upload-file/upload-file)
  - [ImageKit API Keys](https://imagekit.io/docs/api-keys)
  - [ImageKit Node.js SDK](https://github.com/imagekit-developer/imagekit-nodejs)
- **Findings**:
  - クライアントサイドアップロードには`token`, `signature`, `expire`の3つのパラメータが必要
  - 署名はサーバー側でPrivate Keyを使用してHMAC-SHA1で生成
  - アップロードエンドポイント: `https://upload.imagekit.io/api/v1/files/upload`
  - レスポンスには`fileId`, `url`, `thumbnailUrl`等が含まれる
- **Implications**:
  - サーバー側で署名生成エンドポイントが必要
  - Private Keyはサーバー環境変数で管理
  - クライアントはマルチパートPOSTでアップロード

### ImageKit Node.js SDK

- **Context**: サーバー側での署名生成実装方法の調査
- **Sources Consulted**:
  - [imagekit npm package](https://www.npmjs.com/package/imagekit)
  - [GitHub: imagekit-nodejs](https://github.com/imagekit-developer/imagekit-nodejs)
- **Findings**:
  - `imagekit.getAuthenticationParameters()`で署名付きパラメータを自動生成
  - token, expire, signatureを含むオブジェクトを返却
  - tokenとexpireはオプションで、未指定時は自動生成
  - TypeScript型定義が提供されている
- **Implications**:
  - SDK使用により署名生成ロジックの実装不要
  - 型安全な開発が可能

### Flutter HTTP Multipart Upload

- **Context**: モバイルアプリからのファイルアップロード実装方法の調査
- **Sources Consulted**:
  - [Dart http package - MultipartRequest](https://pub.dev/documentation/http/latest/http/MultipartRequest-class.html)
  - [Flutter multipart file upload examples](https://dev.to/carminezacc/advanced-flutter-networking-part-1-uploading-a-file-to-a-rest-api-from-flutter-using-a-multi-part-form-data-post-request-2ekm)
- **Findings**:
  - `http.MultipartRequest`クラスでmultipart/form-dataリクエストを構築
  - `MultipartFile.fromPath(key, path)`でファイルを添付
  - `request.fields['key'] = 'value'`でテキストフィールドを追加
  - プログレス取得には`StreamedRequest`とカスタムストリーム処理が必要
- **Implications**:
  - 標準のhttp packageで実装可能（dio不要）
  - プログレス表示には追加実装が必要

### 既存コードベース分析

- **Context**: 既存のプロフィール編集機能との統合方法の調査
- **Sources Consulted**: プロジェクト内のソースコード
- **Findings**:
  - `users`テーブルに`avatar_url`カラムが既存（スキーマ変更不要）
  - `UserService.updateProfile`は既にavatarUrl更新をサポート
  - `image_picker`パッケージが導入済み
  - `ImagePickerService`が既存で画像選択機能を提供
  - `AvatarEditor`ウィジェットが既存でプレビュー表示をサポート
  - `ProfileFormState`が`pendingAvatarImage`をサポート
- **Implications**:
  - 多くの基盤が既存で、アップロードロジックの追加が主な作業
  - GraphQL schemaに`UpdateProfileInput`へのavatarUrl追加とgetUploadCredentials Queryの追加が必要

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| Server-side Upload | サーバー経由でImageKitにアップロード | シンプルな実装 | サーバー負荷増大、ファイルサイズ制限 | 却下 |
| Client-side Upload | モバイルからImageKitに直接アップロード | サーバー負荷軽減、大容量対応 | 署名生成エンドポイント必要 | 採用 |
| Signed URL | ImageKitのPresigned URLを使用 | セキュア | ImageKitが対応していない | 非対応 |

## Design Decisions

### Decision: クライアントサイドアップロード方式の採用

- **Context**: モバイルアプリからの画像アップロード方式の選定
- **Alternatives Considered**:
  1. サーバー経由アップロード - モバイル -> APIサーバー -> ImageKit
  2. クライアントサイドアップロード - モバイル -> ImageKit（署名はAPIサーバーで生成）
- **Selected Approach**: クライアントサイドアップロード
- **Rationale**:
  - サーバーの帯域・メモリ負荷を軽減
  - 大容量ファイルのアップロードに適している
  - ImageKit公式推奨の方式
- **Trade-offs**:
  - 署名生成のためのエンドポイント追加が必要
  - クライアント側の実装が若干複雑
- **Follow-up**: プログレス表示の実装方法を実装時に詳細検討

### Decision: Infraレイヤでの抽象化

- **Context**: ImageKit連携の実装場所と抽象化レベル
- **Alternatives Considered**:
  1. Feature内に直接実装
  2. 共通Infraレイヤで抽象化
- **Selected Approach**: Infraレイヤで抽象化（IImageUploadService）
- **Rationale**:
  - 将来的なサービス差し替え（Cloudinary, S3等）を容易にする
  - テスト時のモック差し替えが容易
  - 既存のClean Architectureパターンに準拠
- **Trade-offs**:
  - 初期実装コストが若干増加
  - 抽象化層のメンテナンスが必要
- **Follow-up**: なし

### Decision: http packageの使用（dioではなく）

- **Context**: FlutterでのHTTPマルチパートアップロード実装
- **Alternatives Considered**:
  1. http package（標準）
  2. dio package（高機能）
- **Selected Approach**: http package
- **Rationale**:
  - 既存プロジェクトでFerry（GraphQL）を使用しており、REST APIはこの機能のみ
  - 追加依存を最小限に抑える
  - シンプルなアップロード処理には十分
- **Trade-offs**:
  - プログレス取得の実装が若干複雑
  - dioの高度な機能（インターセプター等）は使用不可
- **Follow-up**: プログレス表示が技術的に困難な場合は不定プログレス（スピナー）で対応

## Risks & Mitigations

- **Risk**: ImageKit SDKのバージョン互換性問題
  - Mitigation: package.jsonでバージョンを固定、定期的なアップデート確認

- **Risk**: ネットワーク切断時のアップロード中断
  - Mitigation: リトライボタンの提供、部分アップロードの再開は対応しない（冪等な操作）

- **Risk**: ImageKit APIの変更
  - Mitigation: Infraレイヤの抽象化により影響範囲を限定

- **Risk**: 大容量ファイルによるメモリ不足（モバイル）
  - Mitigation: ファイルサイズ制限（5MB）、ストリーミングアップロード

## References

- [ImageKit Upload File API](https://imagekit.io/docs/api-reference/upload-file/upload-file) - 公式アップロードAPI仕様
- [ImageKit Node.js SDK](https://github.com/imagekit-developer/imagekit-nodejs) - サーバー側SDK
- [Dart http MultipartRequest](https://pub.dev/documentation/http/latest/http/MultipartRequest-class.html) - Flutterでのマルチパートリクエスト
- [Flutter multipart file upload](https://dev.to/carminezacc/advanced-flutter-networking-part-1-uploading-a-file-to-a-rest-api-from-flutter-using-a-multi-part-form-data-post-request-2ekm) - 実装例

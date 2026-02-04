# Research & Design Decisions

---
**Purpose**: 読了カード画像シェア機能のディスカバリ調査結果と設計判断の記録。
---

## Summary
- **Feature**: `book-share-image`
- **Discovery Scope**: Extension（既存アプリへの新機能追加）
- **Key Findings**:
  - Flutter の `RepaintBoundary` + `toImage()` が画像生成の標準手法であり、外部ライブラリ不要
  - `share_plus` ^10.1.3 は既に依存関係に含まれており、最新の `SharePlus.instance.share(ShareParams(...))` API を使用可能
  - 画像保存には `gal` パッケージ（v2.3.2）が最もモダンかつ軽量な選択肢

## Research Log

### Flutter Widget-to-Image 変換手法

- **Context**: 読了カードを Widget として構築し、それを PNG 画像に変換する手法の調査
- **Sources Consulted**:
  - [Flutter 公式 API: RenderRepaintBoundary.toImage()](https://api.flutter.dev/flutter/rendering/RenderRepaintBoundary/toImage.html)
  - [freeCodeCamp: Save and Share Flutter Widgets as Images](https://www.freecodecamp.org/news/how-to-save-and-share-flutter-widgets-as-images-a-complete-production-ready-guide/)
  - [DEV Community: Capturing Flutter Widget as Image](https://dev.to/jordanm_h/capturing-a-flutter-widget-as-an-image-using-repaintboundary-3k50)
- **Findings**:
  - `RepaintBoundary` + `GlobalKey` でウィジェットをラップし、`RenderRepaintBoundary.toImage()` で `ui.Image` に変換後、`toByteData(format: ui.ImageByteFormat.png)` で PNG バイトを取得
  - `pixelRatio: 3.0` で高品質な画像を生成可能（テキストの鮮明さに直結）
  - ウィジェットが完全にレンダリングされていることを確認する必要がある（`debugNeedsPaint` チェック）
  - CachedNetworkImage の画像はレンダリング前に読み込みが完了している必要がある
  - `screenshot` パッケージは高レベル API を提供するが、RepaintBoundary の直接使用で十分制御可能
- **Implications**:
  - 外部パッケージ追加不要で画像生成が可能
  - カード Widget をオフスクリーンで構築・レンダリングする設計が必要
  - 表紙画像のプリロードが画像生成の前提条件となる

### share_plus の現在の API

- **Context**: 既存依存関係 `share_plus: ^10.1.3` の最新 API 確認
- **Sources Consulted**:
  - [pub.dev: share_plus](https://pub.dev/packages/share_plus)
  - [share_plus GitHub](https://github.com/Tonbridge-Developers/share_plus)
- **Findings**:
  - 最新 API は `SharePlus.instance.share(ShareParams(...))` パターン
  - `ShareParams.files` に `XFile` のリストを渡して画像ファイルをシェア
  - iPad 対応には `sharePositionOrigin` パラメータが必須（クラッシュ防止）
  - 旧 API（`Share.shareXFiles`）は deprecated
  - 一時ファイルとして PNG を保存し、`XFile` として渡す設計が必要
- **Implications**:
  - 追加依存なしでシェア機能を実装可能
  - `path_provider` で一時ディレクトリを取得し、PNG ファイルを書き出す必要がある
  - iPad 対応のため、シェアボタンの位置情報を渡す設計を組み込む

### 画像保存パッケージの選定

- **Context**: 生成した画像をフォトライブラリに保存するパッケージの選定
- **Sources Consulted**:
  - [GitHub: gal](https://github.com/natsuk4ze/gal)
  - [pub.dev: flutter_image_gallery_saver](https://pub.dev/packages/flutter_image_gallery_saver)
  - [pub.dev: saver_gallery](https://pub.dev/packages/saver_gallery)
- **Findings**:
  - `gal` v2.3.2: BSD-3-Clause、LocalSend (60k stars) で採用実績、`putImage()`/`hasAccess()`/`requestAccess()` のシンプルな API
  - iOS: `NSPhotoLibraryAddUsageDescription` を Info.plist に追加
  - Android: SDK <= 29 で `WRITE_EXTERNAL_STORAGE` パーミッション必要、SDK 30+ は不要
  - `flutter_image_gallery_saver` と `saver_gallery` も候補だが、`gal` が最もシンプル
- **Implications**:
  - 新規依存として `gal: ^2.3.2` を追加
  - iOS/Android のパーミッション設定が必要
  - パーミッション拒否時のフォールバック UI を設計に含める

### SNS 最適画像サイズの調査

- **Context**: 主要 SNS プラットフォームで最適な画像サイズの確認
- **Findings**:
  - Instagram Stories: 1080x1920 (9:16)
  - Instagram 投稿 / X 投稿: 1080x1080 (1:1)
  - 汎用的なアスペクト比として 1:1 を採用し、まずは単一サイズで MVP を構築
  - 9:16 対応は将来の拡張として検討可能
- **Implications**:
  - Phase 1 では 1:1（1080x1080）の単一アスペクト比でシンプルに実装
  - Widget の論理サイズは 360x360 で構築し、`pixelRatio: 3.0` で 1080x1080 の PNG を生成

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| 新規 Feature モジュール | `features/book_share/` として独立した Feature を作成 | 既存コードへの影響最小、責務分離が明確 | book_detail との連携ポイントが増える | 既存の Feature-first パターンに準拠 |
| book_detail Feature 拡張 | 既存の `features/book_detail/` にシェア機能を追加 | 関連データへのアクセスが容易 | book_detail の肥大化、責務の混在 | 密結合のリスクあり |

**選定**: 新規 Feature モジュール (`features/book_share/`)。既存の Feature-first アーキテクチャに準拠し、book_detail との疎結合を維持する。

## Design Decisions

### Decision: 画像生成手法

- **Context**: 読了カードの Widget を PNG 画像に変換する手法の選定
- **Alternatives Considered**:
  1. `RepaintBoundary` + `toImage()` -- Flutter 標準 API を直接使用
  2. `screenshot` パッケージ -- 高レベル API で簡易化
  3. `widgets_to_image` パッケージ -- Widget キャプチャ専用
- **Selected Approach**: `RepaintBoundary` + `toImage()` を直接使用
- **Rationale**: 外部依存を増やさず、Flutter 標準 API で十分な制御が可能。プロジェクトのライブラリエコシステムガイドライン（車輪の再発明を避けつつ、標準 API で十分な場合は追加依存を避ける）に合致
- **Trade-offs**: ボイラープレートコードがやや多いが、デバッグと制御が容易
- **Follow-up**: 表紙画像のプリロードタイミングの最適化を実装時に検証

### Decision: カード画像のアスペクト比

- **Context**: SNS プラットフォームごとに最適なアスペクト比が異なる
- **Alternatives Considered**:
  1. 1:1 (1080x1080) のみ -- 最もシンプル、X / Instagram 投稿に最適
  2. 9:16 (1080x1920) のみ -- Instagram Stories に最適
  3. 両方対応 -- ユーザーが選択可能
- **Selected Approach**: Phase 1 では 1:1 (1080x1080) のみ
- **Rationale**: MVP としてシンプルさを優先。1:1 は X と Instagram 投稿の両方で見栄えが良い。9:16 は将来の拡張として Phase 1 後半で検討
- **Trade-offs**: Instagram Stories では最適ではないが、投稿として使用可能

### Decision: プログレッシブカードの状態管理

- **Context**: 3段階のカードレベル（シンプル / プロフィール付き / 感想共有）の状態をどう管理するか
- **Alternatives Considered**:
  1. Widget 内の local state で管理 -- シンプルだがテスタビリティが低い
  2. Riverpod Notifier で管理 -- テスタブルで既存パターンに準拠
- **Selected Approach**: Riverpod Notifier (`ShareCardNotifier`) で管理
- **Rationale**: 既存の Riverpod パターンに準拠し、カードレベルの切り替えロジックをテスト可能にする。ShelfEntry と BookDetail の両方を参照してカード利用可能レベルを決定するロジックが必要
- **Trade-offs**: ボイラープレートが増えるが、テスタビリティとメンテナンス性が向上

### Decision: 画像保存パッケージ

- **Context**: 生成した PNG 画像をフォトライブラリに保存するパッケージの選定
- **Alternatives Considered**:
  1. `gal` ^2.3.2 -- モダン、軽量、LocalSend 採用実績
  2. `saver_gallery` -- バッチ保存対応、HarmonyOS 対応
  3. `image_gallery_saver_plus` -- 多機能だが依存が重い
- **Selected Approach**: `gal` ^2.3.2
- **Rationale**: 最もシンプルな API（`putImage()`, `hasAccess()`, `requestAccess()`）、十分な採用実績、BSD-3-Clause ライセンス
- **Trade-offs**: HarmonyOS 非対応だが、現時点では対象外

## Risks & Mitigations

- **表紙画像の読み込み失敗** -- プレースホルダー画像を用意し、表紙なしでもカード生成可能にする（要件 2.7 で定義済み）
- **大きな表紙画像によるメモリ圧迫** -- pixelRatio を 3.0 に制限し、表紙画像は `CachedNetworkImage` のキャッシュを活用
- **iPad でのシェアシートクラッシュ** -- `sharePositionOrigin` パラメータを必ず渡す設計にする
- **フォトライブラリのパーミッション拒否** -- 拒否時にエラーメッセージを表示し、設定画面への誘導を行う

## References

- [Flutter API: RenderRepaintBoundary.toImage()](https://api.flutter.dev/flutter/rendering/RenderRepaintBoundary/toImage.html) -- 画像生成の公式 API
- [pub.dev: share_plus](https://pub.dev/packages/share_plus) -- OS シェアシート連携
- [GitHub: gal](https://github.com/natsuk4ze/gal) -- フォトライブラリ保存
- [docs/sns-share-strategy.md](../../docs/sns-share-strategy.md) -- SNS シェア戦略の意思決定ドキュメント

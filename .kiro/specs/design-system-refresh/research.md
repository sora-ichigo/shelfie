# Research & Design Decisions

## Summary
- **Feature**: `design-system-refresh`
- **Discovery Scope**: Extension（既存テーマシステムの大規模拡張）
- **Key Findings**:
  - Legacy トークン参照は 78 ファイル・600 箇所に分散しており、段階的移行が必須
  - Flutter の `ThemeExtension` は複数インスタンスの共存をサポートするため、Legacy と新トークンの並行運用が技術的に可能
  - ダーク→ライトモード切替は `ColorScheme` と `SystemUiOverlayStyle` の両方を変更する必要がある

## Research Log

### Flutter ThemeExtension の複数トークン共存
- **Context**: 新旧カラートークンを同じ `AppColors` クラスに共存させるか、別クラスに分離するかの判断
- **Findings**:
  - `ThemeExtension` は同一クラスのインスタンスを 1 つだけ保持する（型をキーとして解決）
  - 新旧トークンを同一クラスに統合するのが最もシンプル
  - Legacy プロパティと新プロパティをセクションで分離し、同一 `AppColors` に配置する方式が画面単位の段階的移行に適している
- **Implications**: `AppColors` クラスに新トークンフィールドを追加する設計を採用

### ダークモードからライトモードへの切替
- **Context**: 既存アプリはダークモードのみ。design.pen はライトモードベース
- **Findings**:
  - `ColorScheme.fromSeed` の `brightness` を `Brightness.light` に変更
  - `SystemUiOverlayStyle` を `light` から `dark` に変更（ライト背景にダークアイコン）
  - `scaffoldBackgroundColor`、`AppBarTheme`、`BottomNavigationBar` の配色をすべてライト基調に変更
  - Legacy 画面はダークモード前提の色を使用するため、移行期間中は視覚的に不整合が発生する可能性がある
- **Implications**: `AppTheme.light()` メソッドを新規追加し、移行完了まで `dark()` も残す。デフォルトを `light()` に切替える

### AppTypography の Legacy 化パターン
- **Context**: design.pen のタイポグラフィ定義は既存と一部異なる（display サイズの縮小等）
- **Findings**:
  - 現在の `AppTypography` は `abstract final class` で静的定数として定義
  - `displayLarge` 57px → 36px、`displayMedium` 45px → 36px（同値化）、`displaySmall` 36px → 36px（変更なし）
  - design.pen では display サイズの差が小さく、より控えめなスケール
  - AppColors と同じ Legacy パターン適用：既存スタイルに `Legacy` サフィックス → 新スタイルを元の名前で定義
- **Implications**: `AppTypography` をリファクタリングし、`ThemeExtension` 化は不要（TextTheme 経由で提供されるため）

### go_router タブナビゲーション拡張
- **Context**: 新規ホームタイムライン画面をタブに追加する必要がある
- **Findings**:
  - 現在の `StatefulShellRoute` は 3 ブランチ（検索、通知、プロフィール）
  - ホームタイムラインを最初のタブとして追加すると 4 ブランチに
  - `_addButtonIndex` のオフセット計算を調整する必要あり
  - 既存の `AppRoutes.home` は `/` でプロフィールにマッピング → ホームタイムラインに変更
- **Implications**: タブ構成の変更は既存ナビゲーションへの影響が大きいため、設計で明確に定義する

### オンボーディングフローのルーティング
- **Context**: 新規登録後にオンボーディング（名前入力→アバター選択→完了）を挟む
- **Findings**:
  - `guardRoute` の認証ガードにオンボーディング完了チェックを追加する必要がある
  - ユーザーの `onboardingCompleted` フラグを API から取得し、ルーティング判定に使用
  - オンボーディング画面は認証済み・オンボーディング未完了の場合にのみアクセス可能
- **Implications**: `AuthState` にオンボーディング完了状態を追加するか、別途 Provider で管理

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| 同一 AppColors 拡張 | Legacy と新トークンを同一クラスに共存 | シンプル、既存コード変更なし、ThemeExtension 制約に適合 | クラスが肥大化する | 採用。移行完了後に Legacy を削除して正常サイズに戻る |
| 別 ThemeExtension | 新トークンを別クラス（NewAppColors）で定義 | 関心の分離が明確 | 全画面でアクセスパターンが分岐、二重の extension アクセス | 不採用。開発体験が悪い |
| ColorScheme のみ | Material 3 の ColorScheme にすべて集約 | Flutter 標準準拠 | セマンティックカラー（tag-*, status-* 等）が ColorScheme に収まらない | 不採用。カスタムトークンが多すぎる |

## Design Decisions

### Decision: 新旧トークン共存方式
- **Context**: 78 ファイル 600 箇所の Legacy 参照を一括変更はリスクが高い
- **Alternatives Considered**:
  1. 全画面一括移行 -- 大規模な一括変更
  2. 段階的移行（同一クラス共存） -- Legacy と新トークンを AppColors に共存
  3. 段階的移行（別クラス分離） -- 別 ThemeExtension で分離
- **Selected Approach**: 段階的移行（同一クラス共存）
- **Rationale**: 既存コードへの影響ゼロで新トークンを追加でき、画面単位で安全に移行可能
- **Trade-offs**: AppColors クラスが一時的に肥大化するが、移行完了後に Legacy 削除で解消

### Decision: テーマモード切替戦略
- **Context**: ダークモードからライトモードへの切替
- **Alternatives Considered**:
  1. 即座にライトモードに切替 -- 全画面が一度にライトベースに
  2. AppTheme に light() を追加しデフォルトを切替 -- Legacy 画面は視覚的不整合を受容
  3. 画面単位で ThemeData をオーバーライド -- 各画面で Theme ウィジェットをラップ
- **Selected Approach**: AppTheme に light() を追加しデフォルトを切替
- **Rationale**: Legacy 画面はどのみち新カラーに移行するため、ベーステーマをライトに切替えてから各画面を順次対応するのが効率的。移行期間中の視覚的不整合は受容可能
- **Trade-offs**: Legacy 画面のダーク前提の色（白テキスト等）がライト背景上で見づらくなる期間が存在

### Decision: 新規 Feature ディレクトリ構成
- **Context**: ホームタイムライン、オンボーディング、レビュー作成等の新規 Feature を追加
- **Selected Approach**: 既存の Feature-first + Clean Architecture パターンに準拠
- **Rationale**: steering の mobile-tech.md で定義済みのパターン
- **Trade-offs**: なし（既存パターン踏襲）

## Risks & Mitigations
- **Risk 1**: Legacy 画面の視覚的不整合（ライトモード切替後） → 移行優先度の高い画面から順次対応。主要導線（認証→ホーム→検索）を最優先
- **Risk 2**: AppColors クラスの肥大化 → セマンティックカラーのグループ分け（コメントセクション）で可読性を維持。移行完了後に Legacy 削除
- **Risk 3**: タブナビゲーション構成変更の影響 → ホームタブ追加は既存タブのインデックスに影響。`_addButtonIndex` の調整をテストで検証

## References
- Flutter ThemeExtension -- https://api.flutter.dev/flutter/material/ThemeExtension-class.html
- Material Design 3 Color System -- https://m3.material.io/styles/color/system
- go_router StatefulShellRoute -- https://pub.dev/documentation/go_router/latest/go_router/StatefulShellRoute-class.html

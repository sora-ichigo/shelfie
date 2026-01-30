# Research & Design Decisions

---
**Purpose**: Capture discovery findings, architectural investigations, and rationale that inform the technical design.

**Usage**:
- Log research activities and outcomes during the discovery phase.
- Document design decision trade-offs that are too detailed for `design.md`.
- Provide references and evidence for future audits or reuse.
---

## Summary
- **Feature**: `liquid-glass-navigation`
- **Discovery Scope**: Extension（既存 UI レイヤーの差し替え + 新規外部依存の導入）
- **Key Findings**:
  - adaptive_platform_ui v0.1.101 は AdaptiveApp.router を提供し、go_router の routerConfig をそのまま受け入れる
  - AdaptiveNavigationDestination の icon は `dynamic` 型で、iOS では SF Symbol 文字列、Android では IconData を受け入れる
  - ネイティブ iOS 26 Liquid Glass 統合は実験的機能であり、useNativeBottomBar を有効にする際は制約を理解する必要がある

## Research Log

### adaptive_platform_ui パッケージの API 調査
- **Context**: 要件で指定されたパッケージの API 仕様と互換性を確認する必要がある
- **Sources Consulted**:
  - [pub.dev: adaptive_platform_ui](https://pub.dev/packages/adaptive_platform_ui)
  - [GitHub: berkaycatak/adaptive_platform_ui](https://github.com/berkaycatak/adaptive_platform_ui)
  - [pub.dev API docs](https://pub.dev/documentation/adaptive_platform_ui/latest/)
- **Findings**:
  - **バージョン**: 0.1.101（Dart SDK ^3.9.2 要求）
  - **AdaptiveApp.router**: routerConfig, materialLightTheme, materialDarkTheme, cupertinoLightTheme, cupertinoDarkTheme, themeMode, localizationsDelegates, supportedLocales をサポート
  - **AdaptiveScaffold**: appBar, bottomNavigationBar, body, floatingActionButton, minimizeBehavior, enableBlur, extendBodyBehindAppBar パラメータを持つ
  - **AdaptiveBottomNavigationBar**: items, selectedIndex, onTap, useNativeBottomBar パラメータを持つ
  - **AdaptiveNavigationDestination**: icon (dynamic), label (String), selectedIcon (dynamic), isSearch (bool), badgeCount (int?), addSpacerAfter (bool) プロパティを持つ
  - **PlatformInfo**: isIOS, isAndroid, isIOS26OrHigher(), isIOS18OrLower(), iOSVersion を提供
- **Implications**:
  - AdaptiveApp.router は RouterConfig<Object>? を受け取るため、GoRouter をそのまま渡すことが可能
  - Material テーマと Cupertino テーマを個別に設定する必要がある（現行は Material テーマのみ）
  - AdaptiveNavigationDestination の icon が dynamic 型であるため、プラットフォームに応じた値を渡す設計が必要

### Dart SDK バージョン互換性
- **Context**: adaptive_platform_ui が要求する Dart SDK ^3.9.2 と現行プロジェクトの SDK >=3.4.0 <4.0.0 の互換性
- **Sources Consulted**: pubspec.yaml, pub.dev パッケージページ
- **Findings**:
  - 現行プロジェクトの SDK 制約 `>=3.4.0 <4.0.0` は `^3.9.2` を含むが、実際のビルド環境が Dart 3.9.2 以上である必要がある
  - Flutter 3.x 系の最新安定版であれば Dart 3.9+ が含まれる
- **Implications**: SDK 制約の更新が必要な可能性がある。pubspec.yaml の environment.sdk を `>=3.9.2 <4.0.0` に引き上げる必要がある

### iOS SF Symbol とアイコンマッピング
- **Context**: 現行の _AppTabBar は CupertinoIcons を使用しているが、AdaptiveNavigationDestination は iOS 26+ で SF Symbol 文字列を要求する
- **Sources Consulted**: adaptive_platform_ui API ドキュメント、Apple SF Symbols リファレンス
- **Findings**:
  - `CupertinoIcons.book` / `CupertinoIcons.book_fill` → SF Symbol `'book.fill'`
  - `CupertinoIcons.search` → SF Symbol `'magnifyingglass'`
  - AdaptiveNavigationDestination の icon は dynamic 型のため、SF Symbol 文字列を直接渡す
  - Android では内部的に Material Icons にフォールバックされるが、icon に SF Symbol 文字列を渡した場合の Android 側の挙動を実装時に検証する必要がある
- **Implications**: 現行の IconData ベースのアイコン定義から SF Symbol 文字列ベースに変更が必要

### ネイティブ iOS 26 統合の制約
- **Context**: useNativeBottomBar を有効にした場合の制約を評価する
- **Sources Consulted**: GitHub README、pub.dev ドキュメント
- **Findings**:
  - ネイティブ UITabBar は Flutter のルートビューコントローラーを UITabBarController に置き換える
  - ウィジェットライフサイクル、ナビゲーションスタック、状態管理、ホットリロード、メモリリーク、ジェスチャー競合、フレーム同期に影響する可能性がある
  - 公式には「プロトタイピングとデモのみ推奨、本番非推奨」と明記
  - ただし AdaptiveScaffold のデフォルト設定（useNativeBottomBar のデフォルト値）で、Flutter ベースの Cupertino/Material レンダリングが基本的に使用される
- **Implications**: 初期実装では useNativeBottomBar をデフォルト（パッケージのデフォルト値に委任）で使用し、iOS 26 ネイティブ UITabBar の明示的有効化は見送る。パッケージ側の自動プラットフォーム検出に委譲する

### go_router との統合パターン
- **Context**: ShellRoute + タブナビゲーションのパターンが AdaptiveScaffold/AdaptiveBottomNavigationBar と互換性があるか検証
- **Sources Consulted**: pub.dev ドキュメント、GitHub issues
- **Findings**:
  - AdaptiveApp.router は routerConfig パラメータで GoRouter インスタンスを受け取る
  - ShellRoute の builder で AdaptiveScaffold を使用し、body に child を渡すパターンが可能
  - AdaptiveBottomNavigationBar の onTap コールバックで context.go() によるルート切り替えを実行
  - 既存の _calculateSelectedIndex ロジックはそのまま流用可能
- **Implications**: ルーティングロジック自体の変更は不要。ShellRoute の builder 内で Scaffold → AdaptiveScaffold、_AppTabBar → AdaptiveBottomNavigationBar に置き換えるだけで統合可能

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| UI レイヤー差し替え（採用） | Scaffold → AdaptiveScaffold、MaterialApp.router → AdaptiveApp.router への直接置き換え | 最小限の変更、既存ルーティングを維持、パッケージの設計意図に沿う | パッケージの安定性（v0.1.x）、SDK バージョン制約 | 要件に最も合致 |
| カスタム Platform Channel 実装 | 独自に iOS 26 Liquid Glass を Platform Channel で実装 | 完全な制御が可能 | 実装コスト大、メンテナンスコスト大、車輪の再発明 | steering の「車輪の再発明を避ける」原則に反する |
| Flutter 公式 Cupertino 対応待ち | Flutter SDK の公式 iOS 26 対応を待つ | 最も安定した選択肢 | タイムライン不明、flutter/flutter#170310 で議論中 | 要件の即時対応ができない |

## Design Decisions

### Decision: adaptive_platform_ui パッケージの採用
- **Context**: iOS 26 Liquid Glass デザインをナビゲーションに導入するための手段が必要
- **Alternatives Considered**:
  1. adaptive_platform_ui パッケージ -- プラットフォーム自動検出と適応型ウィジェットを提供
  2. liquid_glass_widgets パッケージ -- Shader ベースの Glassmorphism を提供するが、ネイティブ UIKit 統合なし
  3. 独自 Platform Channel 実装 -- 完全制御だが高コスト
- **Selected Approach**: adaptive_platform_ui を使用。要件で明示的に指定されており、AdaptiveApp.router / AdaptiveScaffold / AdaptiveBottomNavigationBar を提供
- **Rationale**: 要件で指定済み、パッケージが go_router 統合をサポート、プラットフォーム自動検出が組み込み、steering の「車輪の再発明を避ける」原則に合致
- **Trade-offs**: v0.1.x で安定性リスクあり、ネイティブ iOS 26 統合は実験的
- **Follow-up**: パッケージのバージョンアップを継続監視、破壊的変更への対応計画を維持

### Decision: テーマ設定の二重化（Material + Cupertino）
- **Context**: 現行は MaterialApp.router + ThemeData（ダークモードのみ）で統一。AdaptiveApp.router は Material テーマと Cupertino テーマを個別に要求
- **Alternatives Considered**:
  1. Material テーマのみ設定し、Cupertino テーマはパッケージのデフォルトに委任
  2. 既存の Material テーマを維持しつつ、対応する CupertinoThemeData を新規作成
- **Selected Approach**: Material テーマを維持し、最小限の CupertinoThemeData を作成。brightness のみ設定し、詳細なスタイリングは Material テーマから自動派生させる
- **Rationale**: 現行ダークモード固定の設計を維持しつつ、AdaptiveApp.router の API 要件を満たす。Cupertino テーマの詳細カスタマイズは将来のライトモード対応時に実施
- **Trade-offs**: iOS でのフォント等の細かいスタイリングがデフォルト値になるが、現時点では許容範囲
- **Follow-up**: ライトモード対応時に Cupertino テーマの詳細設定を追加

### Decision: ネイティブ iOS 26 UITabBar の使用方針
- **Context**: AdaptiveScaffold / AdaptiveBottomNavigationBar は useNativeBottomBar フラグでネイティブ UITabBar を有効化できるが、実験的機能として警告あり
- **Alternatives Considered**:
  1. useNativeBottomBar を明示的に true に設定（最大限の Liquid Glass 体験）
  2. パッケージのデフォルト値に委任（パッケージ側のプラットフォーム判定に任せる）
  3. useNativeBottomBar を明示的に false に設定（Flutter ベースレンダリングのみ）
- **Selected Approach**: パッケージのデフォルト値に委任。useNativeBottomBar を明示的に設定せず、adaptive_platform_ui の自動プラットフォーム検出に委ねる
- **Rationale**: パッケージの設計意図（Zero Configuration）に沿い、要件の「プラットフォーム判定を adaptive_platform_ui パッケージに委譲」に合致。明示的にフラグを設定するとパッケージの将来的な改善（安定性向上時の自動対応）の恩恵を受けられない
- **Trade-offs**: パッケージの判定ロジックに依存するため、挙動が不透明になる可能性がある
- **Follow-up**: パッケージの安定性が向上した段階で useNativeBottomBar: true を明示的に設定する判断を再検討

## Risks & Mitigations
- **パッケージ安定性リスク（v0.1.x）** -- バージョンを固定（`adaptive_platform_ui: ^0.1.101`）し、パッチアップデートのみ自動適用。破壊的変更への迅速な対応体制を維持
- **Dart SDK バージョン制約の引き上げ** -- CI/CD パイプラインで Flutter/Dart バージョンが要件を満たすことを確認。mise の設定を更新
- **テスト互換性** -- AdaptiveScaffold / AdaptiveApp は flutter_test 環境での動作が未検証。テストヘルパーの更新で対応し、パッケージ固有ウィジェットの find は型ベースではなくセマンティック要素ベースで実行
- **iOS 26 ネイティブ統合の制約** -- 初期実装ではパッケージのデフォルト挙動に委任し、ネイティブ統合の安定性が確認された段階で明示的に有効化

## References
- [adaptive_platform_ui | pub.dev](https://pub.dev/packages/adaptive_platform_ui) -- パッケージ公式ページ
- [adaptive_platform_ui | GitHub](https://github.com/berkaycatak/adaptive_platform_ui) -- ソースコードとドキュメント
- [adaptive_platform_ui API docs](https://pub.dev/documentation/adaptive_platform_ui/latest/) -- API リファレンス
- [Flutter #170310: iOS 26 Liquid Glass support](https://github.com/flutter/flutter/issues/170310) -- Flutter 公式の Liquid Glass 対応議論
- [Liquid Glass Resources: adaptive_platform_ui](https://www.liquidglassresources.com/development/flutter-adaptive-platform-ui/) -- 導入ガイド

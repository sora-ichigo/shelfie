# Implementation Plan

- [ ] 1. adaptive_platform_ui パッケージの依存追加と SDK 制約の更新
  - pubspec.yaml に adaptive_platform_ui パッケージを追加し、Dart SDK 制約を引き上げる
  - パッケージのインストールが成功し、既存の依存関係と競合しないことを確認する
  - _Requirements: 4.4_

- [ ] 2. Cupertino テーマの追加
  - AppTheme に CupertinoThemeData を返すゲッターを追加する
  - ダークモード（brightness: Brightness.dark）のみを設定し、詳細なスタイリングはデフォルトに委ねる
  - ShelfieApp から参照可能な形で公開する
  - _Requirements: 1.3_

- [ ] 3. ShelfieApp を AdaptiveApp.router に移行する
- [ ] 3.1 MaterialApp.router を AdaptiveApp.router に置き換える
  - ルートウィジェットを AdaptiveApp.router に変更する
  - 既存の GoRouter（routerConfig）をそのまま渡す
  - Material ダークテーマに既存の AppTheme.theme を設定する
  - Cupertino ダークテーマにタスク 2 で追加した CupertinoThemeData を設定する
  - _Requirements: 1.1, 1.2, 1.3_

- [ ] 3.2 Localization 設定を AdaptiveApp.router に移行する
  - 既存の localizationsDelegates と supportedLocales を AdaptiveApp.router のパラメータに渡す
  - アプリの多言語表示が従来通り動作することを確認する
  - _Requirements: 1.4_

- [ ] 4. MainShell を AdaptiveScaffold と AdaptiveBottomNavigationBar に移行する
- [ ] 4.1 Scaffold を AdaptiveScaffold に置き換える
  - ShellRoute の builder 内で Scaffold を AdaptiveScaffold に変更する
  - body に go_router の child ウィジェットをそのまま渡す
  - _Requirements: 3.1, 3.2_

- [ ] 4.2 カスタムタブバーを AdaptiveBottomNavigationBar に置き換える
  - _AppTabBar と _TabItem を削除し、AdaptiveBottomNavigationBar を使用する
  - 既存のタブ項目（ライブラリ、検索）を AdaptiveNavigationDestination として同一順序で定義する
  - アイコンに SF Symbol 文字列（book.fill、magnifyingglass）を設定する
  - _Requirements: 2.1, 2.2_

- [ ] 4.3 タブ選択とナビゲーション連携を実装する
  - 既存の _calculateSelectedIndex ロジックを維持し、selectedIndex として渡す
  - onTap コールバックで従来の context.go() によるタブ切り替えを実行する
  - 選択中タブの視覚的ハイライトが AdaptiveBottomNavigationBar により自動適用されることを確認する
  - _Requirements: 2.3, 2.4, 3.3_

- [ ] 4.4 プラットフォーム判定をパッケージに委譲する
  - アプリコード内にプラットフォーム手動分岐が存在しないことを確認する
  - adaptive_platform_ui の自動プラットフォーム検出に全面的に委ねる
  - iOS 26+ では Liquid Glass エフェクト、iOS 26 未満では Cupertino フォールバック、Android では Material Design が自動適用されることを動作確認する
  - _Requirements: 4.1, 4.2, 4.3, 4.4_

- [ ] 5. 既存ルーティングロジックの維持を確認する
  - go_router の全ルート定義が変更されていないことを確認する
  - StatefulShellRoute によるタブ間の状態保持が維持されていることを確認する
  - ディープリンクによるナビゲーションが従来通り動作することを確認する
  - 認証ガード（リダイレクトロジック）が従来通り動作することを確認する
  - ルーティング層（go_router）のコードに変更が加えられていないことを検証する
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_

- [ ] 6. テストの更新と回帰防止
- [ ] 6.1 ShelfieApp のテストを更新する
  - MaterialApp の型チェックを AdaptiveApp（または内部的に使用される MaterialApp/CupertinoApp）に更新する
  - routerConfig、テーマ、タイトルの検証を維持する
  - _Requirements: 6.2, 6.3_

- [ ] 6.2 MainShell のテストを更新する
  - Scaffold に関するアサーションを AdaptiveScaffold に更新する
  - タブが 2 つ（ライブラリ、検索）正しい順序で表示されることを検証する
  - タブ選択時に対応する画面に遷移することを検証する
  - _Requirements: 6.1, 6.2, 6.3_

- [ ] 6.3 テストヘルパーの互換性を確認する
  - buildTestWidget / buildTestWidgetWithRouter が新しいウィジェット構造で正常に動作することを確認する
  - 必要に応じてテスト用ラッパーを調整する
  - 既存の全テストがパスすることを確認する
  - _Requirements: 6.1, 6.2_

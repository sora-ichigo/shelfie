# Requirements Document

## Project Description (Input)
iOS 26 Liquid Glass ナビゲーション導入: adaptive_platform_ui パッケージを使用して、iOS 26 の Liquid Glass デザインをナビゲーションバー（ボトムタブバー）に導入する。go_router のルーティングロジックはそのまま維持し、UI レイヤーのみを差し替える。具体的には、(1) MaterialApp.router を AdaptiveApp.router に変更、(2) カスタム _AppTabBar を AdaptiveBottomNavigationBar に置き換え、(3) Scaffold を AdaptiveScaffold に変更する。iOS 26+ ではネイティブ UIKit の Liquid Glass エフェクト、それ以前では Cupertino フォールバック、Android では Material Design を自動切り替えする。

## Introduction
本ドキュメントは、Shelfie モバイルアプリに iOS 26 Liquid Glass デザインのナビゲーションを導入するための要件を定義する。adaptive_platform_ui パッケージを活用し、プラットフォームごとに最適な UI を自動提供しつつ、既存の go_router ルーティングロジックを維持する。

## Requirements

### Requirement 1: AdaptiveApp.router への移行
**Objective:** 開発者として、MaterialApp.router を AdaptiveApp.router に置き換えたい。それによりプラットフォームごとの適応型 UI 基盤を有効化できる。

#### Acceptance Criteria
1. The Shelfie App shall AdaptiveApp.router をルートウィジェットとして使用する
2. When AdaptiveApp.router に移行した場合、the Shelfie App shall 既存の go_router によるルーティング設定（routerConfig）をそのまま保持する
3. When AdaptiveApp.router に移行した場合、the Shelfie App shall 既存のテーマ設定（ThemeData）を維持する
4. When AdaptiveApp.router に移行した場合、the Shelfie App shall 既存の Localization 設定を維持する

### Requirement 2: AdaptiveBottomNavigationBar への置き換え
**Objective:** ユーザーとして、プラットフォームに最適化されたボトムナビゲーションバーを利用したい。それにより各 OS のネイティブ体験に沿った操作ができる。

#### Acceptance Criteria
1. The Shelfie App shall カスタム _AppTabBar を AdaptiveBottomNavigationBar に置き換える
2. The Shelfie App shall 既存の全タブ項目（アイコン・ラベル）を AdaptiveBottomNavigationBar 上で同一の順序で表示する
3. When ユーザーがタブを選択した場合、the Shelfie App shall go_router の StatefulShellRoute による画面遷移を従来通り実行する
4. When タブが選択された場合、the Shelfie App shall 選択中のタブを視覚的にハイライト表示する

### Requirement 3: AdaptiveScaffold への変更
**Objective:** 開発者として、Scaffold を AdaptiveScaffold に変更したい。それにより各プラットフォームに適したレイアウト構造を自動適用できる。

#### Acceptance Criteria
1. The Shelfie App shall タブナビゲーションを含むシェル画面で AdaptiveScaffold を使用する
2. When AdaptiveScaffold を使用した場合、the Shelfie App shall body 領域に go_router の子ウィジェットを正しく表示する
3. The Shelfie App shall AdaptiveScaffold と AdaptiveBottomNavigationBar を統合して動作させる

### Requirement 4: プラットフォーム別 UI 自動切り替え
**Objective:** ユーザーとして、使用中のプラットフォームに最適な UI デザインが自動的に適用されてほしい。それによりネイティブアプリとして自然な体験が得られる。

#### Acceptance Criteria
1. While iOS 26 以上のデバイスで実行中、the Shelfie App shall ネイティブ UIKit の Liquid Glass エフェクトをナビゲーションバーに適用する
2. While iOS 26 未満のデバイスで実行中、the Shelfie App shall Cupertino スタイルのフォールバック UI を表示する
3. While Android デバイスで実行中、the Shelfie App shall Material Design スタイルのナビゲーションバーを表示する
4. The Shelfie App shall プラットフォーム判定を adaptive_platform_ui パッケージに委譲し、アプリコード内での手動分岐を行わない

### Requirement 5: 既存ルーティングロジックの維持
**Objective:** 開発者として、UI レイヤーの差し替えによって既存のルーティングロジックが破壊されないことを保証したい。それにより安全にリファクタリングを進められる。

#### Acceptance Criteria
1. The Shelfie App shall go_router の全ルート定義を変更なく維持する
2. The Shelfie App shall StatefulShellRoute によるタブ間の状態保持を維持する
3. The Shelfie App shall ディープリンクによるナビゲーションを従来通り動作させる
4. The Shelfie App shall 認証ガード（リダイレクトロジック）を従来通り動作させる
5. If UI 置き換え後にルーティングの不具合が発生した場合、the Shelfie App shall ルーティング層（go_router）のコードを変更せず UI 層のみで解決する

### Requirement 6: 既存機能の回帰防止
**Objective:** 開発者として、UI レイヤーの変更が既存機能に悪影響を与えないことを確認したい。それによりリリース品質を担保できる。

#### Acceptance Criteria
1. The Shelfie App shall 全画面の表示・操作が UI 置き換え後も正常に動作する
2. The Shelfie App shall 既存のウィジェットテストが UI 置き換え後もパスする、またはアダプティブウィジェットに対応する形で更新する
3. If テストが AdaptiveScaffold や AdaptiveBottomNavigationBar の導入により失敗した場合、the Shelfie App shall 新しいウィジェット構造に対応したテストを提供する

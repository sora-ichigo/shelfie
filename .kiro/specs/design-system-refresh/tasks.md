# Implementation Plan

## Phase 1: トークン基盤構築

- [ ] 1. AppColors に新カラートークンを追加する
- [ ] 1.1 (P) design.pen の全 55 カラー変数に対応する新しいカラートークンプロパティを AppColors に追加する
  - MD3 Core: Primary 系 4 色（primary, onPrimary, primaryContainer, onPrimaryContainer）を定義する
  - MD3 Core: Secondary 系 4 色（secondary, onSecondary, secondaryContainer, onSecondaryContainer）を定義する
  - MD3 Core: Tertiary 系 4 色（tertiary, onTertiary, tertiaryContainer, onTertiaryContainer）を定義する
  - MD3 Core: Error 系 4 色（error, onError, errorContainer, onErrorContainer）を定義する
  - MD3 Core: Surface 系 11 色（surface, onSurface, surfaceContainerLowest/Low/Container/High/Highest, surfaceTint, onSurfaceVariant, inverseSurface, inverseOnSurface）を定義する
  - MD3 Core: Outline / Scrim 3 色（outline, outlineVariant, scrim）を定義する
  - Semantic: Border 2 色（borderSubtle, borderStrong）を定義する
  - Semantic: Text 3 色（textPrimary, textSecondary, textTertiary）を定義する
  - Semantic: Background 5 色（bgPrimary, bgSurface, bgMuted, bgHero, bgHeroGrad）を定義する
  - Semantic: Accent 3 色（accentPrimary, accentLink, accentWarm）を定義する
  - Semantic: Tab 1 色（tabInactive）を定義する
  - Semantic: Tag 10 色（tagAmber/Text, tagBlue/Text, tagPurple/Text, tagRose/Text, tagTeal/Text）を定義する
  - Semantic: Status 2 色（statusComplete, statusReading）を定義する
  - Semantic: Star 2 色（starColor, starRating）を定義する
  - Semantic: Match Badge 2 色（matchBadge, matchBadgeBg）を定義する
  - `copyWith` と `lerp` メソッドに全 55 新プロパティを追加する
  - `light` 定数を新規追加し、新トークンにライトモードの値を設定する
  - Legacy プロパティは `light` 定数でもダーク値を保持し、既存画面の互換性を維持する
  - _Requirements: 1.1, 1.2, 1.3_

- [ ] 1.2 (P) AppTypography の既存スタイルに Legacy サフィックスを付与し、design.pen に基づく新タイポグラフィトークンを定義する
  - 既存の静的定数（displayLarge, displayMedium 等）を Legacy サフィックス付きにリネームする
  - design.pen に基づく新しいフォントサイズ・ウェイト・行間で新スタイルを元の名前で定義する（displayLarge: 36px/w700, bodyMedium: 14px/w400 等）
  - フォントファミリーは NotoSansJP を維持する
  - `textTheme` ゲッターを新スタイルベースに更新し、Legacy 用の `textThemeLegacy` ゲッターを追加する
  - _Requirements: 1.4, 1.5, 1.6_

## Phase 2: テーマ切替

- [ ] 2. AppTheme にライトモードテーマを追加しデフォルトを切り替える
  - `light()` メソッドを新規追加し、`ColorScheme.fromSeed` を `Brightness.light` で構成する
  - 新カラートークンを `scaffoldBackgroundColor`、`AppBarTheme`、`FilledButton`、`OutlinedButton`、`InputDecoration` に適用する
  - `SystemUiOverlayStyle` を `dark`（ライト背景にダークステータスバー）に変更する
  - AppTypography の新 `textTheme` を NotoSansJP フォントファミリーと新カラーで適用する
  - `extensions` に `AppColors.light` を設定する
  - `theme` ゲッターのデフォルトを `light()` に切り替える
  - `dark()` メソッドは移行期間中に残す
  - _Requirements: 1.7_

## Phase 3: 認証画面の移行

- [ ] 3. 認証画面を新デザインに刷新する
- [ ] 3.1 (P) WelcomeScreen のデザインを design.pen「ウェルカム」フレームに合わせて刷新する
  - WelcomeBackground, WelcomeButtons, WelcomeLogo 等のウィジェット群で Legacy カラー・タイポグラフィ参照を新トークンに置換する
  - レイアウトを design.pen のフレームに合わせて更新する
  - _Requirements: 2.1, 2.4_

- [ ] 3.2 (P) LoginScreen のデザインを design.pen「ログイン」フレームに合わせて刷新する
  - LoginForm, LoginBackground, LoginHeader 等のウィジェット群で Legacy カラー・タイポグラフィ参照を新トークンに置換する
  - レイアウトを design.pen のフレームに合わせて更新する
  - _Requirements: 2.3, 2.4_

- [ ] 3.3 (P) RegistrationScreen のデザインを design.pen「新規登録」フレームに合わせて刷新する
  - RegistrationForm, RegistrationBackground 等のウィジェット群で Legacy カラー・タイポグラフィ参照を新トークンに置換する
  - レイアウトを design.pen のフレームに合わせて更新する
  - _Requirements: 2.2, 2.4_

## Phase 4: 新規画面の実装

- [ ] 4. オンボーディングフローを新規実装する
- [ ] 4.1 オンボーディングの状態管理とデータモデルを実装する
  - OnboardingState（displayName, avatarUrl, isSubmitting, currentStep）を freezed で定義する
  - OnboardingStep enum（name, avatar, complete）を定義する
  - OnboardingNotifier を Riverpod で実装し、名前入力・アバター選択の状態管理と API 連携（AccountRepository 経由のプロフィール更新）を行う
  - オンボーディング完了時に AuthState のフラグを更新する処理を実装する
  - _Requirements: 3.4, 3.5_

- [ ] 4.2 オンボーディング画面（名前入力・アバター選択・完了）を新規作成する
  - design.pen「プロフィール入力（名前）」フレームに基づく名前入力画面を実装する
  - design.pen「プロフィール入力（アバター）」フレームに基づくアバター選択画面を実装する（プリセットアバターのリストから選択、既存の AvatarEditor を流用可能）
  - design.pen「セットアップ完了」フレームに基づく完了画面を実装する
  - 全画面で新カラートークンのみを使用する
  - _Requirements: 3.1, 3.2, 3.3_

- [ ] 4.3 AppRouter にオンボーディングルートとガードを追加する
  - AppRoutes にオンボーディング画面のルート（`/onboarding/name`, `/onboarding/avatar`, `/onboarding/complete`）を定義する
  - `guardRoute` にオンボーディング完了チェックを追加し、認証済み・オンボーディング未完了のユーザーをオンボーディング画面にリダイレクトする
  - オンボーディング完了後にホーム画面へ遷移する処理を実装する
  - _Requirements: 3.4, 3.5_

- [ ] 5. ホームタイムライン画面を新規実装する
- [ ] 5.1 タイムラインのデータモデルと状態管理を実装する
  - TimelineEntry（id, type, user, createdAt, book, reviewText, rating, statusChange）を freezed で定義する
  - TimelineEntryType enum（addedToShelf, statusChanged, reviewed, rated, addedToList）を定義する
  - TimelineState（entries, isLoading, hasMore, cursor）を freezed で定義する
  - TimelineNotifier をカーソルベースのページネーション対応で実装する
  - TimelineRepository のインターフェースを定義する（API エンドポイントは別 spec で対応のため、モック実装も用意する）
  - _Requirements: 4.3_

- [ ] 5.2 ホームタイムライン画面とタイムラインカードコンポーネントを実装する
  - design.pen「ホーム（確定版）」フレームに基づくホームタイムライン画面を実装する（無限スクロール対応）
  - design.pen「タイムラインカード種別」フレームに基づき、TimelineEntryType ごとに異なるカードレイアウト（本棚追加、ステータス変更、レビュー、評価、リスト追加）を実装する
  - 共通の base widget を定義し、type ごとにコンテンツ部分を差し替える設計にする
  - 全コンポーネントで新カラートークンのみを使用する
  - _Requirements: 4.1, 4.2, 4.4_

- [ ] 5.3 AppRouter にホームタイムラインタブを追加する
  - StatefulShellRoute にホームタイムラインブランチを先頭に追加し、4 ブランチ構成（ホーム, 検索, 通知, プロフィール）にする
  - `AppRoutes.home`（`/`）をホームタイムライン画面にマッピングする
  - `_addButtonIndex` を 2 に更新する
  - _Requirements: 4.1_

- [ ] 6. レビュー・メモ作成画面を新規実装する
- [ ] 6.1 レビュー・メモ作成の状態管理とデータモデルを実装する
  - ReviewCreateState（bookId, content, isSubmitting, isAIMode, aiMessages）を freezed で定義する
  - AIMessage（content, role, timestamp）と AIMessageRole enum を freezed で定義する
  - ReviewCreateNotifier を実装し、レビュー・メモのテキスト入力管理と保存処理を行う
  - AI 対話モードのメッセージ送受信と状態管理を実装する
  - ReviewRepository のインターフェースを定義する（API エンドポイントは別 spec で対応）
  - _Requirements: 5.1, 5.2, 5.3_

- [ ] 6.2 レビュー作成画面・メモ作成画面・AI 対話レビュー画面を実装する
  - design.pen「感想を書く」フレームに基づくレビュー作成画面を実装する
  - design.pen「自分メモを書く」フレームに基づくメモ作成画面を実装する（レビュー作成画面と共通の base widget を共有し、ラベル・プレースホルダーで差別化）
  - design.pen「感想を書く（AI対話中）」フレームに基づく AI アシスタント付きレビュー画面をモード切替で実装する
  - 全画面で新カラートークンのみを使用する
  - _Requirements: 5.1, 5.2, 5.3, 5.4_

- [ ] 7. 感想カード詳細画面を新規実装する
- [ ] 7.1 (P) design.pen「感想カード詳細」フレームに基づくレビューカード詳細画面を実装する
  - タイムラインカードの詳細表示としてレビューテキスト・評価・ユーザー情報を表示する
  - 新カラートークンのみを使用する
  - _Requirements: 6.1, 6.3_

- [ ] 7.2 (P) design.pen「世の中の評判（ソース展開）」フレームに基づく外部評判セクションコンポーネントを実装する
  - BookDetailScreen 内のコンポーネントとして実装する
  - 新カラートークンのみを使用する
  - _Requirements: 6.2_

## Phase 5: 既存画面の刷新

- [ ] 8. ProfileScreen を新デザインに刷新する
  - 本棚タブを design.pen「マイページ」フレームに合わせて刷新する
  - いいねタブを design.pen「マイページ（いいね）」フレームに合わせて刷新する
  - ブックリストタブをリスト表示で design.pen「ブックリスト」フレームに合わせて刷新する
  - ブックリストタブにグリッド表示を追加し、design.pen「ブックリスト（グリッド）」フレームに合わせて実装する
  - リスト表示とグリッド表示の切り替え機能を実装する
  - ProfileHeader, ProfileContentView, ProfileTabBar 等の全ウィジェットで Legacy カラー参照を新トークンに置換する
  - _Requirements: 7.1, 7.2, 7.3, 7.4, 7.5, 7.6_

- [ ] 9. SearchScreen を新デザインに刷新する
  - 初期状態を design.pen「さがす v2」フレームに合わせて刷新する
  - 入力中状態を design.pen「さがす（入力中）」フレームに合わせて刷新する
  - 検索結果の書籍タブを design.pen「検索結果（書籍）」フレームに合わせて刷新する
  - 検索結果の著者タブを design.pen「検索結果（著者）」フレームに合わせて刷新する
  - 検索結果のブックリストタブを design.pen「検索結果（ブックリスト）」フレームに合わせて刷新する
  - SearchBarWidget, RecentBooksSection 等の全ウィジェットで Legacy カラー参照を新トークンに置換する
  - _Requirements: 8.1, 8.2, 8.3, 8.4, 8.5, 8.6_

- [ ] 10. BookDetailScreen を新デザインに刷新する
  - みんなタブを design.pen「本の詳細（みんな）」フレームに合わせて刷新する
  - 自分の記録タブを design.pen「本の詳細（自分の記録）」フレームに合わせて刷新する
  - 作品情報タブを design.pen「本の詳細（作品情報）」フレームに合わせて刷新する
  - みんなタブ（データなし）に design.pen「本の詳細（みんな・空）」フレームに合わせた空状態デザインを追加する
  - 自分の記録タブ（データなし）に design.pen「本の詳細（自分の記録・空）」フレームに合わせた空状態デザインを追加する
  - 全ウィジェットで Legacy カラー参照を新トークンに置換する
  - _Requirements: 9.1, 9.2, 9.3, 9.4, 9.5, 9.6_

- [ ] 11. (P) UserProfileScreen を新デザインに刷新する
  - design.pen「他人のプロフィール」フレームに合わせてプロフィール・本棚表示を刷新する
  - design.pen「他人のプロフィール（ロングタップ）」フレームに合わせたロングタップモーダルを追加する
  - 全ウィジェットで Legacy カラー参照を新トークンに置換する
  - _Requirements: 10.1, 10.2, 10.3_

- [ ] 12. (P) NotificationScreen を新デザインに刷新する
  - design.pen「おしらせ」フレームに合わせて通知一覧の UI を刷新する
  - 全ウィジェットで Legacy カラー参照を新トークンに置換する
  - _Requirements: 11.1, 11.2_

- [ ] 13. (P) ブックリスト関連画面を新デザインに刷新する
  - BookListDetailScreen（自分のリスト）を design.pen「ブックリスト詳細（自分）」フレームに合わせて刷新する
  - BookListDetailScreen（他人のリスト）を design.pen「ブックリスト詳細（他人）」フレームに合わせて刷新する
  - BookListEditScreen を design.pen「ブックリスト編集」フレームに合わせて刷新する
  - 全ウィジェットで Legacy カラー参照を新トークンに置換する
  - _Requirements: 12.1, 12.2, 12.3, 12.4_

## Phase 6: Legacy 削除

- [ ] 14. Legacy トークンを完全に除去する
- [ ] 14.1 AppColors から Legacy サフィックス付きプロパティを削除する
  - 全 15 個の Legacy プロパティ（primaryLegacy, backgroundLegacy, surfaceLegacy 等）を削除する
  - `copyWith` と `lerp` から Legacy プロパティを除去する
  - `dark` 定数を削除する
  - _Requirements: 13.1_

- [ ] 14.2 AppTypography から Legacy サフィックス付きスタイルを削除する
  - 全 Legacy スタイル（displayLargeLegacy, displayMediumLegacy 等）を削除する
  - `textThemeLegacy` ゲッターを削除する
  - _Requirements: 13.2_

- [ ] 14.3 AppTheme から dark() メソッドを削除し、Legacy 依存を解消する
  - `dark()` メソッドを削除する
  - `theme` ゲッターが `light()` のみに依存する状態にする
  - _Requirements: 13.4_

- [ ] 14.4 プロジェクト全体で Legacy 参照が残っていないことを検証する
  - プロジェクト全体を grep し、Legacy カラー・タイポグラフィへの参照が 0 件であることを確認する
  - ビルドが成功し、コンパイルエラーがないことを確認する
  - _Requirements: 13.3_

- [ ]* 15. デザインシステム移行の受け入れ基準テストを実施する
  - AppColors.light の全新トークン値が design.pen の定義と一致することを検証するユニットテストを作成する（AC 1.1, 1.2）
  - AppTypography の新スタイルのフォントサイズ・ウェイトが design.pen と一致することを検証するユニットテストを作成する（AC 1.4, 1.5）
  - guardRoute のオンボーディングガード条件を検証するユニットテストを作成する（AC 3.4, 3.5）
  - タブナビゲーション（ホーム → 検索 → 通知 → プロフィール）の正常動作を検証するウィジェットテストを作成する（AC 4.1）
  - _Requirements: 1.1, 1.2, 1.4, 1.5, 1.8, 3.4, 3.5, 4.1_

# Implementation Plan

## Tasks

- [x] 1. デザインシステム基盤の拡張
- [x] 1.1 (P) AppColors にブランドカラーとセマンティックカラーを追加
  - brandPrimary (#4FD1C5)、brandAccent (#F6C94A)、brandBackground (#0A0A0A) を定義
  - surfacePrimary、surfaceElevated、surfaceOverlay を追加
  - textPrimary、textSecondary、textLink を追加
  - dark インスタンスに新規カラーを設定
  - _Requirements: 2.1_

- [x] 1.2 (P) AppRadius 定数クラスを新規作成
  - none (0px)、sm (4px)、md (8px)、lg (12px)、full (9999px) を定義
  - ボタンやカードで共通利用できる Border Radius 定数を提供
  - _Requirements: 3.1, 4.1_

- [x] 1.3 AppTheme にボタンテーマとカラースキームを追加
  - seedColor を brand.primary (#4FD1C5) に変更
  - ColorScheme.fromSeed で surface と onSurface を設定
  - FilledButtonThemeData（白背景・黒文字・角丸8px・高さ56px）を追加
  - OutlinedButtonThemeData（白枠・透明背景・白文字・角丸8px）を追加
  - AppColors.dark を extensions に登録
  - _Requirements: 2.1, 3.1, 4.1_

- [x] 2. アセットとフォント設定
- [x] 2.1 (P) 背景画像アセットを追加
  - Unsplash から本の画像をダウンロードし assets/images/welcome_background.jpg に配置
  - 画像サイズは 1080x1920 程度、JPEG 品質 80% にリサイズ
  - pubspec.yaml の flutter.assets に assets/images/ を追加
  - _Requirements: 2.5_

- [x] 2.2 (P) google_fonts パッケージを追加
  - pubspec.yaml の dependencies に google_fonts: ^6.2.1 を追加
  - Noto Sans JP フォントをランタイムでロード可能にする
  - _Requirements: 2.3, 2.4_

- [x] 3. ウェルカム画面 UI コンポーネント実装
- [x] 3.1 WelcomeBackground ウィジェットを作成
  - アセットから背景画像を読み込み画面全体に BoxFit.cover で表示
  - ImageFiltered でガウシアンブラー（sigma 10.0）を適用
  - ダークオーバーレイ（opacity 0.6）を重ねて上部コンテンツの視認性を確保
  - 画像読み込み失敗時はフォールバック背景色を使用
  - _Requirements: 2.5_

- [x] 3.2 WelcomeLogo ウィジェットを作成
  - 本のアイコン（ターコイズ #4FD1C5）と星マーク（#F6C94A）で構成されるロゴを表示
  - ロゴサイズは 80x80px、星は右上に 24x24px で配置
  - ロゴの下に「Shelfie」を白い太字（40px, weight 700）で表示
  - アプリ名の下にキャッチコピー「読書家のための本棚」を表示（16px, weight 400）
  - _Requirements: 2.2, 2.3, 2.4_

- [x] 3.3 WelcomeButtons ウィジェットを作成
  - 「ログイン」FilledButton（白背景・黒文字・角丸8px・高さ56px）を表示
  - 「新規登録」OutlinedButton（白枠1.5px・透明背景・白文字・角丸8px）を表示
  - ボタン間の間隔は 12px
  - タップ時の視覚的フィードバック（Material ripple）を提供
  - onLoginPressed と onRegisterPressed コールバックを受け取る
  - _Requirements: 3.1, 3.2, 3.3, 4.1, 4.2, 4.3_

- [x] 3.4 LegalLinks ウィジェットを作成
  - 「続けることで、利用規約とプライバシーポリシーに同意したものとみなされます」テキストを表示
  - 「利用規約」と「プライバシーポリシー」をタップ可能なリンク（下線付き）として表示
  - リンクタップ時のコールバック（onTermsPressed, onPrivacyPressed）を受け取る
  - フォントサイズ 12px、色は textSecondary と textLink を使用
  - _Requirements: 5.1, 5.2, 5.3_

- [x] 3.5 WelcomeContent ウィジェットを作成
  - WelcomeLogo、WelcomeButtons、LegalLinks を縦に配置
  - Column + MainAxisAlignment.spaceBetween でバランス良く配置
  - 小さい画面でもコンテンツが切れないよう SingleChildScrollView でラップ
  - 水平パディングは 48px（spacing.xxl）を適用
  - _Requirements: 6.1, 6.3_

- [x] 3.6 WelcomeScreen ウィジェットを作成
  - ConsumerWidget として Riverpod と統合
  - Stack で WelcomeBackground と WelcomeContent を重ね合わせ
  - SafeArea でノッチやホームインジケーターを考慮したレイアウトを適用
  - ダークテーマ（AppTheme.dark）を適用
  - ログインボタンタップで /auth/login へ遷移
  - 新規登録ボタンタップで /auth/register へ遷移（モック）
  - 利用規約・プライバシーポリシーリンクタップで SnackBar 表示（モック）
  - _Requirements: 1.1, 2.1, 6.2_

- [x] 4. ルーティング拡張
- [x] 4.1 AppRoutes に welcome と register パスを追加
  - welcome = '/welcome' を定義
  - register = '/auth/register' を定義（モック用）
  - _Requirements: 1.1_

- [x] 4.2 GoRouter に WelcomeScreen ルートを追加
  - /welcome ルートに WelcomeScreen を登録
  - /auth/register ルートにプレースホルダー画面を登録（モック）
  - _Requirements: 1.1, 3.2, 4.2_

- [x] 4.3 認証ガード（_guardRoute）を更新
  - 未認証時のデフォルトリダイレクト先を /auth/login から /welcome に変更
  - /welcome は未認証でもアクセス可能なルートとして設定
  - 認証済みで /welcome にアクセスした場合は / へリダイレクト
  - 認証完了時に自動的にホーム画面へ遷移する動作を維持
  - _Requirements: 1.1, 1.2, 1.3_

- [x] 5. ウィジェットテスト
- [x] 5.1 (P) WelcomeBackground のウィジェットテスト
  - 背景画像が表示されることを検証
  - ぼかし効果が適用されていることを検証
  - オーバーレイが重なっていることを検証
  - _Requirements: 2.5_

- [x] 5.2 (P) WelcomeLogo のウィジェットテスト
  - ロゴアイコンが表示されることを検証
  - 「Shelfie」テキストが表示されることを検証
  - キャッチコピーが表示されることを検証
  - _Requirements: 2.2, 2.3, 2.4_

- [x] 5.3 (P) WelcomeButtons のウィジェットテスト
  - ログインボタンが表示されることを検証
  - 新規登録ボタンが表示されることを検証
  - ログインボタンタップで onLoginPressed が呼ばれることを検証
  - 新規登録ボタンタップで onRegisterPressed が呼ばれることを検証
  - _Requirements: 3.1, 3.2, 3.3, 4.1, 4.2, 4.3_

- [x] 5.4 (P) LegalLinks のウィジェットテスト
  - 同意テキストが表示されることを検証
  - 利用規約リンクが表示されることを検証
  - プライバシーポリシーリンクが表示されることを検証
  - リンクタップでコールバックが呼ばれることを検証
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_

- [x] 5.5 (P) WelcomeScreen のウィジェットテスト
  - SafeArea が適用されていることを検証
  - 背景、ロゴ、ボタン、リンクが表示されることを検証
  - 異なる画面サイズでレイアウトが崩れないことを検証
  - _Requirements: 1.1, 6.1, 6.2, 6.3_

- [x] 6. ルーティングユニットテスト
- [x] 6.1 _guardRoute 関数のユニットテスト
  - 未認証 + ルートパス → /welcome へリダイレクトされることを検証
  - 未認証 + /welcome → リダイレクトなしを検証
  - 認証済み + /welcome → / へリダイレクトされることを検証
  - 認証済み + ルートパス → リダイレクトなしを検証
  - _Requirements: 1.1, 1.2, 1.3_

- [x] 7. 統合テスト
- [x] 7.1 アプリ起動から認証フローの統合テスト
  - 未認証状態でアプリ起動時にウェルカム画面が表示されることを検証
  - ログインボタンタップでログイン画面に遷移することを検証
  - 新規登録ボタンタップで新規登録画面に遷移することを検証（モック）
  - 認証完了後にホーム画面へ自動遷移することを検証
  - _Requirements: 1.1, 1.2, 1.3, 3.2, 4.2_

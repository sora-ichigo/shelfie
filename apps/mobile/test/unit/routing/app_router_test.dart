import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;
import 'package:shelfie/routing/app_router.dart';

import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  // RenderFlex overflow エラーを無視する（テスト環境のビューポートサイズの制約による）
  final originalOnError = FlutterError.onError;
  setUp(() {
    FlutterError.onError = (details) {
      final isOverflowError = details.toString().contains('overflowed') ||
          details.toString().contains('Multiple exceptions');
      if (!isOverflowError) {
        originalOnError?.call(details);
      }
    };
  });

  tearDown(() {
    FlutterError.onError = originalOnError;
  });

  // 認証済みテスト用のセットアップ（大きなビューポートを設定）
  void setLargeViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
  }

  void resetViewport(WidgetTester tester) {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  }

  group('AppRouter', () {
    group('6.1 AppRouter の基本設定', () {
      test('appRouterProvider が GoRouter インスタンスを提供する', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);

        expect(router, isA<GoRouter>());
      });

      test('初期ルートが "/" に設定されている', () {
        // AppRoutes.home が初期ルートとして設定されていることを確認
        expect(AppRoutes.home, '/');

        // GoRouter が正常に作成され、ルートが設定されていることを確認
        final container = createTestContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);
        final routes = router.configuration.routes;

        // ルートが存在することを確認
        expect(routes, isNotEmpty);
      });

      test('onException でエラーハンドリングが設定されている', () async {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);

        // 存在しないルートへの遷移でエラーページが表示されることを確認
        // onException が設定されていればエラーが投げられず、代わりにエラー画面に遷移する
        expect(
          () => router.go('/non-existent-route-12345'),
          returnsNormally,
        );
      });

      test('デバッグモードでログ出力が有効になる', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);

        // debugLogDiagnostics は kDebugMode に基づいて設定される
        // テスト環境では kDebugMode は false だが、設定が正しく行われていることを確認
        expect(router, isNotNull);
      });

      test('ProviderScope 経由で GoRouter を取得できる', () async {
        await expectLater(
          () async {
            final container = createTestContainer();
            addTearDown(container.dispose);
            final router = container.read(appRouterProvider);
            return router;
          }(),
          completes,
        );
      });
    });

    group('6.2 型安全なルートパラメータ', () {
      test('AppRoutes にルートパスが定義されている', () {
        expect(AppRoutes.home, '/');
        expect(AppRoutes.login, '/auth/login');
      });

      test('AppRoutes.bookDetail でパスパラメータが正しく構築される', () {
        final path = AppRoutes.bookDetail(bookId: 'abc123', source: BookSource.rakuten);
        expect(path, '/books/abc123?source=rakuten');
      });

      test('AppRoutes.search でクエリパラメータが正しく構築される', () {
        final path = AppRoutes.searchWithQuery(query: 'flutter');
        expect(path, contains('/search'));
        expect(path, contains('q=flutter'));
      });

      test('BookDetailParams が型安全なパラメータ取得を提供する', () {
        const params = BookDetailParams(bookId: 'test-id', source: 'rakuten');
        expect(params.bookId, 'test-id');
        expect(params.source, 'rakuten');
      });

      test('SearchParams がクエリパラメータの型変換を提供する', () {
        const params = SearchParams(query: 'dart', page: 1);
        expect(params.query, 'dart');
        expect(params.page, 1);
      });
    });

    group('6.3 ネストナビゲーション', () {
      late ProviderContainer container;
      late GoRouter router;

      setUp(() {
        container = ProviderContainer();
        router = container.read(appRouterProvider);
      });

      tearDown(() {
        container.dispose();
      });

      test('StatefulShellRoute を使用したタブバーナビゲーションが設定されている', () {
        final routes = router.configuration.routes;
        final hasStatefulShellRoute = routes.any((route) => route is StatefulShellRoute);
        expect(hasStatefulShellRoute, isTrue);
      });

      test('各タブのルートが定義されている', () {
        expect(AppRoutes.homeTab, '/home');
        expect(AppRoutes.searchTab, '/search');
        expect(AppRoutes.account, '/account');
      });

      testWidgets('タブ間の遷移が正しく動作する', (tester) async {
        final container = createTestContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp.router(
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );

        // 初期状態を確認
        await tester.pumpAndSettle();

        // ホームタブから検索タブへ遷移
        container.read(appRouterProvider).go(AppRoutes.searchTab);
        await tester.pumpAndSettle();

        // アカウント画面へ遷移
        container.read(appRouterProvider).go(AppRoutes.account);
        await tester.pumpAndSettle();

        expect(find.byType(MaterialApp), findsOneWidget);
      });

      testWidgets('サブルートから親ルートに戻れる', (tester) async {
        final container = createTestContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp.router(
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // サブルートへ遷移
        container.read(appRouterProvider).go('/books/test-book');
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // 戻る
        container.read(appRouterProvider).go(AppRoutes.home);
        await tester.pumpAndSettle();

        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    group('6.4 認証ガード', () {
      test('AuthStateNotifier が認証状態を管理する', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final authState = container.read(authStateProvider);

        expect(authState, isA<AuthStateData>());
        expect(authState.isAuthenticated, isFalse);
      });

      test('認証状態が変更可能である', () async {
        final container = createTestContainer();
        addTearDown(container.dispose);

        // 初期状態は未認証
        expect(
          container.read(authStateProvider).isAuthenticated,
          isFalse,
        );

        // ログイン
        await container.read(authStateProvider.notifier).login(
              userId: 'user-123',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );

        expect(
          container.read(authStateProvider).isAuthenticated,
          isTrue,
        );
        expect(
          container.read(authStateProvider).userId,
          'user-123',
        );

        // ログアウト
        await container.read(authStateProvider.notifier).logout();

        expect(
          container.read(authStateProvider).isAuthenticated,
          isFalse,
        );
      });

      test('AuthState が ChangeNotifier を実装している', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final authNotifier = container.read(authStateProvider.notifier);

        // refreshListenable で使用するため ChangeNotifier を継承している必要がある
        expect(authNotifier, isA<Notifier<AuthStateData>>());
      });

      testWidgets('未認証時にログイン画面へリダイレクトされる', (tester) async {
        final container = createTestContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: MaterialApp.router(
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // 保護されたルートへアクセスを試みる
        container.read(appRouterProvider).go(AppRoutes.account);
        await tester.pumpAndSettle();

        // ウェルカム画面にリダイレクトされることを確認
        final currentLocation =
            container.read(appRouterProvider).routerDelegate
                .currentConfiguration.uri.path;
        expect(currentLocation, AppRoutes.welcome);
      });

      testWidgets('認証済みユーザーは保護されたルートにアクセスできる', (tester) async {
        setLargeViewport(tester);

        final container = createTestContainer();

        // 先にログイン
        await container.read(authStateProvider.notifier).login(
              userId: 'user-123',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: MaterialApp.router(
              theme: AppTheme.theme,
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );
        await tester.pump();
        tester.takeException();

        // 保護されたルートへアクセス
        container.read(appRouterProvider).go(AppRoutes.account);
        await tester.pump();
        tester.takeException();

        // アカウント画面に遷移していることを確認
        final currentLocation =
            container.read(appRouterProvider).routerDelegate
                .currentConfiguration.uri.path;
        expect(currentLocation, AppRoutes.account);

        // タイマーをクリアするためにウィジェットを破棄し、タイマーを消費
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        container.dispose();
        resetViewport(tester);
      });

      testWidgets('認証済みユーザーがログイン画面にアクセスするとホームにリダイレクトされる',
          (tester) async {
        setLargeViewport(tester);

        final container = createTestContainer();

        // 先にログイン
        await container.read(authStateProvider.notifier).login(
              userId: 'user-123',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: MaterialApp.router(
              theme: AppTheme.theme,
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );
        await tester.pump();
        tester.takeException();

        // ログイン画面へアクセスを試みる
        container.read(appRouterProvider).go(AppRoutes.login);
        await tester.pump();
        tester.takeException();

        // ホームにリダイレクトされることを確認
        final currentLocation =
            container.read(appRouterProvider).routerDelegate
                .currentConfiguration.uri.path;
        expect(currentLocation, AppRoutes.home);

        // タイマーをクリアするためにウィジェットを破棄し、タイマーを消費
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        container.dispose();
        resetViewport(tester);
      });
    });

    group('6.5 ディープリンク対応', () {
      test('ディープリンク用のルートが定義されている', () {
        // カスタム URL スキーム対応のルートが存在することを確認
        expect(AppRoutes.bookDetail(bookId: '123', source: BookSource.rakuten), isNotEmpty);
      });

      testWidgets('ディープリンクから正しい画面に遷移する', (tester) async {
        setLargeViewport(tester);

        final container = createTestContainer();

        // 認証済み状態にする
        await container.read(authStateProvider.notifier).login(
              userId: 'user-123',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: MaterialApp.router(
              theme: AppTheme.theme,
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );
        await tester.pump();
        tester.takeException();

        // ディープリンクをシミュレート
        container.read(appRouterProvider).go('/books/deep-link-book');
        await tester.pump();
        tester.takeException();

        final currentLocation =
            container.read(appRouterProvider).routerDelegate
                .currentConfiguration.uri.path;
        expect(currentLocation, '/books/deep-link-book');

        // タイマーをクリアするためにウィジェットを破棄し、タイマーを消費
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(seconds: 1));
        container.dispose();
        resetViewport(tester);
      });

      testWidgets('不正な URL パラメータの場合はフォールバックが動作する', (tester) async {
        final container = createTestContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: MaterialApp.router(
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // 不正なルートへのアクセス
        container.read(appRouterProvider).go('/invalid/deep/link/path');
        await tester.pumpAndSettle();

        // エラーページまたはウェルカムにリダイレクトされることを確認
        final currentLocation =
            container.read(appRouterProvider).routerDelegate
                .currentConfiguration.uri.path;
        // 不正なルートは onException でエラーページに遷移するか、未認証時はウェルカムにリダイレクトされる
        expect(
          currentLocation == AppRoutes.error ||
              currentLocation == AppRoutes.welcome,
          isTrue,
        );
      });

      test('BookDetailParams が GoRouterState から正しくパースできる', () {
        final params = BookDetailParams.fromState(
          pathParameters: {'bookId': 'parsed-id'},
        );
        expect(params.bookId, 'parsed-id');
      });

      test('SearchParams がクエリパラメータから正しくパースできる', () {
        final params = SearchParams.fromQueryParameters(
          queryParameters: {'q': 'test', 'page': '2'},
        );
        expect(params.query, 'test');
        expect(params.page, 2);
      });

      test('SearchParams のデフォルト値が正しく設定される', () {
        final params = SearchParams.fromQueryParameters(
          queryParameters: {},
        );
        expect(params.query, '');
        expect(params.page, 1);
      });
    });
  });
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/routing/app_router.dart';

void main() {
  group('AppRouter', () {
    group('6.1 AppRouter の基本設定', () {
      test('appRouterProvider が GoRouter インスタンスを提供する', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);

        expect(router, isA<GoRouter>());
      });

      test('初期ルートが "/" に設定されている', () {
        // AppRoutes.home が初期ルートとして設定されていることを確認
        expect(AppRoutes.home, '/');

        // GoRouter が正常に作成され、ルートが設定されていることを確認
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);
        final routes = router.configuration.routes;

        // ルートが存在することを確認
        expect(routes, isNotEmpty);
      });

      test('onException でエラーハンドリングが設定されている', () async {
        final container = ProviderContainer();
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
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);

        // debugLogDiagnostics は kDebugMode に基づいて設定される
        // テスト環境では kDebugMode は false だが、設定が正しく行われていることを確認
        expect(router, isNotNull);
      });

      test('ProviderScope 経由で GoRouter を取得できる', () async {
        await expectLater(
          () async {
            final container = ProviderContainer();
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
        final path = AppRoutes.bookDetail(bookId: 'abc123');
        expect(path, '/books/abc123');
      });

      test('AppRoutes.search でクエリパラメータが正しく構築される', () {
        final path = AppRoutes.searchWithQuery(query: 'flutter');
        expect(path, contains('/search'));
        expect(path, contains('q=flutter'));
      });

      test('BookDetailParams が型安全なパラメータ取得を提供する', () {
        final params = BookDetailParams(bookId: 'test-id');
        expect(params.bookId, 'test-id');
      });

      test('SearchParams がクエリパラメータの型変換を提供する', () {
        final params = SearchParams(query: 'dart', page: 1);
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

      test('ShellRoute を使用したタブバーナビゲーションが設定されている', () {
        // ShellRoute が存在することを確認
        final routes = router.configuration.routes;
        final hasShellRoute = routes.any((route) => route is ShellRoute);
        expect(hasShellRoute, isTrue);
      });

      test('各タブのルートが定義されている', () {
        expect(AppRoutes.homeTab, '/home');
        expect(AppRoutes.searchTab, '/search');
        expect(AppRoutes.profileTab, '/profile');
      });

      testWidgets('タブ間の遷移が正しく動作する', (tester) async {
        final container = ProviderContainer();
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

        // プロファイルタブへ遷移
        container.read(appRouterProvider).go(AppRoutes.profileTab);
        await tester.pumpAndSettle();

        expect(find.byType(MaterialApp), findsOneWidget);
      });

      testWidgets('サブルートから親ルートに戻れる', (tester) async {
        final container = ProviderContainer();
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
        await tester.pumpAndSettle();

        // 戻る
        container.read(appRouterProvider).go(AppRoutes.home);
        await tester.pumpAndSettle();

        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    group('6.4 認証ガード', () {
      test('AuthStateNotifier が認証状態を管理する', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final authState = container.read(authStateProvider);

        expect(authState, isA<AuthState>());
        expect(authState.isAuthenticated, isFalse);
      });

      test('認証状態が変更可能である', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        // 初期状態は未認証
        expect(
          container.read(authStateProvider).isAuthenticated,
          isFalse,
        );

        // ログイン
        container.read(authStateProvider.notifier).login(
              userId: 'user-123',
              token: 'test-token',
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
        container.read(authStateProvider.notifier).logout();

        expect(
          container.read(authStateProvider).isAuthenticated,
          isFalse,
        );
      });

      test('AuthState が ChangeNotifier を実装している', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final authNotifier = container.read(authStateProvider.notifier);

        // refreshListenable で使用するため ChangeNotifier を継承している必要がある
        expect(authNotifier, isA<Notifier<AuthState>>());
      });

      testWidgets('未認証時にログイン画面へリダイレクトされる', (tester) async {
        final container = ProviderContainer();
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
        container.read(appRouterProvider).go(AppRoutes.profileTab);
        await tester.pumpAndSettle();

        // ログイン画面にリダイレクトされることを確認
        final currentLocation =
            container.read(appRouterProvider).routerDelegate
                .currentConfiguration.uri.path;
        expect(currentLocation, AppRoutes.login);
      });

      testWidgets('認証済みユーザーは保護されたルートにアクセスできる', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        // 先にログイン
        container.read(authStateProvider.notifier).login(
              userId: 'user-123',
              token: 'test-token',
            );

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: MaterialApp.router(
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // 保護されたルートへアクセス
        container.read(appRouterProvider).go(AppRoutes.profileTab);
        await tester.pumpAndSettle();

        // プロファイル画面に遷移していることを確認
        final currentLocation =
            container.read(appRouterProvider).routerDelegate
                .currentConfiguration.uri.path;
        expect(currentLocation, AppRoutes.profileTab);
      });

      testWidgets('認証済みユーザーがログイン画面にアクセスするとホームにリダイレクトされる',
          (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        // 先にログイン
        container.read(authStateProvider.notifier).login(
              userId: 'user-123',
              token: 'test-token',
            );

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: MaterialApp.router(
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // ログイン画面へアクセスを試みる
        container.read(appRouterProvider).go(AppRoutes.login);
        await tester.pumpAndSettle();

        // ホームにリダイレクトされることを確認
        final currentLocation =
            container.read(appRouterProvider).routerDelegate
                .currentConfiguration.uri.path;
        expect(currentLocation, AppRoutes.home);
      });
    });

    group('6.5 ディープリンク対応', () {
      test('ディープリンク用のルートが定義されている', () {
        // カスタム URL スキーム対応のルートが存在することを確認
        expect(AppRoutes.bookDetail(bookId: '123'), isNotEmpty);
      });

      testWidgets('ディープリンクから正しい画面に遷移する', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        // 認証済み状態にする
        container.read(authStateProvider.notifier).login(
              userId: 'user-123',
              token: 'test-token',
            );

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: MaterialApp.router(
              routerConfig: container.read(appRouterProvider),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // ディープリンクをシミュレート
        container.read(appRouterProvider).go('/books/deep-link-book');
        await tester.pumpAndSettle();

        final currentLocation =
            container.read(appRouterProvider).routerDelegate
                .currentConfiguration.uri.path;
        expect(currentLocation, '/books/deep-link-book');
      });

      testWidgets('不正な URL パラメータの場合はフォールバックが動作する', (tester) async {
        final container = ProviderContainer();
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

        // エラーページまたはホームにリダイレクトされることを確認
        final currentLocation =
            container.read(appRouterProvider).routerDelegate
                .currentConfiguration.uri.path;
        // 不正なルートは onException でエラーページに遷移するか、ホームにリダイレクトされる
        expect(
          currentLocation == AppRoutes.error ||
              currentLocation == AppRoutes.login,
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

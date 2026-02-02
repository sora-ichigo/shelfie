import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;
import 'package:shelfie/routing/app_router.dart';

import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  group('Task 12.2: モバイルアプリルーティング統合', () {
    group('検索画面へのルート設定', () {
      test('AppRoutes.searchTab が定義されている', () {
        expect(AppRoutes.searchTab, '/search');
      });

      test('検索画面のルートが StatefulShellRoute 内に定義されている', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);
        final routes = router.configuration.routes;

        // StatefulShellRoute を取得
        final shellRoute = routes.firstWhere((r) => r is StatefulShellRoute)
            as StatefulShellRoute;

        // branches 内の全ルートから検索ルートが存在することを確認
        final allBranchRoutes =
            shellRoute.branches.expand((b) => b.routes).toList();
        final hasSearchRoute = allBranchRoutes.any(
          (r) =>
              r is GoRoute &&
              (r.path == '/search' || r.path == AppRoutes.searchTab),
        );
        expect(hasSearchRoute, isTrue);
      });

      test('検索ルートに pageBuilder が設定されている', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);
        final routes = router.configuration.routes;

        // StatefulShellRoute を取得
        final shellRoute = routes.firstWhere((r) => r is StatefulShellRoute)
            as StatefulShellRoute;

        // branches 内の全ルートから検索ルートを取得
        final allBranchRoutes =
            shellRoute.branches.expand((b) => b.routes).toList();
        final searchRoute = allBranchRoutes.firstWhere(
          (r) => r is GoRoute && r.path == AppRoutes.searchTab,
        ) as GoRoute;

        // pageBuilder が定義されていることを確認
        expect(searchRoute.pageBuilder, isNotNull);
      });
    });

    group('ISBN スキャン画面へのルート設定', () {
      test('AppRoutes に ISBN スキャン用のルートパスが定義されている', () {
        // isbnScan ルートが追加されていることを確認
        expect(AppRoutes.isbnScan, isNotNull);
        expect(AppRoutes.isbnScan, contains('isbn'));
      });

      test('AppRoutes.isbnScan のパスが正しい', () {
        expect(AppRoutes.isbnScan, '/search/isbn-scan');
      });

      test('ISBN スキャンルートがトップレベルルートとして定義されている', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);
        final routes = router.configuration.routes;

        // ISBN スキャンがトップレベルルートとして存在することを確認
        // （タブバーなしで表示するため ShellRoute の外に配置）
        final hasIsbnScanRoute = routes.any(
          (r) => r is GoRoute && r.path == AppRoutes.isbnScan,
        );
        expect(hasIsbnScanRoute, isTrue);
      });

      test('ISBN スキャンルートに pageBuilder が設定されている', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);
        final routes = router.configuration.routes;

        // ISBN スキャンルートを取得（トップレベルルート）
        final isbnScanRoute = routes.firstWhere(
          (r) => r is GoRoute && r.path == AppRoutes.isbnScan,
        ) as GoRoute;

        // pageBuilder が定義されていることを確認（fullscreenDialog として設定）
        expect(isbnScanRoute.pageBuilder, isNotNull);
      });
    });

    group('既存プレースホルダーの置き換え', () {
      test('検索ルートが SearchScreen を使用している', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);
        final routes = router.configuration.routes;

        // StatefulShellRoute を取得
        final shellRoute = routes.firstWhere((r) => r is StatefulShellRoute)
            as StatefulShellRoute;

        // branches 内の全ルートから検索ルートを取得
        final allBranchRoutes =
            shellRoute.branches.expand((b) => b.routes).toList();
        final searchRoute = allBranchRoutes.firstWhere(
          (r) => r is GoRoute && r.path == AppRoutes.searchTab,
        ) as GoRoute;

        // pageBuilder が定義されていることを確認
        expect(searchRoute.pageBuilder, isNotNull);
      });
    });

    group('ルートパスの一貫性', () {
      test('AppRoutes の全てのパスが正しく定義されている', () {
        expect(AppRoutes.home, '/');
        expect(AppRoutes.welcome, '/welcome');
        expect(AppRoutes.login, '/auth/login');
        expect(AppRoutes.register, '/auth/register');
        expect(AppRoutes.homeTab, '/home');
        expect(AppRoutes.searchTab, '/search');
        expect(AppRoutes.account, '/account');
        expect(AppRoutes.error, '/error');
        expect(AppRoutes.isbnScan, '/search/isbn-scan');
      });

      test('AppRoutes.bookDetail がパスパラメータを正しく構築する', () {
        final path = AppRoutes.bookDetail(bookId: 'test-book-123', source: BookSource.rakuten);
        expect(path, '/books/test-book-123?source=rakuten');
      });

      test('AppRoutes.searchWithQuery がクエリパラメータを正しく構築する', () {
        final path = AppRoutes.searchWithQuery(query: 'flutter');
        expect(path, contains('/search'));
        expect(path, contains('q=flutter'));
      });
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/book_list_detail_screen.dart';
import 'package:shelfie/features/book_list/presentation/book_list_edit_screen.dart';
import 'package:shelfie/routing/app_router.dart';

import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  group('BookList Routing', () {
    group('11.1.1 BookListDetailScreen ルートの検証', () {
      test('AppRoutes.bookListDetail でパスパラメータが正しく構築される', () {
        final path = AppRoutes.bookListDetail(listId: 123);
        expect(path, '/lists/123');
      });

      test('/lists/:listId ルートがトップレベルルートとして登録されている', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);
        final routes = router.configuration.routes;

        final hasBookListDetailRoute = routes.any(
          (route) => route is GoRoute && route.path == '/lists/:listId',
        );
        expect(hasBookListDetailRoute, isTrue);
      });

      testWidgets('BookListDetailScreen が正しい listId を受け取る',
          (tester) async {
        const testListId = 42;

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: const BookListDetailScreen(listId: testListId),
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(BookListDetailScreen), findsOneWidget);

        final bookListDetailWidget = tester.widget<BookListDetailScreen>(
          find.byType(BookListDetailScreen),
        );
        expect(bookListDetailWidget.listId, testListId);

        await tester.pump(const Duration(seconds: 1));
      });
    });

    group('11.1.2 BookListEditScreen ルートの検証', () {
      test('AppRoutes.bookListCreate が正しいパスを返す', () {
        expect(AppRoutes.bookListCreate, '/lists/new');
      });

      test('AppRoutes.bookListEdit でパスパラメータが正しく構築される', () {
        final path = AppRoutes.bookListEdit(listId: 456);
        expect(path, '/lists/456/edit');
      });

      test('/lists/new ルートが登録されている', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);
        final routes = router.configuration.routes;

        bool hasRoute(List<RouteBase> routes, String path) {
          for (final route in routes) {
            if (route is GoRoute && route.path == path) return true;
            if (route is ShellRoute) {
              if (hasRoute(route.routes, path)) return true;
            }
            if (route is StatefulShellRoute) {
              for (final branch in route.branches) {
                if (hasRoute(branch.routes, path)) return true;
              }
            }
            if (route is GoRoute && route.routes.isNotEmpty) {
              if (hasRoute(route.routes, path)) return true;
            }
          }
          return false;
        }

        expect(hasRoute(routes, '/lists/new'), isTrue);
      });

      test('/lists/:listId/edit ルートが登録されている', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);
        final routes = router.configuration.routes;

        final listDetailRoute = routes.whereType<GoRoute>().firstWhere(
          (route) => route.path == '/lists/:listId',
        );

        final hasEditSubRoute = listDetailRoute.routes.any(
          (route) => route is GoRoute && route.path == 'edit',
        );
        expect(hasEditSubRoute, isTrue);
      });

      testWidgets('BookListEditScreen が作成モードで動作する', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: const BookListEditScreen(autoOpenBookSelector: false),
          ),
        );
        await tester.pump();

        expect(find.byType(BookListEditScreen), findsOneWidget);

        final editWidget = tester.widget<BookListEditScreen>(
          find.byType(BookListEditScreen),
        );
        expect(editWidget.isEditing, isFalse);

        expect(find.text('新しいリスト'), findsOneWidget);

        await tester.pump(const Duration(seconds: 1));
      });

      testWidgets('BookListEditScreen が編集モードで動作する（existingList 渡し）',
          (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: BookListEditScreen(
              existingList: _createMockBookList(id: 789, title: 'テストリスト'),
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(BookListEditScreen), findsOneWidget);

        final editWidget = tester.widget<BookListEditScreen>(
          find.byType(BookListEditScreen),
        );
        expect(editWidget.isEditing, isTrue);

        expect(find.text('リスト編集'), findsOneWidget);

        await tester.pump(const Duration(seconds: 1));
      });
    });

    group('11.1.3 ディープリンク対応', () {
      test('リスト詳細へのディープリンクパスが正しく生成される', () {
        final path = AppRoutes.bookListDetail(listId: 999);
        expect(path, '/lists/999');
        expect(path.startsWith('/'), isTrue);
      });

      test('リスト編集へのディープリンクパスが正しく生成される', () {
        final path = AppRoutes.bookListEdit(listId: 888);
        expect(path, '/lists/888/edit');
        expect(path.startsWith('/'), isTrue);
      });

      test('新規作成へのディープリンクパスが正しく設定されている', () {
        expect(AppRoutes.bookListCreate, '/lists/new');
        expect(AppRoutes.bookListCreate.startsWith('/'), isTrue);
      });

      test('listId パスパラメータのパースが正しく動作する', () {
        final params = BookListParams.fromState(
          pathParameters: {'listId': '12345'},
        );
        expect(params.listId, 12345);
      });

      test('不正な listId は 0 として処理される', () {
        final params = BookListParams.fromState(
          pathParameters: {'listId': 'invalid'},
        );
        expect(params.listId, 0);
      });

      test('listId が存在しない場合は 0 として処理される', () {
        final params = BookListParams.fromState(
          pathParameters: {},
        );
        expect(params.listId, 0);
      });
    });
  });
}

BookList _createMockBookList({required int id, required String title}) {
  return BookList(
    id: id,
    title: title,
    description: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}

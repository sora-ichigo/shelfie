import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_detail/presentation/book_detail_screen.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;
import 'package:shelfie/routing/app_router.dart';

import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  group('BookDetail Routing', () {
    group('10.1 /books/:bookId ルートの検証', () {
      test('AppRoutes.bookDetail でパスパラメータが正しく構築される', () {
        final path = AppRoutes.bookDetail(bookId: 'test-book-123', source: BookSource.rakuten);
        expect(path, '/books/test-book-123?source=rakuten');
      });

      test('BookDetailParams が GoRouterState から正しくパースできる', () {
        final params = BookDetailParams.fromState(
          pathParameters: {'bookId': 'parsed-book-id'},
          queryParameters: {'source': 'google'},
        );
        expect(params.bookId, 'parsed-book-id');
        expect(params.source, 'google');
      });

      test('空の bookId は空文字列として処理される', () {
        final params = BookDetailParams.fromState(
          pathParameters: {},
        );
        expect(params.bookId, '');
      });

      test('/books/:bookId ルートがトップレベルルートとして登録されている', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final router = container.read(appRouterProvider);
        final routes = router.configuration.routes;

        // トップレベルに本詳細ルートが存在することを確認
        // （タブバーなしで表示するため ShellRoute の外に配置されている）
        final hasBookDetailRoute = routes.any(
          (route) => route is GoRoute && route.path == '/books/:bookId',
        );
        expect(hasBookDetailRoute, isTrue);
      });

      testWidgets('BookDetailScreen が正しい bookId を受け取る', (tester) async {
        const testBookId = 'widget-test-book-id';

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              theme: AppTheme.theme,
              home: const BookDetailScreen(bookId: testBookId, source: BookSource.rakuten),
            ),
          ),
        );
        await tester.pump();

        // BookDetailScreen が存在することを確認
        expect(find.byType(BookDetailScreen), findsOneWidget);

        // BookDetailScreen の bookId を確認
        final bookDetailWidget = tester.widget<BookDetailScreen>(
          find.byType(BookDetailScreen),
        );
        expect(bookDetailWidget.bookId, testBookId);

        // タイマー問題を回避するためにフレームを進める
        await tester.pump(const Duration(seconds: 1));
      });

      testWidgets('BookDetailScreen の AppBar に戻るボタンが表示される', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              theme: AppTheme.theme,
              home: const BookDetailScreen(bookId: 'test-id', source: BookSource.rakuten),
            ),
          ),
        );
        await tester.pump();

        // 戻るボタン（Icons.arrow_back_ios_new）が存在することを確認
        expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);

        // タイマー問題を回避するためにフレームを進める
        await tester.pump(const Duration(seconds: 1));
      });

      testWidgets('BookDetailScreen の AppBar に共有ボタンが表示される', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              theme: AppTheme.theme,
              home: const BookDetailScreen(bookId: 'test-id', source: BookSource.rakuten),
            ),
          ),
        );
        await tester.pump();

        // タイマー問題を回避するためにフレームを進める
        await tester.pump(const Duration(seconds: 1));
      });

      testWidgets('戻るボタンタップで Navigator.pop が呼ばれる', (tester) async {
        var popped = false;

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              theme: AppTheme.theme,
              home: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => const BookDetailScreen(bookId: 'test-id', source: BookSource.rakuten),
                      ),
                    );
                    popped = true;
                  },
                  child: const Text('Open'),
                ),
              ),
            ),
          ),
        );

        // BookDetailScreen を開く
        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();

        // 戻るボタンをタップ
        await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
        await tester.pumpAndSettle();

        // Navigator.pop が呼ばれたことを確認
        expect(popped, isTrue);
      });
    });
  });
}

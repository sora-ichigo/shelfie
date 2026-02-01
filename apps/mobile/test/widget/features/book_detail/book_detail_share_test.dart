import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/features/book_detail/presentation/book_detail_screen.dart';
import 'package:shelfie/features/book_detail/presentation/services/share_service.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;

import '../../../helpers/test_helpers.dart';

class MockShareService extends Mock implements ShareService {}

void main() {
  setUpAll(registerTestFallbackValues);

  group('ShareService', () {
    group('10.1 共有機能のサービス層テスト', () {
      test('ShareServiceImpl が正しく作成される', () {
        final service = ShareServiceImpl();
        expect(service, isA<ShareService>());
      });

      test('shareServiceProvider が ShareService を提供する', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final service = container.read(shareServiceProvider);
        expect(service, isA<ShareService>());
      });
    });

    group('BookDetailScreen 共有ボタン', () {
      testWidgets('共有ボタンが AppBar に表示されている', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: const BookDetailScreen(bookId: 'test-id', source: BookSource.rakuten),
            ),
          ),
        );
        await tester.pump();

        // 共有ボタンが存在することを確認
        expect(find.byIcon(Icons.share), findsOneWidget);

        // タイマー問題を回避
        await tester.pump(const Duration(seconds: 1));
      });

      testWidgets('共有ボタンはタップ可能である', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: const BookDetailScreen(bookId: 'test-id', source: BookSource.rakuten),
            ),
          ),
        );
        await tester.pump();

        // 共有ボタンをタップできることを確認（エラーが発生しないことを検証）
        await tester.tap(find.byIcon(Icons.share));
        await tester.pump();

        // タイマー問題を回避
        await tester.pump(const Duration(seconds: 1));
      });
    });
  });
}

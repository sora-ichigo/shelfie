import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_share/presentation/share_card_screen.dart';

void main() {
  const externalId = 'book-123';

  BookDetail createBookDetail() {
    return BookDetail(
      id: externalId,
      title: 'テスト書籍',
      authors: ['著者A'],
      thumbnailUrl: 'https://example.com/cover.jpg',
    );
  }

  Widget buildTestWidget({required BookDetail bookDetail}) {
    return ProviderScope(
      overrides: [
        bookDetailNotifierProvider(externalId)
            .overrideWith(() => _FakeBookDetailNotifier(bookDetail)),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: Builder(
          builder: (context) => Scaffold(
            body: ElevatedButton(
              onPressed: () => showShareCardBottomSheet(
                context: context,
                externalId: externalId,
                accentColor: const Color(0xFF017BC8),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openBottomSheet(WidgetTester tester) async {
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
  }

  group('showShareCardBottomSheet', () {
    testWidgets('カードプレビューが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(bookDetail: createBookDetail()));
      await openBottomSheet(tester);

      expect(find.text('テスト書籍'), findsOneWidget);
    });

    testWidgets('シェアボタンと保存ボタンが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(bookDetail: createBookDetail()));
      await openBottomSheet(tester);

      expect(find.text('シェア'), findsOneWidget);
      expect(find.text('保存'), findsOneWidget);
    });

    testWidgets('ドラッグハンドルが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(bookDetail: createBookDetail()));
      await openBottomSheet(tester);

      final handle = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.constraints?.maxWidth == 40 &&
            widget.constraints?.maxHeight == 4,
      );
      expect(handle, findsOneWidget);
    });
  });
}

class _FakeBookDetailNotifier extends BookDetailNotifier {
  _FakeBookDetailNotifier(this._bookDetail);
  final BookDetail _bookDetail;

  @override
  Future<BookDetail?> build(String externalId) async => _bookDetail;
}

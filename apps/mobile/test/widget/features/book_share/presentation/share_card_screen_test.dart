import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
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

  Widget buildTestWidget({
    required BookDetail bookDetail,
    ReadingStatus readingStatus = ReadingStatus.completed,
  }) {
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
                readingStatus: readingStatus,
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
    const largeScreen = Size(640, 1200);

    testWidgets('カードプレビューが表示される', (tester) async {
      tester.view.physicalSize = largeScreen;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestWidget(bookDetail: createBookDetail()));
      await openBottomSheet(tester);

      expect(find.text('テスト書籍'), findsOneWidget);
    });

    testWidgets('読了状態では「読んだ本をシェアしよう」と表示される', (tester) async {
      tester.view.physicalSize = largeScreen;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestWidget(
        bookDetail: createBookDetail(),
        readingStatus: ReadingStatus.completed,
      ));
      await openBottomSheet(tester);

      expect(find.text('読んだ本をシェアしよう'), findsOneWidget);
    });

    testWidgets('読書中状態では「読んでいる本をシェアしよう」と表示される', (tester) async {
      tester.view.physicalSize = largeScreen;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestWidget(
        bookDetail: createBookDetail(),
        readingStatus: ReadingStatus.reading,
      ));
      await openBottomSheet(tester);

      expect(find.text('読んでいる本をシェアしよう'), findsOneWidget);
    });

    testWidgets('積読状態では「積読をシェアしよう」と表示される', (tester) async {
      tester.view.physicalSize = largeScreen;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestWidget(
        bookDetail: createBookDetail(),
        readingStatus: ReadingStatus.backlog,
      ));
      await openBottomSheet(tester);

      expect(find.text('積読をシェアしよう'), findsOneWidget);
    });

    testWidgets('気になる状態では「気になる本をシェアしよう」と表示される', (tester) async {
      tester.view.physicalSize = largeScreen;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestWidget(
        bookDetail: createBookDetail(),
        readingStatus: ReadingStatus.interested,
      ));
      await openBottomSheet(tester);

      expect(find.text('気になる本をシェアしよう'), findsOneWidget);
    });

    testWidgets('ストーリーズ・LINE・保存・さらに見るの4ボタンが表示される', (tester) async {
      tester.view.physicalSize = largeScreen;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestWidget(bookDetail: createBookDetail()));
      await openBottomSheet(tester);

      expect(find.text('ストーリーズ'), findsOneWidget);
      expect(find.text('LINE'), findsOneWidget);
      expect(find.text('画像を保存'), findsOneWidget);
      expect(find.text('さらに見る'), findsOneWidget);
    });

    testWidgets('ドラッグハンドルが表示される', (tester) async {
      tester.view.physicalSize = largeScreen;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_shelf/application/shelf_search_notifier.dart';
import 'package:shelfie/features/book_shelf/application/shelf_search_state.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/shelf_search_bottom_sheet.dart';

class FakeShelfSearchNotifier extends ShelfSearchNotifier {
  ShelfSearchState _state = const ShelfSearchState.initial();

  @override
  ShelfSearchState build({int? userId}) => _state;

  void setState(ShelfSearchState newState) {
    _state = newState;
    state = newState;
  }

  String? lastQuery;

  @override
  Future<void> search(String query) async {
    lastQuery = query;
  }

  @override
  Future<void> loadMore() async {}
}

void main() {
  final now = DateTime(2024, 1, 15, 10, 30);

  ShelfBookItem createBook({
    int userBookId = 1,
    String externalId = 'id',
    String title = 'Title',
    List<String> authors = const ['Author'],
  }) {
    return ShelfBookItem(
      userBookId: userBookId,
      externalId: externalId,
      title: title,
      authors: authors,
      addedAt: now,
    );
  }

  late FakeShelfSearchNotifier fakeNotifier;

  setUp(() {
    fakeNotifier = FakeShelfSearchNotifier();
  });

  Widget buildWidget({
    void Function(ShelfBookItem)? onBookTap,
  }) {
    return ProviderScope(
      overrides: [
        shelfSearchNotifierProvider().overrideWith(() => fakeNotifier),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showShelfSearchBottomSheet(
                context: context,
                onBookTap: onBookTap ?? (_) {},
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

  group('ShelfSearchBottomSheet', () {
    testWidgets('ボトムシートが開き検索フィールドが表示される', (tester) async {
      await tester.pumpWidget(buildWidget());
      await openBottomSheet(tester);

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('initial 状態で案内テキストが表示される', (tester) async {
      await tester.pumpWidget(buildWidget());
      await openBottomSheet(tester);

      expect(find.text('タイトルや著者名で検索できます'), findsOneWidget);
    });

    testWidgets('loaded 状態で書籍リストが表示される', (tester) async {
      final books = [
        createBook(userBookId: 1, externalId: 'b1', title: 'Flutter入門'),
        createBook(userBookId: 2, externalId: 'b2', title: 'Dart実践ガイド'),
      ];

      await tester.pumpWidget(buildWidget());
      await openBottomSheet(tester);

      fakeNotifier.setState(ShelfSearchState.loaded(
        books: books,
        hasMore: false,
        isLoadingMore: false,
        totalCount: 2,
      ));
      await tester.pumpAndSettle();

      expect(find.text('Flutter入門'), findsOneWidget);
      expect(find.text('Dart実践ガイド'), findsOneWidget);
    });

    testWidgets('書籍タップで onBookTap コールバックが呼ばれる', (tester) async {
      ShelfBookItem? tappedBook;
      final book = createBook(
        userBookId: 1,
        externalId: 'b1',
        title: 'Flutter入門',
      );

      await tester.pumpWidget(
        buildWidget(onBookTap: (b) => tappedBook = b),
      );
      await openBottomSheet(tester);

      fakeNotifier.setState(ShelfSearchState.loaded(
        books: [book],
        hasMore: false,
        isLoadingMore: false,
        totalCount: 1,
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Flutter入門'));
      await tester.pumpAndSettle();

      expect(tappedBook?.externalId, 'b1');
    });

    testWidgets('loading 状態でインジケーターが表示される', (tester) async {
      await tester.pumpWidget(buildWidget());
      await openBottomSheet(tester);

      fakeNotifier.setState(const ShelfSearchState.loading());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('error 状態でエラーメッセージが表示される', (tester) async {
      await tester.pumpWidget(buildWidget());
      await openBottomSheet(tester);

      fakeNotifier.setState(const ShelfSearchState.error(
        failure: NetworkFailure(message: 'No internet'),
      ));
      await tester.pump();

      expect(find.text('エラーが発生しました'), findsOneWidget);
    });

    testWidgets('loaded で書籍が0件の場合に見つかりませんメッセージが表示される', (tester) async {
      await tester.pumpWidget(buildWidget());
      await openBottomSheet(tester);

      fakeNotifier.setState(const ShelfSearchState.loaded(
        books: [],
        hasMore: false,
        isLoadingMore: false,
        totalCount: 0,
      ));
      await tester.pumpAndSettle();

      expect(find.text('本が見つかりません'), findsOneWidget);
    });
  });
}

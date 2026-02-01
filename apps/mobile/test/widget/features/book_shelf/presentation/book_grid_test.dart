import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_card.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_grid.dart';

class MockShelfState extends Notifier<Map<String, ShelfEntry>>
    with Mock
    implements ShelfState {
  MockShelfState(this._initialState);

  final Map<String, ShelfEntry> _initialState;

  @override
  Map<String, ShelfEntry> build() => _initialState;
}

void main() {
  List<ShelfBookItem> createTestBooks(int count) {
    return List.generate(
      count,
      (index) => ShelfBookItem(
        userBookId: index + 1,
        externalId: 'ext-$index',
        title: 'テスト本 ${index + 1}',
        authors: ['著者 ${index + 1}'],
        addedAt: DateTime(2024, 1, 1),
      ),
    );
  }

  Map<String, ShelfEntry> createShelfState(List<ShelfBookItem> books) {
    return {
      for (final book in books)
        book.externalId: ShelfEntry(
          userBookId: book.userBookId,
          externalId: book.externalId,
          readingStatus: ReadingStatus.backlog,
          addedAt: book.addedAt,
        ),
    };
  }

  Widget buildBookGrid({
    List<ShelfBookItem> books = const [],
    Map<String, ShelfEntry>? shelfState,
    bool hasMore = false,
    bool isLoadingMore = false,
    void Function(ShelfBookItem)? onBookTap,
    void Function(ShelfBookItem)? onBookLongPress,
    VoidCallback? onLoadMore,
  }) {
    final effectiveShelfState = shelfState ?? createShelfState(books);

    return ProviderScope(
      overrides: [
        shelfStateProvider.overrideWith(() => MockShelfState(effectiveShelfState)),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: BookGrid(
            books: books,
            hasMore: hasMore,
            isLoadingMore: isLoadingMore,
            onBookTap: onBookTap ?? (_) {},
            onBookLongPress: onBookLongPress ?? (_) {},
            onLoadMore: onLoadMore ?? () {},
          ),
        ),
      ),
    );
  }

  group('BookGrid', () {
    group('グリッドレイアウト', () {
      testWidgets('4列のグリッドレイアウトで書籍カードが配置される', (tester) async {
        await tester.pumpWidget(
          buildBookGrid(books: createTestBooks(6)),
        );

        expect(find.byType(BookCard), findsNWidgets(6));
        expect(find.byType(SliverGrid), findsOneWidget);
      });

      testWidgets('スクロール可能なリストとして実装される', (tester) async {
        await tester.pumpWidget(
          buildBookGrid(books: createTestBooks(12)),
        );

        expect(find.byType(CustomScrollView), findsOneWidget);
      });

      testWidgets('遅延レンダリングに対応している', (tester) async {
        await tester.pumpWidget(
          buildBookGrid(books: createTestBooks(100)),
        );

        expect(find.byType(SliverGrid), findsOneWidget);
      });
    });

    group('無限スクロール', () {
      testWidgets('リスト末尾付近でloadMoreコールバックが発火される', (tester) async {
        var loadMoreCalled = false;

        await tester.pumpWidget(
          buildBookGrid(
            books: createTestBooks(20),
            hasMore: true,
            onLoadMore: () => loadMoreCalled = true,
          ),
        );

        await tester.drag(
          find.byType(CustomScrollView),
          const Offset(0, -10000),
        );
        await tester.pumpAndSettle();

        expect(loadMoreCalled, isTrue);
      });

      testWidgets('hasMoreがfalseの場合はloadMoreが呼ばれない', (tester) async {
        var loadMoreCalled = false;

        await tester.pumpWidget(
          buildBookGrid(
            books: createTestBooks(20),
            hasMore: false,
            onLoadMore: () => loadMoreCalled = true,
          ),
        );

        await tester.drag(
          find.byType(CustomScrollView),
          const Offset(0, -10000),
        );
        await tester.pumpAndSettle();

        expect(loadMoreCalled, isFalse);
      });
    });

    group('ローディングインジケーター', () {
      testWidgets('追加読み込み中はリスト末尾にローディングインジケーターが表示される',
          (tester) async {
        await tester.pumpWidget(
          buildBookGrid(
            books: createTestBooks(3),
            hasMore: true,
            isLoadingMore: true,
          ),
        );

        expect(find.byType(LoadingIndicator), findsOneWidget);
      });

      testWidgets('追加読み込み中でない場合はローディングインジケーターが表示されない',
          (tester) async {
        await tester.pumpWidget(
          buildBookGrid(
            books: createTestBooks(3),
            hasMore: true,
            isLoadingMore: false,
          ),
        );

        expect(find.byType(LoadingIndicator), findsNothing);
      });
    });

    group('書籍カードタップ', () {
      testWidgets('書籍カードタップ時にonBookTapコールバックが呼ばれる', (tester) async {
        ShelfBookItem? tappedBook;
        final testBooks = createTestBooks(3);

        await tester.pumpWidget(
          buildBookGrid(
            books: testBooks,
            onBookTap: (book) => tappedBook = book,
          ),
        );

        await tester.tap(find.byType(BookCard).first);
        await tester.pump();

        expect(tappedBook, equals(testBooks[0]));
      });
    });
  });
}

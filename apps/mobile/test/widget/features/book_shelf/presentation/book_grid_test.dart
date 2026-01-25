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

  Map<String, List<ShelfBookItem>> createGroupedBooks() {
    return {
      '積読': [
        ShelfBookItem(
          userBookId: 1,
          externalId: 'ext-1',
          title: 'テスト本 1',
          authors: ['著者A'],
          addedAt: DateTime(2024, 1, 1),
        ),
        ShelfBookItem(
          userBookId: 2,
          externalId: 'ext-2',
          title: 'テスト本 2',
          authors: ['著者B'],
          addedAt: DateTime(2024, 1, 2),
        ),
      ],
      '読書中': [
        ShelfBookItem(
          userBookId: 3,
          externalId: 'ext-3',
          title: 'テスト本 3',
          authors: ['著者C'],
          addedAt: DateTime(2024, 1, 3),
        ),
      ],
    };
  }

  Map<String, ShelfEntry> createGroupedShelfState() {
    return {
      'ext-1': ShelfEntry(
        userBookId: 1,
        externalId: 'ext-1',
        readingStatus: ReadingStatus.backlog,
        addedAt: DateTime(2024, 1, 1),
      ),
      'ext-2': ShelfEntry(
        userBookId: 2,
        externalId: 'ext-2',
        readingStatus: ReadingStatus.backlog,
        addedAt: DateTime(2024, 1, 2),
      ),
      'ext-3': ShelfEntry(
        userBookId: 3,
        externalId: 'ext-3',
        readingStatus: ReadingStatus.reading,
        addedAt: DateTime(2024, 1, 3),
      ),
    };
  }

  Widget buildBookGrid({
    List<ShelfBookItem> books = const [],
    Map<String, List<ShelfBookItem>>? groupedBooks,
    Map<String, ShelfEntry>? shelfState,
    bool isGrouped = false,
    bool hasMore = false,
    bool isLoadingMore = false,
    void Function(ShelfBookItem)? onBookTap,
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
            groupedBooks: groupedBooks ?? {},
            isGrouped: isGrouped,
            hasMore: hasMore,
            isLoadingMore: isLoadingMore,
            onBookTap: onBookTap ?? (_) {},
            onLoadMore: onLoadMore ?? () {},
          ),
        ),
      ),
    );
  }

  group('BookGrid', () {
    group('グリッドレイアウト', () {
      testWidgets('3列のグリッドレイアウトで書籍カードが配置される', (tester) async {
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

    group('グループ化表示', () {
      testWidgets('グループ化表示時はセクションヘッダーが挿入される', (tester) async {
        await tester.pumpWidget(
          buildBookGrid(
            groupedBooks: createGroupedBooks(),
            shelfState: createGroupedShelfState(),
            isGrouped: true,
          ),
        );

        expect(find.text('積読'), findsOneWidget);

        await tester.drag(
          find.byType(CustomScrollView),
          const Offset(0, -500),
        );
        await tester.pumpAndSettle();

        expect(find.text('読書中'), findsOneWidget);
      });

      testWidgets('グループ化無効時はセクションヘッダーが表示されない', (tester) async {
        await tester.pumpWidget(
          buildBookGrid(
            books: createTestBooks(6),
            isGrouped: false,
          ),
        );

        expect(find.text('積読'), findsNothing);
        expect(find.text('読書中'), findsNothing);
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_detail/data/book_detail_repository.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_detail/domain/user_book.dart';
import 'package:shelfie/features/book_detail/presentation/book_detail_screen.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    as book_search;
import 'package:shelfie/features/book_search/data/recent_books_repository.dart';
import 'package:shelfie/features/book_search/domain/recent_book_entry.dart';

class MockBookDetailRepository extends Mock implements BookDetailRepository {}

class MockRecentBooksRepository extends Mock implements RecentBooksRepository {}

class MockBookSearchRepository extends Mock
    implements book_search.BookSearchRepository {}

class MockBookListRepository extends Mock implements BookListRepository {}

void main() {
  late MockBookDetailRepository mockRepository;
  late MockBookSearchRepository mockBookSearchRepository;
  late MockRecentBooksRepository mockRecentBooksRepository;
  late MockBookListRepository mockBookListRepository;

  final now = DateTime(2024, 1, 15, 10, 30);

  BookListSummary createSummary({
    int id = 1,
    String title = 'Test List',
    String? description,
    int bookCount = 3,
    List<String> coverImages = const [],
  }) {
    return BookListSummary(
      id: id,
      title: title,
      description: description,
      bookCount: bookCount,
      coverImages: coverImages,
      createdAt: now,
      updatedAt: now,
    );
  }

  BookListItem createItem({
    int id = 1,
    int position = 0,
  }) {
    return BookListItem(
      id: id,
      position: position,
      addedAt: now,
    );
  }

  MyBookListsResult createMyBookListsResult({
    List<BookListSummary>? items,
    int totalCount = 1,
    bool hasMore = false,
  }) {
    return MyBookListsResult(
      items: items ?? [createSummary()],
      totalCount: totalCount,
      hasMore: hasMore,
    );
  }

  setUpAll(() {
    registerFallbackValue(
      RecentBookEntry(
        bookId: 'fallback-id',
        title: 'Fallback Title',
        authors: ['Fallback Author'],
        viewedAt: DateTime.now(),
      ),
    );
  });

  setUp(() {
    mockRepository = MockBookDetailRepository();
    mockBookSearchRepository = MockBookSearchRepository();
    mockRecentBooksRepository = MockRecentBooksRepository();
    mockBookListRepository = MockBookListRepository();

    when(() => mockRecentBooksRepository.add(any())).thenAnswer((_) async {});
    when(() => mockRecentBooksRepository.getAll()).thenAnswer((_) async => []);
  });

  Widget buildTestWidget({
    required String bookId,
    UserBook? userBook,
    List<BookListSummary>? lists,
  }) {
    when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
        .thenAnswer((_) async => right((
              bookDetail: BookDetail(
                id: bookId,
                title: 'Test Book',
                authors: const ['Test Author'],
              ),
              userBook: userBook,
            )));

    if (lists != null) {
      when(() => mockBookListRepository.getMyBookLists()).thenAnswer(
        (_) async => right(createMyBookListsResult(items: lists)),
      );
    }

    return ProviderScope(
      overrides: [
        bookDetailRepositoryProvider.overrideWithValue(mockRepository),
        book_search.bookSearchRepositoryProvider
            .overrideWithValue(mockBookSearchRepository),
        recentBooksRepositoryProvider
            .overrideWithValue(mockRecentBooksRepository),
        bookListRepositoryProvider.overrideWithValue(mockBookListRepository),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: BookDetailScreen(bookId: bookId),
      ),
    );
  }

  group('BookDetailScreen リストに追加ボタン', () {
    testWidgets('本棚に追加済みの場合、リストに追加ボタンが表示される', (tester) async {
      final userBook = UserBook(
        id: 1,
        readingStatus: ReadingStatus.backlog,
        addedAt: DateTime(2024, 1, 1),
      );

      await tester.pumpWidget(buildTestWidget(
        bookId: 'test-id',
        userBook: userBook,
        lists: [createSummary()],
      ));
      await tester.pumpAndSettle();

      expect(find.text('リストに追加'), findsOneWidget);
    });

    testWidgets('本棚に追加されていない場合、リストに追加ボタンは表示されない', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        bookId: 'test-id',
        userBook: null,
        lists: [createSummary()],
      ));
      await tester.pumpAndSettle();

      expect(find.text('リストに追加'), findsNothing);
    });

    testWidgets('リストに追加ボタンをタップするとモーダルが表示される', (tester) async {
      final userBook = UserBook(
        id: 1,
        readingStatus: ReadingStatus.backlog,
        addedAt: DateTime(2024, 1, 1),
      );

      await tester.pumpWidget(buildTestWidget(
        bookId: 'test-id',
        userBook: userBook,
        lists: [createSummary(title: 'My Favorites')],
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('リストに追加'));
      await tester.pumpAndSettle();

      expect(find.text('My Favorites'), findsOneWidget);
    });

    testWidgets('リスト選択後にスナックバーでフィードバックが表示される', (tester) async {
      final userBook = UserBook(
        id: 1,
        readingStatus: ReadingStatus.backlog,
        addedAt: DateTime(2024, 1, 1),
      );

      when(() => mockBookListRepository.addBookToList(
            listId: any(named: 'listId'),
            userBookId: any(named: 'userBookId'),
          )).thenAnswer((_) async => right(createItem()));

      await tester.pumpWidget(buildTestWidget(
        bookId: 'test-id',
        userBook: userBook,
        lists: [createSummary(id: 1, title: 'My Favorites')],
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('リストに追加'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('My Favorites'));
      await tester.pumpAndSettle();

      expect(find.text('リストに追加しました'), findsOneWidget);
    });

    testWidgets('リスト追加エラー時にエラーメッセージが表示される', (tester) async {
      final userBook = UserBook(
        id: 1,
        readingStatus: ReadingStatus.backlog,
        addedAt: DateTime(2024, 1, 1),
      );

      when(() => mockBookListRepository.addBookToList(
            listId: any(named: 'listId'),
            userBookId: any(named: 'userBookId'),
          )).thenAnswer(
        (_) async => left(
          const DuplicateBookFailure(message: 'この本は既にリストに追加されています'),
        ),
      );

      await tester.pumpWidget(buildTestWidget(
        bookId: 'test-id',
        userBook: userBook,
        lists: [createSummary(id: 1, title: 'My Favorites')],
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('リストに追加'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('My Favorites'));
      await tester.pumpAndSettle();

      expect(find.text('この書籍は既にマイライブラリに追加されています'), findsOneWidget);
    });
  });
}

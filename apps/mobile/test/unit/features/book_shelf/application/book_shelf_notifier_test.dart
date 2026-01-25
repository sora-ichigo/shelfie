import 'package:fake_async/fake_async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_notifier.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_state.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

class MockBookShelfRepository extends Mock implements BookShelfRepository {}

void main() {
  late ProviderContainer container;
  late MockBookShelfRepository mockRepository;

  final now = DateTime(2024, 1, 15, 10, 30);

  ShelfBookItem createBook({
    int userBookId = 1,
    String externalId = 'id',
    String title = 'Title',
    List<String> authors = const ['Author'],
    ReadingStatus readingStatus = ReadingStatus.backlog,
    DateTime? addedAt,
  }) {
    return ShelfBookItem(
      userBookId: userBookId,
      externalId: externalId,
      title: title,
      authors: authors,
      readingStatus: readingStatus,
      addedAt: addedAt ?? now,
    );
  }

  MyShelfResult createMyShelfResult({
    List<ShelfBookItem>? items,
    int totalCount = 1,
    bool hasMore = false,
  }) {
    return MyShelfResult(
      items: items ?? [createBook()],
      totalCount: totalCount,
      hasMore: hasMore,
    );
  }

  setUp(() {
    mockRepository = MockBookShelfRepository();
    container = ProviderContainer(
      overrides: [
        bookShelfRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('BookShelfNotifier', () {
    group('build (initialization)', () {
      test('should start with initial state', () {
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        final notifier = container.read(bookShelfNotifierProvider.notifier);

        expect(notifier.state, isA<BookShelfInitial>());
      });

      test('should fetch initial data when initialize is called', () async {
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        expect(notifier.state, isA<BookShelfLoaded>());
      });

      test('should transition to loaded state on success', () async {
        final books = [
          createBook(userBookId: 1, externalId: 'id1'),
          createBook(userBookId: 2, externalId: 'id2'),
        ];
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(items: books, totalCount: 2, hasMore: false),
          ),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        expect(notifier.state, isA<BookShelfLoaded>());
        final loaded = notifier.state as BookShelfLoaded;
        expect(loaded.books.length, 2);
        expect(loaded.totalCount, 2);
        expect(loaded.hasMore, isFalse);
      });

      test('should transition to error state on failure', () async {
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => left(const NetworkFailure(message: 'Network error')),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        expect(notifier.state, isA<BookShelfError>());
        final error = notifier.state as BookShelfError;
        expect(error.failure, isA<NetworkFailure>());
      });

      test('should sync data to ShelfState on success', () async {
        final books = [
          createBook(userBookId: 1, externalId: 'id1'),
          createBook(userBookId: 2, externalId: 'id2'),
        ];
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(items: books, totalCount: 2),
          ),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        final shelfState = container.read(shelfStateProvider);
        expect(shelfState.containsKey('id1'), isTrue);
        expect(shelfState.containsKey('id2'), isTrue);
      });
    });

    group('setSearchQuery', () {
      test('should debounce and send query to server after 300ms', () {
        fakeAsync((async) {
          when(
            () => mockRepository.getMyShelf(
              query: any(named: 'query'),
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer((_) async => right(createMyShelfResult()));

          final notifier = container.read(bookShelfNotifierProvider.notifier);

          async.elapse(Duration.zero);

          notifier.initialize();
          async.elapse(Duration.zero);

          clearInteractions(mockRepository);

          when(
            () => mockRepository.getMyShelf(
              query: 'flutter',
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer((_) async => right(createMyShelfResult()));

          notifier.setSearchQuery('flutter');

          async.elapse(const Duration(milliseconds: 100));

          verifyNever(
            () => mockRepository.getMyShelf(
              query: 'flutter',
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          );

          async.elapse(const Duration(milliseconds: 200));

          verify(
            () => mockRepository.getMyShelf(
              query: 'flutter',
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).called(1);
        });
      });

      test('should cancel previous debounce timer when new query is set', () {
        fakeAsync((async) {
          when(
            () => mockRepository.getMyShelf(
              query: any(named: 'query'),
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer((_) async => right(createMyShelfResult()));

          final notifier = container.read(bookShelfNotifierProvider.notifier);

          async.elapse(Duration.zero);

          notifier.initialize();
          async.elapse(Duration.zero);

          clearInteractions(mockRepository);

          notifier.setSearchQuery('dart');
          async.elapse(const Duration(milliseconds: 200));

          notifier.setSearchQuery('flutter');
          async.elapse(const Duration(milliseconds: 300));

          verifyNever(
            () => mockRepository.getMyShelf(
              query: 'dart',
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          );

          verify(
            () => mockRepository.getMyShelf(
              query: 'flutter',
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).called(1);
        });
      });

      test('should reset offset when search query changes', () {
        fakeAsync((async) {
          when(
            () => mockRepository.getMyShelf(
              query: any(named: 'query'),
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: 0,
            ),
          ).thenAnswer(
            (_) async => right(
              createMyShelfResult(hasMore: true, totalCount: 40),
            ),
          );

          final notifier = container.read(bookShelfNotifierProvider.notifier);
          async.elapse(Duration.zero);

          notifier.initialize();
          async.elapse(Duration.zero);

          when(
            () => mockRepository.getMyShelf(
              query: any(named: 'query'),
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: 20,
            ),
          ).thenAnswer(
            (_) async => right(createMyShelfResult(hasMore: false)),
          );

          notifier.loadMore();
          async.elapse(Duration.zero);

          clearInteractions(mockRepository);

          when(
            () => mockRepository.getMyShelf(
              query: 'test',
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: 0,
            ),
          ).thenAnswer((_) async => right(createMyShelfResult()));

          notifier.setSearchQuery('test');
          async.elapse(const Duration(milliseconds: 300));

          verify(
            () => mockRepository.getMyShelf(
              query: 'test',
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: 0,
            ),
          ).called(1);
        });
      });

      test('should update searchQuery in state after fetch', () {
        fakeAsync((async) {
          when(
            () => mockRepository.getMyShelf(
              query: any(named: 'query'),
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer((_) async => right(createMyShelfResult()));

          final notifier = container.read(bookShelfNotifierProvider.notifier);
          async.elapse(Duration.zero);

          notifier.initialize();
          async.elapse(Duration.zero);

          notifier.setSearchQuery('search term');
          async.elapse(const Duration(milliseconds: 300));

          expect(notifier.state, isA<BookShelfLoaded>());
          final loaded = notifier.state as BookShelfLoaded;
          expect(loaded.searchQuery, 'search term');
        });
      });
    });

    group('setSortOption', () {
      test('should refetch data with new sort option', () async {
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        clearInteractions(mockRepository);

        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: 'TITLE',
            sortOrder: 'ASC',
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        await notifier.setSortOption(SortOption.titleAsc);

        verify(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: 'TITLE',
            sortOrder: 'ASC',
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).called(1);
      });

      test('should update state with new sort option', () async {
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();
        await notifier.setSortOption(SortOption.titleAsc);

        expect(notifier.state, isA<BookShelfLoaded>());
        final loaded = notifier.state as BookShelfLoaded;
        expect(loaded.sortOption, SortOption.titleAsc);
      });
    });

    group('setGroupOption', () {
      test('should update groupOption without refetching', () async {
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        clearInteractions(mockRepository);

        notifier.setGroupOption(GroupOption.byStatus);

        verifyNever(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        );
      });

      test('should update state with new group option', () async {
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();
        notifier.setGroupOption(GroupOption.byStatus);

        expect(notifier.state, isA<BookShelfLoaded>());
        final loaded = notifier.state as BookShelfLoaded;
        expect(loaded.groupOption, GroupOption.byStatus);
      });

      test('should group books by status', () async {
        final books = [
          createBook(userBookId: 1, externalId: 'id1', readingStatus: ReadingStatus.reading),
          createBook(userBookId: 2, externalId: 'id2', readingStatus: ReadingStatus.completed),
          createBook(userBookId: 3, externalId: 'id3', readingStatus: ReadingStatus.reading),
        ];
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(items: books, totalCount: 3),
          ),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();
        notifier.setGroupOption(GroupOption.byStatus);

        final loaded = notifier.state as BookShelfLoaded;
        expect(loaded.groupedBooks.containsKey('読書中'), isTrue);
        expect(loaded.groupedBooks.containsKey('読了'), isTrue);
        expect(loaded.groupedBooks['読書中']?.length, 2);
        expect(loaded.groupedBooks['読了']?.length, 1);
      });

      test('should group books by author', () async {
        final books = [
          createBook(userBookId: 1, externalId: 'id1', authors: ['Author A']),
          createBook(userBookId: 2, externalId: 'id2', authors: ['Author B']),
          createBook(userBookId: 3, externalId: 'id3', authors: ['Author A']),
        ];
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(items: books, totalCount: 3),
          ),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();
        notifier.setGroupOption(GroupOption.byAuthor);

        final loaded = notifier.state as BookShelfLoaded;
        expect(loaded.groupedBooks.containsKey('Author A'), isTrue);
        expect(loaded.groupedBooks.containsKey('Author B'), isTrue);
        expect(loaded.groupedBooks['Author A']?.length, 2);
        expect(loaded.groupedBooks['Author B']?.length, 1);
      });

      test('should clear grouped books when set to none', () async {
        final books = [
          createBook(userBookId: 1, externalId: 'id1', readingStatus: ReadingStatus.reading),
        ];
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(items: books, totalCount: 1),
          ),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();
        notifier.setGroupOption(GroupOption.byStatus);
        notifier.setGroupOption(GroupOption.none);

        final loaded = notifier.state as BookShelfLoaded;
        expect(loaded.groupedBooks, isEmpty);
        expect(loaded.groupOption, GroupOption.none);
      });
    });

    group('loadMore', () {
      test('should fetch next page', () async {
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(
              items: [createBook(userBookId: 1, externalId: 'id1')],
              totalCount: 40,
              hasMore: true,
            ),
          ),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 20,
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(
              items: [createBook(userBookId: 2, externalId: 'id2')],
              totalCount: 40,
              hasMore: true,
            ),
          ),
        );

        await notifier.loadMore();

        verify(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 20,
          ),
        ).called(1);
      });

      test('should append new books to existing list', () async {
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(
              items: [createBook(userBookId: 1, externalId: 'id1')],
              totalCount: 40,
              hasMore: true,
            ),
          ),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 20,
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(
              items: [createBook(userBookId: 2, externalId: 'id2')],
              totalCount: 40,
              hasMore: false,
            ),
          ),
        );

        await notifier.loadMore();

        final loaded = notifier.state as BookShelfLoaded;
        expect(loaded.books.length, 2);
        expect(loaded.books[0].externalId, 'id1');
        expect(loaded.books[1].externalId, 'id2');
      });

      test('should not load more if hasMore is false', () async {
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(hasMore: false),
          ),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        clearInteractions(mockRepository);

        await notifier.loadMore();

        verifyNever(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        );
      });

      test('should set isLoadingMore to true while loading', () async {
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(hasMore: true, totalCount: 40),
          ),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        var capturedLoadingState = false;

        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 20,
          ),
        ).thenAnswer((_) async {
          final currentState = notifier.state as BookShelfLoaded;
          capturedLoadingState = currentState.isLoadingMore;
          return right(createMyShelfResult(hasMore: false));
        });

        await notifier.loadMore();

        expect(capturedLoadingState, isTrue);
      });
    });

    group('refresh', () {
      test('should refetch from first page', () async {
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(createMyShelfResult()),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();
        await notifier.loadMore();

        clearInteractions(mockRepository);

        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).thenAnswer(
          (_) async => right(createMyShelfResult()),
        );

        await notifier.refresh();

        verify(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).called(1);
      });

      test('should maintain current sort option after refresh', () async {
        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(createMyShelfResult()),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();
        await notifier.setSortOption(SortOption.titleAsc);

        clearInteractions(mockRepository);

        when(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: 'TITLE',
            sortOrder: 'ASC',
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).thenAnswer(
          (_) async => right(createMyShelfResult()),
        );

        await notifier.refresh();

        verify(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: 'TITLE',
            sortOrder: 'ASC',
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).called(1);
      });
    });
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_notifier.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_state.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_settings_repository.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

class MockBookShelfRepository extends Mock implements BookShelfRepository {}

class MockBookShelfSettingsRepository extends Mock
    implements BookShelfSettingsRepository {}

class FakeGShelfSortField extends Fake implements GShelfSortField {}

class FakeGSortOrder extends Fake implements GSortOrder {}

void main() {
  late ProviderContainer container;
  late MockBookShelfRepository mockRepository;
  late MockBookShelfSettingsRepository mockSettingsRepository;

  final now = DateTime(2024, 1, 15, 10, 30);

  ShelfBookItem createBook({
    int userBookId = 1,
    String externalId = 'id',
    String title = 'Title',
    List<String> authors = const ['Author'],
    DateTime? addedAt,
  }) {
    return ShelfBookItem(
      userBookId: userBookId,
      externalId: externalId,
      title: title,
      authors: authors,
      addedAt: addedAt ?? now,
    );
  }

  ShelfEntry createEntry({
    required int userBookId,
    required String externalId,
    ReadingStatus readingStatus = ReadingStatus.backlog,
    DateTime? addedAt,
  }) {
    return ShelfEntry(
      userBookId: userBookId,
      externalId: externalId,
      readingStatus: readingStatus,
      addedAt: addedAt ?? now,
    );
  }

  MyShelfResult createMyShelfResult({
    List<ShelfBookItem>? items,
    Map<String, ShelfEntry>? entries,
    int totalCount = 1,
    bool hasMore = false,
  }) {
    final bookItems = items ?? [createBook()];
    final bookEntries = entries ??
        {
          for (final item in bookItems)
            item.externalId: createEntry(
              userBookId: item.userBookId,
              externalId: item.externalId,
            ),
        };
    return MyShelfResult(
      items: bookItems,
      entries: bookEntries,
      totalCount: totalCount,
      hasMore: hasMore,
    );
  }

  setUpAll(() {
    registerFallbackValue(FakeGShelfSortField());
    registerFallbackValue(FakeGSortOrder());
    registerFallbackValue(SortOption.defaultOption);
    registerFallbackValue(GroupOption.defaultOption);
  });

  setUp(() {
    mockRepository = MockBookShelfRepository();
    mockSettingsRepository = MockBookShelfSettingsRepository();

    when(() => mockSettingsRepository.getSortOption())
        .thenReturn(SortOption.defaultOption);
    when(() => mockSettingsRepository.getGroupOption())
        .thenReturn(GroupOption.defaultOption);
    when(() => mockSettingsRepository.setSortOption(any()))
        .thenAnswer((_) async {});
    when(() => mockSettingsRepository.setGroupOption(any()))
        .thenAnswer((_) async {});

    container = ProviderContainer(
      overrides: [
        bookShelfRepositoryProvider.overrideWithValue(mockRepository),
        bookShelfSettingsRepositoryProvider
            .overrideWithValue(mockSettingsRepository),
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

    group('setSortOption', () {
      test('should refetch data with new sort option', () async {
        when(
          () => mockRepository.getMyShelf(
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
            sortBy: GShelfSortField.TITLE,
            sortOrder: GSortOrder.ASC,
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        await notifier.setSortOption(SortOption.titleAsc);

        verify(
          () => mockRepository.getMyShelf(
            query: any(named: 'query'),
            sortBy: GShelfSortField.TITLE,
            sortOrder: GSortOrder.ASC,
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).called(1);
      });

      test('should update state with new sort option', () async {
        when(
          () => mockRepository.getMyShelf(
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
          createBook(userBookId: 1, externalId: 'id1'),
          createBook(userBookId: 2, externalId: 'id2'),
          createBook(userBookId: 3, externalId: 'id3'),
        ];
        final entries = {
          'id1': createEntry(userBookId: 1, externalId: 'id1', readingStatus: ReadingStatus.reading),
          'id2': createEntry(userBookId: 2, externalId: 'id2', readingStatus: ReadingStatus.completed),
          'id3': createEntry(userBookId: 3, externalId: 'id3', readingStatus: ReadingStatus.reading),
        };
        when(
          () => mockRepository.getMyShelf(
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(items: books, entries: entries, totalCount: 3),
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

      test('should order status groups as 読書中→積読→読了→読まない', () async {
        final books = [
          createBook(userBookId: 1, externalId: 'id1'),
          createBook(userBookId: 2, externalId: 'id2'),
          createBook(userBookId: 3, externalId: 'id3'),
          createBook(userBookId: 4, externalId: 'id4'),
        ];
        final entries = {
          'id1': createEntry(userBookId: 1, externalId: 'id1', readingStatus: ReadingStatus.dropped),
          'id2': createEntry(userBookId: 2, externalId: 'id2', readingStatus: ReadingStatus.completed),
          'id3': createEntry(userBookId: 3, externalId: 'id3', readingStatus: ReadingStatus.backlog),
          'id4': createEntry(userBookId: 4, externalId: 'id4', readingStatus: ReadingStatus.reading),
        };
        when(
          () => mockRepository.getMyShelf(
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(items: books, entries: entries, totalCount: 4),
          ),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();
        notifier.setGroupOption(GroupOption.byStatus);

        final loaded = notifier.state as BookShelfLoaded;
        final groupKeys = loaded.groupedBooks.keys.toList();
        expect(groupKeys, ['読書中', '積読', '読了', '読まない']);
      });

      test('should group books by author', () async {
        final books = [
          createBook(userBookId: 1, externalId: 'id1', authors: ['Author A']),
          createBook(userBookId: 2, externalId: 'id2', authors: ['Author B']),
          createBook(userBookId: 3, externalId: 'id3', authors: ['Author A']),
        ];
        when(
          () => mockRepository.getMyShelf(
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
          createBook(userBookId: 1, externalId: 'id1'),
        ];
        final entries = {
          'id1': createEntry(userBookId: 1, externalId: 'id1', readingStatus: ReadingStatus.reading),
        };
        when(
          () => mockRepository.getMyShelf(
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(items: books, entries: entries, totalCount: 1),
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

    group('regroupBooks', () {
      test('should regroup books based on current ShelfState', () async {
        final books = [
          createBook(userBookId: 1, externalId: 'id1'),
          createBook(userBookId: 2, externalId: 'id2'),
          createBook(userBookId: 3, externalId: 'id3'),
        ];
        final entries = {
          'id1': createEntry(userBookId: 1, externalId: 'id1', readingStatus: ReadingStatus.reading),
          'id2': createEntry(userBookId: 2, externalId: 'id2', readingStatus: ReadingStatus.reading),
          'id3': createEntry(userBookId: 3, externalId: 'id3', readingStatus: ReadingStatus.completed),
        };
        when(
          () => mockRepository.getMyShelf(
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(items: books, entries: entries, totalCount: 3),
          ),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();
        notifier.setGroupOption(GroupOption.byStatus);

        final loadedBefore = notifier.state as BookShelfLoaded;
        expect(loadedBefore.groupedBooks['読書中']?.length, 2);
        expect(loadedBefore.groupedBooks['読了']?.length, 1);

        // ShelfState の読書状態を外部から変更（Quick Action を模倣）
        container.read(shelfStateProvider.notifier).updateReadingStatus(
              externalId: 'id1',
              status: ReadingStatus.completed,
            );

        // regroupBooks を呼ぶと新しい ShelfState に基づいて再グループ化される
        notifier.regroupBooks();

        final loadedAfter = notifier.state as BookShelfLoaded;
        expect(loadedAfter.groupedBooks['読書中']?.length, 1);
        expect(loadedAfter.groupedBooks['読了']?.length, 2);
      });

      test('should do nothing if state is not loaded', () async {
        final notifier = container.read(bookShelfNotifierProvider.notifier);
        notifier.regroupBooks();
        expect(notifier.state, isA<BookShelfInitial>());
      });

      test('should do nothing if groupOption is none', () async {
        when(
          () => mockRepository.getMyShelf(
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        // groupOption はデフォルトの none
        notifier.regroupBooks();

        final loaded = notifier.state as BookShelfLoaded;
        expect(loaded.groupedBooks, isEmpty);
      });
    });

    group('refresh', () {
      test('should refetch from first page', () async {
        when(
          () => mockRepository.getMyShelf(
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
            sortBy: GShelfSortField.TITLE,
            sortOrder: GSortOrder.ASC,
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
            sortBy: GShelfSortField.TITLE,
            sortOrder: GSortOrder.ASC,
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).called(1);
      });
    });

    group('settings persistence', () {
      test('should load saved sort option on initialize', () async {
        when(() => mockSettingsRepository.getSortOption())
            .thenReturn(SortOption.titleAsc);
        when(
          () => mockRepository.getMyShelf(
            sortBy: GShelfSortField.TITLE,
            sortOrder: GSortOrder.ASC,
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        verify(
          () => mockRepository.getMyShelf(
            sortBy: GShelfSortField.TITLE,
            sortOrder: GSortOrder.ASC,
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).called(1);

        final loaded = notifier.state as BookShelfLoaded;
        expect(loaded.sortOption, SortOption.titleAsc);
      });

      test('should load saved group option on initialize', () async {
        when(() => mockSettingsRepository.getGroupOption())
            .thenReturn(GroupOption.byStatus);
        final books = [
          createBook(userBookId: 1, externalId: 'id1'),
        ];
        final entries = {
          'id1': createEntry(
            userBookId: 1,
            externalId: 'id1',
            readingStatus: ReadingStatus.reading,
          ),
        };
        when(
          () => mockRepository.getMyShelf(
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(items: books, entries: entries, totalCount: 1),
          ),
        );

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        final loaded = notifier.state as BookShelfLoaded;
        expect(loaded.groupOption, GroupOption.byStatus);
        expect(loaded.groupedBooks.isNotEmpty, isTrue);
      });

      test('should persist sort option when setSortOption is called', () async {
        when(
          () => mockRepository.getMyShelf(
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        clearInteractions(mockSettingsRepository);

        await notifier.setSortOption(SortOption.authorAsc);

        verify(() => mockSettingsRepository.setSortOption(SortOption.authorAsc))
            .called(1);
      });

      test('should persist group option when setGroupOption is called',
          () async {
        when(
          () => mockRepository.getMyShelf(
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        final notifier = container.read(bookShelfNotifierProvider.notifier);
        await notifier.initialize();

        clearInteractions(mockSettingsRepository);

        notifier.setGroupOption(GroupOption.byAuthor);

        verify(
          () => mockSettingsRepository.setGroupOption(GroupOption.byAuthor),
        ).called(1);
      });
    });
  });
}

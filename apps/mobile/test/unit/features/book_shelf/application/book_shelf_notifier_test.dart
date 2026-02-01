import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/state/shelf_version.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_notifier.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_state.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_settings_repository.dart';

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
  });

  setUp(() {
    mockRepository = MockBookShelfRepository();
    mockSettingsRepository = MockBookShelfSettingsRepository();

    when(() => mockSettingsRepository.getSortOption())
        .thenReturn(SortOption.defaultOption);
    when(() => mockSettingsRepository.setSortOption(any()))
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
      test('should start with loading state', () {
        when(
          () => mockRepository.getMyShelf(
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        final notifier = container.read(bookShelfNotifierProvider.notifier);

        expect(notifier.state, isA<BookShelfLoading>());
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
            offset: 10,
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
            offset: 10,
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
            offset: 10,
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
            offset: 10,
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

    group('setSearchQuery', () {
      test('should refetch data with search query', () async {
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
            query: 'テスト',
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(
              items: [createBook(userBookId: 10, externalId: 'id10', title: 'テスト本')],
              totalCount: 1,
            ),
          ),
        );

        await notifier.setSearchQuery('テスト');

        verify(
          () => mockRepository.getMyShelf(
            query: 'テスト',
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).called(1);

        final loaded = notifier.state as BookShelfLoaded;
        expect(loaded.books.length, 1);
        expect(loaded.books[0].title, 'テスト本');
      });

      test('should reset offset when search query changes', () async {
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

        when(
          () => mockRepository.getMyShelf(
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 10,
          ),
        ).thenAnswer(
          (_) async => right(createMyShelfResult(hasMore: true, totalCount: 40)),
        );

        await notifier.loadMore();

        clearInteractions(mockRepository);

        when(
          () => mockRepository.getMyShelf(
            query: '検索',
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        await notifier.setSearchQuery('検索');

        verify(
          () => mockRepository.getMyShelf(
            query: '検索',
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).called(1);
      });

      test('should pass null query when search query is empty', () async {
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

        when(
          () => mockRepository.getMyShelf(
            query: '検索',
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        await notifier.setSearchQuery('検索');

        clearInteractions(mockRepository);

        when(
          () => mockRepository.getMyShelf(
            query: null,
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        await notifier.setSearchQuery('');

        verify(
          () => mockRepository.getMyShelf(
            query: null,
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).called(1);
      });
    });

    group('clearSearchQuery', () {
      test('should clear query and refetch all books', () async {
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

        when(
          () => mockRepository.getMyShelf(
            query: '検索',
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => right(createMyShelfResult()));

        await notifier.setSearchQuery('検索');

        clearInteractions(mockRepository);

        when(
          () => mockRepository.getMyShelf(
            query: null,
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(
              items: [
                createBook(userBookId: 1, externalId: 'id1'),
                createBook(userBookId: 2, externalId: 'id2'),
              ],
              totalCount: 2,
            ),
          ),
        );

        await notifier.clearSearchQuery();

        verify(
          () => mockRepository.getMyShelf(
            query: null,
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).called(1);

        final loaded = notifier.state as BookShelfLoaded;
        expect(loaded.books.length, 2);
      });
    });

    group('settings persistence', () {
      test('should load saved sort option on build', () async {
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

        BookShelfState? lastState;
        container.listen(bookShelfNotifierProvider, (_, state) {
          lastState = state;
        });
        await Future<void>(() {});

        verify(
          () => mockRepository.getMyShelf(
            sortBy: GShelfSortField.TITLE,
            sortOrder: GSortOrder.ASC,
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).called(1);

        final loaded = lastState! as BookShelfLoaded;
        expect(loaded.sortOption, SortOption.titleAsc);
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
    });

    group('shelfVersion 連動', () {
      test('shelfVersion が変わったとき refresh が呼ばれる', () async {
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
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(
              items: [
                createBook(userBookId: 10, externalId: 'id10'),
                createBook(userBookId: 11, externalId: 'id11'),
              ],
              totalCount: 2,
            ),
          ),
        );

        container.read(shelfVersionProvider.notifier).increment();

        await Future<void>.delayed(Duration.zero);

        verify(
          () => mockRepository.getMyShelf(
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).called(1);
      });
    });
  });
}

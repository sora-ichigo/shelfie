import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/application/shelf_search_notifier.dart';
import 'package:shelfie/features/book_shelf/application/shelf_search_state.dart';
import 'package:shelfie/features/book_shelf/application/sort_option_notifier.dart';
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
  });

  setUp(() {
    mockRepository = MockBookShelfRepository();
    mockSettingsRepository = MockBookShelfSettingsRepository();

    when(() => mockSettingsRepository.getSortOption())
        .thenReturn(SortOption.defaultOption);

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

  group('ShelfSearchNotifier', () {
    group('build (initialization)', () {
      test('初期状態は initial', () {
        final state = container.read(shelfSearchNotifierProvider());
        expect(state, isA<ShelfSearchInitial>());
      });
    });

    group('search', () {
      test('空文字の場合は initial 状態のまま（API不発火）', () async {
        final notifier =
            container.read(shelfSearchNotifierProvider().notifier);

        await notifier.search('');

        final state = container.read(shelfSearchNotifierProvider());
        expect(state, isA<ShelfSearchInitial>());
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

      test('クエリ指定時に loaded 状態になる', () async {
        final books = [
          createBook(userBookId: 1, externalId: 'book1', title: 'Flutter入門'),
        ];
        when(
          () => mockRepository.getMyShelf(
            query: 'Flutter',
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

        final notifier =
            container.read(shelfSearchNotifierProvider().notifier);
        await notifier.search('Flutter');

        final state = container.read(shelfSearchNotifierProvider());
        expect(state, isA<ShelfSearchLoaded>());
        final loaded = state as ShelfSearchLoaded;
        expect(loaded.books.length, 1);
        expect(loaded.books.first.title, 'Flutter入門');
        expect(loaded.totalCount, 1);
      });

      test('API エラー時に error 状態になる', () async {
        when(
          () => mockRepository.getMyShelf(
            query: 'error',
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async =>
              left(const NetworkFailure(message: 'No internet connection')),
        );

        final notifier =
            container.read(shelfSearchNotifierProvider().notifier);
        await notifier.search('error');

        final state = container.read(shelfSearchNotifierProvider());
        expect(state, isA<ShelfSearchError>());
      });

      test('新しいクエリで検索するとオフセットがリセットされる', () async {
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

        final notifier =
            container.read(shelfSearchNotifierProvider().notifier);
        await notifier.search('first');
        await notifier.search('second');

        verify(
          () => mockRepository.getMyShelf(
            query: 'second',
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).called(1);
      });

      test('検索後に空文字を入力すると initial に戻る', () async {
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

        final notifier =
            container.read(shelfSearchNotifierProvider().notifier);
        await notifier.search('Flutter');
        await notifier.search('');

        final state = container.read(shelfSearchNotifierProvider());
        expect(state, isA<ShelfSearchInitial>());
      });
    });

    group('loadMore', () {
      test('loaded かつ hasMore の場合に追加読み込みできる', () async {
        final firstBooks = [
          createBook(userBookId: 1, externalId: 'book1'),
        ];
        final moreBooks = [
          createBook(userBookId: 2, externalId: 'book2'),
        ];

        when(
          () => mockRepository.getMyShelf(
            query: 'test',
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(
              items: firstBooks,
              totalCount: 2,
              hasMore: true,
            ),
          ),
        );

        when(
          () => mockRepository.getMyShelf(
            query: 'test',
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 10,
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(
              items: moreBooks,
              totalCount: 2,
              hasMore: false,
            ),
          ),
        );

        final notifier =
            container.read(shelfSearchNotifierProvider().notifier);
        await notifier.search('test');
        await notifier.loadMore();

        final state = container.read(shelfSearchNotifierProvider());
        expect(state, isA<ShelfSearchLoaded>());
        final loaded = state as ShelfSearchLoaded;
        expect(loaded.books.length, 2);
      });

      test('initial 状態では loadMore しない', () async {
        final notifier =
            container.read(shelfSearchNotifierProvider().notifier);
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

      test('hasMore が false の場合は loadMore しない', () async {
        when(
          () => mockRepository.getMyShelf(
            query: 'test',
            sortBy: any(named: 'sortBy'),
            sortOrder: any(named: 'sortOrder'),
            limit: any(named: 'limit'),
            offset: 0,
          ),
        ).thenAnswer(
          (_) async => right(
            createMyShelfResult(hasMore: false),
          ),
        );

        final notifier =
            container.read(shelfSearchNotifierProvider().notifier);
        await notifier.search('test');

        // Reset call count
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
    });

    group('sort option', () {
      test('現在のソートオプションを使って検索する', () async {
        // SortOptionNotifier を titleAsc にオーバーライド
        container = ProviderContainer(
          overrides: [
            bookShelfRepositoryProvider.overrideWithValue(mockRepository),
            bookShelfSettingsRepositoryProvider
                .overrideWithValue(mockSettingsRepository),
            sortOptionNotifierProvider.overrideWith(() {
              return SortOptionNotifier();
            }),
          ],
        );

        when(() => mockSettingsRepository.getSortOption())
            .thenReturn(SortOption.titleAsc);

        when(
          () => mockRepository.getMyShelf(
            query: 'test',
            sortBy: GShelfSortField.TITLE,
            sortOrder: GSortOrder.ASC,
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer(
          (_) async => right(createMyShelfResult()),
        );

        final notifier =
            container.read(shelfSearchNotifierProvider().notifier);
        await notifier.search('test');

        verify(
          () => mockRepository.getMyShelf(
            query: 'test',
            sortBy: GShelfSortField.TITLE,
            sortOrder: GSortOrder.ASC,
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          ),
        ).called(1);
      });
    });
  });
}

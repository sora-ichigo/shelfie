import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_version.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/application/status_section_notifier.dart';
import 'package:shelfie/features/book_shelf/application/status_section_state.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_settings_repository.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

class MockBookShelfRepository implements BookShelfRepository {
  MyShelfResult? nextResult;
  Failure? nextError;
  int callCount = 0;
  GReadingStatus? lastReadingStatus;
  int? lastOffset;
  int? lastLimit;
  GShelfSortField? lastSortBy;
  GSortOrder? lastSortOrder;

  @override
  Future<Either<Failure, MyShelfResult>> getMyShelf({
    String? query,
    GShelfSortField? sortBy,
    GSortOrder? sortOrder,
    int? limit,
    int? offset,
    GReadingStatus? readingStatus,
  }) async {
    callCount++;
    lastReadingStatus = readingStatus;
    lastOffset = offset;
    lastLimit = limit;
    lastSortBy = sortBy;
    lastSortOrder = sortOrder;
    if (nextError != null) {
      return left(nextError!);
    }
    return right(nextResult!);
  }

  @override
  Future<Either<Failure, MyShelfResult>> getUserShelf({
    required int userId,
    int? limit,
    int? offset,
  }) async {
    throw UnimplementedError();
  }
}

MyShelfResult createMockResult({
  int count = 3,
  bool hasMore = false,
  int totalCount = 3,
  ReadingStatus status = ReadingStatus.reading,
}) {
  final items = List.generate(
    count,
    (i) => ShelfBookItem(
      userBookId: i + 1,
      externalId: 'book-$i',
      title: 'Book $i',
      authors: ['Author $i'],
      addedAt: DateTime(2025, 1, 1),
    ),
  );

  final entries = <String, ShelfEntry>{};
  for (final item in items) {
    entries[item.externalId] = ShelfEntry(
      userBookId: item.userBookId,
      externalId: item.externalId,
      readingStatus: status,
      addedAt: item.addedAt,
    );
  }

  return MyShelfResult(
    items: items,
    entries: entries,
    totalCount: totalCount,
    hasMore: hasMore,
  );
}

class FakeBookShelfSettingsRepository
    implements BookShelfSettingsRepository {
  FakeBookShelfSettingsRepository([SortOption? initial]) {
    if (initial != null) _current = initial;
  }

  SortOption _current = SortOption.defaultOption;

  @override
  SortOption getSortOption() => _current;

  @override
  Future<void> setSortOption(SortOption option) async {
    _current = option;
  }
}

void main() {
  late MockBookShelfRepository mockRepository;
  late FakeBookShelfSettingsRepository fakeSettingsRepo;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockBookShelfRepository();
    fakeSettingsRepo = FakeBookShelfSettingsRepository();
    container = ProviderContainer(
      overrides: [
        bookShelfRepositoryProvider.overrideWithValue(mockRepository),
        bookShelfSettingsRepositoryProvider
            .overrideWithValue(fakeSettingsRepo),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('StatusSectionNotifier', () {
    group('initialize', () {
      test('初期状態は StatusSectionInitial である', () {
        final state = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading),
        );
        expect(state, isA<StatusSectionInitial>());
      });

      test('initialize で正常にデータを取得して loaded 状態になる', () async {
        mockRepository.nextResult = createMockResult(
          count: 3,
          totalCount: 10,
          hasMore: true,
        );

        final notifier = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading).notifier,
        );
        await notifier.initialize();

        final state = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading),
        );
        expect(state, isA<StatusSectionLoaded>());
        final loaded = state as StatusSectionLoaded;
        expect(loaded.books.length, 3);
        expect(loaded.totalCount, 10);
        expect(loaded.hasMore, true);
        expect(loaded.isLoadingMore, false);
      });

      test('initialize で readingStatus が正しく渡される', () async {
        mockRepository.nextResult = createMockResult();

        final notifier = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading).notifier,
        );
        await notifier.initialize();

        expect(mockRepository.lastReadingStatus, GReadingStatus.READING);
      });

      test('initialize で backlog の readingStatus が正しく渡される', () async {
        mockRepository.nextResult = createMockResult(
          status: ReadingStatus.backlog,
        );

        final notifier = container.read(
          statusSectionNotifierProvider(ReadingStatus.backlog).notifier,
        );
        await notifier.initialize();

        expect(mockRepository.lastReadingStatus, GReadingStatus.BACKLOG);
      });

      test('initialize でエラーが発生した場合 error 状態になる', () async {
        mockRepository.nextError = const ServerFailure(
          message: 'Failed to fetch',
          code: 'SERVER_ERROR',
        );

        final notifier = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading).notifier,
        );
        await notifier.initialize();

        final state = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading),
        );
        expect(state, isA<StatusSectionError>());
      });
    });

    group('loadMore', () {
      test('loadMore で追加データを既存リストに結合する', () async {
        mockRepository.nextResult = createMockResult(
          count: 3,
          totalCount: 10,
          hasMore: true,
        );

        final notifier = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading).notifier,
        );
        await notifier.initialize();

        mockRepository.nextResult = MyShelfResult(
          items: [
            ShelfBookItem(
              userBookId: 4,
              externalId: 'book-3',
              title: 'Book 3',
              authors: const ['Author 3'],
              addedAt: DateTime(2025, 1, 2),
            ),
          ],
          entries: {
            'book-3': ShelfEntry(
              userBookId: 4,
              externalId: 'book-3',
              readingStatus: ReadingStatus.reading,
              addedAt: DateTime(2025, 1, 1),
            ),
          },
          totalCount: 10,
          hasMore: true,
        );

        await notifier.loadMore();

        final state = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading),
        );
        final loaded = state as StatusSectionLoaded;
        expect(loaded.books.length, 4);
        expect(loaded.totalCount, 10);
      });

      test('loadMore で正しい offset が渡される', () async {
        mockRepository.nextResult = createMockResult(
          count: 3,
          totalCount: 10,
          hasMore: true,
        );

        final notifier = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading).notifier,
        );
        await notifier.initialize();

        mockRepository.nextResult = createMockResult(
          count: 3,
          totalCount: 10,
          hasMore: true,
        );
        await notifier.loadMore();

        expect(mockRepository.lastOffset, 3);
      });

      test('hasMore が false のとき loadMore は何もしない', () async {
        mockRepository.nextResult = createMockResult(
          count: 3,
          totalCount: 3,
          hasMore: false,
        );

        final notifier = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading).notifier,
        );
        await notifier.initialize();

        final callCountBefore = mockRepository.callCount;
        await notifier.loadMore();

        expect(mockRepository.callCount, callCountBefore);
      });
    });

    group('refresh', () {
      test('refresh で offset をリセットしてデータを再取得する', () async {
        mockRepository.nextResult = createMockResult(
          count: 3,
          totalCount: 10,
          hasMore: true,
        );

        final notifier = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading).notifier,
        );
        await notifier.initialize();

        mockRepository.nextResult = createMockResult(
          count: 5,
          totalCount: 5,
          hasMore: false,
        );
        await notifier.refresh();

        final state = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading),
        );
        final loaded = state as StatusSectionLoaded;
        expect(loaded.books.length, 5);
        expect(loaded.hasMore, false);
        expect(mockRepository.lastOffset, 0);
      });
    });

    group('removeBook', () {
      test('removeBook でローカルリストから書籍を除去し totalCount を減算する', () async {
        mockRepository.nextResult = createMockResult(
          count: 3,
          totalCount: 3,
          hasMore: false,
        );

        final notifier = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading).notifier,
        );
        await notifier.initialize();

        notifier.removeBook('book-1');

        final state = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading),
        );
        final loaded = state as StatusSectionLoaded;
        expect(loaded.books.length, 2);
        expect(loaded.totalCount, 2);
        expect(
          loaded.books.every((b) => b.externalId != 'book-1'),
          true,
        );
      });
    });

    group('retry', () {
      test('retry でエラー後にデータを再取得する', () async {
        mockRepository.nextError = const ServerFailure(
          message: 'Failed',
          code: 'ERROR',
        );

        final notifier = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading).notifier,
        );
        await notifier.initialize();

        expect(
          container.read(
            statusSectionNotifierProvider(ReadingStatus.reading),
          ),
          isA<StatusSectionError>(),
        );

        mockRepository.nextError = null;
        mockRepository.nextResult = createMockResult(
          count: 2,
          totalCount: 2,
          hasMore: false,
        );

        await notifier.retry();

        final state = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading),
        );
        expect(state, isA<StatusSectionLoaded>());
        final loaded = state as StatusSectionLoaded;
        expect(loaded.books.length, 2);
      });
    });

    group('readingStatus to GReadingStatus 変換', () {
      test('全てのステータスが正しく変換される', () async {
        for (final status in ReadingStatus.values) {
          final mockRepo = MockBookShelfRepository();
          mockRepo.nextResult = createMockResult(status: status);

          final c = ProviderContainer(
            overrides: [
              bookShelfRepositoryProvider.overrideWithValue(mockRepo),
              bookShelfSettingsRepositoryProvider
                  .overrideWithValue(FakeBookShelfSettingsRepository()),
            ],
          );

          final notifier = c.read(
            statusSectionNotifierProvider(status).notifier,
          );
          await notifier.initialize();

          final expected = switch (status) {
            ReadingStatus.reading => GReadingStatus.READING,
            ReadingStatus.backlog => GReadingStatus.BACKLOG,
            ReadingStatus.completed => GReadingStatus.COMPLETED,
            ReadingStatus.interested => GReadingStatus.INTERESTED,
          };
          expect(mockRepo.lastReadingStatus, expected);

          c.dispose();
        }
      });
    });

    group('shelfVersion 連動', () {
      test('shelfVersion が変わったとき refresh が呼ばれる', () async {
        mockRepository.nextResult = createMockResult(
          count: 3,
          totalCount: 3,
          hasMore: false,
        );

        final notifier = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading).notifier,
        );
        await notifier.initialize();

        final callCountAfterInit = mockRepository.callCount;

        mockRepository.nextResult = createMockResult(
          count: 5,
          totalCount: 5,
          hasMore: false,
        );

        container.read(shelfVersionProvider.notifier).increment();

        await Future<void>.delayed(Duration.zero);

        expect(mockRepository.callCount, callCountAfterInit + 1);
      });
    });

    group('ソートパラメータ', () {
      test('initialize でデフォルトのソートパラメータが渡される', () async {
        mockRepository.nextResult = createMockResult();

        final notifier = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading).notifier,
        );
        await notifier.initialize();

        expect(mockRepository.lastSortBy, GShelfSortField.ADDED_AT);
        expect(mockRepository.lastSortOrder, GSortOrder.DESC);
      });

      test('initialize でカスタムのソートパラメータが渡される', () async {
        final customSettingsRepo =
            FakeBookShelfSettingsRepository(SortOption.titleAsc);
        final mockRepo = MockBookShelfRepository();
        mockRepo.nextResult = createMockResult();

        final c = ProviderContainer(
          overrides: [
            bookShelfRepositoryProvider.overrideWithValue(mockRepo),
            bookShelfSettingsRepositoryProvider
                .overrideWithValue(customSettingsRepo),
          ],
        );

        final notifier = c.read(
          statusSectionNotifierProvider(ReadingStatus.reading).notifier,
        );
        await notifier.initialize();

        expect(mockRepo.lastSortBy, GShelfSortField.TITLE);
        expect(mockRepo.lastSortOrder, GSortOrder.ASC);

        c.dispose();
      });

      test('loadMore で現在のソートパラメータが渡される', () async {
        mockRepository.nextResult = createMockResult(
          count: 3,
          totalCount: 10,
          hasMore: true,
        );

        final notifier = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading).notifier,
        );
        await notifier.initialize();

        mockRepository.nextResult = createMockResult(
          count: 3,
          totalCount: 10,
          hasMore: true,
        );
        await notifier.loadMore();

        expect(mockRepository.lastSortBy, GShelfSortField.ADDED_AT);
        expect(mockRepository.lastSortOrder, GSortOrder.DESC);
      });

      test('refresh で現在のソートパラメータが渡される', () async {
        mockRepository.nextResult = createMockResult();

        final notifier = container.read(
          statusSectionNotifierProvider(ReadingStatus.reading).notifier,
        );
        await notifier.initialize();

        mockRepository.nextResult = createMockResult();
        await notifier.refresh();

        expect(mockRepository.lastSortBy, GShelfSortField.ADDED_AT);
        expect(mockRepository.lastSortOrder, GSortOrder.DESC);
      });
    });
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/state/shelf_version.dart';
import 'package:shelfie/features/account/application/profile_books_notifier.dart';
import 'package:shelfie/features/account/application/profile_books_state.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_settings_repository.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

class MockBookShelfRepository extends Mock implements BookShelfRepository {}

class MockBookShelfSettingsRepository extends Mock
    implements BookShelfSettingsRepository {}

MyShelfResult _createShelfResult({
  List<ShelfBookItem>? items,
  int totalCount = 0,
  bool hasMore = false,
}) {
  return MyShelfResult(
    items: items ?? [],
    entries: {},
    totalCount: totalCount,
    hasMore: hasMore,
  );
}

ShelfBookItem _createBook(String id, String title) {
  return ShelfBookItem(
    userBookId: id.hashCode,
    externalId: id,
    title: title,
    authors: ['Author'],
    addedAt: DateTime(2024, 1, 1),
    source: BookSource.rakuten,
  );
}

void main() {
  late MockBookShelfRepository mockRepository;
  late MockBookShelfSettingsRepository mockSettingsRepository;

  setUp(() {
    mockRepository = MockBookShelfRepository();
    mockSettingsRepository = MockBookShelfSettingsRepository();
  });

  setUpAll(() {
    registerFallbackValue(GReadingStatus.READING);
    registerFallbackValue(GShelfSortField.ADDED_AT);
    registerFallbackValue(GSortOrder.DESC);
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        bookShelfRepositoryProvider.overrideWithValue(mockRepository),
        bookShelfSettingsRepositoryProvider
            .overrideWithValue(mockSettingsRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  void stubGetMyShelf({
    List<ShelfBookItem>? items,
    int totalCount = 0,
    bool hasMore = false,
  }) {
    when(
      () => mockRepository.getMyShelf(
        readingStatus: any(named: 'readingStatus'),
        sortBy: any(named: 'sortBy'),
        sortOrder: any(named: 'sortOrder'),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer(
      (_) async => right(
        _createShelfResult(
          items: items,
          totalCount: totalCount,
          hasMore: hasMore,
        ),
      ),
    );
  }

  void stubGetMyShelfForStatus({
    required GReadingStatus status,
    List<ShelfBookItem>? items,
    int totalCount = 0,
    bool hasMore = false,
  }) {
    when(
      () => mockRepository.getMyShelf(
        readingStatus: status,
        sortBy: any(named: 'sortBy'),
        sortOrder: any(named: 'sortOrder'),
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer(
      (_) async => right(
        _createShelfResult(
          items: items,
          totalCount: totalCount,
          hasMore: hasMore,
        ),
      ),
    );
  }

  group('ProfileBooksNotifier', () {
    setUp(() {
      when(() => mockSettingsRepository.getSortOption())
          .thenReturn(SortOption.addedAtDesc);
    });

    test('shelfVersion 変更後も selectedFilter が保持される', () async {
      final readingBooks = [
        _createBook('book-1', 'Reading Book 1'),
        _createBook('book-2', 'Reading Book 2'),
      ];

      stubGetMyShelf(items: []);
      stubGetMyShelfForStatus(
        status: GReadingStatus.READING,
        items: readingBooks,
        totalCount: 2,
      );

      final container = createContainer();

      // listen でプロバイダを維持
      final states = <ProfileBooksState>[];
      container.listen(
        profileBooksNotifierProvider,
        (_, next) => states.add(next),
        fireImmediately: true,
      );

      // 初期ロードを待つ
      await Future<void>.delayed(Duration.zero);

      // フィルタを設定
      await container
          .read(profileBooksNotifierProvider.notifier)
          .setFilter(ReadingStatus.reading);

      final stateAfterFilter = container.read(profileBooksNotifierProvider);
      expect(stateAfterFilter.selectedFilter, ReadingStatus.reading);
      expect(stateAfterFilter.books.length, 2);

      // shelfVersion をインクリメント（クイックアクションをシミュレート）
      container.read(shelfVersionProvider.notifier).increment();

      // リフレッシュを待つ
      await Future<void>.delayed(Duration.zero);

      final stateAfterVersionChange =
          container.read(profileBooksNotifierProvider);
      expect(
        stateAfterVersionChange.selectedFilter,
        ReadingStatus.reading,
        reason: 'shelfVersion 変更後も selectedFilter が保持されるべき',
      );
    });

    test('shelfVersion 変更後に現在のフィルタでデータが再取得される', () async {
      final readingBooks = [
        _createBook('book-1', 'Reading Book 1'),
      ];

      stubGetMyShelf(items: []);
      stubGetMyShelfForStatus(
        status: GReadingStatus.READING,
        items: readingBooks,
        totalCount: 1,
      );

      final container = createContainer();

      container.listen(
        profileBooksNotifierProvider,
        (_, __) {},
        fireImmediately: true,
      );
      await Future<void>.delayed(Duration.zero);

      await container
          .read(profileBooksNotifierProvider.notifier)
          .setFilter(ReadingStatus.reading);

      // shelfVersion をインクリメント
      container.read(shelfVersionProvider.notifier).increment();
      await Future<void>.delayed(Duration.zero);

      // フィルタ付きで API が再呼び出しされていることを確認
      // setFilter で1回 + refresh で1回 = 2回以上
      verify(
        () => mockRepository.getMyShelf(
          readingStatus: GReadingStatus.READING,
          sortBy: any(named: 'sortBy'),
          sortOrder: any(named: 'sortOrder'),
          limit: any(named: 'limit'),
          offset: 0,
        ),
      ).called(greaterThanOrEqualTo(2));
    });

    test('shelfVersion 変更時に isLoading が true にリセットされない', () async {
      final books = [_createBook('book-1', 'Book 1')];
      stubGetMyShelf(items: books, totalCount: 1);

      final container = createContainer();

      container.listen(
        profileBooksNotifierProvider,
        (_, __) {},
        fireImmediately: true,
      );

      // 初期ロードを待つ
      await Future<void>.delayed(Duration.zero);

      final stateBeforeVersionChange =
          container.read(profileBooksNotifierProvider);
      expect(stateBeforeVersionChange.isLoading, false);
      expect(stateBeforeVersionChange.books.length, 1);

      // shelfVersion をインクリメント
      container.read(shelfVersionProvider.notifier).increment();

      // インクリメント直後の状態を確認（books がクリアされていないこと）
      final stateImmediatelyAfter =
          container.read(profileBooksNotifierProvider);
      expect(
        stateImmediatelyAfter.books,
        isNotEmpty,
        reason: 'shelfVersion 変更時に books がクリアされるべきではない',
      );

      // refresh マイクロタスクの完了を待つ
      await Future<void>.delayed(Duration.zero);
    });

    test('フィルタ選択中に読書状態が変更された本がリストから即座に除外される', () async {
      final readingBooks = [
        _createBook('book-1', 'Reading Book 1'),
        _createBook('book-2', 'Reading Book 2'),
      ];

      stubGetMyShelf(items: []);
      stubGetMyShelfForStatus(
        status: GReadingStatus.READING,
        items: readingBooks,
        totalCount: 2,
      );

      final container = createContainer();

      container.listen(
        profileBooksNotifierProvider,
        (_, __) {},
        fireImmediately: true,
      );
      await Future<void>.delayed(Duration.zero);

      // フィルタを「読書中」に設定
      await container
          .read(profileBooksNotifierProvider.notifier)
          .setFilter(ReadingStatus.reading);

      expect(container.read(profileBooksNotifierProvider).books.length, 2);

      // shelfStateProvider にエントリを登録
      final shelfNotifier = container.read(shelfStateProvider.notifier);
      for (final book in readingBooks) {
        shelfNotifier.registerEntry(
          ShelfEntry(
            userBookId: book.userBookId,
            externalId: book.externalId,
            readingStatus: ReadingStatus.reading,
            addedAt: DateTime(2024, 1, 1),
          ),
        );
      }

      // book-1 の読書状態を「読了」に変更（クイックアクションをシミュレート）
      shelfNotifier.updateReadingStatus(
        externalId: 'book-1',
        status: ReadingStatus.completed,
      );

      // book-1 がリストから除外されていることを確認
      final stateAfter = container.read(profileBooksNotifierProvider);
      expect(stateAfter.books.length, 1);
      expect(stateAfter.books.first.externalId, 'book-2');
      expect(stateAfter.totalCount, 1);

      await Future<void>.delayed(Duration.zero);
    });

    test('フィルタ未選択時に読書状態が変更されてもリストは変わらない', () async {
      final books = [
        _createBook('book-1', 'Book 1'),
        _createBook('book-2', 'Book 2'),
      ];

      stubGetMyShelf(items: books, totalCount: 2);

      final container = createContainer();

      container.listen(
        profileBooksNotifierProvider,
        (_, __) {},
        fireImmediately: true,
      );
      await Future<void>.delayed(Duration.zero);

      expect(container.read(profileBooksNotifierProvider).books.length, 2);
      expect(
        container.read(profileBooksNotifierProvider).selectedFilter,
        isNull,
      );

      // shelfStateProvider にエントリを登録
      final shelfNotifier = container.read(shelfStateProvider.notifier);
      shelfNotifier.registerEntry(
        ShelfEntry(
          userBookId: books[0].userBookId,
          externalId: 'book-1',
          readingStatus: ReadingStatus.reading,
          addedAt: DateTime(2024, 1, 1),
        ),
      );

      // 読書状態を変更
      shelfNotifier.updateReadingStatus(
        externalId: 'book-1',
        status: ReadingStatus.completed,
      );

      // フィルタ未選択なのでリストは変わらない
      final stateAfter = container.read(profileBooksNotifierProvider);
      expect(stateAfter.books.length, 2);

      await Future<void>.delayed(Duration.zero);
    });
  });
}

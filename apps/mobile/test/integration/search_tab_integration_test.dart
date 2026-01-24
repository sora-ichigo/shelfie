import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/storage/secure_storage_service.dart';
import 'package:shelfie/features/book_search/application/book_search_notifier.dart';
import 'package:shelfie/features/book_search/application/book_search_state.dart';
import 'package:shelfie/features/book_search/application/recent_books_notifier.dart';
import 'package:shelfie/features/book_search/application/search_history_notifier.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';
import 'package:shelfie/features/book_search/data/recent_books_repository.dart';
import 'package:shelfie/features/book_search/data/search_history_repository.dart';
import 'package:shelfie/features/book_search/domain/recent_book_entry.dart';
import 'package:shelfie/features/book_search/domain/search_history_entry.dart';

class MockBookSearchRepository extends Mock implements BookSearchRepository {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockSearchHistoryRepository extends Mock
    implements SearchHistoryRepository {}

class MockRecentBooksRepository extends Mock implements RecentBooksRepository {}

class FakeSearchHistoryEntry extends Fake implements SearchHistoryEntry {}

class FakeRecentBookEntry extends Fake implements RecentBookEntry {}

ProviderContainer createTestContainer({
  required MockBookSearchRepository mockBookRepo,
  required MockSearchHistoryRepository mockHistoryRepo,
  required MockRecentBooksRepository mockRecentBooksRepo,
  List<Override> overrides = const [],
}) {
  final mockStorage = MockSecureStorageService();
  when(() => mockStorage.saveAuthData(
        userId: any(named: 'userId'),
        email: any(named: 'email'),
        idToken: any(named: 'idToken'),
        refreshToken: any(named: 'refreshToken'),
      )).thenAnswer((_) async {});
  when(() => mockStorage.updateTokens(
        idToken: any(named: 'idToken'),
        refreshToken: any(named: 'refreshToken'),
      )).thenAnswer((_) async {});
  when(() => mockStorage.clearAuthData()).thenAnswer((_) async {});
  when(() => mockStorage.loadAuthData()).thenAnswer((_) async => null);

  return ProviderContainer(
    overrides: [
      secureStorageServiceProvider.overrideWithValue(mockStorage),
      bookSearchRepositoryProvider.overrideWithValue(mockBookRepo),
      searchHistoryRepositoryProvider.overrideWithValue(mockHistoryRepo),
      recentBooksRepositoryProvider.overrideWithValue(mockRecentBooksRepo),
      ...overrides,
    ],
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeSearchHistoryEntry());
    registerFallbackValue(FakeRecentBookEntry());
  });

  group('統合テスト: 検索タブ機能強化', () {
    late MockBookSearchRepository mockBookRepo;
    late MockSearchHistoryRepository mockHistoryRepo;
    late MockRecentBooksRepository mockRecentBooksRepo;
    late ProviderContainer container;

    setUp(() {
      mockBookRepo = MockBookSearchRepository();
      mockHistoryRepo = MockSearchHistoryRepository();
      mockRecentBooksRepo = MockRecentBooksRepository();

      when(() => mockHistoryRepo.getAll())
          .thenAnswer((_) async => <SearchHistoryEntry>[]);
      when(() => mockHistoryRepo.add(any())).thenAnswer((_) async {});
      when(() => mockHistoryRepo.remove(any())).thenAnswer((_) async {});
      when(() => mockHistoryRepo.clear()).thenAnswer((_) async {});

      when(() => mockRecentBooksRepo.getAll())
          .thenAnswer((_) async => <RecentBookEntry>[]);
      when(() => mockRecentBooksRepo.add(any())).thenAnswer((_) async {});

      container = createTestContainer(
        mockBookRepo: mockBookRepo,
        mockHistoryRepo: mockHistoryRepo,
        mockRecentBooksRepo: mockRecentBooksRepo,
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('検索成功時に検索履歴が保存される', () async {
      when(() => mockBookRepo.searchBooks(
            query: 'flutter',
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          )).thenAnswer(
        (_) async => right(
          SearchBooksResult(
            items: [
              const Book(
                id: 'book-1',
                title: 'Flutter Book',
                authors: ['Author'],
              ),
            ],
            totalCount: 1,
            hasMore: false,
          ),
        ),
      );

      final searchNotifier =
          container.read(bookSearchNotifierProvider.notifier);

      await searchNotifier.searchBooks('flutter');

      final state = container.read(bookSearchNotifierProvider);
      expect(state, isA<BookSearchSuccess>());
      expect((state as BookSearchSuccess).books.length, equals(1));

      await Future<void>.delayed(const Duration(milliseconds: 100));

      verify(() => mockHistoryRepo.add(any())).called(1);
    });

    test('履歴からクエリを取得してフィルタリングする', () async {
      final historyEntries = [
        SearchHistoryEntry(
          query: 'dart',
          searchedAt: DateTime.now(),
        ),
        SearchHistoryEntry(
          query: 'flutter',
          searchedAt: DateTime.now().subtract(const Duration(hours: 1)),
        ),
      ];

      final mockHistoryRepoForTest = MockSearchHistoryRepository();
      when(() => mockHistoryRepoForTest.getAll())
          .thenAnswer((_) async => historyEntries);
      when(() => mockHistoryRepoForTest.add(any())).thenAnswer((_) async {});
      when(() => mockHistoryRepoForTest.remove(any())).thenAnswer((_) async {});
      when(() => mockHistoryRepoForTest.clear()).thenAnswer((_) async {});

      final mockRecentBooksRepoForTest = MockRecentBooksRepository();
      when(() => mockRecentBooksRepoForTest.getAll())
          .thenAnswer((_) async => <RecentBookEntry>[]);
      when(() => mockRecentBooksRepoForTest.add(any())).thenAnswer((_) async {});

      final historyContainer = createTestContainer(
        mockBookRepo: mockBookRepo,
        mockHistoryRepo: mockHistoryRepoForTest,
        mockRecentBooksRepo: mockRecentBooksRepoForTest,
      );

      try {
        await historyContainer.read(searchHistoryNotifierProvider.future);

        final historyNotifier =
            historyContainer.read(searchHistoryNotifierProvider.notifier);

        final dartHistories = historyNotifier.getFilteredHistory('dart');
        expect(dartHistories.length, equals(1));
        expect(dartHistories.first.query, equals('dart'));

        final allHistories = historyNotifier.getFilteredHistory('');
        expect(allHistories.length, equals(2));
      } finally {
        historyContainer.dispose();
      }
    });

    test('最近チェックした本の追加フロー', () async {
      final recentBooksNotifier =
          container.read(recentBooksNotifierProvider.notifier);

      await recentBooksNotifier.addRecentBook(
        bookId: 'book-123',
        title: 'Test Book',
        authors: const ['Author 1', 'Author 2'],
        coverImageUrl: 'https://example.com/cover.jpg',
      );

      verify(() => mockRecentBooksRepo.add(any())).called(1);
    });

    test('検索履歴フィルタリングのフロー', () async {
      final historyEntries = [
        SearchHistoryEntry(
          query: 'Flutter Guide',
          searchedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        SearchHistoryEntry(
          query: 'Dart Tutorial',
          searchedAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        SearchHistoryEntry(
          query: 'Flutter Advanced',
          searchedAt: DateTime.now(),
        ),
      ];

      when(() => mockHistoryRepo.getAll())
          .thenAnswer((_) async => historyEntries);

      final container2 = createTestContainer(
        mockBookRepo: mockBookRepo,
        mockHistoryRepo: mockHistoryRepo,
        mockRecentBooksRepo: mockRecentBooksRepo,
      );

      try {
        await container2.read(searchHistoryNotifierProvider.future);

        final historyNotifier =
            container2.read(searchHistoryNotifierProvider.notifier);

        final flutterHistories = historyNotifier.getFilteredHistory('Flutter');
        expect(flutterHistories.length, equals(2));

        final dartHistories = historyNotifier.getFilteredHistory('Dart');
        expect(dartHistories.length, equals(1));
        expect(dartHistories.first.query, equals('Dart Tutorial'));

        final allHistories = historyNotifier.getFilteredHistory('');
        expect(allHistories.length, equals(3));
      } finally {
        container2.dispose();
      }
    });

    test('検索失敗時は履歴が保存されない', () async {
      when(() => mockBookRepo.searchBooks(
            query: 'error_query',
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          )).thenAnswer(
        (_) async => left(
          const ServerFailure(
            message: 'Server error',
            code: 'ERROR',
          ),
        ),
      );

      final searchNotifier =
          container.read(bookSearchNotifierProvider.notifier);

      await searchNotifier.searchBooks('error_query');

      final state = container.read(bookSearchNotifierProvider);
      expect(state, isA<BookSearchError>());

      verifyNever(() => mockHistoryRepo.add(any()));
    });

    test('検索結果が空の場合は履歴が保存されない', () async {
      when(() => mockBookRepo.searchBooks(
            query: 'empty_query',
            limit: any(named: 'limit'),
            offset: any(named: 'offset'),
          )).thenAnswer(
        (_) async => right(
          const SearchBooksResult(
            items: [],
            totalCount: 0,
            hasMore: false,
          ),
        ),
      );

      final searchNotifier =
          container.read(bookSearchNotifierProvider.notifier);

      await searchNotifier.searchBooks('empty_query');

      final state = container.read(bookSearchNotifierProvider);
      expect(state, isA<BookSearchEmpty>());

      verifyNever(() => mockHistoryRepo.add(any()));
    });
  });
}

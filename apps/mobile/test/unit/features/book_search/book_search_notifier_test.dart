import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/storage/secure_storage_service.dart';
import 'package:shelfie/features/book_search/application/book_search_notifier.dart';
import 'package:shelfie/features/book_search/application/book_search_state.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';
import 'package:shelfie/features/book_search/data/search_history_repository.dart';
import 'package:shelfie/features/book_search/domain/search_history_entry.dart';

class MockBookSearchRepository extends Mock implements BookSearchRepository {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockSearchHistoryRepository extends Mock
    implements SearchHistoryRepository {}

class FakeSearchHistoryEntry extends Fake implements SearchHistoryEntry {}

ProviderContainer createTestContainer({
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

  final mockSearchHistoryRepo = MockSearchHistoryRepository();
  when(() => mockSearchHistoryRepo.getAll())
      .thenAnswer((_) async => <SearchHistoryEntry>[]);
  when(() => mockSearchHistoryRepo.add(any())).thenAnswer((_) async {});
  when(() => mockSearchHistoryRepo.remove(any())).thenAnswer((_) async {});
  when(() => mockSearchHistoryRepo.clear()).thenAnswer((_) async {});

  return ProviderContainer(
    overrides: [
      secureStorageServiceProvider.overrideWithValue(mockStorage),
      searchHistoryRepositoryProvider.overrideWithValue(mockSearchHistoryRepo),
      ...overrides,
    ],
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeSearchHistoryEntry());
  });

  group('BookSearchState', () {
    test('initial 状態を作成できる', () {
      const state = BookSearchState.initial();
      expect(state, isA<BookSearchInitial>());
    });

    test('loading 状態を作成できる', () {
      const state = BookSearchState.loading();
      expect(state, isA<BookSearchLoading>());
    });

    test('success 状態を作成できる', () {
      final books = [
        const Book(
          id: 'book-1',
          title: 'Test Book',
          authors: ['Author 1'],
        ),
      ];
      final state = BookSearchState.success(
        books: books,
        totalCount: 100,
        hasMore: true,
        currentQuery: 'flutter',
        currentOffset: 0,
      );
      expect(state, isA<BookSearchSuccess>());
      final success = state as BookSearchSuccess;
      expect(success.books.length, equals(1));
      expect(success.totalCount, equals(100));
      expect(success.hasMore, isTrue);
      expect(success.currentQuery, equals('flutter'));
      expect(success.currentOffset, equals(0));
    });

    test('empty 状態を作成できる', () {
      const state = BookSearchState.empty(query: 'nonexistent');
      expect(state, isA<BookSearchEmpty>());
      expect((state as BookSearchEmpty).query, equals('nonexistent'));
    });

    test('error 状態を作成できる', () {
      const failure = NetworkFailure(message: 'No internet');
      const state = BookSearchState.error(failure: failure);
      expect(state, isA<BookSearchError>());
      expect((state as BookSearchError).failure, isA<NetworkFailure>());
    });

    test('loadingMore 状態を作成できる', () {
      final books = [
        const Book(
          id: 'book-1',
          title: 'Test Book',
          authors: ['Author 1'],
        ),
      ];
      final state = BookSearchState.loadingMore(
        books: books,
        totalCount: 100,
        currentQuery: 'flutter',
        currentOffset: 10,
      );
      expect(state, isA<BookSearchLoadingMore>());
    });
  });

  group('Book model', () {
    test('Book インスタンスを作成できる', () {
      const book = Book(
        id: 'book-1',
        title: 'Test Book',
        authors: ['Author 1', 'Author 2'],
        publisher: 'Test Publisher',
        publishedDate: '2024-01-01',
        isbn: '9781234567890',
        coverImageUrl: 'https://example.com/cover.jpg',
      );
      expect(book.id, equals('book-1'));
      expect(book.title, equals('Test Book'));
      expect(book.authors, equals(['Author 1', 'Author 2']));
      expect(book.publisher, equals('Test Publisher'));
      expect(book.publishedDate, equals('2024-01-01'));
      expect(book.isbn, equals('9781234567890'));
      expect(book.coverImageUrl, equals('https://example.com/cover.jpg'));
    });

    test('オプションフィールドなしで Book を作成できる', () {
      const book = Book(
        id: 'book-1',
        title: 'Test Book',
        authors: ['Author 1'],
      );
      expect(book.publisher, isNull);
      expect(book.publishedDate, isNull);
      expect(book.isbn, isNull);
      expect(book.coverImageUrl, isNull);
    });
  });

  group('BookSearchNotifier', () {
    late MockBookSearchRepository mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = MockBookSearchRepository();
      container = createTestContainer(
        overrides: [
          bookSearchRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態は initial', () {
      final state = container.read(bookSearchNotifierProvider);
      expect(state, isA<BookSearchInitial>());
    });

    group('searchBooks', () {
      test('検索成功時は loading -> success の状態遷移をする', () async {
        when(() => mockRepository.searchBooks(
              query: any(named: 'query'),
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

        final notifier = container.read(bookSearchNotifierProvider.notifier);
        final states = <BookSearchState>[];
        container.listen(bookSearchNotifierProvider, (previous, next) {
          states.add(next);
        });

        await notifier.searchBooks('flutter');

        expect(states, contains(isA<BookSearchLoading>()));
        expect(states.last, isA<BookSearchSuccess>());
        final success = states.last as BookSearchSuccess;
        expect(success.books.length, equals(1));
        expect(success.currentQuery, equals('flutter'));
      });

      test('検索結果が 0 件の場合は empty 状態になる', () async {
        when(() => mockRepository.searchBooks(
              query: any(named: 'query'),
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

        final notifier = container.read(bookSearchNotifierProvider.notifier);
        final states = <BookSearchState>[];
        container.listen(bookSearchNotifierProvider, (previous, next) {
          states.add(next);
        });

        await notifier.searchBooks('nonexistent');

        expect(states.last, isA<BookSearchEmpty>());
        expect((states.last as BookSearchEmpty).query, equals('nonexistent'));
      });

      test('検索失敗時は error 状態になる', () async {
        when(() => mockRepository.searchBooks(
              query: any(named: 'query'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            )).thenAnswer(
          (_) async => left(const NetworkFailure(message: 'No internet')),
        );

        final notifier = container.read(bookSearchNotifierProvider.notifier);
        final states = <BookSearchState>[];
        container.listen(bookSearchNotifierProvider, (previous, next) {
          states.add(next);
        });

        await notifier.searchBooks('flutter');

        expect(states.last, isA<BookSearchError>());
        final error = states.last as BookSearchError;
        expect(error.failure, isA<NetworkFailure>());
      });

      test('空のクエリでは検索を実行しない', () async {
        final notifier = container.read(bookSearchNotifierProvider.notifier);

        await notifier.searchBooks('');

        verifyNever(() => mockRepository.searchBooks(
              query: any(named: 'query'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ));
      });
    });

    group('searchBooksWithDebounce', () {
      test('空のクエリでは initial 状態に戻る', () {
        final notifier = container.read(bookSearchNotifierProvider.notifier);

        notifier.searchBooksWithDebounce('');

        expect(
            container.read(bookSearchNotifierProvider), isA<BookSearchInitial>());
        verifyNever(() => mockRepository.searchBooks(
              query: any(named: 'query'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ));
      });

      test('即座には searchBooks が呼ばれない', () {
        when(() => mockRepository.searchBooks(
              query: any(named: 'query'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            )).thenAnswer(
          (_) async => right(
            SearchBooksResult(
              items: [
                const Book(
                  id: 'book-1',
                  title: 'Result',
                  authors: ['Author'],
                ),
              ],
              totalCount: 1,
              hasMore: false,
            ),
          ),
        );

        final notifier = container.read(bookSearchNotifierProvider.notifier);

        notifier.searchBooksWithDebounce('flutter');

        verifyNever(() => mockRepository.searchBooks(
              query: any(named: 'query'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ));
      });
    });

    group('searchByISBN', () {
      test('ISBN 検索成功時は書籍が返される', () async {
        when(() => mockRepository.searchBookByISBN(
              isbn: any(named: 'isbn'),
            )).thenAnswer(
          (_) async => right(
            const Book(
              id: 'book-isbn',
              title: 'ISBN Book',
              authors: ['Author'],
              isbn: '9781234567890',
            ),
          ),
        );

        final notifier = container.read(bookSearchNotifierProvider.notifier);
        final states = <BookSearchState>[];
        container.listen(bookSearchNotifierProvider, (previous, next) {
          states.add(next);
        });

        await notifier.searchByISBN('9781234567890');

        expect(states, contains(isA<BookSearchLoading>()));
        expect(states.last, isA<BookSearchSuccess>());
        final success = states.last as BookSearchSuccess;
        expect(success.books.length, equals(1));
        expect(success.books.first.isbn, equals('9781234567890'));
      });

      test('ISBN 検索で書籍が見つからない場合は empty 状態になる', () async {
        when(() => mockRepository.searchBookByISBN(
              isbn: any(named: 'isbn'),
            )).thenAnswer(
          (_) async => right(null),
        );

        final notifier = container.read(bookSearchNotifierProvider.notifier);
        final states = <BookSearchState>[];
        container.listen(bookSearchNotifierProvider, (previous, next) {
          states.add(next);
        });

        await notifier.searchByISBN('0000000000000');

        expect(states.last, isA<BookSearchEmpty>());
      });

      test('ISBN 検索失敗時は error 状態になる', () async {
        when(() => mockRepository.searchBookByISBN(
              isbn: any(named: 'isbn'),
            )).thenAnswer(
          (_) async => left(const NetworkFailure(message: 'No internet')),
        );

        final notifier = container.read(bookSearchNotifierProvider.notifier);
        final states = <BookSearchState>[];
        container.listen(bookSearchNotifierProvider, (previous, next) {
          states.add(next);
        });

        await notifier.searchByISBN('9781234567890');

        expect(states.last, isA<BookSearchError>());
      });
    });

    group('addToShelf', () {
      test('マイライブラリ追加成功時は UserBook が返される', () async {
        const book = Book(
          id: 'book-1',
          title: 'Test Book',
          authors: ['Author'],
        );

        when(() => mockRepository.addBookToShelf(
              externalId: any(named: 'externalId'),
              title: any(named: 'title'),
              authors: any(named: 'authors'),
              publisher: any(named: 'publisher'),
              publishedDate: any(named: 'publishedDate'),
              isbn: any(named: 'isbn'),
              coverImageUrl: any(named: 'coverImageUrl'),
            )).thenAnswer(
          (_) async => right(
            UserBook(
              id: 1,
              externalId: 'book-1',
              title: 'Test Book',
              authors: const ['Author'],
              addedAt: DateTime.now(),
            ),
          ),
        );

        final notifier = container.read(bookSearchNotifierProvider.notifier);
        final result = await notifier.addToShelf(book);

        expect(result.isRight(), isTrue);
        final userBook =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(userBook.externalId, equals('book-1'));
      });

      test('マイライブラリ追加失敗時は Failure が返される', () async {
        const book = Book(
          id: 'book-1',
          title: 'Test Book',
          authors: ['Author'],
        );

        when(() => mockRepository.addBookToShelf(
              externalId: any(named: 'externalId'),
              title: any(named: 'title'),
              authors: any(named: 'authors'),
              publisher: any(named: 'publisher'),
              publishedDate: any(named: 'publishedDate'),
              isbn: any(named: 'isbn'),
              coverImageUrl: any(named: 'coverImageUrl'),
            )).thenAnswer(
          (_) async =>
              left(const AuthFailure(message: 'Authentication required')),
        );

        final notifier = container.read(bookSearchNotifierProvider.notifier);
        final result = await notifier.addToShelf(book);

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<AuthFailure>());
      });

      test('重複エラー時は ServerFailure が返される', () async {
        const book = Book(
          id: 'book-1',
          title: 'Test Book',
          authors: ['Author'],
        );

        when(() => mockRepository.addBookToShelf(
              externalId: any(named: 'externalId'),
              title: any(named: 'title'),
              authors: any(named: 'authors'),
              publisher: any(named: 'publisher'),
              publishedDate: any(named: 'publishedDate'),
              isbn: any(named: 'isbn'),
              coverImageUrl: any(named: 'coverImageUrl'),
            )).thenAnswer(
          (_) async => left(
            const ServerFailure(
              message: 'This book is already in your shelf',
              code: 'DUPLICATE_BOOK',
            ),
          ),
        );

        final notifier = container.read(bookSearchNotifierProvider.notifier);
        final result = await notifier.addToShelf(book);

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ServerFailure>());
        expect(
          (failure! as ServerFailure).code,
          equals('DUPLICATE_BOOK'),
        );
      });
    });

    group('loadMore', () {
      test('次のページを読み込む', () async {
        when(() => mockRepository.searchBooks(
              query: 'flutter',
              limit: 10,
              offset: 0,
            )).thenAnswer(
          (_) async => right(
            SearchBooksResult(
              items: List.generate(
                10,
                (i) => Book(
                  id: 'book-$i',
                  title: 'Book $i',
                  authors: ['Author'],
                ),
              ),
              totalCount: 25,
              hasMore: true,
            ),
          ),
        );

        when(() => mockRepository.searchBooks(
              query: 'flutter',
              limit: 10,
              offset: 10,
            )).thenAnswer(
          (_) async => right(
            SearchBooksResult(
              items: List.generate(
                10,
                (i) => Book(
                  id: 'book-${i + 10}',
                  title: 'Book ${i + 10}',
                  authors: ['Author'],
                ),
              ),
              totalCount: 25,
              hasMore: true,
            ),
          ),
        );

        final notifier = container.read(bookSearchNotifierProvider.notifier);

        await notifier.searchBooks('flutter');
        final state1 = container.read(bookSearchNotifierProvider);
        expect((state1 as BookSearchSuccess).books.length, equals(10));

        await notifier.loadMore();
        final state2 = container.read(bookSearchNotifierProvider);
        expect((state2 as BookSearchSuccess).books.length, equals(20));
        expect(state2.currentOffset, equals(10));
      });

      test('initial 状態では loadMore を実行しない', () async {
        final notifier = container.read(bookSearchNotifierProvider.notifier);

        await notifier.loadMore();

        verifyNever(() => mockRepository.searchBooks(
              query: any(named: 'query'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ));
      });

      test('hasMore が false の場合は loadMore を実行しない', () async {
        when(() => mockRepository.searchBooks(
              query: any(named: 'query'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            )).thenAnswer(
          (_) async => right(
            SearchBooksResult(
              items: [
                const Book(
                  id: 'book-1',
                  title: 'Only Book',
                  authors: ['Author'],
                ),
              ],
              totalCount: 1,
              hasMore: false,
            ),
          ),
        );

        final notifier = container.read(bookSearchNotifierProvider.notifier);
        await notifier.searchBooks('flutter');

        reset(mockRepository);

        await notifier.loadMore();

        verifyNever(() => mockRepository.searchBooks(
              query: any(named: 'query'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ));
      });

      test('loadMore 中は loadingMore 状態になる', () async {
        when(() => mockRepository.searchBooks(
              query: 'flutter',
              limit: 10,
              offset: 0,
            )).thenAnswer(
          (_) async => right(
            SearchBooksResult(
              items: List.generate(
                10,
                (i) => Book(
                  id: 'book-$i',
                  title: 'Book $i',
                  authors: ['Author'],
                ),
              ),
              totalCount: 25,
              hasMore: true,
            ),
          ),
        );

        when(() => mockRepository.searchBooks(
              query: 'flutter',
              limit: 10,
              offset: 10,
            )).thenAnswer(
          (_) async {
            await Future<void>.delayed(const Duration(milliseconds: 50));
            return right(
              SearchBooksResult(
                items: List.generate(
                  10,
                  (i) => Book(
                    id: 'book-${i + 10}',
                    title: 'Book ${i + 10}',
                    authors: ['Author'],
                  ),
                ),
                totalCount: 25,
                hasMore: true,
              ),
            );
          },
        );

        final notifier = container.read(bookSearchNotifierProvider.notifier);
        await notifier.searchBooks('flutter');

        final states = <BookSearchState>[];
        container.listen(bookSearchNotifierProvider, (previous, next) {
          states.add(next);
        });

        // ignore: unawaited_futures
        notifier.loadMore();
        await Future<void>.delayed(const Duration(milliseconds: 10));

        expect(states, contains(isA<BookSearchLoadingMore>()));
      });
    });

    group('reset', () {
      test('reset で initial 状態に戻る', () async {
        when(() => mockRepository.searchBooks(
              query: any(named: 'query'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            )).thenAnswer(
          (_) async => right(
            SearchBooksResult(
              items: [
                const Book(
                  id: 'book-1',
                  title: 'Test Book',
                  authors: ['Author'],
                ),
              ],
              totalCount: 1,
              hasMore: false,
            ),
          ),
        );

        final notifier = container.read(bookSearchNotifierProvider.notifier);
        await notifier.searchBooks('flutter');

        expect(container.read(bookSearchNotifierProvider),
            isA<BookSearchSuccess>());

        notifier.reset();

        expect(container.read(bookSearchNotifierProvider),
            isA<BookSearchInitial>());
      });

      test('reset 時にデバウンスタイマーがキャンセルされる', () async {
        when(() => mockRepository.searchBooks(
              query: any(named: 'query'),
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

        final notifier = container.read(bookSearchNotifierProvider.notifier);
        notifier.searchBooksWithDebounce('flutter');

        await Future<void>.delayed(const Duration(milliseconds: 100));

        notifier.reset();

        await Future<void>.delayed(const Duration(milliseconds: 400));

        verifyNever(() => mockRepository.searchBooks(
              query: any(named: 'query'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ));
      });
    });

    group('エラーメッセージ', () {
      test('NetworkFailure のユーザーメッセージが正しい', () {
        const failure = NetworkFailure(message: 'No internet');
        expect(failure.userMessage, equals('ネットワーク接続を確認してください'));
      });

      test('ServerFailure のユーザーメッセージが正しい', () {
        const failure = ServerFailure(message: 'Error', code: 'ERR');
        expect(failure.userMessage, equals('サーバーエラーが発生しました'));
      });

      test('AuthFailure のユーザーメッセージが正しい', () {
        const failure = AuthFailure(message: 'Auth error');
        expect(failure.userMessage, equals('再度ログインしてください'));
      });

      test('ValidationFailure のユーザーメッセージはカスタムメッセージ', () {
        const failure = ValidationFailure(message: 'Custom validation message');
        expect(failure.userMessage, equals('Custom validation message'));
      });
    });
  });
}

Future<void> unawaited(Future<void> future) async {
  // ignore the future
}

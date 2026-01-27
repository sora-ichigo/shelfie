import 'package:built_collection/built_collection.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/network/ferry_client.dart';
import 'package:shelfie/core/storage/secure_storage_service.dart';
import 'package:shelfie/features/book_search/data/__generated__/add_book_to_shelf.data.gql.dart';
import 'package:shelfie/features/book_search/data/__generated__/add_book_to_shelf.req.gql.dart';
import 'package:shelfie/features/book_search/data/__generated__/add_book_to_shelf.var.gql.dart';
import 'package:shelfie/features/book_search/data/__generated__/search_book_by_isbn.data.gql.dart';
import 'package:shelfie/features/book_search/data/__generated__/search_book_by_isbn.req.gql.dart';
import 'package:shelfie/features/book_search/data/__generated__/search_book_by_isbn.var.gql.dart';
import 'package:shelfie/features/book_search/data/__generated__/search_books.data.gql.dart';
import 'package:shelfie/features/book_search/data/__generated__/search_books.req.gql.dart';
import 'package:shelfie/features/book_search/data/__generated__/search_books.var.gql.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';

class MockClient extends Mock implements Client {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

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

  return ProviderContainer(
    overrides: [
      secureStorageServiceProvider.overrideWithValue(mockStorage),
      ...overrides,
    ],
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(
      GSearchBooksReq((b) => b..vars.query = 'test'),
    );
    registerFallbackValue(
      GSearchBookByISBNReq((b) => b..vars.isbn = '1234567890'),
    );
    registerFallbackValue(
      GAddBookToShelfReq(
        (b) => b
          ..vars.bookInput.externalId = 'test'
          ..vars.bookInput.title = 'test'
          ..vars.bookInput.authors = ListBuilder(['test']),
      ),
    );
  });

  group('BookSearchRepository', () {
    late MockClient mockClient;
    late ProviderContainer container;
    late BookSearchRepository repository;

    setUp(() {
      mockClient = MockClient();
      container = createTestContainer(
        overrides: [
          ferryClientProvider.overrideWithValue(mockClient),
        ],
      );
      repository = container.read(bookSearchRepositoryProvider);
    });

    tearDown(() {
      container.dispose();
    });

    group('searchBooks', () {
      test('検索成功時は Right(SearchBooksResult) を返す', () async {
        final mockSearchBooksData = GSearchBooksData(
          (b) => b
            ..searchBooks = GSearchBooksData_searchBooks(
              (sb) => sb
                ..items = ListBuilder([
                  GSearchBooksData_searchBooks_items(
                    (item) => item
                      ..id = 'book-1'
                      ..title = 'Test Book 1'
                      ..authors = ListBuilder(['Author 1'])
                      ..publisher = 'Publisher 1'
                      ..publishedDate = '2024-01-01'
                      ..isbn = '9781234567890'
                      ..coverImageUrl = 'https://example.com/cover1.jpg'
                      ..source = GBookSource.RAKUTEN,
                  ),
                  GSearchBooksData_searchBooks_items(
                    (item) => item
                      ..id = 'book-2'
                      ..title = 'Test Book 2'
                      ..authors = ListBuilder(['Author 2', 'Author 3'])
                      ..publisher = null
                      ..publishedDate = null
                      ..isbn = null
                      ..coverImageUrl = null
                      ..source = GBookSource.GOOGLE,
                  ),
                ])
                ..totalCount = 100
                ..hasMore = true,
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GSearchBooksReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GSearchBooksData, GSearchBooksVars>(
              operationRequest:
                  GSearchBooksReq((b) => b..vars.query = 'flutter'),
              data: mockSearchBooksData,
            ),
          ),
        );

        final result = await repository.searchBooks(
          query: 'flutter',
          limit: 10,
          offset: 0,
        );

        expect(result.isRight(), isTrue);
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.items.length, equals(2));
        expect(data.items[0].id, equals('book-1'));
        expect(data.items[0].title, equals('Test Book 1'));
        expect(data.items[0].authors, equals(['Author 1']));
        expect(data.totalCount, equals(100));
        expect(data.hasMore, isTrue);
      });

      test('GraphQL エラー時は Left(ServerFailure) を返す', () async {
        when(() => mockClient.request(any<GSearchBooksReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GSearchBooksData, GSearchBooksVars>(
              operationRequest:
                  GSearchBooksReq((b) => b..vars.query = 'flutter'),
              data: null,
              graphqlErrors: [
                const GraphQLError(message: 'Search failed'),
              ],
            ),
          ),
        );

        final result = await repository.searchBooks(
          query: 'flutter',
          limit: 10,
          offset: 0,
        );

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ServerFailure>());
        expect((failure! as ServerFailure).message, contains('Search failed'));
      });

      test('例外発生時は Left(UnexpectedFailure) を返す', () async {
        when(() => mockClient.request(any<GSearchBooksReq>()))
            .thenThrow(Exception('Network error'));

        final result = await repository.searchBooks(
          query: 'flutter',
          limit: 10,
          offset: 0,
        );

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<UnexpectedFailure>());
      });

      test('limit と offset のデフォルト値が適用される', () async {
        GSearchBooksReq? capturedRequest;

        when(() => mockClient.request(any<GSearchBooksReq>()))
            .thenAnswer((invocation) {
          capturedRequest =
              invocation.positionalArguments[0] as GSearchBooksReq;
          return Stream.value(
            OperationResponse<GSearchBooksData, GSearchBooksVars>(
              operationRequest: capturedRequest!,
              data: GSearchBooksData(
                (b) => b
                  ..searchBooks = GSearchBooksData_searchBooks(
                    (sb) => sb
                      ..items = ListBuilder([])
                      ..totalCount = 0
                      ..hasMore = false,
                  ).toBuilder(),
              ),
            ),
          );
        });

        await repository.searchBooks(query: 'test');

        expect(capturedRequest, isNotNull);
        expect(capturedRequest!.vars.limit, equals(10));
        expect(capturedRequest!.vars.offset, equals(0));
      });
    });

    group('searchBookByISBN', () {
      test('ISBN 検索成功時は Right(Book) を返す', () async {
        final mockData = GSearchBookByISBNData(
          (b) => b
            ..searchBookByISBN = GSearchBookByISBNData_searchBookByISBN(
              (book) => book
                ..id = 'book-isbn'
                ..title = 'ISBN Book'
                ..authors = ListBuilder(['ISBN Author'])
                ..publisher = 'ISBN Publisher'
                ..publishedDate = '2024-06-15'
                ..isbn = '9781234567890'
                ..coverImageUrl = 'https://example.com/isbn-cover.jpg',
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GSearchBookByISBNReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GSearchBookByISBNData, GSearchBookByISBNVars>(
              operationRequest:
                  GSearchBookByISBNReq((b) => b..vars.isbn = '9781234567890'),
              data: mockData,
            ),
          ),
        );

        final result =
            await repository.searchBookByISBN(isbn: '9781234567890');

        expect(result.isRight(), isTrue);
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data, isNotNull);
        expect(data!.id, equals('book-isbn'));
        expect(data.title, equals('ISBN Book'));
        expect(data.isbn, equals('9781234567890'));
      });

      test('ISBN 検索で書籍が見つからない場合は Right(null) を返す', () async {
        final mockData = GSearchBookByISBNData(
          (b) => b..searchBookByISBN = null,
        );

        when(() => mockClient.request(any<GSearchBookByISBNReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GSearchBookByISBNData, GSearchBookByISBNVars>(
              operationRequest:
                  GSearchBookByISBNReq((b) => b..vars.isbn = '0000000000000'),
              data: mockData,
            ),
          ),
        );

        final result =
            await repository.searchBookByISBN(isbn: '0000000000000');

        expect(result.isRight(), isTrue);
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data, isNull);
      });

      test('GraphQL エラー時は Left(ServerFailure) を返す', () async {
        when(() => mockClient.request(any<GSearchBookByISBNReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GSearchBookByISBNData, GSearchBookByISBNVars>(
              operationRequest:
                  GSearchBookByISBNReq((b) => b..vars.isbn = '9781234567890'),
              data: null,
              graphqlErrors: [
                const GraphQLError(message: 'ISBN search failed'),
              ],
            ),
          ),
        );

        final result =
            await repository.searchBookByISBN(isbn: '9781234567890');

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ServerFailure>());
      });
    });

    group('addBookToShelf', () {
      test('マイライブラリ追加成功時は Right(UserBook) を返す', () async {
        final mockData = GAddBookToShelfData(
          (b) => b
            ..addBookToShelf = GAddBookToShelfData_addBookToShelf(
              (ub) => ub
                ..id = 1
                ..externalId = 'book-1'
                ..title = 'Added Book'
                ..authors = ListBuilder(['Book Author'])
                ..publisher = 'Book Publisher'
                ..publishedDate = '2024-01-01'
                ..isbn = '9781234567890'
                ..coverImageUrl = 'https://example.com/cover.jpg'
                ..addedAt = DateTime(2024, 6, 15, 10, 30)
                ..source = GBookSource.RAKUTEN
                ..readingStatus = GReadingStatus.BACKLOG,
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GAddBookToShelfReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GAddBookToShelfData, GAddBookToShelfVars>(
              operationRequest: GAddBookToShelfReq(
                (b) => b
                  ..vars.bookInput.externalId = 'book-1'
                  ..vars.bookInput.title = 'Added Book'
                  ..vars.bookInput.authors = ListBuilder(['Book Author']),
              ),
              data: mockData,
            ),
          ),
        );

        final result = await repository.addBookToShelf(
          externalId: 'book-1',
          title: 'Added Book',
          authors: ['Book Author'],
          publisher: 'Book Publisher',
          publishedDate: '2024-01-01',
          isbn: '9781234567890',
          coverImageUrl: 'https://example.com/cover.jpg',
        );

        expect(result.isRight(), isTrue);
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.id, equals(1));
        expect(data.externalId, equals('book-1'));
        expect(data.title, equals('Added Book'));
      });

      test('重複エラー時は Left(ServerFailure) を返す', () async {
        when(() => mockClient.request(any<GAddBookToShelfReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GAddBookToShelfData, GAddBookToShelfVars>(
              operationRequest: GAddBookToShelfReq(
                (b) => b
                  ..vars.bookInput.externalId = 'book-1'
                  ..vars.bookInput.title = 'Duplicate Book'
                  ..vars.bookInput.authors = ListBuilder(['Author']),
              ),
              data: null,
              graphqlErrors: [
                const GraphQLError(
                  message: 'This book is already in your shelf',
                  extensions: {'code': 'DUPLICATE_BOOK'},
                ),
              ],
            ),
          ),
        );

        final result = await repository.addBookToShelf(
          externalId: 'book-1',
          title: 'Duplicate Book',
          authors: ['Author'],
        );

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ServerFailure>());
        expect(
          (failure! as ServerFailure).message,
          contains('already in your shelf'),
        );
      });

      test('認証エラー時は Left(AuthFailure) を返す', () async {
        when(() => mockClient.request(any<GAddBookToShelfReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GAddBookToShelfData, GAddBookToShelfVars>(
              operationRequest: GAddBookToShelfReq(
                (b) => b
                  ..vars.bookInput.externalId = 'book-1'
                  ..vars.bookInput.title = 'Auth Book'
                  ..vars.bookInput.authors = ListBuilder(['Author']),
              ),
              data: null,
              graphqlErrors: [
                const GraphQLError(
                  message: 'Authentication required',
                  extensions: {'code': 'UNAUTHENTICATED'},
                ),
              ],
            ),
          ),
        );

        final result = await repository.addBookToShelf(
          externalId: 'book-1',
          title: 'Auth Book',
          authors: ['Author'],
        );

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<AuthFailure>());
      });
    });
  });
}

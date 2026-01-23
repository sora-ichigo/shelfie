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
import 'package:shelfie/features/book_detail/data/__generated__/book_detail.data.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/book_detail.req.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/book_detail.var.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_note.data.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_note.req.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_note.var.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_status.data.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_status.req.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_status.var.gql.dart';
import 'package:shelfie/features/book_detail/data/book_detail_repository.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';

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
      GBookDetailReq((b) => b..vars.bookId = 'test'),
    );
    registerFallbackValue(
      GUpdateReadingStatusReq(
        (b) => b
          ..vars.userBookId = 1
          ..vars.status = GReadingStatus.BACKLOG,
      ),
    );
    registerFallbackValue(
      GUpdateReadingNoteReq(
        (b) => b
          ..vars.userBookId = 1
          ..vars.note = 'test',
      ),
    );
  });

  group('BookDetailRepository', () {
    late MockClient mockClient;
    late ProviderContainer container;
    late BookDetailRepository repository;

    setUp(() {
      mockClient = MockClient();
      container = createTestContainer(
        overrides: [
          ferryClientProvider.overrideWithValue(mockClient),
        ],
      );
      repository = container.read(bookDetailRepositoryProvider);
    });

    tearDown(() {
      container.dispose();
    });

    group('getBookDetail', () {
      test('書籍詳細取得成功時（本棚未追加）は Right(BookDetail) を返す', () async {
        final mockData = GBookDetailData(
          (b) => b
            ..bookDetail = GBookDetailData_bookDetail(
              (bd) => bd
                ..id = 'book-1'
                ..title = 'Test Book'
                ..authors = ListBuilder(['Author 1', 'Author 2'])
                ..publisher = 'Test Publisher'
                ..publishedDate = '2024-01-01'
                ..pageCount = 300
                ..categories = ListBuilder(['Fiction', 'Drama'])
                ..description = 'A great book about testing'
                ..isbn = '9781234567890'
                ..coverImageUrl = 'https://example.com/cover.jpg'
                ..amazonUrl = 'https://amazon.com/dp/123'
                ..infoLink = 'https://books.google.com/book-1'
                ..userBook = null,
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GBookDetailReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GBookDetailData, GBookDetailVars>(
              operationRequest:
                  GBookDetailReq((b) => b..vars.bookId = 'book-1'),
              data: mockData,
            ),
          ),
        );

        final result = await repository.getBookDetail(bookId: 'book-1');

        expect(result.isRight(), isTrue);
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.id, equals('book-1'));
        expect(data.title, equals('Test Book'));
        expect(data.authors, equals(['Author 1', 'Author 2']));
        expect(data.publisher, equals('Test Publisher'));
        expect(data.publishedDate, equals('2024-01-01'));
        expect(data.pageCount, equals(300));
        expect(data.categories, equals(['Fiction', 'Drama']));
        expect(data.description, equals('A great book about testing'));
        expect(data.thumbnailUrl, equals('https://example.com/cover.jpg'));
        expect(data.amazonUrl, equals('https://amazon.com/dp/123'));
        expect(data.infoLink, equals('https://books.google.com/book-1'));
        expect(data.userBook, isNull);
        expect(data.isInShelf, isFalse);
      });

      test('書籍詳細取得成功時（本棚追加済み）は Right(BookDetail) を返す', () async {
        final addedAt = DateTime(2024, 6, 15, 10, 30);
        final completedAt = DateTime(2024, 6, 20, 15, 0);
        final noteUpdatedAt = DateTime(2024, 6, 18, 12, 0);

        final mockData = GBookDetailData(
          (b) => b
            ..bookDetail = GBookDetailData_bookDetail(
              (bd) => bd
                ..id = 'book-1'
                ..title = 'Test Book'
                ..authors = ListBuilder(['Author 1'])
                ..publisher = null
                ..publishedDate = null
                ..pageCount = null
                ..categories = null
                ..description = null
                ..isbn = null
                ..coverImageUrl = null
                ..amazonUrl = null
                ..infoLink = null
                ..userBook = GBookDetailData_bookDetail_userBook(
                  (ub) => ub
                    ..id = 42
                    ..externalId = 'book-1'
                    ..title = 'Test Book'
                    ..authors = ListBuilder(['Author 1'])
                    ..publisher = null
                    ..publishedDate = null
                    ..isbn = null
                    ..coverImageUrl = null
                    ..addedAt = addedAt
                    ..readingStatus = GReadingStatus.COMPLETED
                    ..completedAt = completedAt
                    ..note = 'Great book!'
                    ..noteUpdatedAt = noteUpdatedAt,
                ).toBuilder(),
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GBookDetailReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GBookDetailData, GBookDetailVars>(
              operationRequest:
                  GBookDetailReq((b) => b..vars.bookId = 'book-1'),
              data: mockData,
            ),
          ),
        );

        final result = await repository.getBookDetail(bookId: 'book-1');

        expect(result.isRight(), isTrue);
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.isInShelf, isTrue);
        expect(data.userBook, isNotNull);
        expect(data.userBook!.id, equals(42));
        expect(data.userBook!.readingStatus, equals(ReadingStatus.completed));
        expect(data.userBook!.addedAt, equals(addedAt));
        expect(data.userBook!.completedAt, equals(completedAt));
        expect(data.userBook!.note, equals('Great book!'));
        expect(data.userBook!.noteUpdatedAt, equals(noteUpdatedAt));
      });

      test('書籍が見つからない場合は Left(NotFoundFailure) を返す', () async {
        when(() => mockClient.request(any<GBookDetailReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GBookDetailData, GBookDetailVars>(
              operationRequest:
                  GBookDetailReq((b) => b..vars.bookId = 'not-found'),
              data: null,
              graphqlErrors: [
                const GraphQLError(
                  message: 'Book not found',
                  extensions: {'code': 'NOT_FOUND'},
                ),
              ],
            ),
          ),
        );

        final result = await repository.getBookDetail(bookId: 'not-found');

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<NotFoundFailure>());
      });

      test('GraphQL エラー時は Left(ServerFailure) を返す', () async {
        when(() => mockClient.request(any<GBookDetailReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GBookDetailData, GBookDetailVars>(
              operationRequest:
                  GBookDetailReq((b) => b..vars.bookId = 'book-1'),
              data: null,
              graphqlErrors: [
                const GraphQLError(message: 'Internal server error'),
              ],
            ),
          ),
        );

        final result = await repository.getBookDetail(bookId: 'book-1');

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ServerFailure>());
      });

      test('ネットワークエラー時は Left(NetworkFailure) を返す', () async {
        when(() => mockClient.request(any<GBookDetailReq>()))
            .thenThrow(Exception('Network error'));

        final result = await repository.getBookDetail(bookId: 'book-1');

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<UnexpectedFailure>());
      });
    });

    group('updateReadingStatus', () {
      test('読書状態更新成功時は Right(UserBook) を返す', () async {
        final addedAt = DateTime(2024, 6, 15, 10, 30);
        final completedAt = DateTime(2024, 6, 20, 15, 0);

        final mockData = GUpdateReadingStatusData(
          (b) => b
            ..updateReadingStatus = GUpdateReadingStatusData_updateReadingStatus(
              (ub) => ub
                ..id = 42
                ..externalId = 'book-1'
                ..title = 'Test Book'
                ..authors = ListBuilder(['Author 1'])
                ..publisher = null
                ..publishedDate = null
                ..isbn = null
                ..coverImageUrl = null
                ..addedAt = addedAt
                ..readingStatus = GReadingStatus.COMPLETED
                ..completedAt = completedAt
                ..note = null
                ..noteUpdatedAt = null,
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GUpdateReadingStatusReq>()))
            .thenAnswer(
          (_) => Stream.value(
            OperationResponse<GUpdateReadingStatusData,
                GUpdateReadingStatusVars>(
              operationRequest: GUpdateReadingStatusReq(
                (b) => b
                  ..vars.userBookId = 42
                  ..vars.status = GReadingStatus.COMPLETED,
              ),
              data: mockData,
            ),
          ),
        );

        final result = await repository.updateReadingStatus(
          userBookId: 42,
          status: ReadingStatus.completed,
        );

        expect(result.isRight(), isTrue);
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.id, equals(42));
        expect(data.readingStatus, equals(ReadingStatus.completed));
        expect(data.completedAt, equals(completedAt));
      });

      test('認証エラー時は Left(AuthFailure) を返す', () async {
        when(() => mockClient.request(any<GUpdateReadingStatusReq>()))
            .thenAnswer(
          (_) => Stream.value(
            OperationResponse<GUpdateReadingStatusData,
                GUpdateReadingStatusVars>(
              operationRequest: GUpdateReadingStatusReq(
                (b) => b
                  ..vars.userBookId = 42
                  ..vars.status = GReadingStatus.READING,
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

        final result = await repository.updateReadingStatus(
          userBookId: 42,
          status: ReadingStatus.reading,
        );

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<AuthFailure>());
      });

      test('権限エラー時は Left(ForbiddenFailure) を返す', () async {
        when(() => mockClient.request(any<GUpdateReadingStatusReq>()))
            .thenAnswer(
          (_) => Stream.value(
            OperationResponse<GUpdateReadingStatusData,
                GUpdateReadingStatusVars>(
              operationRequest: GUpdateReadingStatusReq(
                (b) => b
                  ..vars.userBookId = 42
                  ..vars.status = GReadingStatus.READING,
              ),
              data: null,
              graphqlErrors: [
                const GraphQLError(
                  message: 'Not authorized to update this record',
                  extensions: {'code': 'FORBIDDEN'},
                ),
              ],
            ),
          ),
        );

        final result = await repository.updateReadingStatus(
          userBookId: 42,
          status: ReadingStatus.reading,
        );

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ForbiddenFailure>());
      });

      test('書籍が見つからない場合は Left(NotFoundFailure) を返す', () async {
        when(() => mockClient.request(any<GUpdateReadingStatusReq>()))
            .thenAnswer(
          (_) => Stream.value(
            OperationResponse<GUpdateReadingStatusData,
                GUpdateReadingStatusVars>(
              operationRequest: GUpdateReadingStatusReq(
                (b) => b
                  ..vars.userBookId = 999
                  ..vars.status = GReadingStatus.READING,
              ),
              data: null,
              graphqlErrors: [
                const GraphQLError(
                  message: 'UserBook not found',
                  extensions: {'code': 'NOT_FOUND'},
                ),
              ],
            ),
          ),
        );

        final result = await repository.updateReadingStatus(
          userBookId: 999,
          status: ReadingStatus.reading,
        );

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<NotFoundFailure>());
      });
    });

    group('updateReadingNote', () {
      test('読書メモ更新成功時は Right(UserBook) を返す', () async {
        final addedAt = DateTime(2024, 6, 15, 10, 30);
        final noteUpdatedAt = DateTime(2024, 6, 20, 15, 0);

        final mockData = GUpdateReadingNoteData(
          (b) => b
            ..updateReadingNote = GUpdateReadingNoteData_updateReadingNote(
              (ub) => ub
                ..id = 42
                ..externalId = 'book-1'
                ..title = 'Test Book'
                ..authors = ListBuilder(['Author 1'])
                ..publisher = null
                ..publishedDate = null
                ..isbn = null
                ..coverImageUrl = null
                ..addedAt = addedAt
                ..readingStatus = GReadingStatus.READING
                ..completedAt = null
                ..note = 'Updated note content'
                ..noteUpdatedAt = noteUpdatedAt,
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GUpdateReadingNoteReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GUpdateReadingNoteData, GUpdateReadingNoteVars>(
              operationRequest: GUpdateReadingNoteReq(
                (b) => b
                  ..vars.userBookId = 42
                  ..vars.note = 'Updated note content',
              ),
              data: mockData,
            ),
          ),
        );

        final result = await repository.updateReadingNote(
          userBookId: 42,
          note: 'Updated note content',
        );

        expect(result.isRight(), isTrue);
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.id, equals(42));
        expect(data.note, equals('Updated note content'));
        expect(data.noteUpdatedAt, equals(noteUpdatedAt));
      });

      test('空文字でのメモ更新が成功する', () async {
        final addedAt = DateTime(2024, 6, 15, 10, 30);
        final noteUpdatedAt = DateTime(2024, 6, 20, 15, 0);

        final mockData = GUpdateReadingNoteData(
          (b) => b
            ..updateReadingNote = GUpdateReadingNoteData_updateReadingNote(
              (ub) => ub
                ..id = 42
                ..externalId = 'book-1'
                ..title = 'Test Book'
                ..authors = ListBuilder(['Author 1'])
                ..publisher = null
                ..publishedDate = null
                ..isbn = null
                ..coverImageUrl = null
                ..addedAt = addedAt
                ..readingStatus = GReadingStatus.READING
                ..completedAt = null
                ..note = ''
                ..noteUpdatedAt = noteUpdatedAt,
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GUpdateReadingNoteReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GUpdateReadingNoteData, GUpdateReadingNoteVars>(
              operationRequest: GUpdateReadingNoteReq(
                (b) => b
                  ..vars.userBookId = 42
                  ..vars.note = '',
              ),
              data: mockData,
            ),
          ),
        );

        final result = await repository.updateReadingNote(
          userBookId: 42,
          note: '',
        );

        expect(result.isRight(), isTrue);
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.note, equals(''));
      });

      test('認証エラー時は Left(AuthFailure) を返す', () async {
        when(() => mockClient.request(any<GUpdateReadingNoteReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GUpdateReadingNoteData, GUpdateReadingNoteVars>(
              operationRequest: GUpdateReadingNoteReq(
                (b) => b
                  ..vars.userBookId = 42
                  ..vars.note = 'note',
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

        final result = await repository.updateReadingNote(
          userBookId: 42,
          note: 'note',
        );

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<AuthFailure>());
      });

      test('権限エラー時は Left(ForbiddenFailure) を返す', () async {
        when(() => mockClient.request(any<GUpdateReadingNoteReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GUpdateReadingNoteData, GUpdateReadingNoteVars>(
              operationRequest: GUpdateReadingNoteReq(
                (b) => b
                  ..vars.userBookId = 42
                  ..vars.note = 'note',
              ),
              data: null,
              graphqlErrors: [
                const GraphQLError(
                  message: 'Not authorized to update this record',
                  extensions: {'code': 'FORBIDDEN'},
                ),
              ],
            ),
          ),
        );

        final result = await repository.updateReadingNote(
          userBookId: 42,
          note: 'note',
        );

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ForbiddenFailure>());
      });
    });

    group('ReadingStatus Mapper', () {
      test('GReadingStatus.BACKLOG -> ReadingStatus.backlog', () async {
        final addedAt = DateTime(2024, 6, 15);
        final mockData = GBookDetailData(
          (b) => b
            ..bookDetail = GBookDetailData_bookDetail(
              (bd) => bd
                ..id = 'book-1'
                ..title = 'Test'
                ..authors = ListBuilder(['Author'])
                ..userBook = GBookDetailData_bookDetail_userBook(
                  (ub) => ub
                    ..id = 1
                    ..externalId = 'book-1'
                    ..title = 'Test'
                    ..authors = ListBuilder(['Author'])
                    ..addedAt = addedAt
                    ..readingStatus = GReadingStatus.BACKLOG,
                ).toBuilder(),
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GBookDetailReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GBookDetailData, GBookDetailVars>(
              operationRequest:
                  GBookDetailReq((b) => b..vars.bookId = 'book-1'),
              data: mockData,
            ),
          ),
        );

        final result = await repository.getBookDetail(bookId: 'book-1');
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.userBook!.readingStatus, equals(ReadingStatus.backlog));
      });

      test('GReadingStatus.READING -> ReadingStatus.reading', () async {
        final addedAt = DateTime(2024, 6, 15);
        final mockData = GBookDetailData(
          (b) => b
            ..bookDetail = GBookDetailData_bookDetail(
              (bd) => bd
                ..id = 'book-1'
                ..title = 'Test'
                ..authors = ListBuilder(['Author'])
                ..userBook = GBookDetailData_bookDetail_userBook(
                  (ub) => ub
                    ..id = 1
                    ..externalId = 'book-1'
                    ..title = 'Test'
                    ..authors = ListBuilder(['Author'])
                    ..addedAt = addedAt
                    ..readingStatus = GReadingStatus.READING,
                ).toBuilder(),
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GBookDetailReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GBookDetailData, GBookDetailVars>(
              operationRequest:
                  GBookDetailReq((b) => b..vars.bookId = 'book-1'),
              data: mockData,
            ),
          ),
        );

        final result = await repository.getBookDetail(bookId: 'book-1');
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.userBook!.readingStatus, equals(ReadingStatus.reading));
      });

      test('GReadingStatus.COMPLETED -> ReadingStatus.completed', () async {
        final addedAt = DateTime(2024, 6, 15);
        final mockData = GBookDetailData(
          (b) => b
            ..bookDetail = GBookDetailData_bookDetail(
              (bd) => bd
                ..id = 'book-1'
                ..title = 'Test'
                ..authors = ListBuilder(['Author'])
                ..userBook = GBookDetailData_bookDetail_userBook(
                  (ub) => ub
                    ..id = 1
                    ..externalId = 'book-1'
                    ..title = 'Test'
                    ..authors = ListBuilder(['Author'])
                    ..addedAt = addedAt
                    ..readingStatus = GReadingStatus.COMPLETED,
                ).toBuilder(),
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GBookDetailReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GBookDetailData, GBookDetailVars>(
              operationRequest:
                  GBookDetailReq((b) => b..vars.bookId = 'book-1'),
              data: mockData,
            ),
          ),
        );

        final result = await repository.getBookDetail(bookId: 'book-1');
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.userBook!.readingStatus, equals(ReadingStatus.completed));
      });

      test('GReadingStatus.DROPPED -> ReadingStatus.dropped', () async {
        final addedAt = DateTime(2024, 6, 15);
        final mockData = GBookDetailData(
          (b) => b
            ..bookDetail = GBookDetailData_bookDetail(
              (bd) => bd
                ..id = 'book-1'
                ..title = 'Test'
                ..authors = ListBuilder(['Author'])
                ..userBook = GBookDetailData_bookDetail_userBook(
                  (ub) => ub
                    ..id = 1
                    ..externalId = 'book-1'
                    ..title = 'Test'
                    ..authors = ListBuilder(['Author'])
                    ..addedAt = addedAt
                    ..readingStatus = GReadingStatus.DROPPED,
                ).toBuilder(),
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GBookDetailReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GBookDetailData, GBookDetailVars>(
              operationRequest:
                  GBookDetailReq((b) => b..vars.bookId = 'book-1'),
              data: mockData,
            ),
          ),
        );

        final result = await repository.getBookDetail(bookId: 'book-1');
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.userBook!.readingStatus, equals(ReadingStatus.dropped));
      });
    });
  });
}

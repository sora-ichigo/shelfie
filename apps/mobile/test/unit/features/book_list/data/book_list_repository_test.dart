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
import 'package:shelfie/features/book_list/data/__generated__/add_book_to_list.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/add_book_to_list.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/add_book_to_list.var.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/book_list_detail.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/book_list_detail.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/book_list_detail.var.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/create_book_list.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/create_book_list.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/create_book_list.var.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/delete_book_list.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/delete_book_list.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/delete_book_list.var.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/my_book_lists.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/my_book_lists.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/my_book_lists.var.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/remove_book_from_list.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/remove_book_from_list.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/remove_book_from_list.var.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/reorder_book_in_list.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/reorder_book_in_list.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/reorder_book_in_list.var.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/update_book_list.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/update_book_list.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/update_book_list.var.gql.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';

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
    registerFallbackValue(GMyBookListsReq());
    registerFallbackValue(
      GBookListDetailReq((b) => b..vars.listId = 1),
    );
    registerFallbackValue(
      GCreateBookListReq(
        (b) => b
          ..vars.input = GCreateBookListInput(
            (i) => i..title = 'test',
          ).toBuilder(),
      ),
    );
    registerFallbackValue(
      GUpdateBookListReq(
        (b) => b
          ..vars.input = GUpdateBookListInput(
            (i) => i
              ..listId = 1
              ..title = 'test',
          ).toBuilder(),
      ),
    );
    registerFallbackValue(
      GDeleteBookListReq((b) => b..vars.listId = 1),
    );
    registerFallbackValue(
      GAddBookToListReq(
        (b) => b
          ..vars.listId = 1
          ..vars.userBookId = 1,
      ),
    );
    registerFallbackValue(
      GRemoveBookFromListReq(
        (b) => b
          ..vars.listId = 1
          ..vars.userBookId = 1,
      ),
    );
    registerFallbackValue(
      GReorderBookInListReq(
        (b) => b
          ..vars.listId = 1
          ..vars.itemId = 1
          ..vars.newPosition = 0,
      ),
    );
  });

  group('BookListRepository', () {
    late MockClient mockClient;
    late ProviderContainer container;
    late BookListRepository repository;

    setUp(() {
      mockClient = MockClient();
      container = createTestContainer(
        overrides: [
          ferryClientProvider.overrideWithValue(mockClient),
        ],
      );
      repository = container.read(bookListRepositoryProvider);
    });

    tearDown(() {
      container.dispose();
    });

    group('getMyBookLists', () {
      test('リスト一覧取得成功時は Right(MyBookListsResult) を返す', () async {
        final createdAt = DateTime(2024, 6, 15);
        final updatedAt = DateTime(2024, 6, 16);

        final mockData = GMyBookListsData(
          (b) => b
            ..myBookLists = GMyBookListsData_myBookLists(
              (m) => m
                ..items = ListBuilder([
                  GMyBookListsData_myBookLists_items(
                    (i) => i
                      ..id = 1
                      ..title = 'My List'
                      ..description = 'Test description'
                      ..bookCount = 3
                      ..coverImages = ListBuilder(['url1', 'url2'])
                      ..createdAt = createdAt
                      ..updatedAt = updatedAt,
                  ),
                ])
                ..totalCount = 1
                ..hasMore = false,
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GMyBookListsReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GMyBookListsData, GMyBookListsVars>(
              operationRequest: GMyBookListsReq(),
              data: mockData,
            ),
          ),
        );

        final result = await repository.getMyBookLists();

        expect(result.isRight(), isTrue);
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.items.length, equals(1));
        expect(data.items.first.id, equals(1));
        expect(data.items.first.title, equals('My List'));
        expect(data.items.first.description, equals('Test description'));
        expect(data.items.first.bookCount, equals(3));
        expect(data.items.first.coverImages, equals(['url1', 'url2']));
        expect(data.totalCount, equals(1));
        expect(data.hasMore, isFalse);
      });

      test('認証エラー時は Left(AuthFailure) を返す', () async {
        when(() => mockClient.request(any<GMyBookListsReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GMyBookListsData, GMyBookListsVars>(
              operationRequest: GMyBookListsReq(),
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

        final result = await repository.getMyBookLists();

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<AuthFailure>());
      });

      test('データがない場合は Left(ServerFailure) を返す', () async {
        when(() => mockClient.request(any<GMyBookListsReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GMyBookListsData, GMyBookListsVars>(
              operationRequest: GMyBookListsReq(),
              data: null,
            ),
          ),
        );

        final result = await repository.getMyBookLists();

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ServerFailure>());
      });
    });

    group('getBookListDetail', () {
      test('リスト詳細取得成功時は Right(BookListDetail) を返す', () async {
        final createdAt = DateTime(2024, 6, 15);
        final updatedAt = DateTime(2024, 6, 16);
        final addedAt = DateTime(2024, 6, 17);

        final mockData = GBookListDetailData(
          (b) => b
            ..bookListDetail = GBookListDetailData_bookListDetail(
              (d) => d
                ..id = 1
                ..title = 'My List'
                ..description = 'Description'
                ..items = ListBuilder([
                  GBookListDetailData_bookListDetail_items(
                    (i) => i
                      ..id = 10
                      ..position = 0
                      ..addedAt = addedAt,
                  ),
                ])
                ..stats = GBookListDetailData_bookListDetail_stats(
                  (s) => s
                    ..bookCount = 1
                    ..completedCount = 0
                    ..coverImages = ListBuilder<String>(),
                ).toBuilder()
                ..createdAt = createdAt
                ..updatedAt = updatedAt,
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GBookListDetailReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GBookListDetailData, GBookListDetailVars>(
              operationRequest: GBookListDetailReq((b) => b..vars.listId = 1),
              data: mockData,
            ),
          ),
        );

        final result = await repository.getBookListDetail(listId: 1);

        expect(result.isRight(), isTrue);
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.id, equals(1));
        expect(data.title, equals('My List'));
        expect(data.description, equals('Description'));
        expect(data.items.length, equals(1));
        expect(data.items.first.id, equals(10));
        expect(data.items.first.position, equals(0));
      });

      test('リストが見つからない場合は Left(NotFoundFailure) を返す', () async {
        when(() => mockClient.request(any<GBookListDetailReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GBookListDetailData, GBookListDetailVars>(
              operationRequest: GBookListDetailReq((b) => b..vars.listId = 999),
              data: null,
              graphqlErrors: [
                const GraphQLError(
                  message: 'List not found',
                  extensions: {'code': 'NOT_FOUND'},
                ),
              ],
            ),
          ),
        );

        final result = await repository.getBookListDetail(listId: 999);

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<NotFoundFailure>());
      });

      test('権限エラー時は Left(ForbiddenFailure) を返す', () async {
        when(() => mockClient.request(any<GBookListDetailReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GBookListDetailData, GBookListDetailVars>(
              operationRequest: GBookListDetailReq((b) => b..vars.listId = 1),
              data: null,
              graphqlErrors: [
                const GraphQLError(
                  message: 'Forbidden',
                  extensions: {'code': 'FORBIDDEN'},
                ),
              ],
            ),
          ),
        );

        final result = await repository.getBookListDetail(listId: 1);

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ForbiddenFailure>());
      });
    });

    group('createBookList', () {
      test('リスト作成成功時は Right(BookList) を返す', () async {
        final createdAt = DateTime(2024, 6, 15);
        final updatedAt = DateTime(2024, 6, 16);

        final mockData = GCreateBookListData(
          (b) => b
            ..createBookList = GCreateBookListData_createBookList(
              (c) => c
                ..id = 1
                ..title = 'New List'
                ..description = 'New description'
                ..createdAt = createdAt
                ..updatedAt = updatedAt,
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GCreateBookListReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GCreateBookListData, GCreateBookListVars>(
              operationRequest: GCreateBookListReq(
                (b) => b
                  ..vars.input = GCreateBookListInput(
                    (i) => i
                      ..title = 'New List'
                      ..description = 'New description',
                  ).toBuilder(),
              ),
              data: mockData,
            ),
          ),
        );

        final result = await repository.createBookList(
          title: 'New List',
          description: 'New description',
        );

        expect(result.isRight(), isTrue);
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.id, equals(1));
        expect(data.title, equals('New List'));
        expect(data.description, equals('New description'));
      });

      test('バリデーションエラー時は Left(ValidationFailure) を返す', () async {
        when(() => mockClient.request(any<GCreateBookListReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GCreateBookListData, GCreateBookListVars>(
              operationRequest: GCreateBookListReq(
                (b) => b
                  ..vars.input = GCreateBookListInput(
                    (i) => i..title = '',
                  ).toBuilder(),
              ),
              data: null,
              graphqlErrors: [
                const GraphQLError(
                  message: 'Title is required',
                  extensions: {'code': 'VALIDATION_ERROR'},
                ),
              ],
            ),
          ),
        );

        final result = await repository.createBookList(title: '');

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ValidationFailure>());
      });
    });

    group('updateBookList', () {
      test('リスト更新成功時は Right(BookList) を返す', () async {
        final createdAt = DateTime(2024, 6, 15);
        final updatedAt = DateTime(2024, 6, 17);

        final mockData = GUpdateBookListData(
          (b) => b
            ..updateBookList = GUpdateBookListData_updateBookList(
              (u) => u
                ..id = 1
                ..title = 'Updated Title'
                ..description = 'Updated description'
                ..createdAt = createdAt
                ..updatedAt = updatedAt,
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GUpdateBookListReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GUpdateBookListData, GUpdateBookListVars>(
              operationRequest: GUpdateBookListReq(
                (b) => b
                  ..vars.input = GUpdateBookListInput(
                    (i) => i
                      ..listId = 1
                      ..title = 'Updated Title'
                      ..description = 'Updated description',
                  ).toBuilder(),
              ),
              data: mockData,
            ),
          ),
        );

        final result = await repository.updateBookList(
          listId: 1,
          title: 'Updated Title',
          description: 'Updated description',
        );

        expect(result.isRight(), isTrue);
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.id, equals(1));
        expect(data.title, equals('Updated Title'));
        expect(data.description, equals('Updated description'));
      });

      test('リストが見つからない場合は Left(NotFoundFailure) を返す', () async {
        when(() => mockClient.request(any<GUpdateBookListReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GUpdateBookListData, GUpdateBookListVars>(
              operationRequest: GUpdateBookListReq(
                (b) => b
                  ..vars.input = GUpdateBookListInput(
                    (i) => i
                      ..listId = 999
                      ..title = 'title',
                  ).toBuilder(),
              ),
              data: null,
              graphqlErrors: [
                const GraphQLError(
                  message: 'List not found',
                  extensions: {'code': 'NOT_FOUND'},
                ),
              ],
            ),
          ),
        );

        final result = await repository.updateBookList(
          listId: 999,
          title: 'title',
        );

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<NotFoundFailure>());
      });
    });

    group('deleteBookList', () {
      test('リスト削除成功時は Right(void) を返す', () async {
        final mockData = GDeleteBookListData((b) => b..deleteBookList = true);

        when(() => mockClient.request(any<GDeleteBookListReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GDeleteBookListData, GDeleteBookListVars>(
              operationRequest: GDeleteBookListReq((b) => b..vars.listId = 1),
              data: mockData,
            ),
          ),
        );

        final result = await repository.deleteBookList(listId: 1);

        expect(result.isRight(), isTrue);
      });

      test('リストが見つからない場合は Left(NotFoundFailure) を返す', () async {
        when(() => mockClient.request(any<GDeleteBookListReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GDeleteBookListData, GDeleteBookListVars>(
              operationRequest: GDeleteBookListReq((b) => b..vars.listId = 999),
              data: null,
              graphqlErrors: [
                const GraphQLError(
                  message: 'List not found',
                  extensions: {'code': 'NOT_FOUND'},
                ),
              ],
            ),
          ),
        );

        final result = await repository.deleteBookList(listId: 999);

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<NotFoundFailure>());
      });
    });

    group('addBookToList', () {
      test('本の追加成功時は Right(BookListItem) を返す', () async {
        final addedAt = DateTime(2024, 6, 15);

        final mockData = GAddBookToListData(
          (b) => b
            ..addBookToList = GAddBookToListData_addBookToList(
              (a) => a
                ..id = 10
                ..position = 5
                ..addedAt = addedAt,
            ).toBuilder(),
        );

        when(() => mockClient.request(any<GAddBookToListReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GAddBookToListData, GAddBookToListVars>(
              operationRequest: GAddBookToListReq(
                (b) => b
                  ..vars.listId = 1
                  ..vars.userBookId = 100,
              ),
              data: mockData,
            ),
          ),
        );

        final result = await repository.addBookToList(
          listId: 1,
          userBookId: 100,
        );

        expect(result.isRight(), isTrue);
        final data =
            result.getOrElse((_) => throw Exception('Should be right'));
        expect(data.id, equals(10));
        expect(data.position, equals(5));
      });

      test('重複追加時は Left(DuplicateBookFailure) を返す', () async {
        when(() => mockClient.request(any<GAddBookToListReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GAddBookToListData, GAddBookToListVars>(
              operationRequest: GAddBookToListReq(
                (b) => b
                  ..vars.listId = 1
                  ..vars.userBookId = 100,
              ),
              data: null,
              graphqlErrors: [
                const GraphQLError(
                  message: 'Book already in list',
                  extensions: {'code': 'DUPLICATE_BOOK'},
                ),
              ],
            ),
          ),
        );

        final result = await repository.addBookToList(
          listId: 1,
          userBookId: 100,
        );

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<DuplicateBookFailure>());
      });
    });

    group('removeBookFromList', () {
      test('本の削除成功時は Right(void) を返す', () async {
        final mockData =
            GRemoveBookFromListData((b) => b..removeBookFromList = true);

        when(() => mockClient.request(any<GRemoveBookFromListReq>()))
            .thenAnswer(
          (_) => Stream.value(
            OperationResponse<GRemoveBookFromListData, GRemoveBookFromListVars>(
              operationRequest: GRemoveBookFromListReq(
                (b) => b
                  ..vars.listId = 1
                  ..vars.userBookId = 100,
              ),
              data: mockData,
            ),
          ),
        );

        final result = await repository.removeBookFromList(
          listId: 1,
          userBookId: 100,
        );

        expect(result.isRight(), isTrue);
      });

      test('本がリストにない場合は Left(NotFoundFailure) を返す', () async {
        when(() => mockClient.request(any<GRemoveBookFromListReq>()))
            .thenAnswer(
          (_) => Stream.value(
            OperationResponse<GRemoveBookFromListData, GRemoveBookFromListVars>(
              operationRequest: GRemoveBookFromListReq(
                (b) => b
                  ..vars.listId = 1
                  ..vars.userBookId = 999,
              ),
              data: null,
              graphqlErrors: [
                const GraphQLError(
                  message: 'Book not in list',
                  extensions: {'code': 'BOOK_NOT_IN_LIST'},
                ),
              ],
            ),
          ),
        );

        final result = await repository.removeBookFromList(
          listId: 1,
          userBookId: 999,
        );

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<NotFoundFailure>());
      });
    });

    group('reorderBookInList', () {
      test('並べ替え成功時は Right(void) を返す', () async {
        final mockData =
            GReorderBookInListData((b) => b..reorderBookInList = true);

        when(() => mockClient.request(any<GReorderBookInListReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GReorderBookInListData, GReorderBookInListVars>(
              operationRequest: GReorderBookInListReq(
                (b) => b
                  ..vars.listId = 1
                  ..vars.itemId = 10
                  ..vars.newPosition = 2,
              ),
              data: mockData,
            ),
          ),
        );

        final result = await repository.reorderBookInList(
          listId: 1,
          itemId: 10,
          newPosition: 2,
        );

        expect(result.isRight(), isTrue);
      });

      test('リストが見つからない場合は Left(NotFoundFailure) を返す', () async {
        when(() => mockClient.request(any<GReorderBookInListReq>())).thenAnswer(
          (_) => Stream.value(
            OperationResponse<GReorderBookInListData, GReorderBookInListVars>(
              operationRequest: GReorderBookInListReq(
                (b) => b
                  ..vars.listId = 999
                  ..vars.itemId = 10
                  ..vars.newPosition = 2,
              ),
              data: null,
              graphqlErrors: [
                const GraphQLError(
                  message: 'List not found',
                  extensions: {'code': 'NOT_FOUND'},
                ),
              ],
            ),
          ),
        );

        final result = await repository.reorderBookInList(
          listId: 999,
          itemId: 10,
          newPosition: 2,
        );

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<NotFoundFailure>());
      });
    });
  });
}

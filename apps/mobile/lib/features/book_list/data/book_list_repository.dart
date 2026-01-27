import 'dart:async';
import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/network/ferry_client.dart';
import 'package:shelfie/features/book_list/data/__generated__/add_book_to_list.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/add_book_to_list.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/book_list_detail.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/book_list_detail.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/create_book_list.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/create_book_list.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/delete_book_list.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/delete_book_list.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/my_book_lists.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/my_book_lists.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/remove_book_from_list.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/remove_book_from_list.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/reorder_book_in_list.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/reorder_book_in_list.req.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/update_book_list.data.gql.dart';
import 'package:shelfie/features/book_list/data/__generated__/update_book_list.req.gql.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

part 'book_list_repository.g.dart';

abstract class BookListRepository {
  Future<Either<Failure, MyBookListsResult>> getMyBookLists({
    int? limit,
    int? offset,
  });

  Future<Either<Failure, BookListDetail>> getBookListDetail({
    required int listId,
  });

  Future<Either<Failure, BookList>> createBookList({
    required String title,
    String? description,
  });

  Future<Either<Failure, BookList>> updateBookList({
    required int listId,
    String? title,
    String? description,
  });

  Future<Either<Failure, void>> deleteBookList({
    required int listId,
  });

  Future<Either<Failure, BookListItem>> addBookToList({
    required int listId,
    required int userBookId,
  });

  Future<Either<Failure, void>> removeBookFromList({
    required int listId,
    required int userBookId,
  });

  Future<Either<Failure, void>> reorderBookInList({
    required int listId,
    required int itemId,
    required int newPosition,
  });
}

class BookListRepositoryImpl implements BookListRepository {
  const BookListRepositoryImpl({required this.client});

  final Client client;

  @override
  Future<Either<Failure, MyBookListsResult>> getMyBookLists({
    int? limit,
    int? offset,
  }) async {
    final request = GMyBookListsReq(
      (b) => b
        ..fetchPolicy = FetchPolicy.NetworkOnly
        ..vars.input = GMyBookListsInput(
          (i) => i
            ..limit = limit
            ..offset = offset,
        ).toBuilder(),
    );

    try {
      final response = await client.request(request).first;
      return _handleMyBookListsResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Either<Failure, MyBookListsResult> _handleMyBookListsResponse(
    OperationResponse<GMyBookListsData, dynamic> response,
  ) {
    if (response.hasErrors) {
      return left(_mapGraphQLError(response.graphqlErrors));
    }

    final data = response.data;
    if (data == null) {
      return left(
        const ServerFailure(message: 'No data received', code: 'NO_DATA'),
      );
    }

    final result = data.myBookLists;
    return right(
      MyBookListsResult(
        items: result.items
            .map(
              (item) => BookListSummary(
                id: item.id,
                title: item.title,
                description: item.description,
                bookCount: item.bookCount,
                coverImages: item.coverImages.toList(),
                createdAt: item.createdAt,
                updatedAt: item.updatedAt,
              ),
            )
            .toList(),
        totalCount: result.totalCount,
        hasMore: result.hasMore,
      ),
    );
  }

  @override
  Future<Either<Failure, BookListDetail>> getBookListDetail({
    required int listId,
  }) async {
    final request = GBookListDetailReq(
      (b) => b
        ..fetchPolicy = FetchPolicy.NetworkOnly
        ..vars.listId = listId,
    );

    try {
      final response = await client.request(request).first;
      return _handleBookListDetailResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Either<Failure, BookListDetail> _handleBookListDetailResponse(
    OperationResponse<GBookListDetailData, dynamic> response,
  ) {
    if (response.hasErrors) {
      return left(_mapGraphQLError(response.graphqlErrors));
    }

    final data = response.data;
    if (data == null) {
      return left(
        const ServerFailure(message: 'No data received', code: 'NO_DATA'),
      );
    }

    final detail = data.bookListDetail;
    return right(
      BookListDetail(
        id: detail.id,
        title: detail.title,
        description: detail.description,
        items: detail.items
            .map(
              (item) => BookListItem(
                id: item.id,
                position: item.position,
                addedAt: item.addedAt,
              ),
            )
            .toList(),
        createdAt: detail.createdAt,
        updatedAt: detail.updatedAt,
      ),
    );
  }

  @override
  Future<Either<Failure, BookList>> createBookList({
    required String title,
    String? description,
  }) async {
    final request = GCreateBookListReq(
      (b) => b
        ..fetchPolicy = FetchPolicy.NetworkOnly
        ..vars.input = GCreateBookListInput(
          (i) => i
            ..title = title
            ..description = description,
        ).toBuilder(),
    );

    try {
      final response = await client.request(request).first;
      return _handleCreateBookListResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Either<Failure, BookList> _handleCreateBookListResponse(
    OperationResponse<GCreateBookListData, dynamic> response,
  ) {
    if (response.hasErrors) {
      return left(_mapGraphQLError(response.graphqlErrors));
    }

    final data = response.data;
    if (data == null) {
      return left(
        const ServerFailure(message: 'No data received', code: 'NO_DATA'),
      );
    }

    final list = data.createBookList;
    return right(
      BookList(
        id: list.id,
        title: list.title,
        description: list.description,
        createdAt: list.createdAt,
        updatedAt: list.updatedAt,
      ),
    );
  }

  @override
  Future<Either<Failure, BookList>> updateBookList({
    required int listId,
    String? title,
    String? description,
  }) async {
    final request = GUpdateBookListReq(
      (b) => b
        ..fetchPolicy = FetchPolicy.NetworkOnly
        ..vars.input = GUpdateBookListInput(
          (i) => i
            ..listId = listId
            ..title = title
            ..description = description,
        ).toBuilder(),
    );

    try {
      final response = await client.request(request).first;
      return _handleUpdateBookListResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Either<Failure, BookList> _handleUpdateBookListResponse(
    OperationResponse<GUpdateBookListData, dynamic> response,
  ) {
    if (response.hasErrors) {
      return left(_mapGraphQLError(response.graphqlErrors));
    }

    final data = response.data;
    if (data == null) {
      return left(
        const ServerFailure(message: 'No data received', code: 'NO_DATA'),
      );
    }

    final list = data.updateBookList;
    return right(
      BookList(
        id: list.id,
        title: list.title,
        description: list.description,
        createdAt: list.createdAt,
        updatedAt: list.updatedAt,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> deleteBookList({
    required int listId,
  }) async {
    final request = GDeleteBookListReq(
      (b) => b
        ..fetchPolicy = FetchPolicy.NetworkOnly
        ..vars.listId = listId,
    );

    try {
      final response = await client.request(request).first;
      return _handleDeleteBookListResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Either<Failure, void> _handleDeleteBookListResponse(
    OperationResponse<GDeleteBookListData, dynamic> response,
  ) {
    if (response.hasErrors) {
      return left(_mapGraphQLError(response.graphqlErrors));
    }

    return right(null);
  }

  @override
  Future<Either<Failure, BookListItem>> addBookToList({
    required int listId,
    required int userBookId,
  }) async {
    final request = GAddBookToListReq(
      (b) => b
        ..fetchPolicy = FetchPolicy.NetworkOnly
        ..vars.listId = listId
        ..vars.userBookId = userBookId,
    );

    try {
      final response = await client.request(request).first;
      return _handleAddBookToListResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Either<Failure, BookListItem> _handleAddBookToListResponse(
    OperationResponse<GAddBookToListData, dynamic> response,
  ) {
    if (response.hasErrors) {
      return left(_mapGraphQLError(response.graphqlErrors));
    }

    final data = response.data;
    if (data == null) {
      return left(
        const ServerFailure(message: 'No data received', code: 'NO_DATA'),
      );
    }

    final item = data.addBookToList;
    return right(
      BookListItem(
        id: item.id,
        position: item.position,
        addedAt: item.addedAt,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> removeBookFromList({
    required int listId,
    required int userBookId,
  }) async {
    final request = GRemoveBookFromListReq(
      (b) => b
        ..fetchPolicy = FetchPolicy.NetworkOnly
        ..vars.listId = listId
        ..vars.userBookId = userBookId,
    );

    try {
      final response = await client.request(request).first;
      return _handleRemoveBookFromListResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Either<Failure, void> _handleRemoveBookFromListResponse(
    OperationResponse<GRemoveBookFromListData, dynamic> response,
  ) {
    if (response.hasErrors) {
      return left(_mapGraphQLError(response.graphqlErrors));
    }

    return right(null);
  }

  @override
  Future<Either<Failure, void>> reorderBookInList({
    required int listId,
    required int itemId,
    required int newPosition,
  }) async {
    final request = GReorderBookInListReq(
      (b) => b
        ..fetchPolicy = FetchPolicy.NetworkOnly
        ..vars.listId = listId
        ..vars.itemId = itemId
        ..vars.newPosition = newPosition,
    );

    try {
      final response = await client.request(request).first;
      return _handleReorderBookInListResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Either<Failure, void> _handleReorderBookInListResponse(
    OperationResponse<GReorderBookInListData, dynamic> response,
  ) {
    if (response.hasErrors) {
      return left(_mapGraphQLError(response.graphqlErrors));
    }

    return right(null);
  }

  Failure _mapGraphQLError(List<GraphQLError>? errors) {
    final error = errors?.firstOrNull;
    final errorMessage = error?.message ?? 'GraphQL error';
    final extensions = error?.extensions;
    final code = extensions?['code'] as String?;

    return switch (code) {
      'UNAUTHENTICATED' => AuthFailure(message: errorMessage),
      'NOT_FOUND' => NotFoundFailure(message: errorMessage),
      'FORBIDDEN' => ForbiddenFailure(message: errorMessage),
      'DUPLICATE_BOOK' => DuplicateBookFailure(message: errorMessage),
      'BOOK_NOT_IN_LIST' => NotFoundFailure(message: errorMessage),
      'VALIDATION_ERROR' => ValidationFailure(message: errorMessage),
      _ => ServerFailure(message: errorMessage, code: code ?? 'GRAPHQL_ERROR'),
    };
  }
}

@riverpod
BookListRepository bookListRepository(Ref ref) {
  final client = ref.watch(ferryClientProvider);
  return BookListRepositoryImpl(client: client);
}

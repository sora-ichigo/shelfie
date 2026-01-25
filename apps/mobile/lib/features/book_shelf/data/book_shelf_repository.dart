import 'dart:async';
import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/network/ferry_client.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/data/__generated__/my_shelf_paginated.data.gql.dart';
import 'package:shelfie/features/book_shelf/data/__generated__/my_shelf_paginated.req.gql.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

part 'book_shelf_repository.g.dart';

/// myShelf クエリの結果を表すモデル
class MyShelfResult {
  const MyShelfResult({
    required this.items,
    required this.totalCount,
    required this.hasMore,
  });

  final List<ShelfBookItem> items;
  final int totalCount;
  final bool hasMore;
}

/// 本棚データのリポジトリ
abstract class BookShelfRepository {
  /// 本棚の書籍一覧を取得
  Future<Either<Failure, MyShelfResult>> getMyShelf({
    String? query,
    GShelfSortField? sortBy,
    GSortOrder? sortOrder,
    int? limit,
    int? offset,
  });
}

/// 本棚リポジトリの実装
class BookShelfRepositoryImpl implements BookShelfRepository {
  const BookShelfRepositoryImpl({required this.client});

  final Client client;

  static const int defaultPageSize = 20;

  @override
  Future<Either<Failure, MyShelfResult>> getMyShelf({
    String? query,
    GShelfSortField? sortBy,
    GSortOrder? sortOrder,
    int? limit,
    int? offset,
  }) async {
    final request = GMyShelfPaginatedReq(
      (b) => b
        ..vars.input = GMyShelfInput(
          (i) => i
            ..query = query
            ..sortBy = sortBy
            ..sortOrder = sortOrder
            ..limit = limit ?? defaultPageSize
            ..offset = offset ?? 0,
        ).toBuilder(),
    );

    try {
      final response = await client.request(request).first;
      return _handleResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Either<Failure, MyShelfResult> _handleResponse(
    OperationResponse<GMyShelfPaginatedData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      final errorMessage = error?.message ?? 'Failed to fetch shelf';
      final extensions = error?.extensions;
      final code = extensions?['code'] as String?;

      if (code == 'UNAUTHENTICATED') {
        return left(AuthFailure(message: errorMessage));
      }

      return left(
        ServerFailure(
          message: errorMessage,
          code: code ?? 'GRAPHQL_ERROR',
        ),
      );
    }

    final data = response.data;
    if (data == null) {
      return left(
        const ServerFailure(
          message: 'No data received',
          code: 'NO_DATA',
        ),
      );
    }

    final result = data.myShelf;
    return right(
      MyShelfResult(
        items: result.items
            .map(
              (item) => ShelfBookItem(
                userBookId: item.id,
                externalId: item.externalId,
                title: item.title,
                authors: item.authors.toList(),
                readingStatus: _mapReadingStatus(item.readingStatus.name),
                addedAt: item.addedAt,
                coverImageUrl: item.coverImageUrl,
                completedAt: item.completedAt,
              ),
            )
            .toList(),
        totalCount: result.totalCount,
        hasMore: result.hasMore,
      ),
    );
  }

  ReadingStatus _mapReadingStatus(String status) {
    return switch (status.toUpperCase()) {
      'BACKLOG' => ReadingStatus.backlog,
      'READING' => ReadingStatus.reading,
      'COMPLETED' => ReadingStatus.completed,
      'DROPPED' => ReadingStatus.dropped,
      _ => ReadingStatus.backlog,
    };
  }
}

@riverpod
BookShelfRepository bookShelfRepository(Ref ref) {
  final client = ref.watch(ferryClientProvider);
  return BookShelfRepositoryImpl(client: client);
}

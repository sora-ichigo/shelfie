import 'dart:async';
import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/network/ferry_client.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;
import 'package:shelfie/features/book_shelf/data/__generated__/my_shelf_paginated.data.gql.dart';
import 'package:shelfie/features/book_shelf/data/__generated__/my_shelf_paginated.req.gql.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/follow/data/__generated__/user_shelf.data.gql.dart';
import 'package:shelfie/features/follow/data/__generated__/user_shelf.req.gql.dart';

part 'book_shelf_repository.g.dart';

/// myShelf クエリの結果を表すモデル
class MyShelfResult {
  const MyShelfResult({
    required this.items,
    required this.entries,
    required this.totalCount,
    required this.hasMore,
  });

  /// 書籍情報のリスト
  final List<ShelfBookItem> items;

  /// 状態情報のマップ（externalId → ShelfEntry）
  /// shelfStateProvider に登録するためのデータ
  final Map<String, ShelfEntry> entries;

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
    GReadingStatus? readingStatus,
  });

  /// 他ユーザーの本棚を取得
  Future<Either<Failure, MyShelfResult>> getUserShelf({
    required int userId,
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
    GReadingStatus? readingStatus,
  }) async {
    final request = GMyShelfPaginatedReq(
      (b) => b
        ..fetchPolicy = FetchPolicy.NetworkOnly
        ..vars.input = GMyShelfInput(
          (i) => i
            ..query = query
            ..sortBy = sortBy
            ..sortOrder = sortOrder
            ..limit = limit ?? defaultPageSize
            ..offset = offset ?? 0
            ..readingStatus = readingStatus,
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

  @override
  Future<Either<Failure, MyShelfResult>> getUserShelf({
    required int userId,
    int? limit,
    int? offset,
  }) async {
    final request = GUserShelfReq(
      (b) => b
        ..fetchPolicy = FetchPolicy.NetworkOnly
        ..vars.userId = userId
        ..vars.input = GMyShelfInput(
          (i) => i
            ..limit = limit ?? defaultPageSize
            ..offset = offset ?? 0,
        ).toBuilder(),
    );

    try {
      final response = await client.request(request).first;
      return _handleUserShelfResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Either<Failure, MyShelfResult> _handleUserShelfResponse(
    OperationResponse<GUserShelfData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      final errorMessage = error?.message ?? 'Failed to fetch shelf';
      final extensions = error?.extensions;
      final code = extensions?['code'] as String?;

      if (code == 'UNAUTHENTICATED') {
        return left(AuthFailure(message: errorMessage));
      }
      if (code == 'FORBIDDEN') {
        return left(ForbiddenFailure(message: errorMessage));
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

    final result = data.userShelf;
    final items = <ShelfBookItem>[];

    for (final item in result.items) {
      items.add(
        ShelfBookItem(
          userBookId: item.id,
          externalId: item.externalId,
          title: item.title,
          authors: item.authors.toList(),
          source: _mapBookSource(item.source.name),
          addedAt: item.addedAt,
          coverImageUrl: item.coverImageUrl,
        ),
      );
    }

    return right(
      MyShelfResult(
        items: items,
        entries: const {},
        totalCount: result.totalCount,
        hasMore: result.hasMore,
      ),
    );
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

    final items = <ShelfBookItem>[];
    final entries = <String, ShelfEntry>{};

    for (final item in result.items) {
      // 書籍情報
      items.add(
        ShelfBookItem(
          userBookId: item.id,
          externalId: item.externalId,
          title: item.title,
          authors: item.authors.toList(),
          source: _mapBookSource(item.source.name),
          addedAt: item.addedAt,
          coverImageUrl: item.coverImageUrl,
        ),
      );

      // 状態情報（SSOT 用）
      entries[item.externalId] = ShelfEntry(
        userBookId: item.id,
        externalId: item.externalId,
        readingStatus: _mapReadingStatus(item.readingStatus.name),
        addedAt: item.addedAt,
        startedAt: item.startedAt,
        completedAt: item.completedAt,
        rating: item.rating,
      );
    }

    return right(
      MyShelfResult(
        items: items,
        entries: entries,
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
      'INTERESTED' => ReadingStatus.interested,
      _ => ReadingStatus.backlog,
    };
  }

  BookSource _mapBookSource(String source) {
    return switch (source.toUpperCase()) {
      'GOOGLE' => BookSource.google,
      _ => BookSource.rakuten,
    };
  }
}

@riverpod
BookShelfRepository bookShelfRepository(Ref ref) {
  final client = ref.watch(ferryClientProvider);
  return BookShelfRepositoryImpl(client: client);
}

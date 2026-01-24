import 'dart:async';
import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/network/ferry_client.dart';
import 'package:shelfie/features/book_detail/data/__generated__/book_detail.data.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/book_detail.req.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/remove_from_shelf.data.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/remove_from_shelf.req.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_note.data.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_note.req.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_status.data.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/update_reading_status.req.gql.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_detail/domain/user_book.dart';

part 'book_detail_repository.g.dart';

@riverpod
BookDetailRepository bookDetailRepository(BookDetailRepositoryRef ref) {
  final client = ref.watch(ferryClientProvider);
  return BookDetailRepository(client: client);
}

/// 書籍詳細取得APIのレスポンス
typedef BookDetailResponse = ({BookDetail bookDetail, UserBook? userBook});

class BookDetailRepository {
  const BookDetailRepository({required this.client});

  final Client client;

  Future<Either<Failure, BookDetailResponse>> getBookDetail({
    required String bookId,
  }) async {
    final request = GBookDetailReq(
      (b) => b..vars.bookId = bookId,
    );

    try {
      final response = await client.request(request).first;
      return _handleBookDetailResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, UserBook>> updateReadingStatus({
    required int userBookId,
    required ReadingStatus status,
  }) async {
    final request = GUpdateReadingStatusReq(
      (b) => b
        ..vars.userBookId = userBookId
        ..vars.status = _toGReadingStatus(status),
    );

    try {
      final response = await client.request(request).first;
      return _handleUpdateReadingStatusResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, UserBook>> updateReadingNote({
    required int userBookId,
    required String note,
  }) async {
    final request = GUpdateReadingNoteReq(
      (b) => b
        ..vars.userBookId = userBookId
        ..vars.note = note,
    );

    try {
      final response = await client.request(request).first;
      return _handleUpdateReadingNoteResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> removeFromShelf({
    required int userBookId,
  }) async {
    final request = GRemoveFromShelfReq(
      (b) => b..vars.userBookId = userBookId,
    );

    try {
      final response = await client.request(request).first;
      return _handleRemoveFromShelfResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Either<Failure, BookDetailResponse> _handleBookDetailResponse(
    OperationResponse<GBookDetailData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      final errorMessage = error?.message ?? 'Failed to fetch book detail';
      final extensions = error?.extensions;
      final code = extensions?['code'] as String?;

      return left(_mapErrorCodeToFailure(code, errorMessage));
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

    final bookDetailData = data.bookDetail;
    final bookDetail = _mapToBookDetail(bookDetailData);
    final userBook = bookDetailData.userBook != null
        ? _mapToUserBook(bookDetailData.userBook!)
        : null;
    return right((bookDetail: bookDetail, userBook: userBook));
  }

  Either<Failure, UserBook> _handleUpdateReadingStatusResponse(
    OperationResponse<GUpdateReadingStatusData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      final errorMessage = error?.message ?? 'Failed to update reading status';
      final extensions = error?.extensions;
      final code = extensions?['code'] as String?;

      return left(_mapErrorCodeToFailure(code, errorMessage));
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

    final userBook = data.updateReadingStatus;
    return right(_mapUpdateReadingStatusToUserBook(userBook));
  }

  Either<Failure, UserBook> _handleUpdateReadingNoteResponse(
    OperationResponse<GUpdateReadingNoteData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      final errorMessage = error?.message ?? 'Failed to update reading note';
      final extensions = error?.extensions;
      final code = extensions?['code'] as String?;

      return left(_mapErrorCodeToFailure(code, errorMessage));
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

    final userBook = data.updateReadingNote;
    return right(_mapUpdateReadingNoteToUserBook(userBook));
  }

  Either<Failure, void> _handleRemoveFromShelfResponse(
    OperationResponse<GRemoveFromShelfData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      final errorMessage = error?.message ?? 'Failed to remove from shelf';
      final extensions = error?.extensions;
      final code = extensions?['code'] as String?;

      return left(_mapErrorCodeToFailure(code, errorMessage));
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

    if (!data.removeFromShelf) {
      return left(
        const ServerFailure(
          message: 'Failed to remove from shelf',
          code: 'REMOVE_FAILED',
        ),
      );
    }

    return right(null);
  }

  Failure _mapErrorCodeToFailure(String? code, String message) {
    return switch (code) {
      'UNAUTHENTICATED' => AuthFailure(message: message),
      'FORBIDDEN' => ForbiddenFailure(message: message),
      'NOT_FOUND' => NotFoundFailure(message: message),
      _ => ServerFailure(message: message, code: code ?? 'GRAPHQL_ERROR'),
    };
  }

  BookDetail _mapToBookDetail(GBookDetailData_bookDetail bookDetail) {
    return BookDetail(
      id: bookDetail.id,
      title: bookDetail.title,
      authors: bookDetail.authors.toList(),
      publisher: bookDetail.publisher,
      publishedDate: bookDetail.publishedDate,
      pageCount: bookDetail.pageCount,
      categories: bookDetail.categories?.toList(),
      description: bookDetail.description,
      isbn: bookDetail.isbn,
      thumbnailUrl: bookDetail.coverImageUrl,
      amazonUrl: bookDetail.amazonUrl,
      rakutenBooksUrl: bookDetail.rakutenBooksUrl,
    );
  }

  UserBook _mapToUserBook(GBookDetailData_bookDetail_userBook userBook) {
    return UserBook(
      id: userBook.id,
      readingStatus: _fromGReadingStatus(userBook.readingStatus),
      addedAt: userBook.addedAt,
      completedAt: userBook.completedAt,
      note: userBook.note,
      noteUpdatedAt: userBook.noteUpdatedAt,
    );
  }

  UserBook _mapUpdateReadingStatusToUserBook(
    GUpdateReadingStatusData_updateReadingStatus userBook,
  ) {
    return UserBook(
      id: userBook.id,
      readingStatus: _fromGReadingStatus(userBook.readingStatus),
      addedAt: userBook.addedAt,
      completedAt: userBook.completedAt,
      note: userBook.note,
      noteUpdatedAt: userBook.noteUpdatedAt,
    );
  }

  UserBook _mapUpdateReadingNoteToUserBook(
    GUpdateReadingNoteData_updateReadingNote userBook,
  ) {
    return UserBook(
      id: userBook.id,
      readingStatus: _fromGReadingStatus(userBook.readingStatus),
      addedAt: userBook.addedAt,
      completedAt: userBook.completedAt,
      note: userBook.note,
      noteUpdatedAt: userBook.noteUpdatedAt,
    );
  }

  ReadingStatus _fromGReadingStatus(GReadingStatus status) {
    return switch (status) {
      GReadingStatus.BACKLOG => ReadingStatus.backlog,
      GReadingStatus.READING => ReadingStatus.reading,
      GReadingStatus.COMPLETED => ReadingStatus.completed,
      GReadingStatus.DROPPED => ReadingStatus.dropped,
      _ => ReadingStatus.backlog,
    };
  }

  GReadingStatus _toGReadingStatus(ReadingStatus status) {
    return switch (status) {
      ReadingStatus.backlog => GReadingStatus.BACKLOG,
      ReadingStatus.reading => GReadingStatus.READING,
      ReadingStatus.completed => GReadingStatus.COMPLETED,
      ReadingStatus.dropped => GReadingStatus.DROPPED,
    };
  }
}

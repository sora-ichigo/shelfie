import 'dart:async';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/network/ferry_client.dart';
import 'package:shelfie/features/book_detail/data/__generated__/remove_from_shelf.data.gql.dart';
import 'package:shelfie/features/book_detail/data/__generated__/remove_from_shelf.req.gql.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_search/data/__generated__/add_book_to_shelf.data.gql.dart';
import 'package:shelfie/features/book_search/data/__generated__/add_book_to_shelf.req.gql.dart';
import 'package:shelfie/features/book_search/data/__generated__/search_book_by_isbn.data.gql.dart';
import 'package:shelfie/features/book_search/data/__generated__/search_book_by_isbn.req.gql.dart';
import 'package:shelfie/features/book_search/data/__generated__/search_books.data.gql.dart';
import 'package:shelfie/features/book_search/data/__generated__/search_books.req.gql.dart';

part 'book_search_repository.g.dart';

enum BookSource { rakuten, google }

class Book {
  const Book({
    required this.id,
    required this.title,
    required this.authors,
    this.source = BookSource.rakuten,
    this.publisher,
    this.publishedDate,
    this.isbn,
    this.coverImageUrl,
    this.userBookId,
  });

  final String id;
  final String title;
  final List<String> authors;
  final BookSource source;
  final String? publisher;
  final String? publishedDate;
  final String? isbn;
  final String? coverImageUrl;
  final int? userBookId;

  bool get isInShelf => userBookId != null;

  Book copyWith({
    String? id,
    String? title,
    List<String>? authors,
    BookSource? source,
    String? publisher,
    String? publishedDate,
    String? isbn,
    String? coverImageUrl,
    int? userBookId,
    bool clearUserBookId = false,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      source: source ?? this.source,
      publisher: publisher ?? this.publisher,
      publishedDate: publishedDate ?? this.publishedDate,
      isbn: isbn ?? this.isbn,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      userBookId: clearUserBookId ? null : (userBookId ?? this.userBookId),
    );
  }
}

class SearchBooksResult {
  const SearchBooksResult({
    required this.items,
    required this.totalCount,
    required this.hasMore,
  });

  final List<Book> items;
  final int totalCount;
  final bool hasMore;
}

class UserBook {
  const UserBook({
    required this.id,
    required this.externalId,
    required this.title,
    required this.authors,
    required this.addedAt,
    this.publisher,
    this.publishedDate,
    this.isbn,
    this.coverImageUrl,
  });

  final int id;
  final String externalId;
  final String title;
  final List<String> authors;
  final String? publisher;
  final String? publishedDate;
  final String? isbn;
  final String? coverImageUrl;
  final DateTime addedAt;
}

@riverpod
BookSearchRepository bookSearchRepository(Ref ref) {
  final client = ref.watch(ferryClientProvider);
  return BookSearchRepository(client: client);
}

class BookSearchRepository {
  const BookSearchRepository({required this.client});

  final Client client;

  static const int defaultLimit = 10;
  static const int defaultOffset = 0;

  Future<Either<Failure, SearchBooksResult>> searchBooks({
    required String query,
    int? limit,
    int? offset,
  }) async {
    final request = GSearchBooksReq(
      (b) => b
        ..vars.query = query
        ..vars.limit = limit ?? defaultLimit
        ..vars.offset = offset ?? defaultOffset,
    );

    try {
      final response = await client.request(request).first;
      return _handleSearchBooksResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Book?>> searchBookByISBN({
    required String isbn,
  }) async {
    final request = GSearchBookByISBNReq(
      (b) => b..vars.isbn = isbn,
    );

    try {
      final response = await client.request(request).first;
      return _handleSearchBookByISBNResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, UserBook>> addBookToShelf({
    required String externalId,
    required String title,
    required List<String> authors,
    String? publisher,
    String? publishedDate,
    String? isbn,
    String? coverImageUrl,
    BookSource source = BookSource.rakuten,
    ReadingStatus readingStatus = ReadingStatus.backlog,
  }) async {
    final request = GAddBookToShelfReq(
      (b) => b
        ..vars.bookInput = GAddBookInput(
          (i) => i
            ..externalId = externalId
            ..title = title
            ..authors = ListBuilder(authors)
            ..publisher = publisher
            ..publishedDate = publishedDate
            ..isbn = isbn
            ..coverImageUrl = coverImageUrl
            ..source = source == BookSource.google
                ? GBookSource.GOOGLE
                : GBookSource.RAKUTEN
            ..readingStatus = _toGReadingStatus(readingStatus),
        ).toBuilder(),
    );

    try {
      final response = await client.request(request).first;
      return _handleAddBookToShelfResponse(response);
    } on SocketException {
      return left(const NetworkFailure(message: 'No internet connection'));
    } on TimeoutException {
      return left(const NetworkFailure(message: 'Request timeout'));
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> removeFromShelf({
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

  Either<Failure, bool> _handleRemoveFromShelfResponse(
    OperationResponse<GRemoveFromShelfData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      final errorMessage = error?.message ?? 'Remove from shelf failed';
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

    return right(data.removeFromShelf);
  }

  Either<Failure, SearchBooksResult> _handleSearchBooksResponse(
    OperationResponse<GSearchBooksData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final errorMessage =
          response.graphqlErrors?.firstOrNull?.message ?? 'Search failed';
      return left(
        ServerFailure(
          message: errorMessage,
          code: 'GRAPHQL_ERROR',
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

    final searchBooks = data.searchBooks;
    final items = searchBooks.items.map((item) {
      return Book(
        id: item.id,
        title: item.title,
        authors: item.authors.toList(),
        source: item.source == GBookSource.GOOGLE
            ? BookSource.google
            : BookSource.rakuten,
        publisher: item.publisher,
        publishedDate: item.publishedDate,
        isbn: item.isbn,
        coverImageUrl: item.coverImageUrl,
      );
    }).toList();

    return right(
      SearchBooksResult(
        items: items,
        totalCount: searchBooks.totalCount,
        hasMore: searchBooks.hasMore,
      ),
    );
  }

  Either<Failure, Book?> _handleSearchBookByISBNResponse(
    OperationResponse<GSearchBookByISBNData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final errorMessage =
          response.graphqlErrors?.firstOrNull?.message ?? 'ISBN search failed';
      return left(
        ServerFailure(
          message: errorMessage,
          code: 'GRAPHQL_ERROR',
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

    final book = data.searchBookByISBN;
    if (book == null) {
      return right(null);
    }

    return right(
      Book(
        id: book.id,
        title: book.title,
        authors: book.authors.toList(),
        source: BookSource.rakuten,
        publisher: book.publisher,
        publishedDate: book.publishedDate,
        isbn: book.isbn,
        coverImageUrl: book.coverImageUrl,
      ),
    );
  }

  Either<Failure, UserBook> _handleAddBookToShelfResponse(
    OperationResponse<GAddBookToShelfData, dynamic> response,
  ) {
    if (response.hasErrors) {
      final error = response.graphqlErrors?.firstOrNull;
      final errorMessage = error?.message ?? 'Add to shelf failed';
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

    final userBook = data.addBookToShelf;
    return right(
      UserBook(
        id: userBook.id,
        externalId: userBook.externalId,
        title: userBook.title,
        authors: userBook.authors.toList(),
        publisher: userBook.publisher,
        publishedDate: userBook.publishedDate,
        isbn: userBook.isbn,
        coverImageUrl: userBook.coverImageUrl,
        addedAt: userBook.addedAt,
      ),
    );
  }

  GReadingStatus _toGReadingStatus(ReadingStatus status) {
    return switch (status) {
      ReadingStatus.backlog => GReadingStatus.BACKLOG,
      ReadingStatus.reading => GReadingStatus.READING,
      ReadingStatus.completed => GReadingStatus.COMPLETED,
      ReadingStatus.interested => GReadingStatus.INTERESTED,
    };
  }
}

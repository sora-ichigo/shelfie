import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_list.freezed.dart';

@freezed
class BookList with _$BookList {
  const factory BookList({
    required int id,
    required String title,
    String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BookList;
}

@freezed
class BookListSummary with _$BookListSummary {
  const factory BookListSummary({
    required int id,
    required String title,
    String? description,
    required int bookCount,
    required List<String> coverImages,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BookListSummary;
}

@freezed
class BookListDetail with _$BookListDetail {
  const factory BookListDetail({
    required int id,
    required String title,
    String? description,
    required List<BookListItem> items,
    required BookListDetailStats stats,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BookListDetail;
}

@freezed
class BookListItem with _$BookListItem {
  const factory BookListItem({
    required int id,
    required int position,
    required DateTime addedAt,
    BookListItemUserBook? userBook,
  }) = _BookListItem;
}

@freezed
class BookListItemUserBook with _$BookListItemUserBook {
  const factory BookListItemUserBook({
    required int id,
    required String externalId,
    required String title,
    required List<String> authors,
    String? coverImageUrl,
    required String readingStatus,
    required String source,
  }) = _BookListItemUserBook;
}

@freezed
class BookListDetailStats with _$BookListDetailStats {
  const factory BookListDetailStats({
    required int bookCount,
    required int completedCount,
    required List<String> coverImages,
  }) = _BookListDetailStats;
}

@freezed
class MyBookListsResult with _$MyBookListsResult {
  const factory MyBookListsResult({
    required List<BookListSummary> items,
    required int totalCount,
    required bool hasMore,
  }) = _MyBookListsResult;
}

import 'package:flutter/foundation.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

@immutable
class AuthorCount {
  const AuthorCount({required this.name, required this.count});

  final String name;
  final int count;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorCount && name == other.name && count == other.count;

  @override
  int get hashCode => Object.hash(name, count);

  @override
  String toString() => 'AuthorCount(name: $name, count: $count)';
}

/// 本棚の書籍リストから著者を出現回数順で抽出する
///
/// - 空文字の著者は無視する
/// - 出現回数が多い著者から順に並べる
/// - 同数の場合は安定ソート（元の出現順）を維持する
List<AuthorCount> extractAuthorsFromShelf(List<ShelfBookItem> books) {
  final authorCounts = <String, int>{};

  for (final book in books) {
    for (final author in book.authors) {
      final trimmed = author.trim();
      if (trimmed.isNotEmpty) {
        authorCounts[trimmed] = (authorCounts[trimmed] ?? 0) + 1;
      }
    }
  }

  final sorted = authorCounts.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return sorted
      .map((e) => AuthorCount(name: e.key, count: e.value))
      .toList();
}

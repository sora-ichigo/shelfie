import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;
import 'package:shelfie/features/book_search/domain/author_count.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

ShelfBookItem _book({
  required String externalId,
  required List<String> authors,
}) {
  return ShelfBookItem(
    userBookId: 1,
    externalId: externalId,
    title: 'Book $externalId',
    authors: authors,
    source: BookSource.rakuten,
    addedAt: DateTime(2026, 1, 1),
  );
}

void main() {
  group('extractAuthorsFromShelf', () {
    test('空のリストからは空の結果を返す', () {
      final result = extractAuthorsFromShelf([]);
      expect(result, isEmpty);
    });

    test('著者を出現回数順でソートする', () {
      final books = [
        _book(externalId: '1', authors: ['東野圭吾']),
        _book(externalId: '2', authors: ['東野圭吾']),
        _book(externalId: '3', authors: ['東野圭吾']),
        _book(externalId: '4', authors: ['村上春樹']),
        _book(externalId: '5', authors: ['村上春樹']),
        _book(externalId: '6', authors: ['伊坂幸太郎']),
      ];

      final result = extractAuthorsFromShelf(books);

      expect(result.length, 3);
      expect(result[0], const AuthorCount(name: '東野圭吾', count: 3));
      expect(result[1], const AuthorCount(name: '村上春樹', count: 2));
      expect(result[2], const AuthorCount(name: '伊坂幸太郎', count: 1));
    });

    test('空文字の著者は無視する', () {
      final books = [
        _book(externalId: '1', authors: ['東野圭吾', '']),
        _book(externalId: '2', authors: ['  ']),
      ];

      final result = extractAuthorsFromShelf(books);

      expect(result.length, 1);
      expect(result[0].name, '東野圭吾');
    });

    test('複数著者の本は各著者を個別にカウントする', () {
      final books = [
        _book(externalId: '1', authors: ['著者A', '著者B']),
        _book(externalId: '2', authors: ['著者A', '著者C']),
      ];

      final result = extractAuthorsFromShelf(books);

      expect(result.length, 3);
      expect(result[0], const AuthorCount(name: '著者A', count: 2));
      expect(result[1].count, 1);
      expect(result[2].count, 1);
    });

    test('著者名の前後の空白をトリムする', () {
      final books = [
        _book(externalId: '1', authors: [' 東野圭吾 ']),
        _book(externalId: '2', authors: ['東野圭吾']),
      ];

      final result = extractAuthorsFromShelf(books);

      expect(result.length, 1);
      expect(result[0], const AuthorCount(name: '東野圭吾', count: 2));
    });

    test('著者がいない本は結果に影響しない', () {
      final books = [
        _book(externalId: '1', authors: []),
        _book(externalId: '2', authors: ['東野圭吾']),
      ];

      final result = extractAuthorsFromShelf(books);

      expect(result.length, 1);
      expect(result[0].name, '東野圭吾');
    });
  });

  group('AuthorCount', () {
    test('同じ値なら等しい', () {
      const a = AuthorCount(name: '東野圭吾', count: 3);
      const b = AuthorCount(name: '東野圭吾', count: 3);
      expect(a, equals(b));
    });

    test('異なる値なら等しくない', () {
      const a = AuthorCount(name: '東野圭吾', count: 3);
      const b = AuthorCount(name: '村上春樹', count: 3);
      expect(a, isNot(equals(b)));
    });
  });
}

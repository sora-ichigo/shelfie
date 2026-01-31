import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/library_books_tab.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/library_lists_tab.dart';

void main() {
  final now = DateTime(2024, 1, 15, 10, 30);

  BookListSummary createListSummary({
    int id = 1,
    String title = 'Test List',
    int bookCount = 3,
    List<String> coverImages = const [],
  }) {
    return BookListSummary(
      id: id,
      title: title,
      description: null,
      bookCount: bookCount,
      coverImages: coverImages,
      createdAt: now,
      updatedAt: now,
    );
  }

  ShelfBookItem createBook({
    int userBookId = 1,
    String title = 'Test Book',
    String externalId = 'ext-1',
  }) {
    return ShelfBookItem(
      userBookId: userBookId,
      externalId: externalId,
      title: title,
      authors: ['Author'],
      coverImageUrl: 'https://example.com/cover.jpg',
      addedAt: now,
    );
  }

  group('LibraryBooksTab', () {
    testWidgets('displays empty state when books is empty', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: LibraryBooksTab(
                books: [],

                hasMore: false,
                isLoadingMore: false,
                onBookTap: (_) {},
                onBookLongPress: (_) {},
                onLoadMore: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('本を追加してみましょう'), findsOneWidget);
    });

    testWidgets('displays books in grid', (tester) async {
      final books = [
        createBook(userBookId: 1, title: 'Book 1', externalId: 'ext-1'),
        createBook(userBookId: 2, title: 'Book 2', externalId: 'ext-2'),
      ];

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: LibraryBooksTab(
                books: books,

                hasMore: false,
                isLoadingMore: false,
                onBookTap: (_) {},
                onBookLongPress: (_) {},
                onLoadMore: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('Book 1'), findsOneWidget);
      expect(find.text('Book 2'), findsOneWidget);
    });
  });

  group('LibraryListsTab', () {
    testWidgets('displays vertical list of book lists with horizontal layout',
        (tester) async {
      final lists = [
        createListSummary(id: 1, title: 'My List 1'),
        createListSummary(id: 2, title: 'My List 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LibraryListsTab(
              lists: lists,
              hasBooks: true,
              onListTap: (_) {},
              onCreateTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('My List 1'), findsOneWidget);
      expect(find.text('My List 2'), findsOneWidget);
    });

    testWidgets('displays empty state with create button when lists is empty',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LibraryListsTab(
              lists: [],
              hasBooks: true,
              onListTap: (_) {},
              onCreateTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('最初のリストを作成'), findsOneWidget);
      expect(find.text('リストを作成'), findsOneWidget);
    });

    testWidgets('calls onCreateTap when create button is tapped in empty state',
        (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LibraryListsTab(
              lists: [],
              hasBooks: true,
              onListTap: (_) {},
              onCreateTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('リストを作成'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('displays create button when lists exist', (tester) async {
      final lists = [
        createListSummary(id: 1, title: 'Existing List'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LibraryListsTab(
              lists: lists,
              hasBooks: true,
              onListTap: (_) {},
              onCreateTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('新しいリスト'), findsOneWidget);
    });
  });
}

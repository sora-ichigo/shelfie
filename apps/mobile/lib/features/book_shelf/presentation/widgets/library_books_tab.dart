import 'package:flutter/material.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_grid.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/no_books_message.dart';

class LibraryBooksTab extends StatelessWidget {
  const LibraryBooksTab({
    required this.books,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onBookTap,
    required this.onBookLongPress,
    required this.onLoadMore,
    super.key,
  });

  final List<ShelfBookItem> books;
  final bool hasMore;
  final bool isLoadingMore;
  final ValueChanged<ShelfBookItem> onBookTap;
  final ValueChanged<ShelfBookItem> onBookLongPress;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return const NoBooksMessage();
    }

    return BookGrid(
      books: books,
      hasMore: hasMore,
      isLoadingMore: isLoadingMore,
      onBookTap: onBookTap,
      onBookLongPress: onBookLongPress,
      onLoadMore: onLoadMore,
    );
  }
}

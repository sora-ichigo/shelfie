import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/empty_state.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_grid.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/search_filter_bar.dart';

class LibraryBooksTab extends StatelessWidget {
  const LibraryBooksTab({
    required this.books,
    required this.groupedBooks,
    required this.sortOption,
    required this.groupOption,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onBookTap,
    required this.onBookLongPress,
    required this.onLoadMore,
    required this.onSortChanged,
    required this.onGroupChanged,
    super.key,
  });

  final List<ShelfBookItem> books;
  final Map<String, List<ShelfBookItem>> groupedBooks;
  final SortOption sortOption;
  final GroupOption groupOption;
  final bool hasMore;
  final bool isLoadingMore;
  final ValueChanged<ShelfBookItem> onBookTap;
  final ValueChanged<ShelfBookItem> onBookLongPress;
  final VoidCallback onLoadMore;
  final ValueChanged<SortOption> onSortChanged;
  final ValueChanged<GroupOption> onGroupChanged;

  bool get isGrouped => groupOption != GroupOption.none;

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return const EmptyState(
        icon: Icons.auto_stories_outlined,
        message: '本を追加してみましょう',
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: SearchFilterBar(
            sortOption: sortOption,
            groupOption: groupOption,
            onSortChanged: onSortChanged,
            onGroupChanged: onGroupChanged,
          ),
        ),
        Expanded(
          child: BookGrid(
            books: books,
            groupedBooks: groupedBooks,
            isGrouped: isGrouped,
            hasMore: hasMore,
            isLoadingMore: isLoadingMore,
            onBookTap: onBookTap,
            onBookLongPress: onBookLongPress,
            onLoadMore: onLoadMore,
          ),
        ),
      ],
    );
  }
}

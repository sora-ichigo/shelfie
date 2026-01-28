import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/empty_state.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/book_list_card.dart';
import 'package:shelfie/features/book_list/presentation/widgets/create_list_card.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_card.dart';

class LibraryAllTab extends StatelessWidget {
  const LibraryAllTab({
    required this.lists,
    required this.recentBooks,
    required this.totalBookCount,
    required this.onListTap,
    required this.onBookTap,
    required this.onBookLongPress,
    required this.onSeeAllBooksTap,
    required this.onSeeAllListsTap,
    required this.onCreateListTap,
    super.key,
  });

  final List<BookListSummary> lists;
  final List<ShelfBookItem> recentBooks;
  final int totalBookCount;
  final ValueChanged<BookListSummary> onListTap;
  final ValueChanged<ShelfBookItem> onBookTap;
  final ValueChanged<ShelfBookItem> onBookLongPress;
  final VoidCallback onSeeAllBooksTap;
  final VoidCallback onSeeAllListsTap;
  final VoidCallback onCreateListTap;

  @override
  Widget build(BuildContext context) {
    if (recentBooks.isEmpty) {
      return const EmptyState(
        icon: Icons.auto_stories_outlined,
        message: '本を追加してみましょう',
      );
    }

    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      children: [
        if (recentBooks.isNotEmpty) ...[
          _buildSectionTitleWithAction(
            context,
            '最近',
            appColors,
            onSeeAllBooksTap,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildRecentBooksGrid(),
          const SizedBox(height: AppSpacing.lg),
        ],
        if (lists.isNotEmpty) ...[
          _buildSectionTitleWithAction(
            context,
            'リスト',
            appColors,
            onSeeAllListsTap,
          ),
        ] else ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(
              'リスト',
              style: theme.textTheme.titleLarge?.copyWith(
                color: appColors.foreground,
              ),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        _buildListsSection(context, appColors),
      ],
    );
  }

  Widget _buildSectionTitleWithAction(
    BuildContext context,
    String title,
    AppColors appColors,
    VoidCallback onSeeAllTap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: appColors.foreground,
                ),
          ),
          InkWell(
            onTap: onSeeAllTap,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Text(
                'すべて表示',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: appColors.link,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListsSection(BuildContext context, AppColors appColors) {
    if (lists.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: CreateListCard(onCreateTap: onCreateListTap),
      );
    }

    final displayLists = lists.take(3).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        children: [
          for (int i = 0; i < displayLists.length; i++) ...[
            if (i > 0) const SizedBox(height: AppSpacing.sm),
            BookListCard(
              summary: displayLists[i],
              onTap: () => onListTap(displayLists[i]),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRecentBooksGrid() {
    final displayBooks = recentBooks.take(6).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: AppSpacing.xs,
          crossAxisSpacing: AppSpacing.sm,
          childAspectRatio: 0.45,
        ),
        itemCount: displayBooks.length,
        itemBuilder: (context, index) {
          final book = displayBooks[index];
          return BookCard(
            book: book,
            onTap: () => onBookTap(book),
            onLongPress: () => onBookLongPress(book),
          );
        },
      ),
    );
  }
}

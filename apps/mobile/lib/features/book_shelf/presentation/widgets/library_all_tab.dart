import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/book_list_card.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

class LibraryAllTab extends StatelessWidget {
  const LibraryAllTab({
    required this.lists,
    required this.recentBooks,
    required this.onListTap,
    required this.onBookTap,
    required this.onSeeAllBooksTap,
    required this.onSeeAllListsTap,
    required this.onCreateListTap,
    super.key,
  });

  final List<BookListSummary> lists;
  final List<ShelfBookItem> recentBooks;
  final ValueChanged<BookListSummary> onListTap;
  final ValueChanged<ShelfBookItem> onBookTap;
  final VoidCallback onSeeAllBooksTap;
  final VoidCallback onSeeAllListsTap;
  final VoidCallback onCreateListTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      children: [
        _buildSectionTitleWithAction(
          context,
          'リスト',
          appColors,
          onSeeAllListsTap,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildListsSection(context, appColors),
        const SizedBox(height: AppSpacing.lg),
        if (recentBooks.isNotEmpty) ...[
          _buildSectionTitleWithAction(
            context,
            '最近追加した本',
            appColors,
            onSeeAllBooksTap,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildRecentBooksHorizontalScroll(context, appColors),
        ],
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
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: appColors.foreground,
                  fontWeight: FontWeight.w700,
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
                'すべて見る',
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        children: [
          ...lists.take(3).map(
                (list) => BookListCard(
                  summary: list,
                  onTap: () => onListTap(list),
                ),
              ),
          const SizedBox(height: AppSpacing.sm),
          _CreateListButton(
            appColors: appColors,
            onTap: onCreateListTap,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentBooksHorizontalScroll(
    BuildContext context,
    AppColors appColors,
  ) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: recentBooks.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final book = recentBooks[index];
          return _RecentBookCard(
            book: book,
            appColors: appColors,
            onTap: () => onBookTap(book),
          );
        },
      ),
    );
  }
}

class _RecentBookCard extends StatelessWidget {
  const _RecentBookCard({
    required this.book,
    required this.appColors,
    required this.onTap,
  });

  final ShelfBookItem book;
  final AppColors appColors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: SizedBox(
        width: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: _buildCoverImage(),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImage() {
    if (book.hasCoverImage) {
      return CachedNetworkImage(
        imageUrl: book.coverImageUrl!,
        fit: BoxFit.cover,
        placeholder: (_, __) => _buildPlaceholder(),
        errorWidget: (_, __, ___) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return ColoredBox(
      color: appColors.surface,
      child: Center(
        child: Icon(
          Icons.book,
          size: 32,
          color: appColors.foregroundMuted,
        ),
      ),
    );
  }
}

class _CreateListButton extends StatelessWidget {
  const _CreateListButton({
    required this.appColors,
    required this.onTap,
  });

  final AppColors appColors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: appColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: appColors.foregroundMuted,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '新しいリストを作成',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: appColors.foregroundMuted,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

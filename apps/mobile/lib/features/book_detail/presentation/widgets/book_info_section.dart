import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';

/// 書籍基本情報セクション
///
/// 表紙画像、タイトル、著者、書誌情報、説明文を表示する。
class BookInfoSection extends StatelessWidget {
  const BookInfoSection({
    required this.bookDetail,
    super.key,
  });

  final BookDetail bookDetail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCoverImage(context),
        const SizedBox(height: AppSpacing.md),
        _buildTitleAndAuthor(theme),
        const SizedBox(height: AppSpacing.md),
        _buildBibliographicInfo(theme),
        if (bookDetail.description != null) ...[
          const SizedBox(height: AppSpacing.lg),
          _buildDescription(theme),
        ],
      ],
    );
  }

  Widget _buildCoverImage(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        child: bookDetail.thumbnailUrl != null
            ? Image.network(
                bookDetail.thumbnailUrl!,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const _CoverPlaceholder();
                },
                errorBuilder: (_, __, ___) => const _CoverPlaceholder(),
              )
            : const _CoverPlaceholder(),
      ),
    );
  }

  Widget _buildTitleAndAuthor(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bookDetail.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          bookDetail.authors.join(', '),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildBibliographicInfo(ThemeData theme) {
    final items = <Widget>[];

    if (bookDetail.publisher != null) {
      items.add(_buildInfoItem(theme, '出版社', bookDetail.publisher!));
    }
    if (bookDetail.publishedDate != null) {
      items.add(_buildInfoItem(theme, '発売日', bookDetail.publishedDate!));
    }
    if (bookDetail.pageCount != null) {
      items.add(_buildInfoItem(theme, 'ページ数', '${bookDetail.pageCount}ページ'));
    }
    if (bookDetail.categories != null && bookDetail.categories!.isNotEmpty) {
      items.add(_buildCategoriesChips(theme));
    }

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '書誌情報',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...items,
      ],
    );
  }

  Widget _buildInfoItem(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesChips(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              'ジャンル',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: bookDetail.categories!
                  .map(
                    (category) => Chip(
                      label: Text(
                        category,
                        style: theme.textTheme.labelSmall,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                      labelPadding: AppSpacing.horizontal(AppSpacing.xs),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '作品紹介',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          bookDetail.description!,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 130,
      height: 200,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.book,
        size: 64,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

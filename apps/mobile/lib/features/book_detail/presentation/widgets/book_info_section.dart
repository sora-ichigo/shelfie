import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/utils/date_formatter.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';

class BookInfoSection extends StatelessWidget {
  const BookInfoSection({
    required this.bookDetail,
    required this.isInShelf,
    this.onAddToShelfPressed,
    this.onRemoveFromShelfPressed,
    this.onLinkTap,
    super.key,
  });

  final BookDetail bookDetail;
  final bool isInShelf;
  final VoidCallback? onAddToShelfPressed;
  final VoidCallback? onRemoveFromShelfPressed;
  final void Function(String url)? onLinkTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(theme),
        const SizedBox(height: AppSpacing.lg),
        _buildBibliographicCard(theme),
        if (bookDetail.description != null) ...[
          const SizedBox(height: AppSpacing.lg),
          _buildDescription(theme),
        ],
        if (_hasExternalLinks()) ...[
          const SizedBox(height: AppSpacing.lg),
          _buildExternalLinksCard(theme),
        ],
      ],
    );
  }

  Widget _buildHeader(ThemeData theme) {
    const coverHeight = 200.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildCoverImage(),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: SizedBox(
            height: coverHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  bookDetail.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  bookDetail.authors.join(', '),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                if (isInShelf)
                  _buildRemoveFromShelfButton(theme)
                else
                  _buildAddToShelfButton(theme),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddToShelfButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.actionGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton.icon(
          onPressed: onAddToShelfPressed,
          icon: const Icon(Icons.add, color: Colors.white, size: 20),
          label: Text(
            '本棚に追加',
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRemoveFromShelfButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton.icon(
        onPressed: onRemoveFromShelfPressed,
        icon: const Icon(Icons.remove, color: Colors.white, size: 20),
        label: Text(
          '本棚から削除',
          style: theme.textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildCoverImage() {
    const coverWidth = 140.0;
    const coverHeight = 200.0;

    return Container(
      width: coverWidth,
      height: coverHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: bookDetail.thumbnailUrl != null
            ? Image.network(
                bookDetail.thumbnailUrl!,
                width: coverWidth,
                height: coverHeight,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const _CoverPlaceholder(
                    width: coverWidth,
                    height: coverHeight,
                  );
                },
                errorBuilder: (_, __, ___) => const _CoverPlaceholder(
                  width: coverWidth,
                  height: coverHeight,
                ),
              )
            : const _CoverPlaceholder(
                width: coverWidth,
                height: coverHeight,
              ),
      ),
    );
  }

  Widget _buildBibliographicCard(ThemeData theme) {
    final items = <Widget>[];

    if (bookDetail.publisher != null) {
      items.add(_buildInfoItem(theme, '出版社', bookDetail.publisher!));
    }
    if (bookDetail.publishedDate != null) {
      items.add(_buildInfoItem(
          theme, '発売日', formatDateString(bookDetail.publishedDate!)));
    }
    if (bookDetail.pageCount != null) {
      items.add(_buildInfoItem(theme, 'ページ数', '${bookDetail.pageCount}ページ'));
    }
    if (bookDetail.isbn != null) {
      items.add(_buildInfoItem(theme, 'ISBN', bookDetail.isbn!));
    }
    if (bookDetail.categories != null && bookDetail.categories!.isNotEmpty) {
      items.add(_buildCategoriesChips(theme));
    }

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: AppSpacing.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
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
      ),
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
                    (category) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        category,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
    return Container(
      width: double.infinity,
      padding: AppSpacing.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
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
            _stripHtmlTags(bookDetail.description!),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _stripHtmlTags(String htmlString) {
    final regex = RegExp('<[^>]*>', multiLine: true, caseSensitive: false);
    return htmlString.replaceAll(regex, '').replaceAll('&nbsp;', ' ').trim();
  }

  bool _hasExternalLinks() {
    return bookDetail.amazonUrl != null || bookDetail.infoLink != null;
  }

  Widget _buildExternalLinksCard(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '購入・詳細',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (bookDetail.amazonUrl != null)
            _buildLinkButton(
              theme,
              icon: Icons.menu_book,
              label: 'Amazonで見る',
              description: '商品ページを開く',
              url: bookDetail.amazonUrl!,
              gradientColors: const [Color(0xFFFF9500), Color(0xFFFF6B00)],
            ),
          if (bookDetail.infoLink != null) ...[
            if (bookDetail.amazonUrl != null)
              const SizedBox(height: AppSpacing.sm),
            _buildLinkButton(
              theme,
              icon: Icons.public,
              label: '公式サイト',
              description: '出版社ページを開く',
              url: bookDetail.infoLink!,
              gradientColors: const [Color(0xFF00D4AA), Color(0xFF00B4D8)],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLinkButton(
    ThemeData theme, {
    required IconData icon,
    required String label,
    required String description,
    required String url,
    required List<Color> gradientColors,
  }) {
    return InkWell(
      onTap: onLinkTap != null ? () => onLinkTap!(url) : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: AppSpacing.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHigh.withOpacity(1.0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.open_in_new,
              size: 20,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder({
    this.width = 140,
    this.height = 200,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.book,
        size: height * 0.25,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

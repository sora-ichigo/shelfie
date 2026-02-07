import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/utils/category_translator.dart';
import 'package:shelfie/core/utils/date_formatter.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';

class BookInfoSection extends StatelessWidget {
  const BookInfoSection({
    required this.bookDetail,
    required this.isInShelf,
    this.isAddingToShelf = false,
    this.isRemovingFromShelf = false,
    this.onAddToShelfPressed,
    this.onRemoveFromShelfPressed,
    this.onLinkTap,
    this.headerBottomSlot,
    super.key,
  });

  final BookDetail bookDetail;
  final bool isInShelf;
  final bool isAddingToShelf;
  final bool isRemovingFromShelf;
  final VoidCallback? onAddToShelfPressed;
  final VoidCallback? onRemoveFromShelfPressed;
  final void Function(String url)? onLinkTap;
  final Widget? headerBottomSlot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(theme),
        const SizedBox(height: AppSpacing.md),
        _buildShelfButton(theme),
        const SizedBox(height: AppSpacing.lg),
        if (headerBottomSlot != null) ...[
          headerBottomSlot!,
          const SizedBox(height: AppSpacing.lg),
        ],
        if (_hasDescription()) ...[
          _buildDescription(theme),
          const SizedBox(height: AppSpacing.lg),
        ],
        _buildBibliographicCard(theme),
        if (_hasExternalLinks()) ...[
          const SizedBox(height: AppSpacing.lg),
          _buildExternalLinksCard(theme),
        ],
      ],
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildCoverImage(),
        const SizedBox(height: AppSpacing.md),
        Text(
          bookDetail.title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          bookDetail.authors.join(', '),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.extension<AppColors>()!.textSecondary,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildShelfButton(ThemeData theme) {
    if (isAddingToShelf || isRemovingFromShelf) {
      return _buildLoadingButton(theme);
    } else if (isInShelf) {
      return _buildRemoveFromShelfButton(theme);
    } else {
      return _buildAddToShelfButton(theme);
    }
  }

  Widget _buildAddToShelfButton(ThemeData theme) {
    final appColors = theme.extension<AppColors>()!;

    return SizedBox(
      width: double.infinity,
      height: 44,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: appColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton.icon(
          onPressed: onAddToShelfPressed,
          icon: const Icon(Icons.add, color: Colors.white, size: 20),
          label: Text(
            'マイライブラリに追加',
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

  Widget _buildLoadingButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildRemoveFromShelfButton(ThemeData theme) {
    final appColors = theme.extension<AppColors>()!;

    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton.icon(
        onPressed: onRemoveFromShelfPressed,
        icon: Icon(Icons.remove, color: appColors.destructive, size: 20),
        label: Text(
          'マイライブラリから削除',
          style: theme.textTheme.labelLarge?.copyWith(
            color: appColors.destructive,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: appColors.surface,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildCoverImage() {
    const coverWidth = 168.0;
    const coverHeight = 240.0;

    return Container(
      width: coverWidth,
      height: coverHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          // 大きな影（浮遊感）
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 2,
            offset: const Offset(12, 16),
          ),
          // 中間の影
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(6, 8),
          ),
          // 近い影（エッジ）
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(2, 3),
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
                frameBuilder:
                    (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded || frame != null) {
                    return child;
                  }
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
      final translatedCategories = translateCategories(bookDetail.categories!);
      if (translatedCategories.isNotEmpty) {
        items.add(_buildCategoriesChips(theme, translatedCategories));
      }
    }

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '書誌情報',
          style: theme.textTheme.titleMedium,
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
                color: theme.extension<AppColors>()!.textSecondary,
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

  Widget _buildCategoriesChips(ThemeData theme, List<String> translatedCategories) {
    final appColors = theme.extension<AppColors>()!;
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
              children: translatedCategories
                  .map(
                    (category) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: appColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: appColors.primary.withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        category,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: appColors.primary,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '作品紹介',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          _stripHtmlTags(bookDetail.description!),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.extension<AppColors>()!.textSecondary,
          ),
        ),
      ],
    );
  }

  String _stripHtmlTags(String htmlString) {
    var result = htmlString;

    // <br>, <br/>, <br /> を改行に変換
    result = result.replaceAll(RegExp(r'<br\s*/?\s*>', caseSensitive: false), '\n');

    // </p> を段落区切り（2改行）に変換
    result = result.replaceAll(RegExp(r'</p\s*>', caseSensitive: false), '\n\n');

    // 残りのHTMLタグを除去
    result = result.replaceAll(RegExp('<[^>]*>', multiLine: true, caseSensitive: false), '');

    // HTMLエンティティを変換
    result = result
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'");

    // 3つ以上の連続改行を2つに正規化
    result = result.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    return result.trim();
  }

  bool _hasDescription() {
    return bookDetail.description != null &&
        _stripHtmlTags(bookDetail.description!).isNotEmpty;
  }

  bool _hasExternalLinks() {
    return bookDetail.amazonUrl != null || bookDetail.rakutenBooksUrl != null;
  }

  Widget _buildExternalLinksCard(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '購入・詳細',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (bookDetail.amazonUrl != null)
              _buildLinkButton(
                theme,
                label: 'Amazon',
                url: bookDetail.amazonUrl!,
              ),
            if (bookDetail.amazonUrl != null &&
                bookDetail.rakutenBooksUrl != null)
              const SizedBox(width: 12),
            if (bookDetail.rakutenBooksUrl != null)
              _buildLinkButton(
                theme,
                label: '楽天ブックス',
                url: bookDetail.rakutenBooksUrl!,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildLinkButton(
    ThemeData theme, {
    required String label,
    required String url,
  }) {
    final appColors = theme.extension<AppColors>()!;

    return Material(
      color: appColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: appColors.border,
        ),
      ),
      child: InkWell(
        onTap: onLinkTap != null ? () => onLinkTap!(url) : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: AppSpacing.all(AppSpacing.md),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: appColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Icon(
                Icons.open_in_new,
                size: 16,
                color: appColors.textSecondary,
              ),
            ],
          ),
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

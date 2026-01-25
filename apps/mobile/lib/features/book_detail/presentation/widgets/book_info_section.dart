import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(theme),
        const SizedBox(height: AppSpacing.lg),
        if (headerBottomSlot != null) ...[
          headerBottomSlot!,
          const SizedBox(height: AppSpacing.lg),
        ],
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
                Flexible(
                  child: Text(
                    bookDetail.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  bookDetail.authors.join(', '),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.md),
                if (isAddingToShelf || isRemovingFromShelf)
                  _buildLoadingButton(theme)
                else if (isInShelf)
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
    final appColors = theme.extension<AppColors>()!;

    return SizedBox(
      width: double.infinity,
      height: 44,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: appColors.actionGradient,
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

  Widget _buildCategoriesChips(ThemeData theme, List<String> translatedCategories) {
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
                        color: AppColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        category,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.primary,
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

  bool _hasExternalLinks() {
    return bookDetail.amazonUrl != null || bookDetail.rakutenBooksUrl != null;
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
              label: 'Amazonで見る',
              description: '商品ページを開く',
              url: bookDetail.amazonUrl!,
              gradientColors: const [Color(0xFFFF9500), Color(0xFFFF6B00)],
            ),
          if (bookDetail.rakutenBooksUrl != null) ...[
            if (bookDetail.amazonUrl != null)
              const SizedBox(height: AppSpacing.sm),
            _buildRakutenBooksLinkButton(
              theme,
              label: '楽天ブックスで見る',
              description: '商品ページを開く',
              url: bookDetail.rakutenBooksUrl!,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLinkButton(
    ThemeData theme, {
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
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.amazon,
                  size: 20,
                  color: Colors.white,
                ),
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

  Widget _buildRakutenBooksLinkButton(
    ThemeData theme, {
    required String label,
    required String description,
    required String url,
  }) {
    return InkWell(
      onTap: onLinkTap != null ? () => onLinkTap!(url) : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: AppSpacing.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFBF0000),
                    Color(0xFF8C0000),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'R',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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

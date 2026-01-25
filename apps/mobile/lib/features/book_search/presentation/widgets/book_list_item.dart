import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/utils/date_formatter.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({
    required this.book,
    required this.onAddPressed,
    super.key,
    this.onTap,
    this.onRemovePressed,
    this.isAddingToShelf = false,
    this.isRemovingFromShelf = false,
  });

  final Book book;
  final VoidCallback onAddPressed;
  final VoidCallback? onTap;
  final VoidCallback? onRemovePressed;
  final bool isAddingToShelf;
  final bool isRemovingFromShelf;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final listTile = ListTile(
      onTap: onTap,
      contentPadding: AppSpacing.horizontal(AppSpacing.md),
      leading: _buildCoverImage(theme),
      title: Text(
        book.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.titleSmall,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatAuthors(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (_hasPublisherInfo())
            Text(
              _formatPublisherInfo(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
      trailing: _buildTrailingWidget(theme),
      isThreeLine: _hasPublisherInfo(),
    );

    return listTile;
  }

  Widget _buildCoverImage(ThemeData theme) {
    const imageWidth = 48.0;
    const imageHeight = 72.0;

    if (book.coverImageUrl != null && book.coverImageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Image.network(
          book.coverImageUrl!,
          width: imageWidth,
          height: imageHeight,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _buildPlaceholder(theme, imageWidth, imageHeight),
        ),
      );
    }
    return _buildPlaceholder(theme, imageWidth, imageHeight);
  }

  Widget _buildPlaceholder(ThemeData theme, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Icon(
        Icons.book,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildTrailingWidget(ThemeData theme) {
    if (isAddingToShelf || isRemovingFromShelf) {
      return const SizedBox(
        width: 48,
        height: 48,
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (book.isInShelf) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: onRemovePressed,
            icon: Icon(
              Icons.close,
              size: 20,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            tooltip: '本棚から削除',
            visualDensity: VisualDensity.compact,
          ),
        ],
      );
    }

    return IconButton(
      onPressed: onAddPressed,
      icon: const Icon(Icons.add_circle_outline),
      tooltip: '本棚に追加',
    );
  }

  String _formatAuthors() {
    if (book.authors.isEmpty) {
      return '著者不明';
    }
    return book.authors.join(', ');
  }

  bool _hasPublisherInfo() {
    return book.publisher != null || book.publishedDate != null;
  }

  String _formatPublisherInfo() {
    final parts = <String>[];
    if (book.publisher != null) {
      parts.add(book.publisher!);
    }
    if (book.publishedDate != null) {
      parts.add(formatDateString(book.publishedDate!));
    }
    return parts.join(' / ');
  }
}

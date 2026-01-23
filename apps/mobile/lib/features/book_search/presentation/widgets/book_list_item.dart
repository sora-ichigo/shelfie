import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({
    required this.book,
    required this.onAddPressed,
    super.key,
    this.onTap,
    this.isAddingToShelf = false,
  });

  final Book book;
  final VoidCallback onAddPressed;
  final VoidCallback? onTap;
  final bool isAddingToShelf;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
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
      trailing: _buildAddButton(theme),
      isThreeLine: _hasPublisherInfo(),
    );
  }

  Widget _buildCoverImage(ThemeData theme) {
    const imageWidth = 48.0;
    const imageHeight = 72.0;

    if (book.coverImageUrl != null && book.coverImageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
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
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        Icons.book,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildAddButton(ThemeData theme) {
    if (isAddingToShelf) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return IconButton(
      onPressed: onAddPressed,
      icon: const Icon(Icons.add),
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
      parts.add(book.publishedDate!);
    }
    return parts.join(' / ');
  }
}

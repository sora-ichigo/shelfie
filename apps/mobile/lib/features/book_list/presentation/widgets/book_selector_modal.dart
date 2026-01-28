import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_notifier.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_state.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

Future<void> showBookSelectorModal({
  required BuildContext context,
  required List<int> existingUserBookIds,
  required void Function(ShelfBookItem book) onBookSelected,
  void Function(ShelfBookItem book)? onBookRemoved,
  List<int> initialSelectedUserBookIds = const [],
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (context) => _BookSelectorModalContent(
      existingUserBookIds: existingUserBookIds,
      onBookSelected: onBookSelected,
      onBookRemoved: onBookRemoved,
      initialSelectedUserBookIds: initialSelectedUserBookIds,
    ),
  );
}

class _BookSelectorModalContent extends ConsumerStatefulWidget {
  const _BookSelectorModalContent({
    required this.existingUserBookIds,
    required this.onBookSelected,
    this.onBookRemoved,
    this.initialSelectedUserBookIds = const [],
  });

  final List<int> existingUserBookIds;
  final void Function(ShelfBookItem book) onBookSelected;
  final void Function(ShelfBookItem book)? onBookRemoved;
  final List<int> initialSelectedUserBookIds;

  @override
  ConsumerState<_BookSelectorModalContent> createState() =>
      _BookSelectorModalContentState();
}

class _BookSelectorModalContentState
    extends ConsumerState<_BookSelectorModalContent> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  late final Set<int> _selectedUserBookIds;

  @override
  void initState() {
    super.initState();
    _selectedUserBookIds = {...widget.initialSelectedUserBookIds};
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shelfState = ref.watch(bookShelfNotifierProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return BaseBottomSheet(
          title: '本を追加',
          child: Expanded(
            child: Column(
              children: [
                _buildSearchField(context),
                const SizedBox(height: AppSpacing.md),
                Expanded(
                  child: _buildBookList(context, shelfState, scrollController),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: _searchController,
      onChanged: (value) => setState(() => _searchQuery = value),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: '本を検索...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  setState(() => _searchQuery = '');
                },
              )
            : null,
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          borderSide: BorderSide.none,
        ),
        contentPadding: AppSpacing.vertical(AppSpacing.sm),
      ),
    );
  }

  Widget _buildBookList(
    BuildContext context,
    BookShelfState shelfState,
    ScrollController scrollController,
  ) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return shelfState.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (books, _, __, ___, ____, _____, ______) {
        final filteredBooks = _filterBooks(books);

        if (filteredBooks.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search_off,
                  size: 48,
                  color: appColors.foregroundMuted,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  '本が見つかりません',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: appColors.foregroundMuted,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          controller: scrollController,
          itemCount: filteredBooks.length,
          itemBuilder: (context, index) {
            final book = filteredBooks[index];
            final isSelected = _isSelected(book);
            return _BookListItem(
              book: book,
              isSelected: isSelected,
              onTap: isSelected
                  ? () => _onBookRemove(book)
                  : () => _onBookTap(book),
              onRemove: isSelected ? () => _onBookRemove(book) : null,
            );
          },
        );
      },
      error: (_) => Center(
        child: Text(
          'エラーが発生しました',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: appColors.error,
          ),
        ),
      ),
    );
  }

  List<ShelfBookItem> _filterBooks(List<ShelfBookItem> books) {
    var filtered = books
        .where((b) => !widget.existingUserBookIds.contains(b.userBookId))
        .toList();

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((b) {
        return b.title.toLowerCase().contains(query) ||
            b.authors.any((a) => a.toLowerCase().contains(query));
      }).toList();
    }

    return filtered;
  }

  void _onBookTap(ShelfBookItem book) {
    setState(() {
      _selectedUserBookIds.add(book.userBookId);
    });
    widget.onBookSelected(book);
  }

  void _onBookRemove(ShelfBookItem book) {
    setState(() {
      _selectedUserBookIds.remove(book.userBookId);
    });
    widget.onBookRemoved?.call(book);
  }

  bool _isSelected(ShelfBookItem book) {
    return _selectedUserBookIds.contains(book.userBookId);
  }
}

class _BookListItem extends StatelessWidget {
  const _BookListItem({
    required this.book,
    this.isSelected = false,
    this.onTap,
    this.onRemove,
  });

  final ShelfBookItem book;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  static const _imageWidth = 48.0;
  static const _imageHeight = 72.0;

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
      subtitle: Text(
        book.authorsDisplay.isNotEmpty ? book.authorsDisplay : '著者不明',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: _buildTrailingWidget(theme),
    );
  }

  Widget _buildTrailingWidget(ThemeData theme) {
    if (isSelected) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: onRemove,
            icon: Icon(
              Icons.close,
              size: 20,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            visualDensity: VisualDensity.compact,
          ),
        ],
      );
    }

    return const Icon(Icons.add_circle_outline);
  }

  Widget _buildCoverImage(ThemeData theme) {
    if (book.hasCoverImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: CachedNetworkImage(
          imageUrl: book.coverImageUrl!,
          width: _imageWidth,
          height: _imageHeight,
          fit: BoxFit.cover,
          placeholder: (_, __) => _buildPlaceholder(theme),
          errorWidget: (_, __, ___) => _buildPlaceholder(theme),
        ),
      );
    }
    return _buildPlaceholder(theme);
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Container(
      width: _imageWidth,
      height: _imageHeight,
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
}

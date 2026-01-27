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
  required int listId,
  required List<int> existingUserBookIds,
  required void Function(int userBookId) onBookSelected,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (context) => _BookSelectorModalContent(
      listId: listId,
      existingUserBookIds: existingUserBookIds,
      onBookSelected: onBookSelected,
    ),
  );
}

class _BookSelectorModalContent extends ConsumerStatefulWidget {
  const _BookSelectorModalContent({
    required this.listId,
    required this.existingUserBookIds,
    required this.onBookSelected,
  });

  final int listId;
  final List<int> existingUserBookIds;
  final void Function(int userBookId) onBookSelected;

  @override
  ConsumerState<_BookSelectorModalContent> createState() =>
      _BookSelectorModalContentState();
}

class _BookSelectorModalContentState
    extends ConsumerState<_BookSelectorModalContent> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

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
    final appColors = theme.extension<AppColors>()!;

    return TextField(
      controller: _searchController,
      onChanged: (value) => setState(() => _searchQuery = value),
      decoration: InputDecoration(
        hintText: '本を検索...',
        prefixIcon: Icon(
          Icons.search,
          color: appColors.foregroundMuted,
        ),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  setState(() => _searchQuery = '');
                },
              )
            : null,
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
            return _BookListItem(
              book: book,
              onTap: () => _onBookTap(book),
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
    widget.onBookSelected(book.userBookId);
    Navigator.of(context).pop();
  }
}

class _BookListItem extends StatelessWidget {
  const _BookListItem({
    required this.book,
    required this.onTap,
  });

  final ShelfBookItem book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return ListTile(
      onTap: onTap,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: SizedBox(
          width: 40,
          height: 60,
          child: book.hasCoverImage
              ? CachedNetworkImage(
                  imageUrl: book.coverImageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => ColoredBox(color: appColors.surface),
                  errorWidget: (_, __, ___) =>
                      _CoverPlaceholder(appColors: appColors),
                )
              : _CoverPlaceholder(appColors: appColors),
        ),
      ),
      title: Text(
        book.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        book.authorsDisplay,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodySmall?.copyWith(
          color: appColors.foregroundMuted,
        ),
      ),
      trailing: Icon(
        Icons.add_circle_outline,
        color: appColors.accent,
      ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder({required this.appColors});

  final AppColors appColors;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: appColors.surface,
      child: Center(
        child: Icon(
          Icons.book,
          size: 20,
          color: appColors.foregroundMuted,
        ),
      ),
    );
  }
}

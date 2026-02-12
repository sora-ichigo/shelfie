import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';
import 'package:shelfie/features/book_shelf/application/shelf_search_notifier.dart';
import 'package:shelfie/features/book_shelf/application/shelf_search_state.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

Future<void> showShelfSearchBottomSheet({
  required BuildContext context,
  required void Function(ShelfBookItem book) onBookTap,
  void Function(ShelfBookItem book)? onBookLongPress,
}) async {
  final appColors = Theme.of(context).extension<AppColors>()!;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: appColors.surface,
    builder: (context) => _ShelfSearchBottomSheetContent(
      onBookTap: onBookTap,
      onBookLongPress: onBookLongPress,
    ),
  );
}

class _ShelfSearchBottomSheetContent extends ConsumerStatefulWidget {
  const _ShelfSearchBottomSheetContent({
    required this.onBookTap,
    this.onBookLongPress,
  });

  final void Function(ShelfBookItem book) onBookTap;
  final void Function(ShelfBookItem book)? onBookLongPress;

  @override
  ConsumerState<_ShelfSearchBottomSheetContent> createState() =>
      _ShelfSearchBottomSheetContentState();
}

class _ShelfSearchBottomSheetContentState
    extends ConsumerState<_ShelfSearchBottomSheetContent> {
  final _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(shelfSearchNotifierProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return BaseBottomSheet(
          title: '本棚を検索',
          child: Expanded(
            child: Column(
              children: [
                _buildSearchField(context),
                const SizedBox(height: AppSpacing.md),
                Expanded(
                  child: _buildContent(
                    context,
                    searchState,
                    scrollController,
                  ),
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
      onChanged: _onSearchChanged,
      autofocus: true,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'タイトルや著者名で検索...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  _onSearchChanged('');
                },
              )
            : null,
        filled: true,
        fillColor: theme.extension<AppColors>()!.surfaceElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          borderSide: BorderSide.none,
        ),
        contentPadding: AppSpacing.vertical(AppSpacing.sm),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ShelfSearchState searchState,
    ScrollController scrollController,
  ) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return switch (searchState) {
      ShelfSearchInitial() => Center(
          child: Text(
            'タイトルや著者名で検索できます',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appColors.textSecondary,
            ),
          ),
        ),
      ShelfSearchLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
      ShelfSearchError() => Center(
          child: Text(
            'エラーが発生しました',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appColors.destructive,
            ),
          ),
        ),
      ShelfSearchLoaded(:final books, :final hasMore, :final isLoadingMore) =>
        books.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: appColors.textSecondary,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      '本が見つかりません',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: appColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              )
            : NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (!hasMore || isLoadingMore) return false;
                  if (notification is! ScrollUpdateNotification) return false;

                  final maxScroll = notification.metrics.maxScrollExtent;
                  final currentScroll = notification.metrics.pixels;
                  final threshold = maxScroll * 0.8;

                  if (currentScroll >= threshold) {
                    ref
                        .read(shelfSearchNotifierProvider.notifier)
                        .loadMore();
                  }
                  return false;
                },
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: books.length + (isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == books.length) {
                      return const Padding(
                        padding: EdgeInsets.all(AppSpacing.md),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final book = books[index];
                    return _SearchResultItem(
                      book: book,
                      onTap: () {
                        Navigator.pop(context);
                        widget.onBookTap(book);
                      },
                      onLongPress: widget.onBookLongPress != null
                          ? () => widget.onBookLongPress!(book)
                          : null,
                    );
                  },
                ),
              ),
    };
  }

  void _onSearchChanged(String value) {
    setState(() {});
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      ref.read(shelfSearchNotifierProvider.notifier).search(value);
    });
  }
}

class _SearchResultItem extends StatelessWidget {
  const _SearchResultItem({
    required this.book,
    required this.onTap,
    this.onLongPress,
  });

  final ShelfBookItem book;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  static const _imageWidth = 48.0;
  static const _imageHeight = 72.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
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
          color: appColors.textSecondary,
        ),
      ),
      trailing: onLongPress != null
          ? IconButton(
              icon: Icon(
                Icons.more_vert,
                color: appColors.textSecondary,
              ),
              onPressed: onLongPress,
              visualDensity: VisualDensity.compact,
            )
          : null,
    );
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
    final appColors = theme.extension<AppColors>()!;
    return Container(
      width: _imageWidth,
      height: _imageHeight,
      decoration: BoxDecoration(
        color: appColors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Icon(
        Icons.book,
        color: appColors.textSecondary,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_card.dart';

/// 書籍グリッドコンポーネント
///
/// 本棚画面で書籍を3列のグリッドレイアウトで表示する。
/// グループ化表示と無限スクロールに対応。
class BookGrid extends StatefulWidget {
  const BookGrid({
    required this.books,
    required this.groupedBooks,
    required this.isGrouped,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onBookTap,
    required this.onLoadMore,
    super.key,
  });

  final List<ShelfBookItem> books;
  final Map<String, List<ShelfBookItem>> groupedBooks;
  final bool isGrouped;
  final bool hasMore;
  final bool isLoadingMore;
  final void Function(ShelfBookItem) onBookTap;
  final VoidCallback onLoadMore;

  @override
  State<BookGrid> createState() => _BookGridState();
}

class _BookGridState extends State<BookGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!widget.hasMore || widget.isLoadingMore) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    final threshold = maxScroll * 0.8;

    if (currentScroll >= threshold) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isGrouped) {
      return _buildGroupedGrid(context);
    }
    return _buildFlatGrid(context);
  }

  Widget _buildFlatGrid(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.md),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: AppSpacing.xs,
              crossAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.48,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => BookCard(
                book: widget.books[index],
                onTap: () => widget.onBookTap(widget.books[index]),
              ),
              childCount: widget.books.length,
            ),
          ),
        ),
        if (widget.isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: LoadingIndicator(),
            ),
          ),
      ],
    );
  }

  Widget _buildGroupedGrid(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    final groups = widget.groupedBooks.entries.toList();

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        for (final group in groups) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: Text(
                group.key,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: appColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 0.48,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => BookCard(
                  book: group.value[index],
                  onTap: () => widget.onBookTap(group.value[index]),
                ),
                childCount: group.value.length,
              ),
            ),
          ),
        ],
        if (widget.isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: LoadingIndicator(),
            ),
          ),
      ],
    );
  }
}

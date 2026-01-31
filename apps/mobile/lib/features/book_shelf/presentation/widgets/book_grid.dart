import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
    required this.onBookLongPress,
    required this.onLoadMore,
    super.key,
  });

  final List<ShelfBookItem> books;
  final Map<String, List<ShelfBookItem>> groupedBooks;
  final bool isGrouped;
  final bool hasMore;
  final bool isLoadingMore;
  final void Function(ShelfBookItem) onBookTap;
  final void Function(ShelfBookItem) onBookLongPress;
  final VoidCallback onLoadMore;

  @override
  State<BookGrid> createState() => _BookGridState();
}

class _BookGridState extends State<BookGrid> {
  bool _onScrollNotification(ScrollNotification notification) {
    if (!widget.hasMore || widget.isLoadingMore) return false;
    if (notification is! ScrollUpdateNotification) return false;

    final maxScroll = notification.metrics.maxScrollExtent;
    final currentScroll = notification.metrics.pixels;
    final threshold = maxScroll * 0.8;

    if (currentScroll >= threshold) {
      widget.onLoadMore();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.isGrouped
        ? _buildGroupedGrid(context)
        : _buildFlatGrid(context);
    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: child,
    );
  }

  Widget _buildFlatGrid(BuildContext context) {
    return AnimationLimiter(
      key: ValueKey('flat_${widget.books.map((b) => b.userBookId).join('_')}'),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: AppSpacing.md,
            ),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: AppSpacing.xs,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 0.45,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: 3,
                  duration: const Duration(milliseconds: 300),
                  child: ScaleAnimation(
                    scale: 0.9,
                    child: FadeInAnimation(
                      child: BookCard(
                        book: widget.books[index],
                        onTap: () => widget.onBookTap(widget.books[index]),
                        onLongPress: () =>
                            widget.onBookLongPress(widget.books[index]),
                      ),
                    ),
                  ),
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
      ),
    );
  }

  Widget _buildGroupedGrid(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    final groups = widget.groupedBooks.entries.toList();

    return AnimationLimiter(
      key: ValueKey(
        'grouped_${groups.map((g) => '${g.key}_${g.value.length}').join('_')}',
      ),
      child: CustomScrollView(
        slivers: [
          for (var groupIndex = 0; groupIndex < groups.length; groupIndex++) ...[
            SliverToBoxAdapter(
              child: AnimationConfiguration.staggeredList(
                position: groupIndex,
                duration: const Duration(milliseconds: 300),
                child: SlideAnimation(
                  horizontalOffset: -50,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        AppSpacing.md,
                        AppSpacing.md,
                        AppSpacing.sm,
                      ),
                      child: Text(
                        groups[groupIndex].key,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: appColors.foreground,
                        ),
                      ),
                    ),
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
                  childAspectRatio: 0.45,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      columnCount: 3,
                      duration: const Duration(milliseconds: 300),
                      child: ScaleAnimation(
                        scale: 0.9,
                        child: FadeInAnimation(
                          child: BookCard(
                            book: groups[groupIndex].value[index],
                            onTap: () => widget.onBookTap(
                              groups[groupIndex].value[index],
                            ),
                            onLongPress: () => widget.onBookLongPress(
                              groups[groupIndex].value[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: groups[groupIndex].value.length,
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
      ),
    );
  }
}

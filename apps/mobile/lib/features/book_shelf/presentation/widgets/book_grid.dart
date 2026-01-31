import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_card.dart';

/// 書籍グリッドコンポーネント
///
/// 本棚画面で書籍を4列のグリッドレイアウトで表示する。
/// 無限スクロールに対応。
class BookGrid extends StatefulWidget {
  const BookGrid({
    required this.books,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onBookTap,
    required this.onBookLongPress,
    required this.onLoadMore,
    super.key,
  });

  final List<ShelfBookItem> books;
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
    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: AnimationLimiter(
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
                  crossAxisCount: 4,
                  mainAxisSpacing: AppSpacing.xs,
                  crossAxisSpacing: AppSpacing.xs,
                  childAspectRatio: 0.40,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => AnimationConfiguration.staggeredGrid(
                    position: index,
                    columnCount: 4,
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
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).padding.bottom +
                    kBottomNavigationBarHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

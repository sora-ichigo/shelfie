import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/application/status_section_notifier.dart';
import 'package:shelfie/features/book_shelf/application/status_section_state.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_card.dart';

class StatusSection extends ConsumerStatefulWidget {
  const StatusSection({
    required this.status,
    required this.onBookTap,
    required this.onBookLongPress,
    super.key,
  });

  final ReadingStatus status;
  final void Function(ShelfBookItem) onBookTap;
  final void Function(ShelfBookItem) onBookLongPress;

  @override
  ConsumerState<StatusSection> createState() => _StatusSectionState();
}

class _StatusSectionState extends ConsumerState<StatusSection> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      statusSectionNotifierProvider(widget.status),
    );

    return switch (state) {
      StatusSectionInitial() => const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        ),
      StatusSectionLoading() => const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: LoadingIndicator(),
          ),
        ),
      StatusSectionLoaded(:final books, :final totalCount, :final hasMore, :final isLoadingMore) =>
        books.isEmpty
            ? const SliverToBoxAdapter(child: SizedBox.shrink())
            : _buildLoadedSection(
                context,
                books: books,
                totalCount: totalCount,
                hasMore: hasMore,
                isLoadingMore: isLoadingMore,
              ),
      StatusSectionError(:final failure) => SliverToBoxAdapter(
          child: Padding(
            padding: AppSpacing.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(context, 0),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  failure.userMessage,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: () => ref
                      .read(statusSectionNotifierProvider(widget.status).notifier)
                      .retry(),
                  child: const Text('再試行'),
                ),
              ],
            ),
          ),
        ),
    };
  }

  Widget _buildLoadedSection(
    BuildContext context, {
    required List<ShelfBookItem> books,
    required int totalCount,
    required bool hasMore,
    required bool isLoadingMore,
  }) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: _buildHeader(context, totalCount),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: AppSpacing.xs,
              crossAxisSpacing: AppSpacing.xs,
              childAspectRatio: 0.40,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == books.length - 1 && hasMore && !isLoadingMore) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ref
                        .read(
                          statusSectionNotifierProvider(widget.status).notifier,
                        )
                        .loadMore();
                  });
                }

                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: 4,
                  duration: const Duration(milliseconds: 300),
                  child: ScaleAnimation(
                    scale: 0.9,
                    child: FadeInAnimation(
                      child: BookCard(
                        book: books[index],
                        onTap: () => widget.onBookTap(books[index]),
                        onLongPress: () => widget.onBookLongPress(books[index]),
                      ),
                    ),
                  ),
                );
              },
              childCount: books.length,
            ),
          ),
        ),
        if (isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: LoadingIndicator(),
            ),
          ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, int count) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Row(
      children: [
        Text(
          widget.status.displayName,
          style: theme.textTheme.titleMedium?.copyWith(
            color: appColors.foreground,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '$count',
          style: theme.textTheme.titleMedium?.copyWith(
            color: appColors.foregroundMuted,
          ),
        ),
      ],
    );
  }
}

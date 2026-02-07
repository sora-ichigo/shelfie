import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/state/book_list_version.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_list/application/book_list_notifier.dart';
import 'package:shelfie/features/book_list/application/book_list_state.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/book_selector_modal.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_quick_actions_modal.dart';
import 'package:shelfie/routing/app_router.dart';

class BookListDetailScreen extends ConsumerStatefulWidget {
  const BookListDetailScreen({
    required this.listId,
    super.key,
  });

  final int listId;

  @override
  ConsumerState<BookListDetailScreen> createState() =>
      _BookListDetailScreenState();
}

class _BookListDetailScreenState extends ConsumerState<BookListDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(bookListDetailNotifierProvider(widget.listId).notifier)
          .loadDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(shelfStateProvider, (previous, next) {
      if (previous == null) return;

      final removedIds =
          previous.keys.where((id) => !next.containsKey(id)).toList();
      if (removedIds.isEmpty) return;

      final notifier = ref.read(
        bookListDetailNotifierProvider(widget.listId).notifier,
      );
      for (final id in removedIds) {
        notifier.removeItemByExternalId(
          id,
          wasCompleted: previous[id]?.isCompleted ?? false,
        );
      }
    });

    final state = ref.watch(bookListDetailNotifierProvider(widget.listId));

    return Scaffold(
      body: _buildBody(state),
    );
  }

  Widget _buildBody(BookListDetailState state) {
    return switch (state) {
      BookListDetailInitial() => const LoadingIndicator(fullScreen: true),
      BookListDetailLoading() => const LoadingIndicator(fullScreen: true),
      BookListDetailLoaded(:final list) => _buildLoadedContent(list),
      BookListDetailError(:final failure) => ErrorView(
          failure: failure,
          onRetry: () => ref
              .read(bookListDetailNotifierProvider(widget.listId).notifier)
              .refresh(),
          retryButtonText: '再試行',
        ),
    };
  }

  Widget _buildLoadedContent(BookListDetail list) {
    return CustomScrollView(
      slivers: [
        _DetailHeader(
          list: list,
          onBack: () => Navigator.of(context).pop(),
        ),
        SliverToBoxAdapter(
          child: _ActionButtons(
            onAddBook: _onAddBooksPressed,
            onMore: () => _onMorePressed(list),
          ),
        ),
        if (list.items.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu_book_outlined,
                    size: 64,
                    color: Theme.of(context)
                        .extension<AppColors>()!
                        .textSecondary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'このリストにはまだ本がありません',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .extension<AppColors>()!
                              .textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          )
        else ...[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final sortedItems = List<BookListItem>.from(list.items)
                  ..sort((a, b) => a.position.compareTo(b.position));
                final item = sortedItems[index];
                return _BookListItemTile(
                  item: item,
                  position: index + 1,
                  onTap: () => _onItemTap(item),
                  onLongPress: () => _onItemLongPress(item),
                );
              },
              childCount: list.items.length,
            ),
          ),
          SliverToBoxAdapter(
            child: _StatsSection(stats: list.stats),
          ),
        ],
      ],
    );
  }

  void _onMorePressed(BookListDetail list) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: appColors.surface,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.delete_outline, color: appColors.destructive),
              title: Text(
                'リストを削除',
                style: TextStyle(color: appColors.destructive),
              ),
              onTap: () {
                Navigator.of(context).pop();
                _showDeleteConfirmation(list);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BookListDetail list) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('リストを削除'),
        content: const Text('このリストを削除しますか？この操作は取り消せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('削除', style: TextStyle(color: Theme.of(context).extension<AppColors>()!.destructive)),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    final notifier = ref.read(bookListNotifierProvider.notifier);
    final result = await notifier.deleteList(listId: list.id);

    if (!mounted) return;

    result.fold(
      (failure) {
        AdaptiveSnackBar.show(
          context,
          message: failure.userMessage,
          type: AdaptiveSnackBarType.error,
        );
      },
      (_) {
        Navigator.of(context).pop();
      },
    );
  }

  void _onAddBooksPressed() {
    final state = ref.read(bookListDetailNotifierProvider(widget.listId));
    if (state is! BookListDetailLoaded) return;

    final existingUserBookIds =
        state.list.items.map((item) => item.userBook?.id ?? 0).toList();

    showBookSelectorModal(
      context: context,
      existingUserBookIds: const [],
      initialSelectedUserBookIds: existingUserBookIds,
      onBookSelected: (book) async {
        final repository = ref.read(bookListRepositoryProvider);
        final result = await repository.addBookToList(
          listId: widget.listId,
          userBookId: book.userBookId,
        );
        result.fold(
          (failure) {
            if (mounted) {
              AdaptiveSnackBar.show(
                context,
                message: failure.userMessage,
                type: AdaptiveSnackBarType.error,
              );
            }
          },
          (_) {
            ref.read(bookListVersionProvider.notifier).increment();
          },
        );
      },
      onBookRemoved: (book) async {
        final repository = ref.read(bookListRepositoryProvider);
        final result = await repository.removeBookFromList(
          listId: widget.listId,
          userBookId: book.userBookId,
        );
        result.fold(
          (failure) {
            if (mounted) {
              AdaptiveSnackBar.show(
                context,
                message: failure.userMessage,
                type: AdaptiveSnackBarType.error,
              );
            }
          },
          (_) {
            ref.read(bookListVersionProvider.notifier).increment();
          },
        );
      },
    );
  }

  void _onItemLongPress(BookListItem item) {
    final userBook = item.userBook;
    if (userBook == null) return;

    final shelfEntry = ref.read(shelfStateProvider)[userBook.externalId];
    if (shelfEntry == null) return;

    final source = switch (userBook.source) {
      'google' => BookSource.google,
      'rakuten' => BookSource.rakuten,
      _ => BookSource.rakuten,
    };

    showBookQuickActionsModal(
      context: context,
      ref: ref,
      book: ShelfBookItem(
        userBookId: userBook.id,
        externalId: userBook.externalId,
        title: userBook.title,
        authors: userBook.authors,
        source: source,
        addedAt: item.addedAt,
        coverImageUrl: userBook.coverImageUrl,
      ),
      shelfEntry: shelfEntry,
    );
  }

  void _onItemTap(BookListItem item) {
    final userBook = item.userBook;
    if (userBook == null) return;

    final source = switch (userBook.source) {
      'google' => BookSource.google,
      _ => BookSource.rakuten,
    };
    context.push(
      AppRoutes.bookDetail(bookId: userBook.externalId, source: source),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({
    required this.list,
    required this.onBack,
  });

  final BookListDetail list;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // ignore: avoid_direct_colors
              Color(0xFF1A4B8C),
              // ignore: avoid_direct_colors
              Color(0xFF0A1929),
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: AppSpacing.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    // ignore: avoid_direct_colors
                    color: Colors.white,
                    onPressed: onBack,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CoverCollage(coverImages: list.stats.coverImages),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list.title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              // ignore: avoid_direct_colors
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            '${list.stats.bookCount}冊',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              // ignore: avoid_direct_colors
                              color: Colors.white70,
                            ),
                          ),
                          if (list.description != null) ...[
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              list.description!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                // ignore: avoid_direct_colors
                                color: Colors.white60,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CoverCollage extends StatelessWidget {
  const _CoverCollage({required this.coverImages});

  final List<String> coverImages;

  static const double _size = 90;
  static const double _half = 45;
  static const double _radius = 8;

  @override
  Widget build(BuildContext context) {
    if (coverImages.isEmpty) {
      return Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          // ignore: avoid_direct_colors
          color: Colors.white12,
          borderRadius: BorderRadius.circular(_radius),
        ),
        child: const Icon(
          Icons.menu_book_outlined,
          // ignore: avoid_direct_colors
          color: Colors.white38,
          size: 32,
        ),
      );
    }

    if (coverImages.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(_radius),
        child: _buildImage(coverImages[0], _size, _size),
      );
    }

    if (coverImages.length == 2) {
      return _buildTwoImages();
    }

    if (coverImages.length == 3) {
      return _buildThreeImages();
    }

    return _buildFourImages();
  }

  /// 2枚: 左右2列
  Widget _buildTwoImages() {
    return SizedBox(
      width: _size,
      height: _size,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(_radius),
              bottomLeft: Radius.circular(_radius),
            ),
            child: _buildImage(coverImages[0], _half, _size),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(_radius),
              bottomRight: Radius.circular(_radius),
            ),
            child: _buildImage(coverImages[1], _half, _size),
          ),
        ],
      ),
    );
  }

  /// 3枚: 左1枚 + 右2枚縦
  Widget _buildThreeImages() {
    return SizedBox(
      width: _size,
      height: _size,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(_radius),
              bottomLeft: Radius.circular(_radius),
            ),
            child: _buildImage(coverImages[0], _half, _size),
          ),
          Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(_radius),
                ),
                child: _buildImage(coverImages[1], _half, _half),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(_radius),
                ),
                child: _buildImage(coverImages[2], _half, _half),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 4枚: 2x2グリッド
  Widget _buildFourImages() {
    return SizedBox(
      width: _size,
      height: _size,
      child: Row(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(_radius),
                ),
                child: _buildImage(coverImages[0], _half, _half),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(_radius),
                ),
                child: _buildImage(coverImages[2], _half, _half),
              ),
            ],
          ),
          Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(_radius),
                ),
                child: _buildImage(coverImages[1], _half, _half),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(_radius),
                ),
                child: _buildImage(coverImages[3], _half, _half),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String url, double width, double height) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        // ignore: avoid_direct_colors
        color: Colors.white12,
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        // ignore: avoid_direct_colors
        color: Colors.white12,
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.onAddBook,
    required this.onMore,
  });

  final VoidCallback onAddBook;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onAddBook,
              icon: const Icon(Icons.add, size: 20),
              label: const Text('本を追加'),
              style: ElevatedButton.styleFrom(
                backgroundColor: appColors.textPrimary,
                foregroundColor: appColors.overlay.withOpacity(0.87),
                iconColor: appColors.overlay.withOpacity(0.87),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          _CircleIconButton(
            icon: Icons.more_vert,
            onPressed: onMore,
            backgroundColor: appColors.surface,
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }
}

class _BookListItemTile extends StatelessWidget {
  const _BookListItemTile({
    required this.item,
    required this.position,
    required this.onTap,
    required this.onLongPress,
  });

  final BookListItem item;
  final int position;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    final userBook = item.userBook;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Text(
                '$position',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: appColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: userBook?.coverImageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: userBook!.coverImageUrl!,
                      width: 50,
                      height: 75,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 50,
                        height: 75,
                        color: appColors.surface,
                      ),
                      errorWidget: (context, url, error) => _BookPlaceholder(
                        appColors: appColors,
                      ),
                    )
                  : _BookPlaceholder(appColors: appColors),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userBook?.title ?? '不明な本',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (userBook != null && userBook.authors.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      userBook.authors.join('、'),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: appColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookPlaceholder extends StatelessWidget {
  const _BookPlaceholder({required this.appColors});

  final AppColors appColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 75,
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        Icons.book,
        color: appColors.textSecondary,
        size: 24,
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection({required this.stats});

  final BookListDetailStats stats;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Container(
      margin: AppSpacing.all(AppSpacing.md),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: appColors.textSecondary.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            value: stats.bookCount.toString(),
            label: '冊',
          ),
          _StatItem(
            value: stats.completedCount.toString(),
            label: '読了',
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: appColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

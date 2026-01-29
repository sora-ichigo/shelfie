import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
          onShare: () => _onSharePressed(list),
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
                        .foregroundMuted,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'このリストにはまだ本がありません',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .extension<AppColors>()!
                              .foregroundMuted,
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

  void _onSharePressed(BookListDetail list) {
    // TODO(shelfie): Implement share functionality
  }

  void _onMorePressed(BookListDetail list) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text(
                'リストを削除',
                style: TextStyle(color: Colors.red),
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
            child: const Text('削除', style: TextStyle(color: Colors.red)),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.userMessage)),
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
      existingUserBookIds: existingUserBookIds,
      onBookSelected: (book) async {
        final repository = ref.read(bookListRepositoryProvider);
        final result = await repository.addBookToList(
          listId: widget.listId,
          userBookId: book.userBookId,
        );
        result.fold(
          (failure) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(failure.userMessage)),
              );
            }
          },
          (_) {
            ref
                .read(bookListDetailNotifierProvider(widget.listId).notifier)
                .refresh();
          },
        );
      },
    );
  }

  void _onItemTap(BookListItem item) {
    final userBook = item.userBook;
    if (userBook == null) return;

    final source = switch (userBook.source) {
      'google' => BookSource.google,
      'rakuten' => BookSource.rakuten,
      _ => null,
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
    required this.onShare,
  });

  final BookListDetail list;
  final VoidCallback onBack;
  final VoidCallback onShare;

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
              Color(0xFF1A4B8C),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                      onPressed: onBack,
                    ),
                    IconButton(
                      icon: const Icon(Icons.share_outlined),
                      color: Colors.white,
                      onPressed: onShare,
                    ),
                  ],
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
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            '${list.stats.bookCount}冊',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          if (list.description != null) ...[
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              list.description!,
                              style: theme.textTheme.bodySmall?.copyWith(
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

  @override
  Widget build(BuildContext context) {
    const double totalWidth = 120;
    const double totalHeight = 90;
    const double singleWidth = 60;
    const double singleHeight = 90;

    if (coverImages.isEmpty) {
      return Container(
        width: totalWidth,
        height: totalHeight,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.menu_book_outlined,
          color: Colors.white38,
          size: 32,
        ),
      );
    }

    if (coverImages.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: coverImages[0],
          width: singleWidth,
          height: singleHeight,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            width: singleWidth,
            height: singleHeight,
            color: Colors.white12,
          ),
          errorWidget: (context, url, error) => Container(
            width: singleWidth,
            height: singleHeight,
            color: Colors.white12,
            child: const Icon(Icons.book, color: Colors.white38),
          ),
        ),
      );
    }

    return SizedBox(
      width: totalWidth,
      height: totalHeight,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: CachedNetworkImage(
              imageUrl: coverImages[0],
              width: singleWidth,
              height: singleHeight,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: singleWidth,
                height: singleHeight,
                color: Colors.white12,
              ),
              errorWidget: (context, url, error) => Container(
                width: singleWidth,
                height: singleHeight,
                color: Colors.white12,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: CachedNetworkImage(
              imageUrl: coverImages.length > 1 ? coverImages[1] : coverImages[0],
              width: singleWidth,
              height: singleHeight,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: singleWidth,
                height: singleHeight,
                color: Colors.white12,
              ),
              errorWidget: (context, url, error) => Container(
                width: singleWidth,
                height: singleHeight,
                color: Colors.white12,
              ),
            ),
          ),
        ],
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
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
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
  });

  final BookListItem item;
  final int position;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    final userBook = item.userBook;

    return InkWell(
      onTap: onTap,
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
                  color: appColors.foregroundMuted,
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
                        color: appColors.foregroundMuted,
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
        color: appColors.foregroundMuted,
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
            color: appColors.foregroundMuted.withOpacity(0.2),
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
            color: appColors.foregroundMuted,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/empty_state.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_list/application/book_list_notifier.dart';
import 'package:shelfie/features/book_list/application/book_list_state.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (state is BookListDetailLoaded)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _onEditPressed(state.list),
            ),
        ],
      ),
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
        SliverToBoxAdapter(
          child: _ListHeader(list: list),
        ),
        if (list.items.isEmpty)
          SliverFillRemaining(
            child: EmptyState(
              icon: Icons.menu_book_outlined,
              message: 'このリストにはまだ本がありません',
              onAction: () => _onAddBooksPressed(),
              actionText: '本を追加',
            ),
          )
        else
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final sortedItems = List<BookListItem>.from(list.items)
                  ..sort((a, b) => a.position.compareTo(b.position));
                final item = sortedItems[index];
                return _BookListItemTile(
                  item: item,
                  onTap: () => _onItemTap(item),
                );
              },
              childCount: list.items.length,
            ),
          ),
      ],
    );
  }

  void _onEditPressed(BookListDetail list) {
    // TODO(shelfie): Navigate to edit screen
  }

  void _onAddBooksPressed() {
    // TODO(shelfie): Show book selector modal
  }

  void _onItemTap(BookListItem item) {
    // TODO(shelfie): Navigate to book detail
  }
}

class _ListHeader extends StatelessWidget {
  const _ListHeader({required this.list});

  final BookListDetail list;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Padding(
      padding: AppSpacing.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            list.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (list.description != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              list.description!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.foregroundMuted,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${list.items.length}冊',
            style: theme.textTheme.bodySmall?.copyWith(
              color: appColors.foregroundMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Divider(color: appColors.foregroundMuted.withOpacity(0.3)),
        ],
      ),
    );
  }
}

class _BookListItemTile extends StatelessWidget {
  const _BookListItemTile({
    required this.item,
    required this.onTap,
  });

  final BookListItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 60,
        decoration: BoxDecoration(
          color: appColors.surface,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Icon(
            Icons.book,
            color: appColors.foregroundMuted,
            size: 20,
          ),
        ),
      ),
      title: Text(
        'Book #${item.id}',
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        'Position: ${item.position}',
        style: theme.textTheme.bodySmall?.copyWith(
          color: appColors.foregroundMuted,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: appColors.foregroundMuted,
      ),
    );
  }
}

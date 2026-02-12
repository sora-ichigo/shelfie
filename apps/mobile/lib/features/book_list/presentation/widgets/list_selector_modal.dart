import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/state/book_list_version.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/app_snack_bar.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';
import 'package:shelfie/features/book_list/application/book_list_notifier.dart';
import 'package:shelfie/features/book_list/application/book_list_state.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/book_list_card.dart';
import 'package:shelfie/features/book_list/presentation/widgets/create_book_list_modal.dart';

Future<void> showListSelectorModal({
  required BuildContext context,
  required int userBookId,
}) async {
  final appColors = Theme.of(context).extension<AppColors>()!;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: appColors.surface,
    builder: (context) => _ListSelectorModalContent(
      userBookId: userBookId,
    ),
  );
}

class _ListSelectorModalContent extends ConsumerStatefulWidget {
  const _ListSelectorModalContent({
    required this.userBookId,
  });

  final int userBookId;

  @override
  ConsumerState<_ListSelectorModalContent> createState() =>
      _ListSelectorModalContentState();
}

class _ListSelectorModalContentState
    extends ConsumerState<_ListSelectorModalContent> {
  Set<int> _addedListIds = {};
  final Set<int> _addingListIds = {};
  final Set<int> _removingListIds = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookListNotifierProvider.notifier).loadLists();
      _loadAddedListIds();
    });
  }

  Future<void> _loadAddedListIds() async {
    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.getListIdsContainingUserBook(
      userBookId: widget.userBookId,
    );

    if (!mounted) return;

    result.fold(
      (_) {},
      (listIds) {
        setState(() {
          _addedListIds = listIds.toSet();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookListNotifierProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) {
        return BaseBottomSheet(
          title: 'リストに追加',
          child: Expanded(
            child: Column(
              children: [
                _buildCreateListButton(context),
                const SizedBox(height: AppSpacing.md),
                Expanded(
                  child: _buildListContent(context, state, scrollController),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreateListButton(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return FilledButton.icon(
      onPressed: _onCreateNewList,
      icon: Icon(Icons.add, color: appColors.background),
      label: Text(
        '新しいリストを作成',
        style: theme.textTheme.labelLarge?.copyWith(
          color: appColors.background,
        ),
      ),
      style: FilledButton.styleFrom(
        backgroundColor: appColors.textPrimary,
        foregroundColor: appColors.background,
        minimumSize: const Size(double.infinity, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.sm,
        ),
      ),
    );
  }

  Widget _buildListContent(
    BuildContext context,
    BookListState state,
    ScrollController scrollController,
  ) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return switch (state) {
      BookListInitial() => const Center(child: CircularProgressIndicator()),
      BookListLoading() => const Center(child: CircularProgressIndicator()),
      BookListLoaded(:final lists) => _buildListView(
          context,
          lists,
          scrollController,
        ),
      BookListError(:final failure) => Center(
          child: Text(
            failure.userMessage,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appColors.destructive,
            ),
          ),
        ),
    };
  }

  Widget _buildListView(
    BuildContext context,
    List<BookListSummary> lists,
    ScrollController scrollController,
  ) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    if (lists.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.playlist_add,
              size: 48,
              color: appColors.textSecondary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'リストがありません',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '新しいリストを作成してください',
              style: theme.textTheme.bodySmall?.copyWith(
                color: appColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: lists.length,
      itemBuilder: (context, index) {
        final list = lists[index];
        final isInList = _addedListIds.contains(list.id);
        final isAdding = _addingListIds.contains(list.id);
        final isRemoving = _removingListIds.contains(list.id);
        return _ListItem(
          list: list,
          isInList: isInList,
          isAdding: isAdding,
          isRemoving: isRemoving,
          onTap: isInList ? null : () => _onAddToList(list),
          onRemove: isInList ? () => _onRemoveFromList(list) : null,
        );
      },
    );
  }

  Future<void> _onCreateNewList() async {
    final state = ref.read(bookListNotifierProvider);
    final existingCount = switch (state) {
      BookListLoaded(:final lists) => lists.length,
      _ => 0,
    };

    final bookList = await showCreateBookListModal(
      context: context,
      existingCount: existingCount,
    );

    if (bookList == null || !mounted) return;

    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.addBookToList(
      listId: bookList.id,
      userBookId: widget.userBookId,
    );

    if (!mounted) return;

    result.fold(
      (failure) {
        AppSnackBar.show(
          context,
          message: failure.userMessage,
          type: AppSnackBarType.error,
        );
      },
      (_) {
        ref.read(bookListVersionProvider.notifier).increment();
        setState(() {
          _addedListIds.add(bookList.id);
        });
        AppSnackBar.show(
          context,
          message: 'リストに追加しました',
          type: AppSnackBarType.success,
        );
        ref.read(bookListNotifierProvider.notifier).loadLists();
      },
    );
  }

  Future<void> _onAddToList(BookListSummary list) async {
    setState(() {
      _addingListIds.add(list.id);
    });

    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.addBookToList(
      listId: list.id,
      userBookId: widget.userBookId,
    );

    if (!mounted) return;

    setState(() {
      _addingListIds.remove(list.id);
    });

    result.fold(
      (failure) {
        AppSnackBar.show(
          context,
          message: failure.userMessage,
          type: AppSnackBarType.error,
        );
      },
      (_) {
        ref.read(bookListVersionProvider.notifier).increment();
        setState(() {
          _addedListIds.add(list.id);
        });
        AppSnackBar.show(
          context,
          message: '「${list.title}」に追加しました',
          type: AppSnackBarType.success,
        );
      },
    );
  }

  Future<void> _onRemoveFromList(BookListSummary list) async {
    setState(() {
      _removingListIds.add(list.id);
    });

    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.removeBookFromList(
      listId: list.id,
      userBookId: widget.userBookId,
    );

    if (!mounted) return;

    setState(() {
      _removingListIds.remove(list.id);
    });

    result.fold(
      (failure) {
        AppSnackBar.show(
          context,
          message: failure.userMessage,
          type: AppSnackBarType.error,
        );
      },
      (_) {
        ref.read(bookListVersionProvider.notifier).increment();
        setState(() {
          _addedListIds.remove(list.id);
        });
        AppSnackBar.show(
          context,
          message: '「${list.title}」から削除しました',
          type: AppSnackBarType.success,
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    required this.list,
    required this.isInList,
    required this.isAdding,
    required this.isRemoving,
    this.onTap,
    this.onRemove,
  });

  final BookListSummary list;
  final bool isInList;
  final bool isAdding;
  final bool isRemoving;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: appColors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: list.coverImages.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CoverCollage(coverImages: list.coverImages),
              )
            : Center(
                child: Icon(
                  Icons.collections_bookmark,
                  color: appColors.textSecondary,
                ),
              ),
      ),
      title: Text(
        list.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${list.bookCount}冊',
        style: theme.textTheme.bodySmall?.copyWith(
          color: appColors.textSecondary,
        ),
      ),
      trailing: _buildTrailing(appColors),
    );
  }

  Widget _buildTrailing(AppColors appColors) {
    if (isAdding || isRemoving) {
      return const SizedBox(
        width: 48,
        height: 48,
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (isInList) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: appColors.primary,
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: onRemove,
            icon: Icon(
              Icons.close,
              size: 20,
              color: appColors.textSecondary,
            ),
            visualDensity: VisualDensity.compact,
          ),
        ],
      );
    }

    return const Icon(Icons.add_circle_outline);
  }
}

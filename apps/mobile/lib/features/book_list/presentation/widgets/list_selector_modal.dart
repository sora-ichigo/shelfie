import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';
import 'package:shelfie/features/book_list/application/book_list_notifier.dart';
import 'package:shelfie/features/book_list/application/book_list_state.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

Future<void> showListSelectorModal({
  required BuildContext context,
  required int userBookId,
  required void Function(int listId) onListSelected,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (context) => _ListSelectorModalContent(
      userBookId: userBookId,
      onListSelected: onListSelected,
    ),
  );
}

class _ListSelectorModalContent extends ConsumerStatefulWidget {
  const _ListSelectorModalContent({
    required this.userBookId,
    required this.onListSelected,
  });

  final int userBookId;
  final void Function(int listId) onListSelected;

  @override
  ConsumerState<_ListSelectorModalContent> createState() =>
      _ListSelectorModalContentState();
}

class _ListSelectorModalContentState
    extends ConsumerState<_ListSelectorModalContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookListNotifierProvider.notifier).loadLists();
    });
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

    return InkWell(
      onTap: _onCreateNewList,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: AppSpacing.all(AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(
            color: appColors.primary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: appColors.primary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '新しいリストを作成',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
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
        return _ListItem(
          list: list,
          onTap: () => _onListTap(list),
        );
      },
    );
  }

  void _onCreateNewList() {
    Navigator.of(context).pop();
    // TODO(shelfie): Navigate to create list screen
  }

  void _onListTap(BookListSummary list) {
    widget.onListSelected(list.id);
    Navigator.of(context).pop();
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    required this.list,
    required this.onTap,
  });

  final BookListSummary list;
  final VoidCallback onTap;

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
                child: _buildCoverCollage(list.coverImages, appColors),
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
      trailing: Icon(
        Icons.add_circle_outline,
        color: appColors.primary,
      ),
    );
  }

  Widget _buildCoverCollage(List<String> images, AppColors appColors) {
    return ColoredBox(
      color: appColors.surface,
      child: Icon(
        Icons.collections_bookmark,
        color: appColors.textSecondary,
      ),
    );
  }
}

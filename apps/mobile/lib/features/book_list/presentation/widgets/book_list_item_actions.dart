import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

class BookListItemActions extends ConsumerStatefulWidget {
  const BookListItemActions({
    required this.item,
    required this.listId,
    this.onRemoved,
    this.index,
    super.key,
  });

  final BookListItem item;
  final int listId;
  final VoidCallback? onRemoved;
  final int? index;

  @override
  ConsumerState<BookListItemActions> createState() =>
      _BookListItemActionsState();
}

class _BookListItemActionsState extends ConsumerState<BookListItemActions> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: _isDeleting
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: appColors.textSecondary,
                  ),
                )
              : Icon(
                  Icons.delete_outline,
                  color: appColors.textSecondary,
                ),
          onPressed: _isDeleting ? null : _onDeleteTap,
        ),
        const SizedBox(width: AppSpacing.xs),
        if (widget.index != null)
          ReorderableDragStartListener(
            index: widget.index!,
            child: Icon(
              Icons.drag_handle,
              color: appColors.textSecondary,
            ),
          )
        else
          Icon(
            Icons.drag_handle,
            color: appColors.textSecondary,
          ),
      ],
    );
  }

  Future<void> _onDeleteTap() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('本をリストから削除'),
        content: const Text('この本をリストから削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isDeleting = true);

    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.removeBookFromList(
      listId: widget.listId,
      userBookId: widget.item.id,
    );

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() => _isDeleting = false);
        AdaptiveSnackBar.show(
          context,
          message: failure.userMessage,
          type: AdaptiveSnackBarType.error,
        );
      },
      (_) {
        widget.onRemoved?.call();
      },
    );
  }
}

class ReorderableBookList extends ConsumerStatefulWidget {
  const ReorderableBookList({
    required this.items,
    required this.listId,
    required this.itemBuilder,
    this.onReordered,
    super.key,
  });

  final List<BookListItem> items;
  final int listId;
  final Widget Function(BuildContext, BookListItem, int) itemBuilder;
  final void Function(int oldIndex, int newIndex)? onReordered;

  @override
  ConsumerState<ReorderableBookList> createState() =>
      _ReorderableBookListState();
}

class _ReorderableBookListState extends ConsumerState<ReorderableBookList> {
  late List<BookListItem> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  @override
  void didUpdateWidget(ReorderableBookList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _items = List.from(widget.items);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: _items.length,
      onReorder: _onReorder,
      buildDefaultDragHandles: false,
      itemBuilder: (context, index) {
        final item = _items[index];
        return KeyedSubtree(
          key: ValueKey(item.id),
          child: widget.itemBuilder(context, item, index),
        );
      },
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    var adjustedIndex = newIndex;
    setState(() {
      if (oldIndex < newIndex) {
        adjustedIndex -= 1;
      }
      final item = _items.removeAt(oldIndex);
      _items.insert(adjustedIndex, item);
    });

    widget.onReordered?.call(oldIndex, adjustedIndex);
  }
}

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_icon_size.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/theme/app_typography.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/reading_note_modal.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/presentation/widgets/list_selector_modal.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

Future<void> showBookQuickActionsModal({
  required BuildContext context,
  required WidgetRef ref,
  required ShelfBookItem book,
  required ShelfEntry shelfEntry,
}) async {
  unawaited(HapticFeedback.mediumImpact());

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (context) => _BookQuickActionsModalContent(
      book: book,
      shelfEntry: shelfEntry,
    ),
  );
}

class _BookQuickActionsModalContent extends ConsumerStatefulWidget {
  const _BookQuickActionsModalContent({
    required this.book,
    required this.shelfEntry,
  });

  final ShelfBookItem book;
  final ShelfEntry shelfEntry;

  @override
  ConsumerState<_BookQuickActionsModalContent> createState() =>
      _BookQuickActionsModalContentState();
}

class _BookQuickActionsModalContentState
    extends ConsumerState<_BookQuickActionsModalContent> {
  bool _isUpdating = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    final currentEntry = ref.watch(
      shelfStateProvider.select((s) => s[widget.book.externalId]),
    );
    final entry = currentEntry ?? widget.shelfEntry;

    return SafeArea(
      child: Padding(
        padding: AppSpacing.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDragHandle(theme),
            const SizedBox(height: AppSpacing.md),
            _buildBookInfo(theme, appColors),
            const SizedBox(height: AppSpacing.lg),
            _buildReadingStatusSection(theme, appColors, entry),
            const SizedBox(height: AppSpacing.lg),
            _buildRatingSection(theme, appColors, entry),
            const SizedBox(height: AppSpacing.md),
            Divider(color: appColors.foregroundMuted.withOpacity(0.3)),
            const SizedBox(height: AppSpacing.sm),
            _buildActionList(theme, appColors, entry),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle(ThemeData theme) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildBookInfo(ThemeData theme, AppColors appColors) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          child: SizedBox(
            width: 48,
            height: 72,
            child: widget.book.hasCoverImage
                ? CachedNetworkImage(
                    imageUrl: widget.book.coverImageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        _buildImagePlaceholder(appColors),
                    errorWidget: (context, url, error) =>
                        _buildImagePlaceholder(appColors),
                  )
                : _buildImagePlaceholder(appColors),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.book.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                widget.book.authorsDisplay,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.captionSmall.copyWith(
                  color: appColors.foregroundMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImagePlaceholder(AppColors appColors) {
    return ColoredBox(
      color: appColors.overlay,
      child: Center(
        child: Icon(
          Icons.book,
          size: AppIconSize.base,
          color: appColors.foregroundMuted,
        ),
      ),
    );
  }

  Widget _buildReadingStatusSection(
    ThemeData theme,
    AppColors appColors,
    ShelfEntry entry,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '読書状態',
          style: theme.textTheme.labelMedium?.copyWith(
            color: appColors.foregroundMuted,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _buildStatusButton(theme, ReadingStatus.backlog, entry),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: _buildStatusButton(theme, ReadingStatus.reading, entry),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: _buildStatusButton(theme, ReadingStatus.completed, entry),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: _buildStatusButton(theme, ReadingStatus.dropped, entry),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusButton(
    ThemeData theme,
    ReadingStatus status,
    ShelfEntry entry,
  ) {
    final isSelected = entry.readingStatus == status;
    final statusColor = _getStatusColor(status);

    return InkWell(
      onTap: _isUpdating || isSelected ? null : () => _onStatusTap(status),
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: isSelected
              ? statusColor.withOpacity(0.3)
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
            color: isSelected ? statusColor : Colors.white.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            status.displayName,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? statusColor : const Color(0xFF99A1AF),
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(ReadingStatus status) {
    return switch (status) {
      ReadingStatus.backlog => const Color(0xFFFFB74D),
      ReadingStatus.reading => const Color(0xFF64B5F6),
      ReadingStatus.completed => const Color(0xFF81C784),
      ReadingStatus.dropped => const Color(0xFF90A4AE),
    };
  }

  Future<void> _onStatusTap(ReadingStatus status) async {
    setState(() => _isUpdating = true);
    unawaited(HapticFeedback.selectionClick());

    await ref.read(shelfStateProvider.notifier).updateReadingStatusWithApi(
          externalId: widget.book.externalId,
          status: status,
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${status.displayName}に変更しました')),
      );
      Navigator.pop(context);
    }
  }

  Widget _buildRatingSection(
    ThemeData theme,
    AppColors appColors,
    ShelfEntry entry,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '評価',
          style: theme.textTheme.labelMedium?.copyWith(
            color: appColors.foregroundMuted,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(5, (index) {
            final starValue = index + 1;
            final isSelected =
                entry.rating != null && entry.rating! >= starValue;

            return GestureDetector(
              onTap: _isUpdating ? null : () => _onRatingTap(starValue),
              child: Padding(
                padding: const EdgeInsets.only(right: AppSpacing.xs),
                child: Icon(
                  isSelected ? Icons.star : Icons.star_border,
                  size: 32.0,
                  color: isSelected
                      ? appColors.accentSecondary
                      : theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Future<void> _onRatingTap(int rating) async {
    setState(() => _isUpdating = true);
    unawaited(HapticFeedback.selectionClick());

    await ref.read(shelfStateProvider.notifier).updateRatingWithApi(
          externalId: widget.book.externalId,
          rating: rating,
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('評価を変更しました')),
      );
      Navigator.pop(context);
    }
  }

  Widget _buildActionList(
    ThemeData theme,
    AppColors appColors,
    ShelfEntry entry,
  ) {
    return Column(
      children: [
        _buildActionItem(
          theme: theme,
          appColors: appColors,
          icon: Icons.playlist_add,
          label: 'リストに追加',
          onTap: _onAddToListTap,
        ),
        _buildActionItem(
          theme: theme,
          appColors: appColors,
          icon: Icons.edit_note,
          label: 'メモを編集',
          onTap: () => _onEditNoteTap(entry),
        ),
        _buildActionItem(
          theme: theme,
          appColors: appColors,
          icon: Icons.delete_outline,
          label: 'マイライブラリから削除',
          isDestructive: true,
          onTap: _onDeleteTap,
        ),
      ],
    );
  }

  Widget _buildActionItem({
    required ThemeData theme,
    required AppColors appColors,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive ? appColors.error : appColors.foreground;

    return InkWell(
      onTap: _isUpdating ? null : onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: AppIconSize.base),
            const SizedBox(width: AppSpacing.md),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAddToListTap() {
    final repository = ref.read(bookListRepositoryProvider);
    final userBookId = widget.book.userBookId;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final errorColor = Theme.of(context).colorScheme.error;

    Navigator.pop(context);
    showListSelectorModal(
      context: context,
      userBookId: userBookId,
      onListSelected: (listId) async {
        final result = await repository.addBookToList(
          listId: listId,
          userBookId: userBookId,
        );

        result.fold(
          (failure) {
            scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text(failure.userMessage),
                backgroundColor: errorColor,
              ),
            );
          },
          (_) {
            scaffoldMessenger.showSnackBar(
              const SnackBar(content: Text('リストに追加しました')),
            );
          },
        );
      },
    );
  }

  void _onEditNoteTap(ShelfEntry entry) {
    Navigator.pop(context);
    showReadingNoteModal(
      context: context,
      currentNote: entry.note,
      userBookId: widget.book.userBookId,
      externalId: widget.book.externalId,
    );
  }

  Future<void> _onDeleteTap() async {
    setState(() => _isUpdating = true);
    unawaited(HapticFeedback.mediumImpact());

    final result =
        await ref.read(shelfStateProvider.notifier).removeFromShelf(
              externalId: widget.book.externalId,
              userBookId: widget.book.userBookId,
            );

    result.fold(
      (failure) {
        if (mounted) {
          setState(() => _isUpdating = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(failure.userMessage)),
          );
        }
      },
      (_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('マイライブラリから削除しました')),
          );
          Navigator.pop(context);
        }
      },
    );
  }
}

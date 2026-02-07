import 'dart:async';

import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/state/book_list_version.dart';
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
import 'package:shelfie/features/book_shelf/application/status_section_notifier.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/routing/app_router.dart';

Future<void> showBookQuickActionsModal({
  required BuildContext context,
  required WidgetRef ref,
  required ShelfBookItem book,
  required ShelfEntry shelfEntry,
}) async {
  unawaited(HapticFeedback.mediumImpact());

  final appColors = Theme.of(context).extension<AppColors>()!;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: appColors.surface,
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
            Divider(color: appColors.textSecondary.withOpacity(0.3)),
            const SizedBox(height: AppSpacing.sm),
            _buildActionList(theme, appColors, entry),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle(ThemeData theme) {
    final appColors = theme.extension<AppColors>()!;

    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: appColors.inactive,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  void _navigateToBookDetail() {
    Navigator.pop(context);
    context.push(
      AppRoutes.bookDetail(
        bookId: widget.book.externalId,
        source: widget.book.source,
      ),
    );
  }

  Widget _buildBookInfo(ThemeData theme, AppColors appColors) {
    return GestureDetector(
      onTap: _navigateToBookDetail,
      child: Row(
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
                    color: appColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder(AppColors appColors) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: Icon(
          Icons.book,
          size: AppIconSize.base,
          color: appColors.textSecondary,
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
            color: appColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _buildStatusButton(theme, ReadingStatus.interested, entry),
            ),
            const SizedBox(width: AppSpacing.xs),
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
    final appColors = theme.extension<AppColors>()!;
    final isSelected = entry.readingStatus == status;
    final statusColor = status.color;

    return InkWell(
      onTap: _isUpdating || isSelected ? null : () => _onStatusTap(status),
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: isSelected
              ? statusColor.withOpacity(0.15)
              : appColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
            color: isSelected ? statusColor : appColors.border,
          ),
        ),
        child: Center(
          child: Text(
            status.displayName,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? statusColor : appColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onStatusTap(ReadingStatus status) async {
    setState(() => _isUpdating = true);
    unawaited(HapticFeedback.selectionClick());

    final currentEntry =
        ref.read(shelfStateProvider)[widget.book.externalId];
    final previousStatus = currentEntry?.readingStatus;

    await ref.read(shelfStateProvider.notifier).updateReadingStatusWithApi(
          externalId: widget.book.externalId,
          status: status,
        );

    if (previousStatus != null && previousStatus != status) {
      ref
          .read(statusSectionNotifierProvider(previousStatus).notifier)
          .removeBook(widget.book.externalId);
    }

    if (mounted) {
      setState(() => _isUpdating = false);
      AdaptiveSnackBar.show(
        context,
        message: '${status.displayName}に変更しました',
        type: AdaptiveSnackBarType.success,
      );
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
            color: appColors.textSecondary,
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
                  isSelected ? Icons.star_rounded : Icons.star_border_rounded,
                  size: 32.0,
                  color: isSelected
                      ? appColors.star
                      : appColors.inactive,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Future<void> _onRatingTap(int starValue) async {
    final currentEntry =
        ref.read(shelfStateProvider)[widget.book.externalId];
    final newRating =
        currentEntry?.rating == starValue ? null : starValue;

    setState(() => _isUpdating = true);
    unawaited(HapticFeedback.selectionClick());

    await ref.read(shelfStateProvider.notifier).updateRatingWithApi(
          externalId: widget.book.externalId,
          rating: newRating,
        );

    if (mounted) {
      setState(() => _isUpdating = false);
      AdaptiveSnackBar.show(
        context,
        message: newRating == null ? '評価を解除しました' : '評価を変更しました',
        type: AdaptiveSnackBarType.success,
      );
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
    final color = isDestructive ? appColors.destructive : appColors.textPrimary;

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

    showListSelectorModal(
      context: context,
      userBookId: userBookId,
      onListSelected: (listId) async {
        final result = await repository.addBookToList(
          listId: listId,
          userBookId: userBookId,
        );

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
            ref.read(bookListVersionProvider.notifier).increment();
            AdaptiveSnackBar.show(
              context,
              message: 'リストに追加しました',
              type: AdaptiveSnackBarType.success,
            );
            Navigator.pop(context);
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

    final currentEntry =
        ref.read(shelfStateProvider)[widget.book.externalId];

    final result =
        await ref.read(shelfStateProvider.notifier).removeFromShelf(
              externalId: widget.book.externalId,
              userBookId: widget.book.userBookId,
            );

    result.fold(
      (failure) {
        if (mounted) {
          setState(() => _isUpdating = false);
          AdaptiveSnackBar.show(
            context,
            message: failure.userMessage,
            type: AdaptiveSnackBarType.error,
          );
        }
      },
      (_) {
        if (currentEntry != null) {
          ref
              .read(statusSectionNotifierProvider(
                      currentEntry.readingStatus)
                  .notifier)
              .removeBook(widget.book.externalId);
        }
        if (mounted) {
          AdaptiveSnackBar.show(
            context,
            message: 'マイライブラリから削除しました',
            type: AdaptiveSnackBarType.success,
          );
          Navigator.pop(context);
        }
      },
    );
  }
}

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_icon_size.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';
import 'package:shelfie/features/book_search/domain/recent_book_entry.dart';

Future<void> showRecentBookQuickActionsModal({
  required BuildContext context,
  required RecentBookEntry book,
  required VoidCallback onAddToShelf,
  required VoidCallback onRemoveFromShelf,
}) async {
  unawaited(HapticFeedback.mediumImpact());

  final appColors = Theme.of(context).extension<AppColors>()!;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: appColors.surfaceLegacy,
    builder: (context) => _RecentBookQuickActionsModalContent(
      book: book,
      onAddToShelf: onAddToShelf,
      onRemoveFromShelf: onRemoveFromShelf,
    ),
  );
}

class _RecentBookQuickActionsModalContent extends ConsumerWidget {
  const _RecentBookQuickActionsModalContent({
    required this.book,
    required this.onAddToShelf,
    required this.onRemoveFromShelf,
  });

  final RecentBookEntry book;
  final VoidCallback onAddToShelf;
  final VoidCallback onRemoveFromShelf;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    final isInShelf = ref.watch(
      shelfStateProvider.select((s) => s.containsKey(book.bookId)),
    );

    return BaseBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBookInfo(theme, appColors),
          const SizedBox(height: AppSpacing.lg),
          Divider(color: appColors.borderLegacy),
          const SizedBox(height: AppSpacing.sm),
          if (isInShelf)
            _buildRemoveAction(context, theme, appColors)
          else
            _buildAddAction(context, theme, appColors),
        ],
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
            child: book.coverImageUrl != null
                ? CachedNetworkImage(
                    imageUrl: book.coverImageUrl!,
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
                book.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                book.authors.join(', '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: appColors.textSecondaryLegacy,
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
      color: appColors.surfaceElevatedLegacy,
      child: Center(
        child: Icon(
          Icons.book,
          size: AppIconSize.base,
          color: appColors.textSecondaryLegacy,
        ),
      ),
    );
  }

  Widget _buildAddAction(
    BuildContext context,
    ThemeData theme,
    AppColors appColors,
  ) {
    return InkWell(
      onTap: () {
        unawaited(HapticFeedback.selectionClick());
        Navigator.pop(context);
        onAddToShelf();
      },
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Icon(
              Icons.add_circle_outline,
              color: appColors.textPrimaryLegacy,
              size: AppIconSize.base,
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              'マイライブラリに追加',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.textPrimaryLegacy,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemoveAction(
    BuildContext context,
    ThemeData theme,
    AppColors appColors,
  ) {
    return InkWell(
      onTap: () {
        unawaited(HapticFeedback.selectionClick());
        Navigator.pop(context);
        onRemoveFromShelf();
      },
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Icon(
              Icons.delete_outline,
              color: appColors.destructiveLegacy,
              size: AppIconSize.base,
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              'マイライブラリから削除',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.destructiveLegacy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

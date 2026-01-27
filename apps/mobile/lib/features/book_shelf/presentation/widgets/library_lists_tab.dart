import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/empty_state.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/book_list_card.dart';

class LibraryListsTab extends StatelessWidget {
  const LibraryListsTab({
    required this.lists,
    required this.onListTap,
    required this.onCreateTap,
    super.key,
  });

  final List<BookListSummary> lists;
  final ValueChanged<BookListSummary> onListTap;
  final VoidCallback onCreateTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: _CreateListButton(
            onTap: onCreateTap,
            appColors: appColors,
          ),
        ),
        Expanded(
          child: lists.isEmpty
              ? const EmptyState(
                  icon: Icons.playlist_add,
                  message: 'リストを作成して本を整理しましょう',
                )
              : _buildListView(context, appColors),
        ),
      ],
    );
  }

  Widget _buildListView(BuildContext context, AppColors appColors) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      itemCount: lists.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final list = lists[index];
        return BookListCard.horizontal(
          summary: list,
          onTap: () => onListTap(list),
        );
      },
    );
  }
}

class _CreateListButton extends StatelessWidget {
  const _CreateListButton({
    required this.onTap,
    required this.appColors,
  });

  final VoidCallback onTap;
  final AppColors appColors;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: appColors.accent,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: appColors.accent,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '新規作成',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

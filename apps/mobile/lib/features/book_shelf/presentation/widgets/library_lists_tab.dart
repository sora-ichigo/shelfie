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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: _CreateListButton(onTap: onCreateTap),
        ),
        Expanded(
          child: lists.isEmpty
              ? const EmptyState(
                  icon: Icons.playlist_add,
                  message: 'リストを作成して本を整理しましょう',
                )
              : _buildListView(context),
        ),
      ],
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      itemCount: lists.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final list = lists[index];
        return BookListCard(
          summary: list,
          onTap: () => onListTap(list),
        );
      },
    );
  }
}

class _CreateListButton extends StatelessWidget {
  const _CreateListButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.add, color: Colors.white, size: 20),
        label: Text(
          '新しいリスト',
          style: theme.textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: appColors.accent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
        ),
      ),
    );
  }
}

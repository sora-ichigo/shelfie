import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/book_list_card.dart';
import 'package:shelfie/features/book_list/presentation/widgets/create_list_card.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/no_books_message.dart';

class LibraryListsTab extends StatelessWidget {
  const LibraryListsTab({
    required this.lists,
    required this.hasBooks,
    required this.onListTap,
    required this.onCreateTap,
    super.key,
  });

  final List<BookListSummary> lists;
  final bool hasBooks;
  final ValueChanged<BookListSummary> onListTap;
  final VoidCallback onCreateTap;

  @override
  Widget build(BuildContext context) {
    if (!hasBooks) {
      return const NoBooksMessage();
    }

    if (lists.isEmpty) {
      return Center(
        child: CreateListCard(onCreateTap: onCreateTap),
      );
    }

    final bottomInset =
        MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight;

    return Scrollbar(
      child: ListView.builder(
        padding: EdgeInsets.only(
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.md,
          bottom: bottomInset,
        ),
        itemCount: lists.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _CreateListButton(onTap: onCreateTap),
            );
          }
          final list = lists[index - 1];
          return Padding(
            padding: EdgeInsets.only(
              top: index == 1 ? 0 : AppSpacing.sm,
            ),
            child: BookListCard(
              summary: list,
              onTap: () => onListTap(list),
            ),
          );
        },
      ),
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
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.add, color: Colors.white, size: 20),
        label: Text(
          '新しいリスト',
          style: theme.textTheme.labelLarge?.copyWith(
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: appColors.surfaceSubtle,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
        ),
      ),
    );
  }
}

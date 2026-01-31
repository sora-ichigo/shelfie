import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

enum LibraryFilterTab {
  books,
  lists,
}

extension LibraryFilterTabX on LibraryFilterTab {
  String get label {
    return switch (this) {
      LibraryFilterTab.books => 'すべて',
      LibraryFilterTab.lists => 'ブックリスト',
    };
  }
}

class LibraryFilterTabs extends StatelessWidget {
  const LibraryFilterTabs({
    required this.selectedTab,
    required this.onTabChanged,
    super.key,
  });

  final LibraryFilterTab selectedTab;
  final ValueChanged<LibraryFilterTab> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: LibraryFilterTab.values.map((tab) {
        return Padding(
          padding: EdgeInsets.only(
            right: tab != LibraryFilterTab.lists ? AppSpacing.xs : 0,
          ),
          child: _FilterTabButton(
            label: tab.label,
            isSelected: tab == selectedTab,
            onTap: () => onTabChanged(tab),
          ),
        );
      }).toList(),
    );
  }
}

class _FilterTabButton extends StatelessWidget {
  const _FilterTabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? appColors.chipHighlight
              : appColors.chipUnselected,
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w400,
            color: isSelected
                ? appColors.onChipHighlight
                : appColors.chipHighlight,
          ),
        ),
      ),
    );
  }
}

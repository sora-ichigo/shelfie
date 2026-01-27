import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

enum LibraryFilterTab {
  all,
  books,
  lists,
}

extension LibraryFilterTabX on LibraryFilterTab {
  String get label {
    return switch (this) {
      LibraryFilterTab.all => 'すべて',
      LibraryFilterTab.books => '本',
      LibraryFilterTab.lists => 'リスト',
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
            right: tab != LibraryFilterTab.lists ? AppSpacing.sm : 0,
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
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: isSelected ? appColors.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: isSelected
                ? appColors.accent
                : appColors.foregroundMuted.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color:
                isSelected ? appColors.foreground : appColors.foregroundMuted,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';

enum LibraryFilterTab {
  books,
  lists,
}

extension LibraryFilterTabX on LibraryFilterTab {
  String get label {
    return switch (this) {
      LibraryFilterTab.books => '本棚',
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
        return Expanded(
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

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? appColors.textPrimary
                    : appColors.textSecondary,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2,
            color: isSelected ? appColors.primary : Colors.transparent,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';

enum ProfileTab {
  bookShelf,
  bookList,
}

extension ProfileTabX on ProfileTab {
  String get label {
    return switch (this) {
      ProfileTab.bookShelf => '本棚',
      ProfileTab.bookList => 'ブックリスト',
    };
  }

  IconData get icon {
    return switch (this) {
      ProfileTab.bookShelf => Icons.grid_view_rounded,
      ProfileTab.bookList => Icons.list_rounded,
    };
  }
}

class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({
    required this.selectedTab,
    required this.onTabChanged,
    super.key,
  });

  final ProfileTab selectedTab;
  final ValueChanged<ProfileTab> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ProfileTab.values.map((tab) {
        return Expanded(
          child: _TabButton(
            tab: tab,
            isSelected: tab == selectedTab,
            onTap: () => onTabChanged(tab),
          ),
        );
      }).toList(),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  final ProfileTab tab;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    final color = isSelected ? appColors.textPrimary : appColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(tab.icon, size: 20, color: color),
                const SizedBox(width: 6),
                Text(
                  tab.label,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: color,
                  ),
                ),
              ],
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

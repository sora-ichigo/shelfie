import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/widgets/icon_tap_area.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

/// フィルターバーコンポーネント
///
/// 本棚画面で使用するソートボタン、グループ化ボタンを横並びで配置する。
class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({
    required this.sortOption,
    required this.groupOption,
    required this.onSortChanged,
    required this.onGroupChanged,
    super.key,
  });

  final SortOption sortOption;
  final GroupOption groupOption;
  final void Function(SortOption) onSortChanged;
  final void Function(GroupOption) onGroupChanged;

  Future<void> _showSortBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<SortOption>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => _SortBottomSheet(
        currentOption: sortOption,
      ),
    );

    if (result != null) {
      onSortChanged(result);
    }
  }

  Future<void> _showGroupBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<GroupOption>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => _GroupBottomSheet(
        currentOption: groupOption,
      ),
    );

    if (result != null) {
      onGroupChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Row(
      children: [
        _FilterIconButton(
          icon: Icons.tune,
          isActive: sortOption != SortOption.defaultOption,
          semanticLabel: sortOption != SortOption.defaultOption
              ? '並び替え（${sortOption.displayName}）'
              : '並び替え',
          color: appColors.foreground,
          onTap: () => _showSortBottomSheet(context),
        ),
        _FilterIconButton(
          icon: Icons.grid_view,
          isActive: groupOption != GroupOption.defaultOption,
          semanticLabel: groupOption != GroupOption.defaultOption
              ? 'グループ化（${groupOption.displayName}）'
              : 'グループ化',
          color: appColors.foreground,
          onTap: () => _showGroupBottomSheet(context),
        ),
      ],
    );
  }
}

class _FilterIconButton extends StatelessWidget {
  const _FilterIconButton({
    required this.icon,
    required this.isActive,
    required this.semanticLabel,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final bool isActive;
  final String semanticLabel;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconTapArea(
          icon: icon,
          onTap: onTap,
          color: color,
          semanticLabel: semanticLabel,
        ),
        if (isActive)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}

/// ソート選択用の BottomSheet
class _SortBottomSheet extends StatelessWidget {
  const _SortBottomSheet({
    required this.currentOption,
  });

  final SortOption currentOption;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return BaseBottomSheet(
      title: '並び替え',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: SortOption.values.map((option) {
          final isSelected = option == currentOption;
          return _OptionTile(
            label: option.displayName,
            isSelected: isSelected,
            onTap: () => Navigator.of(context).pop(option),
            colors: colors,
            theme: theme,
          );
        }).toList(),
      ),
    );
  }
}

/// グループ化選択用の BottomSheet
class _GroupBottomSheet extends StatelessWidget {
  const _GroupBottomSheet({
    required this.currentOption,
  });

  final GroupOption currentOption;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return BaseBottomSheet(
      title: 'グループ化',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: GroupOption.values.map((option) {
          final isSelected = option == currentOption;
          return _OptionTile(
            label: option.displayName,
            isSelected: isSelected,
            onTap: () => Navigator.of(context).pop(option),
            colors: colors,
            theme: theme,
          );
        }).toList(),
      ),
    );
  }
}

/// 選択肢タイル（共通）
class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.colors,
    required this.theme,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final AppColors? colors;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: Icon(
        isSelected ? Icons.check_circle : Icons.circle_outlined,
        color: isSelected
            ? colors?.accent ?? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant,
      ),
      title: Text(
        label,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}

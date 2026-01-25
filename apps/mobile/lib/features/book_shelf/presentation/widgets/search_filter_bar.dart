import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

/// フィルターバーコンポーネント
///
/// 本棚画面で使用するソートドロップダウン、
/// グループ化ドロップダウンを横並びで配置する。
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Row(
      children: [
        _buildSortButton(context, appColors),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _buildGroupDropdown(theme, appColors),
        ),
      ],
    );
  }

  Widget _buildSortButton(BuildContext context, AppColors appColors) {
    return GestureDetector(
      onTap: () => _showSortBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: appColors.surfaceElevated,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: appColors.textSecondary.withOpacity(0.3),
          ),
        ),
        child: Icon(
          Icons.tune,
          size: 20,
          color: appColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildGroupDropdown(ThemeData theme, AppColors appColors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: appColors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: appColors.textSecondary.withOpacity(0.3),
        ),
      ),
      child: DropdownButton<GroupOption>(
        value: groupOption,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: appColors.surfaceElevated,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: appColors.textSecondary,
        ),
        style: theme.textTheme.bodySmall?.copyWith(
          color: appColors.textPrimary,
        ),
        selectedItemBuilder: (context) {
          return GroupOption.values.map((option) {
            return Row(
              children: [
                Icon(
                  Icons.grid_view,
                  size: 18,
                  color: appColors.textPrimary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    option.displayName,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          }).toList();
        },
        items: GroupOption.values.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(
              option.displayName,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (option) {
          if (option != null) {
            onGroupChanged(option);
          }
        },
      ),
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
          return _buildOptionTile(
            context: context,
            option: option,
            isSelected: isSelected,
            colors: colors,
            theme: theme,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required SortOption option,
    required bool isSelected,
    required AppColors? colors,
    required ThemeData theme,
  }) {
    return ListTile(
      onTap: () => Navigator.of(context).pop(option),
      dense: true,
      visualDensity: VisualDensity.compact,
      leading: Icon(
        isSelected ? Icons.check_circle : Icons.circle_outlined,
        color: isSelected
            ? colors?.brandPrimary ?? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant,
      ),
      title: Text(
        option.displayName,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return _buildFilterRow(theme, appColors);
  }

  Widget _buildFilterRow(ThemeData theme, AppColors appColors) {
    return Row(
      children: [
        Expanded(
          child: _buildSortDropdown(theme, appColors),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _buildGroupDropdown(theme, appColors),
        ),
      ],
    );
  }

  Widget _buildSortDropdown(ThemeData theme, AppColors appColors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: appColors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: DropdownButton<SortOption>(
        value: sortOption,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: appColors.surfaceElevated,
        icon: Icon(
          Icons.arrow_drop_down,
          color: appColors.textSecondary,
        ),
        style: theme.textTheme.bodySmall?.copyWith(
          color: appColors.textPrimary,
        ),
        items: SortOption.values.map((option) {
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
            onSortChanged(option);
          }
        },
      ),
    );
  }

  Widget _buildGroupDropdown(ThemeData theme, AppColors appColors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: appColors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: DropdownButton<GroupOption>(
        value: groupOption,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: appColors.surfaceElevated,
        icon: Icon(
          Icons.arrow_drop_down,
          color: appColors.textSecondary,
        ),
        style: theme.textTheme.bodySmall?.copyWith(
          color: appColors.textPrimary,
        ),
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

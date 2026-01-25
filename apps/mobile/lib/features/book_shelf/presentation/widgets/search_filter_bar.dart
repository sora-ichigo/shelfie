import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/theme/app_typography.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

/// フィルターバーコンポーネント
///
/// 本棚画面で使用するソートドロップダウン、
/// グループ化ドロップダウンを横並びで配置する。
class SearchFilterBar extends StatefulWidget {
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
  State<SearchFilterBar> createState() => _SearchFilterBarState();
}

class _SearchFilterBarState extends State<SearchFilterBar> {
  bool _isSortMenuOpen = false;

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
          flex: 11,
          child: _buildSortDropdown(theme, appColors),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          flex: 9,
          child: _buildGroupDropdown(theme, appColors),
        ),
      ],
    );
  }

  Widget _buildSortDropdown(ThemeData theme, AppColors appColors) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final buttonWidth = constraints.maxWidth;
        return PopupMenuButton<SortOption>(
          onSelected: (option) {
            setState(() => _isSortMenuOpen = false);
            widget.onSortChanged(option);
          },
          onOpened: () => setState(() => _isSortMenuOpen = true),
          onCanceled: () => setState(() => _isSortMenuOpen = false),
          offset: const Offset(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          color: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          menuPadding: EdgeInsets.zero,
          constraints: BoxConstraints(
            minWidth: buttonWidth,
            maxWidth: buttonWidth,
          ),
          itemBuilder: (context) {
            final options = SortOption.values;
            return options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final isSelected = option == widget.sortOption;
              final isFirst = index == 0;
              final isLast = index == options.length - 1;
              return PopupMenuItem<SortOption>(
                value: option,
                padding: EdgeInsets.zero,
                height: 40,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.selectionHighlight
                        : appColors.surfaceElevated,
                    borderRadius: BorderRadius.only(
                      topLeft: isFirst
                          ? const Radius.circular(AppRadius.lg)
                          : Radius.zero,
                      topRight: isFirst
                          ? const Radius.circular(AppRadius.lg)
                          : Radius.zero,
                      bottomLeft: isLast
                          ? const Radius.circular(AppRadius.lg)
                          : Radius.zero,
                      bottomRight: isLast
                          ? const Radius.circular(AppRadius.lg)
                          : Radius.zero,
                    ),
                  ),
                  child: Text(
                    option.displayName,
                    style: AppTypography.labelMedium.copyWith(
                      color: appColors.textPrimary,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: appColors.surfaceElevated,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.tune,
                  size: 16,
                  color: appColors.textPrimary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    widget.sortOption.displayName,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.labelMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  _isSortMenuOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: appColors.textSecondary,
                ),
              ],
            ),
          ),
        );
      },
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
        value: widget.groupOption,
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
            widget.onGroupChanged(option);
          }
        },
      ),
    );
  }
}

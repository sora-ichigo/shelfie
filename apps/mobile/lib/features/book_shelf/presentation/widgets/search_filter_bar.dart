import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

/// 検索・フィルターバーコンポーネント
///
/// 本棚画面で使用する検索バー、ソートドロップダウン、
/// グループ化ドロップダウンを横並びで配置する。
class SearchFilterBar extends StatefulWidget {
  const SearchFilterBar({
    required this.sortOption,
    required this.groupOption,
    required this.onSearchChanged,
    required this.onSortChanged,
    required this.onGroupChanged,
    super.key,
  });

  final SortOption sortOption;
  final GroupOption groupOption;
  final void Function(String) onSearchChanged;
  final void Function(SortOption) onSortChanged;
  final void Function(GroupOption) onGroupChanged;

  @override
  State<SearchFilterBar> createState() => _SearchFilterBarState();
}

class _SearchFilterBarState extends State<SearchFilterBar> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchTextChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      widget.onSearchChanged(value);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _debounceTimer?.cancel();
    widget.onSearchChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSearchBar(theme, appColors),
        const SizedBox(height: AppSpacing.sm),
        _buildFilterRow(theme, appColors),
      ],
    );
  }

  Widget _buildSearchBar(ThemeData theme, AppColors appColors) {
    return TextField(
      controller: _searchController,
      onChanged: _onSearchTextChanged,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: appColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: '本を検索...',
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: appColors.textSecondary,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: appColors.textSecondary,
        ),
        suffixIcon: ListenableBuilder(
          listenable: _searchController,
          builder: (context, child) {
            if (_searchController.text.isEmpty) {
              return const SizedBox.shrink();
            }
            return IconButton(
              icon: Icon(
                Icons.clear,
                color: appColors.textSecondary,
              ),
              onPressed: _clearSearch,
            );
          },
        ),
        filled: true,
        fillColor: appColors.surfaceElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
    );
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
        value: widget.sortOption,
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
            widget.onSortChanged(option);
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
        value: widget.groupOption,
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
            widget.onGroupChanged(option);
          }
        },
      ),
    );
  }
}

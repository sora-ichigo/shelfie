import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';

class ReadingStatusChips extends StatelessWidget {
  const ReadingStatusChips({
    required this.selectedFilter,
    required this.onFilterChanged,
    super.key,
  });

  final ReadingStatus? selectedFilter;
  final ValueChanged<ReadingStatus?> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        children: [
          _Chip(
            label: 'すべて',
            isSelected: selectedFilter == null,
            onTap: () => onFilterChanged(null),
          ),
          const SizedBox(width: AppSpacing.xs),
          ...ReadingStatus.values.map(
            (status) => Padding(
              padding: const EdgeInsets.only(right: AppSpacing.xs),
              child: _Chip(
                label: status.displayName,
                isSelected: selectedFilter == status,
                onTap: () => onFilterChanged(status),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        decoration: BoxDecoration(
          color: isSelected ? appColors.primary : appColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? Colors.white : appColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

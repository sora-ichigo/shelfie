import 'package:flutter/material.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

/// 読書記録セクション
///
/// 読書状態、追加日、読了日を表示する。
class ReadingRecordSection extends StatelessWidget {
  const ReadingRecordSection({
    required this.shelfEntry,
    required this.onStatusTap,
    super.key,
  });

  final ShelfEntry shelfEntry;
  final VoidCallback onStatusTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: AppSpacing.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '読書記録',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildRecordTable(context),
        ],
      ),
    );
  }

  Widget _buildRecordTable(BuildContext context) {
    final hasCompletedDate =
        shelfEntry.isCompleted && shelfEntry.completedAt != null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          _buildTableRow(
            context,
            label: '読書状態',
            value: shelfEntry.readingStatus.displayName,
            onTap: onStatusTap,
            position: _RowPosition.first,
          ),
          _buildTableRow(
            context,
            label: '追加日',
            value: _formatDate(shelfEntry.addedAt),
            position: hasCompletedDate ? _RowPosition.middle : _RowPosition.last,
          ),
          if (hasCompletedDate)
            _buildTableRow(
              context,
              label: '読了日',
              value: _formatDate(shelfEntry.completedAt!),
              position: _RowPosition.last,
            ),
        ],
      ),
    );
  }

  Widget _buildTableRow(
    BuildContext context, {
    required String label,
    required String value,
    required _RowPosition position,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    final borderRadius = switch (position) {
      _RowPosition.first => const BorderRadius.vertical(top: Radius.circular(8)),
      _RowPosition.middle => BorderRadius.zero,
      _RowPosition.last => const BorderRadius.vertical(bottom: Radius.circular(8)),
    };

    final border = switch (position) {
      _RowPosition.first || _RowPosition.middle => Border(
          left: BorderSide(color: theme.colorScheme.outline.withOpacity(0.3)),
          right: BorderSide(color: theme.colorScheme.outline.withOpacity(0.3)),
          top: BorderSide(color: theme.colorScheme.outline.withOpacity(0.3)),
        ),
      _RowPosition.last => Border.all(
          color: theme.colorScheme.outline.withOpacity(0.3),
        ),
    };

    final content = Container(
      padding: AppSpacing.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.4),
        borderRadius: borderRadius,
        border: border,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }

  String _formatDate(DateTime date) {
    return '${date.year}年${date.month}月${date.day}日';
  }
}

enum _RowPosition { first, middle, last }

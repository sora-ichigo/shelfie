import 'package:flutter/material.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';

/// 読書記録セクション
///
/// 読書状態、追加日、読了日を表示する。
class ReadingRecordSection extends StatelessWidget {
  const ReadingRecordSection({
    required this.shelfEntry,
    required this.onStatusTap,
    required this.onRatingTap,
    super.key,
  });

  final ShelfEntry shelfEntry;
  final VoidCallback onStatusTap;
  final VoidCallback onRatingTap;

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
            valueWidget: _buildStatusTag(context, shelfEntry.readingStatus),
            onTap: onStatusTap,
            position: _RowPosition.first,
          ),
          _buildTableRow(
            context,
            label: '評価',
            valueWidget: _buildRatingDisplay(context, shelfEntry.rating),
            onTap: onRatingTap,
            position: _RowPosition.middle,
          ),
          _buildTableRow(
            context,
            label: '追加日',
            value: _formatDate(shelfEntry.addedAt),
            position:
                hasCompletedDate ? _RowPosition.middle : _RowPosition.last,
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
    String? value,
    Widget? valueWidget,
    required _RowPosition position,
    VoidCallback? onTap,
    bool showChevron = true,
  }) {
    final theme = Theme.of(context);

    final borderRadius = switch (position) {
      _RowPosition.first =>
        const BorderRadius.vertical(top: Radius.circular(8)),
      _RowPosition.middle => BorderRadius.zero,
      _RowPosition.last =>
        const BorderRadius.vertical(bottom: Radius.circular(8)),
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
              if (valueWidget != null)
                valueWidget
              else if (value != null)
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (onTap != null && showChevron) ...[
                const SizedBox(width: AppSpacing.xs),
                Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
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

  Widget _buildStatusTag(BuildContext context, ReadingStatus status) {
    final color = _getStatusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(36),
        border: Border.all(
          color: color.withOpacity(0.5),
        ),
      ),
      child: Text(
        status.displayName,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildRatingDisplay(BuildContext context, int? rating) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    if (rating == null) {
      return Text(
        '未評価',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final isFilled = index < rating;
        return Icon(
          isFilled ? Icons.star : Icons.star_border,
          size: 18,
          color: isFilled
              ? appColors.brandAccent
              : theme.colorScheme.onSurfaceVariant.withOpacity(0.3),
        );
      }),
    );
  }

  Color _getStatusColor(ReadingStatus status) {
    return switch (status) {
      ReadingStatus.backlog => const Color(0xFFFFB74D),
      ReadingStatus.reading => const Color(0xFF64B5F6),
      ReadingStatus.completed => const Color(0xFF81C784),
      ReadingStatus.dropped => const Color(0xFF90A4AE),
    };
  }

  String _formatDate(DateTime date) {
    return '${date.year}年${date.month}月${date.day}日';
  }
}

enum _RowPosition { first, middle, last }

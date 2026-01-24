import 'package:flutter/material.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';

/// 読書記録セクション
///
/// 読書状態、追加日、読了日、メモを表示する。
class ReadingRecordSection extends StatelessWidget {
  const ReadingRecordSection({
    required this.shelfEntry,
    required this.onStatusTap,
    required this.onNoteTap,
    super.key,
  });

  final ShelfEntry shelfEntry;
  final VoidCallback onStatusTap;
  final VoidCallback onNoteTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '読書記録',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildStatusField(context),
        const SizedBox(height: AppSpacing.sm),
        _buildAddedDateField(context),
        if (shelfEntry.isCompleted && shelfEntry.completedAt != null) ...[
          const SizedBox(height: AppSpacing.sm),
          _buildCompletedDateField(context),
        ],
        const SizedBox(height: AppSpacing.md),
        _buildNoteField(context),
      ],
    );
  }

  Widget _buildStatusField(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onStatusTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: AppSpacing.all(AppSpacing.sm),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  _getStatusIcon(shelfEntry.readingStatus),
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '読書状態',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  shelfEntry.readingStatus.displayName,
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
      ),
    );
  }

  Widget _buildAddedDateField(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: AppSpacing.horizontal(AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '追加日',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            _formatDate(shelfEntry.addedAt),
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedDateField(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: AppSpacing.horizontal(AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '読了日',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            _formatDate(shelfEntry.completedAt!),
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildNoteField(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onNoteTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: AppSpacing.all(AppSpacing.sm),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.note_alt_outlined,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      '読書メモ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            if (shelfEntry.hasNote) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                shelfEntry.note!,
                style: theme.textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (shelfEntry.noteUpdatedAt != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                '最終更新: ${_formatDateTime(shelfEntry.noteUpdatedAt!)}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon(ReadingStatus status) {
    return switch (status) {
      ReadingStatus.backlog => Icons.bookmark_outline,
      ReadingStatus.reading => Icons.auto_stories,
      ReadingStatus.completed => Icons.check_circle_outline,
      ReadingStatus.dropped => Icons.cancel_outlined,
    };
  }

  String _formatDate(DateTime date) {
    return '${date.year}年${date.month.toString().padLeft(2, '0')}月${date.day.toString().padLeft(2, '0')}日';
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

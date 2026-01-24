import 'package:flutter/material.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

/// 読書メモセクション
///
/// 読書メモの内容と最終更新日時を表示する。
class ReadingNoteSection extends StatelessWidget {
  const ReadingNoteSection({
    required this.shelfEntry,
    required this.onNoteTap,
    super.key,
  });

  final ShelfEntry shelfEntry;
  final VoidCallback onNoteTap;

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
            '読書メモ',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildNoteContent(context),
          if (shelfEntry.noteUpdatedAt != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              '最終更新: ${_formatDateTime(shelfEntry.noteUpdatedAt!)}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNoteContent(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onNoteTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: AppSpacing.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                shelfEntry.hasNote ? shelfEntry.note! : 'メモを追加...',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: shelfEntry.hasNote
                      ? null
                      : theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}年${dateTime.month}月${dateTime.day}日 ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

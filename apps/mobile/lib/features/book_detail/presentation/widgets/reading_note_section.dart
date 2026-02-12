import 'package:flutter/material.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/theme/app_colors.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('自分メモ', style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        _buildNoteContent(context),
        if (shelfEntry.noteUpdatedAt != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            '最終更新: ${_formatDateTime(shelfEntry.noteUpdatedAt!)}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.extension<AppColors>()!.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNoteContent(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return InkWell(
      onTap: onNoteTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: AppSpacing.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: appColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: appColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                shelfEntry.hasNote ? shelfEntry.note! : '自分用のメモを書く...',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: shelfEntry.hasNote ? null : appColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(Icons.chevron_right, color: appColors.textSecondary),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}年${dateTime.month}月${dateTime.day}日 ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

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
        Row(
          children: [
            Text('自分メモ', style: theme.textTheme.titleMedium),
            const SizedBox(width: AppSpacing.xs),
            Icon(
              Icons.lock,
              size: 16,
              color: theme.extension<AppColors>()!.textSecondaryLegacy,
            ),
            const SizedBox(width: 2),
            Text(
              '自分のみ見ることができます',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.extension<AppColors>()!.textSecondaryLegacy,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildNoteContent(context),
        if (shelfEntry.noteUpdatedAt != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            '最終更新: ${_formatDateTime(shelfEntry.noteUpdatedAt!)}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.extension<AppColors>()!.textSecondaryLegacy,
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
          color: appColors.surfaceLegacy,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: appColors.borderLegacy),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                shelfEntry.hasNote ? shelfEntry.note! : '自分用のメモを書く...',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: shelfEntry.hasNote ? null : appColors.textSecondaryLegacy,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(Icons.chevron_right, color: appColors.textSecondaryLegacy),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}年${dateTime.month}月${dateTime.day}日 ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

import 'package:flutter/material.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

/// 感想セクション
///
/// 感想の内容と最終更新日時を表示する。
class ThoughtsSection extends StatelessWidget {
  const ThoughtsSection({
    required this.shelfEntry,
    required this.onThoughtsTap,
    super.key,
  });

  final ShelfEntry shelfEntry;
  final VoidCallback onThoughtsTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('感想', style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        _buildThoughtsContent(context),
        if (shelfEntry.thoughtsUpdatedAt != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            '最終更新: ${_formatDateTime(shelfEntry.thoughtsUpdatedAt!)}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.extension<AppColors>()!.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildThoughtsContent(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return InkWell(
      onTap: onThoughtsTap,
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
                shelfEntry.hasThoughts ? shelfEntry.thoughts! : '読んだ感想を書く...',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: shelfEntry.hasThoughts
                      ? null
                      : appColors.textSecondary,
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

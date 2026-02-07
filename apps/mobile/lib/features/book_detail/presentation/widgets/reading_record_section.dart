import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';

/// 読書記録セクション
///
/// 読書状態、追加日、読了日を表示する。
class ReadingRecordSection extends StatelessWidget {
  const ReadingRecordSection({
    required this.shelfEntry,
    required this.onStatusTap,
    required this.onRatingTap,
    this.onCompletedAtTap,
    this.onStartedAtTap,
    super.key,
  });

  final ShelfEntry shelfEntry;
  final VoidCallback onStatusTap;
  final VoidCallback onRatingTap;
  final ValueChanged<DateTime>? onCompletedAtTap;
  final ValueChanged<DateTime>? onStartedAtTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '読書記録',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildRecordTable(context),
      ],
    );
  }

  Widget _buildRecordTable(BuildContext context) {
    final showStartedDate =
        shelfEntry.startedAt != null || onStartedAtTap != null;
    final hasCompletedDate =
        shelfEntry.isCompleted && shelfEntry.completedAt != null;
    final isLastRow =
        !showStartedDate && !hasCompletedDate;

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
            position: isLastRow ? _RowPosition.last : _RowPosition.middle,
          ),
          if (showStartedDate)
            _buildTableRow(
              context,
              label: '読書開始日',
              value: shelfEntry.startedAt != null
                  ? _formatDate(shelfEntry.startedAt!)
                  : '未設定',
              position:
                  hasCompletedDate ? _RowPosition.middle : _RowPosition.last,
              onTap: onStartedAtTap != null
                  ? () => _showStartedAtPicker(context)
                  : null,
            ),
          if (hasCompletedDate)
            _buildTableRow(
              context,
              label: '読了日',
              value: _formatDate(shelfEntry.completedAt!),
              position: _RowPosition.last,
              onTap: onCompletedAtTap != null
                  ? () => _showCompletedAtPicker(context)
                  : null,
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

    final appColors = theme.extension<AppColors>()!;

    final border = switch (position) {
      _RowPosition.first || _RowPosition.middle => Border(
          left: BorderSide(color: appColors.border),
          right: BorderSide(color: appColors.border),
          top: BorderSide(color: appColors.border),
        ),
      _RowPosition.last => Border.all(
          color: appColors.border,
        ),
    };

    final content = Container(
      padding: AppSpacing.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: borderRadius,
        border: border,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appColors.textSecondary,
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
                  color: appColors.textSecondary,
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
          isFilled ? Icons.star_rounded : Icons.star_border_rounded,
          size: 18,
          color: isFilled
              ? appColors.star
              : appColors.inactive,
        );
      }),
    );
  }

  Color _getStatusColor(ReadingStatus status) {
    return switch (status) {
      ReadingStatus.backlog => const Color(0xFFFFB74D),
      ReadingStatus.reading => const Color(0xFF64B5F6),
      ReadingStatus.completed => const Color(0xFF81C784),
      ReadingStatus.interested => const Color(0xFFE091D6),
    };
  }

  Future<void> _showCompletedAtPicker(BuildContext context) async {
    final initialDate = shelfEntry.completedAt ?? DateTime.now();
    final selectedDate = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _DatePickerSheet(
        title: '読了日を変更',
        initialDate: initialDate,
        lastDate: DateTime.now(),
      ),
    );

    if (selectedDate != null) {
      onCompletedAtTap?.call(
        DateTime.utc(selectedDate.year, selectedDate.month, selectedDate.day),
      );
    }
  }

  Future<void> _showStartedAtPicker(BuildContext context) async {
    final initialDate = shelfEntry.startedAt ?? DateTime.now();
    final selectedDate = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _DatePickerSheet(
        title: shelfEntry.startedAt != null ? '読書開始日を変更' : '読書開始日を設定',
        initialDate: initialDate,
        lastDate: DateTime.now(),
      ),
    );

    if (selectedDate != null) {
      onStartedAtTap?.call(
        DateTime.utc(selectedDate.year, selectedDate.month, selectedDate.day),
      );
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}年${date.month}月${date.day}日';
  }
}

enum _RowPosition { first, middle, last }

class _DatePickerSheet extends StatefulWidget {
  const _DatePickerSheet({
    required this.title,
    required this.initialDate,
    required this.lastDate,
  });

  final String title;
  final DateTime initialDate;
  final DateTime lastDate;

  @override
  State<_DatePickerSheet> createState() => _DatePickerSheetState();
}

class _DatePickerSheetState extends State<_DatePickerSheet> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return BaseBottomSheet(
      title: widget.title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 216,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _selectedDate,
              minimumDate: DateTime(2000),
              maximumDate: widget.lastDate,
              onDateTimeChanged: (date) {
                _selectedDate = date;
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                    ),
                    child: const Text('キャンセル'),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: appColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, _selectedDate),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                      ),
                      child: const Text('決定'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

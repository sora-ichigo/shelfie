import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';

/// 読書状態選択モーダルを表示する
///
/// [context] - BuildContext
/// [currentStatus] - 現在の読書状態
/// [userBookId] - ユーザー本ID
/// [externalId] - 外部ID（BookDetailNotifier のパラメータ）
Future<void> showReadingStatusModal({
  required BuildContext context,
  required ReadingStatus currentStatus,
  required int userBookId,
  required String externalId,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => _ReadingStatusModalContent(
      currentStatus: currentStatus,
      userBookId: userBookId,
      externalId: externalId,
    ),
  );
}

class _ReadingStatusModalContent extends ConsumerStatefulWidget {
  const _ReadingStatusModalContent({
    required this.currentStatus,
    required this.userBookId,
    required this.externalId,
  });

  final ReadingStatus currentStatus;
  final int userBookId;
  final String externalId;

  @override
  ConsumerState<_ReadingStatusModalContent> createState() =>
      _ReadingStatusModalContentState();
}

class _ReadingStatusModalContentState
    extends ConsumerState<_ReadingStatusModalContent> {
  late ReadingStatus _selectedStatus;
  bool _isSaving = false;
  Failure? _error;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.currentStatus;
  }

  bool get _hasChanges => _selectedStatus != widget.currentStatus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceModal,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: AppSpacing.all(AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDragHandle(theme),
              const SizedBox(height: AppSpacing.md),
              Text(
                '読書状態を変更',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildStatusGrid(theme),
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _error!.userMessage,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              _buildActionButtons(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDragHandle(ThemeData theme) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildStatusGrid(ThemeData theme) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatusButton(theme, ReadingStatus.backlog),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _buildStatusButton(theme, ReadingStatus.reading),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _buildStatusButton(theme, ReadingStatus.completed),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _buildStatusButton(theme, ReadingStatus.dropped),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusButton(ThemeData theme, ReadingStatus status) {
    final isSelected = _selectedStatus == status;

    return InkWell(
      onTap: _isSaving
          ? null
          : () {
              setState(() {
                _selectedStatus = status;
                _error = null;
              });
            },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.5)
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? AppColors.primary : Colors.white.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            status.displayName,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF99A1AF),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: _isSaving ? null : () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('キャンセル'),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _buildPrimaryButton(),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton() {
    final isEnabled = _hasChanges && !_isSaving;

    return SizedBox(
      height: 48,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.actionGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton(
          onPressed: isEnabled ? _onSave : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            disabledForegroundColor: Colors.white.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: _isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('保存'),
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    setState(() {
      _isSaving = true;
      _error = null;
    });

    final notifier =
        ref.read(bookDetailNotifierProvider(widget.externalId).notifier);
    final result = await notifier.updateReadingStatus(
      userBookId: widget.userBookId,
      status: _selectedStatus,
    );

    result.fold(
      (failure) {
        if (mounted) {
          setState(() {
            _isSaving = false;
            _error = failure;
          });
        }
      },
      (_) {
        if (mounted) {
          Navigator.pop(context);
        }
      },
    );
  }
}

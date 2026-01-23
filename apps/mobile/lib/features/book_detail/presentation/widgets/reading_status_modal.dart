import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/error/failure.dart';
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

    return SafeArea(
      child: Padding(
        padding: AppSpacing.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '読書状態を選択',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ...ReadingStatus.values.map(_buildRadioTile),
            if (_error != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                _error!.userMessage,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isSaving ? null : () => Navigator.pop(context),
                  child: const Text('キャンセル'),
                ),
                const SizedBox(width: AppSpacing.sm),
                ElevatedButton(
                  onPressed: _hasChanges && !_isSaving ? _onSave : null,
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('保存'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioTile(ReadingStatus status) {
    return RadioListTile<ReadingStatus>(
      value: status,
      groupValue: _selectedStatus,
      onChanged: _isSaving
          ? null
          : (value) {
              if (value != null) {
                setState(() {
                  _selectedStatus = value;
                  _error = null;
                });
              }
            },
      title: Text(status.displayName),
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

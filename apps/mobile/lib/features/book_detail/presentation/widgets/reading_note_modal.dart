import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';

/// 読書メモ編集モーダルを表示する
///
/// [context] - BuildContext
/// [currentNote] - 現在のメモ（既存メモがある場合）
/// [userBookId] - ユーザー本ID
/// [externalId] - 外部ID（BookDetailNotifier のパラメータ）
Future<void> showReadingNoteModal({
  required BuildContext context,
  required String? currentNote,
  required int userBookId,
  required String externalId,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: _ReadingNoteModalContent(
        currentNote: currentNote,
        userBookId: userBookId,
        externalId: externalId,
      ),
    ),
  );
}

class _ReadingNoteModalContent extends ConsumerStatefulWidget {
  const _ReadingNoteModalContent({
    required this.currentNote,
    required this.userBookId,
    required this.externalId,
  });

  final String? currentNote;
  final int userBookId;
  final String externalId;

  @override
  ConsumerState<_ReadingNoteModalContent> createState() =>
      _ReadingNoteModalContentState();
}

class _ReadingNoteModalContentState
    extends ConsumerState<_ReadingNoteModalContent> {
  late TextEditingController _controller;
  bool _isSaving = false;
  Failure? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentNote ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              '読書メモ',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _controller,
              maxLines: 6,
              minLines: 3,
              decoration: InputDecoration(
                hintText: 'メモを入力...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: AppSpacing.all(AppSpacing.sm),
              ),
              enabled: !_isSaving,
            ),
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
                  onPressed: _isSaving ? null : _onSave,
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

  Future<void> _onSave() async {
    setState(() {
      _isSaving = true;
      _error = null;
    });

    final notifier =
        ref.read(bookDetailNotifierProvider(widget.externalId).notifier);
    final result = await notifier.updateReadingNote(
      userBookId: widget.userBookId,
      note: _controller.text,
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

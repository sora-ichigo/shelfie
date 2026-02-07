import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';
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
  final appColors = Theme.of(context).extension<AppColors>()!;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: appColors.surface,
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

    return BaseBottomSheet(
      title: '読書メモを編集',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            maxLines: 6,
            minLines: 3,
            decoration: InputDecoration(
              hintText: 'この本の感想を書く...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).extension<AppColors>()!.primary,
                ),
              ),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest,
              contentPadding: AppSpacing.all(AppSpacing.md),
            ),
            enabled: !_isSaving,
          ),
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
                backgroundColor: theme.extension<AppColors>()!.surfaceElevated,
                foregroundColor: theme.extension<AppColors>()!.textPrimary,
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
    final appColors = Theme.of(context).extension<AppColors>()!;

    return SizedBox(
      height: 48,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: appColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton(
          onPressed: _isSaving ? null : _onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            foregroundColor: appColors.textPrimary,
            disabledForegroundColor: appColors.textPrimary.withOpacity(0.5),
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
          AdaptiveSnackBar.show(
            context,
            message: 'メモを保存しました',
            type: AdaptiveSnackBarType.success,
          );
          Navigator.pop(context);
        }
      },
    );
  }
}

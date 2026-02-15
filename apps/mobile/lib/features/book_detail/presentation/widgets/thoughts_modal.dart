import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/app_snack_bar.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';

/// 感想編集モーダルを表示する
Future<void> showThoughtsModal({
  required BuildContext context,
  required String? currentThoughts,
  required int userBookId,
  required String externalId,
}) async {
  final appColors = Theme.of(context).extension<AppColors>()!;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: appColors.surfaceLegacy,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: _ThoughtsModalContent(
        currentThoughts: currentThoughts,
        userBookId: userBookId,
        externalId: externalId,
      ),
    ),
  );
}

class _ThoughtsModalContent extends ConsumerStatefulWidget {
  const _ThoughtsModalContent({
    required this.currentThoughts,
    required this.userBookId,
    required this.externalId,
  });

  final String? currentThoughts;
  final int userBookId;
  final String externalId;

  @override
  ConsumerState<_ThoughtsModalContent> createState() =>
      _ThoughtsModalContentState();
}

class _ThoughtsModalContentState
    extends ConsumerState<_ThoughtsModalContent> {
  late TextEditingController _controller;
  bool _isSaving = false;
  Failure? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentThoughts ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return BaseBottomSheet(
      title: '感想を編集',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            maxLines: 6,
            minLines: 3,
            style: TextStyle(color: appColors.textPrimaryLegacy),
            cursorColor: appColors.primaryLegacy,
            decoration: InputDecoration(
              hintText: '読んだ感想を書く...',
              hintStyle: TextStyle(color: appColors.inactiveLegacy),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: appColors.borderLegacy),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: appColors.borderLegacy),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: appColors.primaryLegacy),
              ),
              filled: true,
              fillColor: appColors.surfaceElevatedLegacy,
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
                  color: appColors.destructiveLegacy,
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
                backgroundColor: theme.extension<AppColors>()!.surfaceElevatedLegacy,
                foregroundColor: theme.extension<AppColors>()!.textPrimaryLegacy,
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
          color: appColors.primaryLegacy,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton(
          onPressed: _isSaving ? null : _onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            foregroundColor: appColors.textPrimaryLegacy,
            disabledForegroundColor: appColors.textPrimaryLegacy.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: _isSaving
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: appColors.textPrimaryLegacy,
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
    final result = await notifier.updateThoughts(
      userBookId: widget.userBookId,
      thoughts: _controller.text,
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
          AppSnackBar.show(
            context,
            message: '感想を保存しました',
            type: AppSnackBarType.success,
          );
          Navigator.pop(context);
        }
      },
    );
  }
}

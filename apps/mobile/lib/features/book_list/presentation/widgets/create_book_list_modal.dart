import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/app_snack_bar.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';
import 'package:shelfie/features/book_list/application/book_list_notifier.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

Future<BookList?> showCreateBookListModal({
  required BuildContext context,
  required int existingCount,
}) async {
  final appColors = Theme.of(context).extension<AppColors>()!;
  return showModalBottomSheet<BookList>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: appColors.surfaceLegacy,
    builder: (context) =>
        _CreateBookListModalContent(existingCount: existingCount),
  );
}

class _CreateBookListModalContent extends ConsumerStatefulWidget {
  const _CreateBookListModalContent({required this.existingCount});

  final int existingCount;

  @override
  ConsumerState<_CreateBookListModalContent> createState() =>
      _CreateBookListModalContentState();
}

class _CreateBookListModalContentState
    extends ConsumerState<_CreateBookListModalContent> {
  late final TextEditingController _controller;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final initialText = 'ブックリスト#${widget.existingCount + 1}';
    _controller = TextEditingController(text: initialText);
    _controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: initialText.length,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isValid => _controller.text.trim().isNotEmpty;

  Future<void> _onSubmit() async {
    if (!_isValid || _isSubmitting) return;

    setState(() => _isSubmitting = true);

    final result = await ref
        .read(bookListNotifierProvider.notifier)
        .createList(title: _controller.text.trim());

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() => _isSubmitting = false);
        AppSnackBar.show(
          context,
          message: failure.userMessage,
          type: AppSnackBarType.error,
        );
      },
      (bookList) {
        Navigator.of(context).pop(bookList);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: BaseBottomSheet(
        title: 'ブックリストを作成',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'ブックリストに名前をつけてください',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: appColors.textSecondaryLegacy,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final hintString = 'ブックリスト#${widget.existingCount + 1}';
                  final isEmpty = _controller.text.isEmpty;
                  final baseStyle = theme.textTheme.headlineSmall!;
                  final baseFontSize = baseStyle.fontSize!;
                  const minFontSize = 14.0;
                  const contentPadding = 8.0;
                  final availableWidth =
                      constraints.maxWidth - contentPadding * 2;

                  var fontSize = baseFontSize;
                  var hintPadding = contentPadding;

                  if (isEmpty) {
                    final tp = TextPainter(
                      text: TextSpan(text: hintString, style: baseStyle),
                      textDirection: TextDirection.ltr,
                    )..layout();
                    hintPadding = math.max(
                      contentPadding,
                      (constraints.maxWidth - tp.width) / 2,
                    );
                  } else {
                    final tp = TextPainter(
                      text: TextSpan(text: _controller.text, style: baseStyle),
                      textDirection: TextDirection.ltr,
                    )..layout();
                    if (tp.width > availableWidth) {
                      fontSize = math.max(
                        minFontSize,
                        baseFontSize * (availableWidth / tp.width),
                      );
                    }
                  }

                  final textStyle = baseStyle.copyWith(fontSize: fontSize);

                  return TextFormField(
                    controller: _controller,
                    autofocus: true,
                    maxLength: 36,
                    textAlign: isEmpty ? TextAlign.left : TextAlign.center,
                    style: textStyle,
                    decoration: InputDecoration(
                      hintText: isEmpty ? hintString : null,
                      hintStyle: baseStyle.copyWith(
                        color: appColors.textSecondaryLegacy,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: isEmpty ? hintPadding : contentPadding,
                      ),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: appColors.borderLegacy,
                          width: 0.5,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: appColors.borderLegacy,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: appColors.primaryLegacy,
                          width: 0.5,
                        ),
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton(
              onPressed: _isValid ? _onSubmit : null,
              style: FilledButton.styleFrom(
                backgroundColor: appColors.textPrimaryLegacy,
                foregroundColor: appColors.backgroundLegacy,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 32,
                ),
              ),
              child: _isSubmitting
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: appColors.textPrimaryLegacy,
                      ),
                    )
                  : Text(
                      '作成する',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: appColors.backgroundLegacy,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

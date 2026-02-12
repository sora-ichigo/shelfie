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
    backgroundColor: appColors.surface,
    builder: (context) => _CreateBookListModalContent(
      existingCount: existingCount,
    ),
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
    _controller = TextEditingController(
      text: 'ブックリスト#${widget.existingCount + 1}',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ブックリストに名前をつけてください',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _controller,
              autofocus: true,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isValid ? _onSubmit : null,
                child: _isSubmitting
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: appColors.textPrimary,
                        ),
                      )
                    : const Text('作成する'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';

/// 評価選択モーダルを表示する
///
/// [context] - BuildContext
/// [currentRating] - 現在の評価（1-5, null で未評価）
/// [userBookId] - ユーザー本ID
/// [externalId] - 外部ID（BookDetailNotifier のパラメータ）
Future<void> showRatingModal({
  required BuildContext context,
  required int? currentRating,
  required int userBookId,
  required String externalId,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => _RatingModalContent(
      currentRating: currentRating,
      userBookId: userBookId,
      externalId: externalId,
    ),
  );
}

class _RatingModalContent extends ConsumerStatefulWidget {
  const _RatingModalContent({
    required this.currentRating,
    required this.userBookId,
    required this.externalId,
  });

  final int? currentRating;
  final int userBookId;
  final String externalId;

  @override
  ConsumerState<_RatingModalContent> createState() =>
      _RatingModalContentState();
}

class _RatingModalContentState extends ConsumerState<_RatingModalContent> {
  late int? _selectedRating;
  bool _isSaving = false;
  Failure? _error;

  @override
  void initState() {
    super.initState();
    _selectedRating = widget.currentRating;
  }

  bool get _hasChanges => _selectedRating != widget.currentRating;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseBottomSheet(
      title: '評価を変更',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStarRating(theme),
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

  Widget _buildStarRating(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        final isSelected = _selectedRating != null && _selectedRating! >= starValue;

        return GestureDetector(
          onTap: _isSaving
              ? null
              : () {
                  setState(() {
                    _selectedRating = starValue;
                    _error = null;
                  });
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Icon(
              isSelected ? Icons.star : Icons.star_border,
              size: 48,
              color: isSelected
                  ? const Color(0xFFFFD54F)
                  : theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
            ),
          ),
        );
      }),
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
    final isEnabled = _hasChanges && _selectedRating != null && !_isSaving;

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
    if (_selectedRating == null) return;

    setState(() {
      _isSaving = true;
      _error = null;
    });

    final notifier =
        ref.read(bookDetailNotifierProvider(widget.externalId).notifier);
    final result = await notifier.updateRating(
      userBookId: widget.userBookId,
      rating: _selectedRating!,
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

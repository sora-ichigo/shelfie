import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_icon_size.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';

/// 読書状態選択モーダルのモード
enum ReadingStatusModalMode {
  /// 既存の本の読書状態を変更するモード
  update,

  /// 新しく本を追加する際に読書状態を選択するモード
  addToShelf,
}

/// 読書状態選択モーダルを表示する（変更モード）
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
      mode: ReadingStatusModalMode.update,
      currentStatus: currentStatus,
      userBookId: userBookId,
      externalId: externalId,
    ),
  );
}

/// 読書状態選択モーダルを表示する（追加モード）
///
/// 選択された読書状態と任意の評価を返す。キャンセルされた場合は null を返す。
Future<({ReadingStatus status, int? rating})?> showAddToShelfModal({
  required BuildContext context,
}) async {
  return showModalBottomSheet<({ReadingStatus status, int? rating})>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (context) => const _ReadingStatusModalContent(
      mode: ReadingStatusModalMode.addToShelf,
      currentStatus: ReadingStatus.backlog,
    ),
  );
}

class _ReadingStatusModalContent extends ConsumerStatefulWidget {
  const _ReadingStatusModalContent({
    required this.mode,
    required this.currentStatus,
    this.userBookId,
    this.externalId,
  });

  final ReadingStatusModalMode mode;
  final ReadingStatus currentStatus;
  final int? userBookId;
  final String? externalId;

  @override
  ConsumerState<_ReadingStatusModalContent> createState() =>
      _ReadingStatusModalContentState();
}

class _ReadingStatusModalContentState
    extends ConsumerState<_ReadingStatusModalContent> {
  late ReadingStatus _selectedStatus;
  int? _selectedRating;
  bool _isSaving = false;
  Failure? _error;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.currentStatus;
  }

  bool get _isUpdateMode => widget.mode == ReadingStatusModalMode.update;
  bool get _hasChanges =>
      !_isUpdateMode ||
      _selectedStatus != widget.currentStatus ||
      (_selectedStatus == ReadingStatus.completed && _selectedRating != null);

  String get _title => _isUpdateMode ? '読書状態を変更' : '読書状態を選択';
  String get _primaryButtonLabel => _isUpdateMode ? '保存' : '登録';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseBottomSheet(
      title: _title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStatusGrid(theme),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _selectedStatus == ReadingStatus.completed
                ? _buildRatingSection(theme)
                : const SizedBox.shrink(),
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
    final statusColor = _getStatusColor(status);

    return InkWell(
      onTap: _isSaving
          ? null
          : () {
              setState(() {
                _selectedStatus = status;
                if (status != ReadingStatus.completed) {
                  _selectedRating = null;
                }
                _error = null;
              });
            },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? statusColor.withOpacity(0.3)
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? statusColor : Colors.white.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            status.displayName,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? statusColor : const Color(0xFF99A1AF),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingSection(ThemeData theme) {
    final appColors = theme.extension<AppColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),
        Text(
          '評価（任意）',
          style: theme.textTheme.labelMedium?.copyWith(
            color: appColors.foregroundMuted,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final starValue = index + 1;
            final isSelected =
                _selectedRating != null && _selectedRating! >= starValue;

            return GestureDetector(
              onTap: _isSaving
                  ? null
                  : () {
                      setState(() {
                        _selectedRating =
                            _selectedRating == starValue ? null : starValue;
                        _error = null;
                      });
                    },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: Icon(
                  isSelected ? Icons.star : Icons.star_border,
                  size: AppIconSize.xxl,
                  color: isSelected
                      ? appColors.accentSecondary
                      : theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Color _getStatusColor(ReadingStatus status) {
    return switch (status) {
      ReadingStatus.backlog => const Color(0xFFFFB74D),
      ReadingStatus.reading => const Color(0xFF64B5F6),
      ReadingStatus.completed => const Color(0xFF81C784),
      ReadingStatus.dropped => const Color(0xFF90A4AE),
    };
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
    final appColors = Theme.of(context).extension<AppColors>()!;
    final isEnabled = _hasChanges && !_isSaving;

    return SizedBox(
      height: 48,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [appColors.success, appColors.accent],
          ),
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
              : Text(_primaryButtonLabel),
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    if (!_isUpdateMode) {
      Navigator.pop(
        context,
        (status: _selectedStatus, rating: _selectedRating),
      );
      return;
    }

    setState(() {
      _isSaving = true;
      _error = null;
    });

    final notifier =
        ref.read(bookDetailNotifierProvider(widget.externalId!).notifier);
    final result = await notifier.updateReadingStatus(
      userBookId: widget.userBookId!,
      status: _selectedStatus,
    );

    final failed = result.fold(
      (failure) {
        if (mounted) {
          setState(() {
            _isSaving = false;
            _error = failure;
          });
        }
        return true;
      },
      (_) => false,
    );

    if (failed) return;

    if (_selectedStatus == ReadingStatus.completed && _selectedRating != null) {
      await notifier.updateRating(
        userBookId: widget.userBookId!,
        rating: _selectedRating,
      );
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }
}

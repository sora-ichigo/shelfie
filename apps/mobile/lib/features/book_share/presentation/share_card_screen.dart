import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_share/application/share_card_notifier.dart';
import 'package:shelfie/features/book_share/domain/share_card_level.dart';
import 'package:shelfie/features/book_share/infrastructure/gallery_save_service.dart';
import 'package:shelfie/features/book_share/infrastructure/share_image_service.dart';
import 'package:shelfie/features/book_share/presentation/widgets/share_card_widget.dart';

class ShareCardScreen extends ConsumerStatefulWidget {
  const ShareCardScreen({
    required this.externalId,
    super.key,
  });

  final String externalId;

  @override
  ConsumerState<ShareCardScreen> createState() => _ShareCardScreenState();
}

class _ShareCardScreenState extends ConsumerState<ShareCardScreen> {
  final _boundaryKey = GlobalKey();
  bool _isSharing = false;
  bool _isSaving = false;

  bool get _isProcessing => _isSharing || _isSaving;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shareCardNotifierProvider(widget.externalId));
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _isProcessing ? null : () => Navigator.of(context).pop(),
        ),
        title: const Text('シェアカード'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: AppSpacing.horizontal(AppSpacing.xl),
                  child: FittedBox(
                    child: ShareCardWidget(
                      level: state.currentLevel,
                      data: state.cardData,
                      boundaryKey: _boundaryKey,
                    ),
                  ),
                ),
              ),
            ),
            if (state.availableLevels.length > 1) ...[
              _CardLevelSelector(
                availableLevels: state.availableLevels,
                currentLevel: state.currentLevel,
                onLevelChanged: _isProcessing ? null : _onLevelChanged,
                appColors: appColors,
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            _ActionBar(
              isSharing: _isSharing,
              isSaving: _isSaving,
              onShare: _isProcessing ? null : _onShare,
              onSave: _isProcessing ? null : _onSave,
              appColors: appColors,
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }

  void _onLevelChanged(ShareCardLevel level) {
    ref
        .read(shareCardNotifierProvider(widget.externalId).notifier)
        .changeLevel(level);
  }

  Future<void> _onShare() async {
    setState(() => _isSharing = true);

    final box = context.findRenderObject() as RenderBox?;
    final sharePositionOrigin =
        box != null ? box.localToGlobal(Offset.zero) & box.size : null;

    final service = ref.read(shareImageServiceProvider);
    final result = await service.captureAndShare(
      boundaryKey: _boundaryKey,
      sharePositionOrigin: sharePositionOrigin,
    );

    if (!mounted) return;
    setState(() => _isSharing = false);

    result.fold(
      (failure) {
        AdaptiveSnackBar.show(
          context,
          message: 'シェアに失敗しました。再度お試しください',
          type: AdaptiveSnackBarType.error,
        );
      },
      (_) {},
    );
  }

  Future<void> _onSave() async {
    setState(() => _isSaving = true);

    final imageService = ref.read(shareImageServiceProvider);
    final bytesResult = await imageService.captureAsBytes(
      boundaryKey: _boundaryKey,
    );

    if (!mounted) return;

    await bytesResult.fold(
      (failure) async {
        setState(() => _isSaving = false);
        AdaptiveSnackBar.show(
          context,
          message: '画像の生成に失敗しました。再度お試しください',
          type: AdaptiveSnackBarType.error,
        );
      },
      (bytes) async {
        final saveService = ref.read(gallerySaveServiceProvider);
        final saveResult = await saveService.saveToGallery(imageBytes: bytes);

        if (!mounted) return;
        setState(() => _isSaving = false);

        switch (saveResult) {
          case GallerySaveSuccess():
            AdaptiveSnackBar.show(
              context,
              message: '画像を保存しました',
              type: AdaptiveSnackBarType.success,
            );
          case GallerySavePermissionDenied():
            AdaptiveSnackBar.show(
              context,
              message: '設定アプリから写真ライブラリへのアクセスを許可してください',
              type: AdaptiveSnackBarType.error,
            );
          case GallerySaveError(:final message):
            AdaptiveSnackBar.show(
              context,
              message: message,
              type: AdaptiveSnackBarType.error,
            );
        }
      },
    );
  }
}

class _CardLevelSelector extends StatelessWidget {
  const _CardLevelSelector({
    required this.availableLevels,
    required this.currentLevel,
    required this.onLevelChanged,
    required this.appColors,
  });

  final List<ShareCardLevel> availableLevels;
  final ShareCardLevel currentLevel;
  final void Function(ShareCardLevel)? onLevelChanged;
  final AppColors appColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.horizontal(AppSpacing.lg),
      child: SegmentedButton<ShareCardLevel>(
        segments: availableLevels
            .map(
              (level) => ButtonSegment<ShareCardLevel>(
                value: level,
                label: Text(level.displayName),
              ),
            )
            .toList(),
        selected: {currentLevel},
        onSelectionChanged: onLevelChanged != null
            ? (selected) => onLevelChanged!(selected.first)
            : null,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return appColors.accent.withValues(alpha: 0.3);
            }
            return appColors.surfaceCard;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return appColors.foreground;
            }
            return appColors.foregroundMuted;
          }),
        ),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({
    required this.isSharing,
    required this.isSaving,
    required this.onShare,
    required this.onSave,
    required this.appColors,
  });

  final bool isSharing;
  final bool isSaving;
  final VoidCallback? onShare;
  final VoidCallback? onSave;
  final AppColors appColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.horizontal(AppSpacing.lg),
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              icon: Icons.share,
              label: 'シェア',
              isLoading: isSharing,
              onPressed: onShare,
              appColors: appColors,
              isPrimary: true,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: _ActionButton(
              icon: Icons.save_alt,
              label: '保存',
              isLoading: isSaving,
              onPressed: onSave,
              appColors: appColors,
              isPrimary: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isLoading,
    required this.onPressed,
    required this.appColors,
    required this.isPrimary,
  });

  final IconData icon;
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;
  final AppColors appColors;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: isPrimary
          ? DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [appColors.success, appColors.accent],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildButton(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
              ),
            )
          : _buildButton(
              backgroundColor: appColors.surfaceCard,
              foregroundColor: appColors.foreground,
            ),
    );
  }

  Widget _buildButton({
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: isLoading
          ? SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: foregroundColor,
              ),
            )
          : Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

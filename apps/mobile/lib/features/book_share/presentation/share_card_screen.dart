import 'dart:io';

import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_share/application/share_card_notifier.dart';
import 'package:shelfie/features/book_share/infrastructure/gallery_save_service.dart';
import 'package:shelfie/features/book_share/infrastructure/instagram_story_service.dart';
import 'package:shelfie/features/book_share/infrastructure/share_image_service.dart';
import 'package:shelfie/features/book_share/presentation/widgets/share_card_widget.dart';

Future<void> showShareCardBottomSheet({
  required BuildContext context,
  required String externalId,
  Color? accentColor,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) =>
        _ShareCardBottomSheet(externalId: externalId, accentColor: accentColor),
  );
}

class _ShareCardBottomSheet extends ConsumerStatefulWidget {
  const _ShareCardBottomSheet({required this.externalId, this.accentColor});

  final String externalId;
  final Color? accentColor;

  @override
  ConsumerState<_ShareCardBottomSheet> createState() =>
      _ShareCardBottomSheetState();
}

class _ShareCardBottomSheetState extends ConsumerState<_ShareCardBottomSheet> {
  final _boundaryKey = GlobalKey();
  bool _isSharingInstagram = false;
  bool _isSharingOther = false;
  bool _isSaving = false;

  bool get _isProcessing => _isSharingInstagram || _isSharingOther || _isSaving;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shareCardNotifierProvider(widget.externalId));
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return SafeArea(
      child: Padding(
        padding: AppSpacing.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDragHandle(theme),
            const SizedBox(height: AppSpacing.lg),
            FractionallySizedBox(
              widthFactor: 0.75,
              child: FittedBox(
                child: ShareCardWidget(
                  data: state.cardData,
                  boundaryKey: _boundaryKey,
                  accentColor: widget.accentColor,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _ActionBar(
              isSharingInstagram: _isSharingInstagram,
              isSharingOther: _isSharingOther,
              isSaving: _isSaving,
              onInstagramStory: _isProcessing ? null : _onInstagramStory,
              onShareOther: _isProcessing ? null : _onShareOther,
              onSave: _isProcessing ? null : _onSave,
              appColors: appColors,
            ),
          ],
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

  Future<String?> _captureToTempFile() async {
    final imageService = ref.read(shareImageServiceProvider);
    final bytesResult = await imageService.captureAsBytes(
      boundaryKey: _boundaryKey,
    );

    return bytesResult.fold((_) => null, (bytes) async {
      final dir = Directory.systemTemp;
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${dir.path}/shelfie_share_$timestamp.png');
      await file.writeAsBytes(bytes);
      return file.path;
    });
  }

  Future<void> _onInstagramStory() async {
    setState(() => _isSharingInstagram = true);

    final filePath = await _captureToTempFile();

    if (!mounted) return;

    if (filePath == null) {
      setState(() => _isSharingInstagram = false);
      AdaptiveSnackBar.show(
        context,
        message: '画像の生成に失敗しました。再度お試しください',
        type: AdaptiveSnackBarType.error,
      );
      return;
    }

    final instagramService = ref.read(instagramStoryServiceProvider);
    final success = await instagramService.shareToStory(filePath: filePath);

    if (!mounted) return;
    setState(() => _isSharingInstagram = false);

    _cleanupTempFile(filePath);

    if (!success) {
      AdaptiveSnackBar.show(
        context,
        message: 'Instagramアプリが見つかりませんでした',
        type: AdaptiveSnackBarType.error,
      );
    }
  }

  Future<void> _onShareOther() async {
    setState(() => _isSharingOther = true);

    final box = context.findRenderObject() as RenderBox?;
    final sharePositionOrigin = box != null
        ? box.localToGlobal(Offset.zero) & box.size
        : null;

    final service = ref.read(shareImageServiceProvider);
    final result = await service.captureAndShare(
      boundaryKey: _boundaryKey,
      sharePositionOrigin: sharePositionOrigin,
    );

    if (!mounted) return;
    setState(() => _isSharingOther = false);

    result.fold((failure) {
      AdaptiveSnackBar.show(
        context,
        message: 'シェアに失敗しました。再度お試しください',
        type: AdaptiveSnackBarType.error,
      );
    }, (_) {});
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

  void _cleanupTempFile(String filePath) {
    try {
      final file = File(filePath);
      if (file.existsSync()) {
        file.deleteSync();
      }
    } on Exception catch (_) {}
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({
    required this.isSharingInstagram,
    required this.isSharingOther,
    required this.isSaving,
    required this.onInstagramStory,
    required this.onShareOther,
    required this.onSave,
    required this.appColors,
  });

  final bool isSharingInstagram;
  final bool isSharingOther;
  final bool isSaving;
  final VoidCallback? onInstagramStory;
  final VoidCallback? onShareOther;
  final VoidCallback? onSave;
  final AppColors appColors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionIcon(
          icon: FontAwesomeIcons.instagram,
          label: 'ストーリーズ',
          isLoading: isSharingInstagram,
          onPressed: onInstagramStory,
          iconSize: 44,
          gradient: const RadialGradient(
            center: Alignment(-0.4, 1.14),
            radius: 1.4,
            colors: [
              Color(0xFFFDF497),
              Color(0xFFFD5949),
              Color(0xFFD6249F),
              Color(0xFF285AEB),
            ],
            stops: [0.0, 0.35, 0.55, 0.9],
          ),
          foregroundColor: Colors.white,
        ),
        const SizedBox(width: AppSpacing.lg),
        _ActionIcon(
          icon: Icons.save_alt,
          label: '画像を保存',
          isLoading: isSaving,
          onPressed: onSave,
          backgroundColor: appColors.surfaceCard,
          foregroundColor: appColors.foreground,
        ),
        const SizedBox(width: AppSpacing.lg),
        _ActionIcon(
          icon: Icons.more_horiz,
          label: 'さらに見る',
          isLoading: isSharingOther,
          onPressed: onShareOther,
          backgroundColor: appColors.surfaceCard,
          foregroundColor: appColors.foreground,
        ),
      ],
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({
    required this.icon,
    required this.label,
    required this.isLoading,
    required this.onPressed,
    required this.foregroundColor,
    this.backgroundColor,
    this.gradient,
    this.iconSize,
  });

  final IconData icon;
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color foregroundColor;
  final double? iconSize;

  static const double _circleSize = 60;
  static const double _defaultIconSize = 30;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Opacity(
        opacity: onPressed == null ? 0.4 : 1.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: _circleSize,
              height: _circleSize,
              decoration: BoxDecoration(
                color: gradient == null ? backgroundColor : null,
                gradient: gradient,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: foregroundColor,
                        ),
                      )
                    : Icon(
                        icon,
                        size: iconSize ?? _defaultIconSize,
                        color: foregroundColor,
                      ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

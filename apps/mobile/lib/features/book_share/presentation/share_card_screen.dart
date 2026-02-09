import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/app_snack_bar.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_share/application/share_card_notifier.dart';
import 'package:shelfie/features/book_share/infrastructure/gallery_save_service.dart';
import 'package:shelfie/features/book_share/infrastructure/instagram_story_service.dart';
import 'package:shelfie/features/book_share/infrastructure/line_share_service.dart';
import 'package:shelfie/features/book_share/infrastructure/share_image_service.dart';
import 'package:shelfie/features/book_share/presentation/widgets/share_card_widget.dart';

Future<void> showShareCardBottomSheet({
  required BuildContext context,
  required String externalId,
  ReadingStatus? readingStatus,
  Color? accentColor,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Theme.of(context).extension<AppColors>()!.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => _ShareCardBottomSheet(
      externalId: externalId,
      accentColor: accentColor,
      readingStatus: readingStatus,
    ),
  );
}

class _ShareCardBottomSheet extends ConsumerStatefulWidget {
  const _ShareCardBottomSheet({
    required this.externalId,
    required this.readingStatus,
    this.accentColor,
  });

  final String externalId;
  final ReadingStatus? readingStatus;
  final Color? accentColor;

  @override
  ConsumerState<_ShareCardBottomSheet> createState() =>
      _ShareCardBottomSheetState();
}

class _ShareCardBottomSheetState extends ConsumerState<_ShareCardBottomSheet> {
  final _boundaryKey = GlobalKey();
  bool _isSharingInstagram = false;
  bool _isSharingLine = false;
  bool _isSharingOther = false;
  bool _isSaving = false;
  ShareCardStyle _selectedStyle = ShareCardStyle.card;

  bool get _isProcessing =>
      _isSharingInstagram || _isSharingLine || _isSharingOther || _isSaving;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shareCardNotifierProvider(widget.externalId));
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return BaseBottomSheet(
      title: _shareTitle(widget.readingStatus),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FractionallySizedBox(
            widthFactor: 0.75,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  FittedBox(
                    child: ShareCardWidget(
                      data: state.cardData,
                      boundaryKey: _boundaryKey,
                      accentColor: widget.accentColor,
                      style: _selectedStyle,
                    ),
                  ),
                  if (_isProcessing)
                    Positioned.fill(
                      child: ColoredBox(color: appColors.overlay.withOpacity(0.3)),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _StyleSelector(
            selectedStyle: _selectedStyle,
            accentColor: widget.accentColor,
            onStyleChanged: (style) => setState(() => _selectedStyle = style),
          ),
          const SizedBox(height: AppSpacing.md),
          _ActionBar(
            isSharingInstagram: _isSharingInstagram,
            isSharingLine: _isSharingLine,
            isSharingOther: _isSharingOther,
            isSaving: _isSaving,
            onInstagramStory: _isProcessing ? null : _onInstagramStory,
            onLine: _isProcessing ? null : _onLine,
            onShareOther: _isProcessing ? null : _onShareOther,
            onSave: _isProcessing ? null : _onSave,
            appColors: appColors,
          ),
        ],
      ),
    );
  }

  String _shareTitle(ReadingStatus? status) {
    switch (status) {
      case ReadingStatus.completed:
        return '読んだ本をシェアしよう';
      case ReadingStatus.reading:
        return '読んでいる本をシェアしよう';
      case ReadingStatus.backlog:
        return '積読をシェアしよう';
      case ReadingStatus.interested:
        return '気になる本をシェアしよう';
      case null:
        return 'この本をシェアしよう';
    }
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
      AppSnackBar.show(
        context,
        message: '画像の生成に失敗しました。再度お試しください',
        type: AppSnackBarType.error,
      );
      return;
    }

    final instagramService = ref.read(instagramStoryServiceProvider);
    final success = await instagramService.shareToStory(filePath: filePath);

    if (!mounted) return;
    setState(() => _isSharingInstagram = false);

    _cleanupTempFile(filePath);

    if (!success) {
      AppSnackBar.show(
        context,
        message: 'Instagramアプリが見つかりませんでした',
        type: AppSnackBarType.error,
      );
    }
  }

  Future<void> _onLine() async {
    setState(() => _isSharingLine = true);

    final filePath = await _captureToTempFile();

    if (!mounted) return;

    if (filePath == null) {
      setState(() => _isSharingLine = false);
      AppSnackBar.show(
        context,
        message: '画像の生成に失敗しました。再度お試しください',
        type: AppSnackBarType.error,
      );
      return;
    }

    final lineService = ref.read(lineShareServiceProvider);
    final success = await lineService.shareImage(filePath: filePath);

    if (!mounted) return;
    setState(() => _isSharingLine = false);

    _cleanupTempFile(filePath);

    if (!success) {
      AppSnackBar.show(
        context,
        message: 'LINEアプリが見つかりませんでした',
        type: AppSnackBarType.error,
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
      AppSnackBar.show(
        context,
        message: 'シェアに失敗しました。再度お試しください',
        type: AppSnackBarType.error,
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
        AppSnackBar.show(
          context,
          message: '画像の生成に失敗しました。再度お試しください',
          type: AppSnackBarType.error,
        );
      },
      (bytes) async {
        final saveService = ref.read(gallerySaveServiceProvider);
        final saveResult = await saveService.saveToGallery(imageBytes: bytes);

        if (!mounted) return;
        setState(() => _isSaving = false);

        switch (saveResult) {
          case GallerySaveSuccess():
            AppSnackBar.show(
              context,
              message: '画像を保存しました',
              type: AppSnackBarType.success,
            );
          case GallerySavePermissionDenied():
            AppSnackBar.show(
              context,
              message: '設定アプリから写真ライブラリへのアクセスを許可してください',
              type: AppSnackBarType.error,
            );
          case GallerySaveError(:final message):
            AppSnackBar.show(
              context,
              message: message,
              type: AppSnackBarType.error,
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

class _StyleSelector extends StatelessWidget {
  const _StyleSelector({
    required this.selectedStyle,
    required this.accentColor,
    required this.onStyleChanged,
  });

  final ShareCardStyle selectedStyle;
  final Color? accentColor;
  final ValueChanged<ShareCardStyle> onStyleChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StyleButton(
          isSelected: selectedStyle == ShareCardStyle.card,
          onTap: () => onStyleChanged(ShareCardStyle.card),
          color: accentColor ?? appColors.surface,
          hasInnerCircle: true,
        ),
        const SizedBox(width: AppSpacing.sm),
        _StyleButton(
          isSelected: selectedStyle == ShareCardStyle.simple,
          onTap: () => onStyleChanged(ShareCardStyle.simple),
          color: accentColor ?? appColors.surface,
        ),
      ],
    );
  }
}

class _StyleButton extends StatelessWidget {
  const _StyleButton({
    required this.isSelected,
    required this.onTap,
    required this.color,
    this.hasInnerCircle = false,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final Color color;
  final bool hasInnerCircle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: Theme.of(context).extension<AppColors>()!.textPrimary, width: 2.5)
              : null,
        ),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: hasInnerCircle
              ? Center(
                  child: Container(
                    width: 16,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Theme.of(context).extension<AppColors>()!.overlay.withOpacity(0.4),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({
    required this.isSharingInstagram,
    required this.isSharingLine,
    required this.isSharingOther,
    required this.isSaving,
    required this.onInstagramStory,
    required this.onLine,
    required this.onShareOther,
    required this.onSave,
    required this.appColors,
  });

  final bool isSharingInstagram;
  final bool isSharingLine;
  final bool isSharingOther;
  final bool isSaving;
  final VoidCallback? onInstagramStory;
  final VoidCallback? onLine;
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
          // ignore: avoid_direct_colors
          gradient: const RadialGradient(
            center: Alignment(-0.4, 1.14),
            radius: 1.4,
            colors: [
              // ignore: avoid_direct_colors
              Color(0xFFFDF497),
              // ignore: avoid_direct_colors
              Color(0xFFFD5949),
              // ignore: avoid_direct_colors
              Color(0xFFD6249F),
              // ignore: avoid_direct_colors
              Color(0xFF285AEB),
            ],
            stops: [0.0, 0.35, 0.55, 0.9],
          ),
          // ignore: avoid_direct_colors
          foregroundColor: Colors.white,
        ),
        const SizedBox(width: AppSpacing.lg),
        _ActionIcon(
          iconWidget: SvgPicture.asset(
            'assets/icons/line_icon.svg',
            width: 34,
            height: 34,
            // ignore: avoid_direct_colors
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          label: 'LINE',
          isLoading: isSharingLine,
          onPressed: onLine,
          // ignore: avoid_direct_colors
          backgroundColor: const Color(0xFF06C755),
          // ignore: avoid_direct_colors
          foregroundColor: Colors.white,
        ),
        const SizedBox(width: AppSpacing.lg),
        _ActionIcon(
          icon: Icons.save_alt,
          label: '画像を保存',
          isLoading: isSaving,
          onPressed: onSave,
          backgroundColor: appColors.surfaceElevated,
          foregroundColor: appColors.textPrimary,
        ),
        const SizedBox(width: AppSpacing.lg),
        _ActionIcon(
          icon: Icons.more_horiz,
          label: 'さらに見る',
          isLoading: isSharingOther,
          onPressed: onShareOther,
          backgroundColor: appColors.surfaceElevated,
          foregroundColor: appColors.textPrimary,
        ),
      ],
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({
    required this.label,
    required this.isLoading,
    required this.onPressed,
    required this.foregroundColor,
    this.icon,
    this.iconWidget,
    this.backgroundColor,
    this.gradient,
    this.iconSize,
  });

  final IconData? icon;
  final Widget? iconWidget;
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
                    : iconWidget ??
                          Icon(
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
                color: theme.extension<AppColors>()!.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

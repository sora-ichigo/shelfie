import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/app_snack_bar.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';

Future<void> showProfileShareBottomSheet({
  required BuildContext context,
  required String shareUrl,
}) {
  final appColors = Theme.of(context).extension<AppColors>()!;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: appColors.surface,
    builder: (context) => _ProfileShareBottomSheetContent(shareUrl: shareUrl),
  );
}

class _ProfileShareBottomSheetContent extends StatelessWidget {
  const _ProfileShareBottomSheetContent({required this.shareUrl});

  final String shareUrl;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return BaseBottomSheet(
      title: 'プロフィールをシェア',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ActionIcon(
                icon: Icons.copy,
                label: 'URLをコピー',
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: shareUrl));
                  if (context.mounted) {
                    AppSnackBar.show(
                      context,
                      message: 'URLをコピーしました',
                      type: AppSnackBarType.success,
                    );
                  }
                },
                backgroundColor: appColors.surfaceElevated,
                foregroundColor: appColors.textPrimary,
              ),
              const SizedBox(width: AppSpacing.lg),
              _ActionIcon(
                icon: Icons.share,
                label: '共有',
                onPressed: () async {
                  final box = context.findRenderObject() as RenderBox?;
                  final sharePositionOrigin = box != null
                      ? box.localToGlobal(Offset.zero) & box.size
                      : null;
                  await Share.share(
                    shareUrl,
                    sharePositionOrigin: sharePositionOrigin,
                  );
                },
                backgroundColor: appColors.surfaceElevated,
                foregroundColor: appColors.textPrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  static const double _circleSize = 60;
  static const double _iconSize = 30;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _circleSize,
            height: _circleSize,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                size: _iconSize,
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
    );
  }
}

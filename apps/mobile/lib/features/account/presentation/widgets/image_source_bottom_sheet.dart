import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

Future<void> showImageSourceBottomSheet({
  required BuildContext context,
  required VoidCallback onCameraSelected,
  required VoidCallback onGallerySelected,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.surfaceModal,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.md)),
    ),
    builder: (context) => _ImageSourceBottomSheetContent(
      onCameraSelected: () {
        Navigator.pop(context);
        onCameraSelected();
      },
      onGallerySelected: () {
        Navigator.pop(context);
        onGallerySelected();
      },
    ),
  );
}

class _ImageSourceBottomSheetContent extends StatelessWidget {
  const _ImageSourceBottomSheetContent({
    required this.onCameraSelected,
    required this.onGallerySelected,
  });

  final VoidCallback onCameraSelected;
  final VoidCallback onGallerySelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              '画像を選択',
              style: theme.textTheme.titleMedium?.copyWith(
                color: colors?.textPrimary ?? Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _OptionTile(
              icon: Icons.camera_alt_outlined,
              label: 'カメラで撮影',
              onTap: onCameraSelected,
            ),
            const SizedBox(height: AppSpacing.xs),
            _OptionTile(
              icon: Icons.photo_library_outlined,
              label: 'ギャラリーから選択',
              onTap: onGallerySelected,
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return ListTile(
      leading: Icon(
        icon,
        color: colors?.textPrimary ?? Colors.white,
      ),
      title: Text(
        label,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: colors?.textPrimary ?? Colors.white,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      tileColor: colors?.surfaceElevated ?? const Color(0xFF1A1A1A),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';

Future<void> showImageSourceBottomSheet({
  required BuildContext context,
  required VoidCallback onCameraSelected,
  required VoidCallback onGallerySelected,
}) {
  final appColors = Theme.of(context).extension<AppColors>()!;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: appColors.surface,
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
    return BaseBottomSheet(
      title: '画像を選択',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
        ],
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
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      tileColor: colors?.surface,
    );
  }
}

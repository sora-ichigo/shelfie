import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';

Future<void> showAddBookBottomSheet({
  required BuildContext context,
  VoidCallback? onSearchSelected,
  VoidCallback? onCameraSelected,
}) {
  final appColors = Theme.of(context).extension<AppColors>()!;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: appColors.surface,
    builder: (context) => _AddBookBottomSheetContent(
      onSearchSelected: () {
        Navigator.pop(context);
        onSearchSelected?.call();
      },
      onCameraSelected: () {
        Navigator.pop(context);
        onCameraSelected?.call();
      },
    ),
  );
}

class _AddBookBottomSheetContent extends StatelessWidget {
  const _AddBookBottomSheetContent({
    required this.onSearchSelected,
    required this.onCameraSelected,
  });

  final VoidCallback onSearchSelected;
  final VoidCallback onCameraSelected;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: '本を追加',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _OptionTile(
            icon: CupertinoIcons.search,
            label: 'キーワードで検索',
            onTap: onSearchSelected,
          ),
          const SizedBox(height: AppSpacing.xs),
          _OptionTile(
            icon: CupertinoIcons.camera,
            label: 'カメラで登録',
            onTap: onCameraSelected,
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
    final colors = Theme.of(context).extension<AppColors>();

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

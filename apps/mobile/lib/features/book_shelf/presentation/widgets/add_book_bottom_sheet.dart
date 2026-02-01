import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';

Future<void> showAddBookBottomSheet({
  required BuildContext context,
  required VoidCallback onKeywordSearch,
  required VoidCallback onBarcodeScan,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => _AddBookBottomSheetContent(
      onKeywordSearch: () {
        Navigator.pop(context);
        onKeywordSearch();
      },
      onBarcodeScan: () {
        Navigator.pop(context);
        onBarcodeScan();
      },
    ),
  );
}

class _AddBookBottomSheetContent extends StatelessWidget {
  const _AddBookBottomSheetContent({
    required this.onKeywordSearch,
    required this.onBarcodeScan,
  });

  final VoidCallback onKeywordSearch;
  final VoidCallback onBarcodeScan;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: '本を追加',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _OptionTile(
            icon: Icons.search,
            label: 'キーワードで検索',
            onTap: onKeywordSearch,
          ),
          const SizedBox(height: AppSpacing.xs),
          _OptionTile(
            icon: Icons.camera_alt_outlined,
            label: 'カメラで読み取り',
            onTap: onBarcodeScan,
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/base_bottom_sheet.dart';

Future<void> showProfileShareBottomSheet({
  required BuildContext context,
  required String shareUrl,
}) {
  final appColors = Theme.of(context).extension<AppColors>()!;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: appColors.surface,
    builder: (context) => _ProfileShareBottomSheetContent(shareUrl: shareUrl),
  );
}

class _ProfileShareBottomSheetContent extends StatelessWidget {
  const _ProfileShareBottomSheetContent({required this.shareUrl});

  final String shareUrl;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: 'プロフィールをシェア',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _OptionTile(
            icon: Icons.copy,
            label: 'URLをコピー',
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: shareUrl));
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('URLをコピーしました')),
                );
              }
            },
          ),
          const SizedBox(height: AppSpacing.xs),
          _OptionTile(
            icon: Icons.share,
            label: '共有',
            onTap: () async {
              Navigator.pop(context);
              await Share.share(shareUrl);
            },
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

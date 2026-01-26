import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class ProfileEditHeader extends StatelessWidget {
  const ProfileEditHeader({
    required this.onClose,
    required this.onSave,
    required this.isSaveEnabled,
    super.key,
  });

  final VoidCallback onClose;
  final VoidCallback onSave;
  final bool isSaveEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: colors?.foreground ?? Colors.white,
            ),
            onPressed: onClose,
          ),
          Expanded(
            child: Center(
              child: Text(
                'プロフィール編集',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colors?.foreground ?? Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.check,
              color: isSaveEnabled
                  ? (colors?.accent ?? const Color(0xFF4FD1C5))
                  : (colors?.foregroundMuted ?? const Color(0xFFA0A0A0)),
            ),
            onPressed: isSaveEnabled ? onSave : null,
          ),
        ],
      ),
    );
  }
}

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
            icon: const Icon(Icons.close),
            onPressed: onClose,
          ),
          Expanded(
            child: Center(
              child: Text(
                'プロフィール編集',
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.check,
              color: isSaveEnabled ? colors?.accent : colors?.foregroundMuted,
            ),
            onPressed: isSaveEnabled ? onSave : null,
          ),
        ],
      ),
    );
  }
}

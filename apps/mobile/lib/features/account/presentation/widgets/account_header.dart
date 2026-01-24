import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    required this.onClose,
    super.key,
  });

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'アカウント',
              style: theme.textTheme.titleLarge?.copyWith(
                color: colors?.textPrimary ?? Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: colors?.textPrimary ?? Colors.white,
            ),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}

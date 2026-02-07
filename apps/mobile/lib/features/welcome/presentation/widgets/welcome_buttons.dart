import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class WelcomeButtons extends StatelessWidget {
  const WelcomeButtons({
    required this.onLoginPressed,
    required this.onRegisterPressed,
    super.key,
  });

  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = Theme.of(context).textTheme.labelLarge;
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: onLoginPressed,
            child: Text(
              'ログイン',
              style: baseTextStyle?.copyWith(color: appColors.overlay),
            ),
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onRegisterPressed,
            child: Text(
              '新規登録',
              style: baseTextStyle?.copyWith(color: appColors.textPrimary),
            ),
          ),
        ),
      ],
    );
  }
}

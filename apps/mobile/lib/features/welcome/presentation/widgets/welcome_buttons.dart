import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class WelcomeButtons extends StatelessWidget {
  const WelcomeButtons({
    required this.onLoginPressed,
    required this.onRegisterPressed,
    this.onGuestModePressed,
    super.key,
  });

  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;
  final VoidCallback? onGuestModePressed;

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = Theme.of(context).textTheme.labelLarge;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: onLoginPressed,
            child: Text(
              'ログイン',
              style: baseTextStyle?.copyWith(color: Colors.black),
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
              style: baseTextStyle?.copyWith(color: Colors.white),
            ),
          ),
        ),
        if (onGuestModePressed != null) ...[
          SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: onGuestModePressed,
            child: Text(
              'アカウントなしで利用',
              style: baseTextStyle?.copyWith(
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

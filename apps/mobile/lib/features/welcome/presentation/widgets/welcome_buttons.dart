import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class WelcomeButtons extends StatelessWidget {
  const WelcomeButtons({
    super.key,
    required this.onLoginPressed,
    required this.onRegisterPressed,
  });

  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w600,
    );

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
      ],
    );
  }
}

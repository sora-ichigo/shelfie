import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';

class LegalLinks extends StatelessWidget {
  const LegalLinks({
    super.key,
    required this.onTermsPressed,
    required this.onPrivacyPressed,
  });

  final VoidCallback onTermsPressed;
  final VoidCallback onPrivacyPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();
    final textColor = colors?.textSecondary ?? const Color(0xFFA0A0A0);
    final linkColor = colors?.textLink ?? Colors.white;

    final textStyle = theme.textTheme.bodySmall?.copyWith(
      color: textColor,
    );

    final linkStyle = textStyle?.copyWith(
      color: linkColor,
      decoration: TextDecoration.underline,
      decorationColor: linkColor,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textStyle,
        children: [
          const TextSpan(text: '続けることで、'),
          TextSpan(
            text: '利用規約',
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = onTermsPressed,
          ),
          const TextSpan(text: 'と'),
          TextSpan(
            text: 'プライバシーポリシー',
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = onPrivacyPressed,
          ),
          const TextSpan(text: 'に\n同意したものとみなされます'),
        ],
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';

class RegistrationLegalLinks extends StatefulWidget {
  const RegistrationLegalLinks({
    required this.onTermsPressed,
    required this.onPrivacyPressed,
    super.key,
  });

  final VoidCallback onTermsPressed;
  final VoidCallback onPrivacyPressed;

  @override
  State<RegistrationLegalLinks> createState() => _RegistrationLegalLinksState();
}

class _RegistrationLegalLinksState extends State<RegistrationLegalLinks> {
  late final TapGestureRecognizer _termsRecognizer;
  late final TapGestureRecognizer _privacyRecognizer;

  @override
  void initState() {
    super.initState();
    _termsRecognizer = TapGestureRecognizer()..onTap = widget.onTermsPressed;
    _privacyRecognizer = TapGestureRecognizer()..onTap = widget.onPrivacyPressed;
  }

  @override
  void dispose() {
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();
    final textColor = colors?.textSecondary ?? const Color(0xFFA0A0A0);
    final linkColor = colors?.brandPrimary ?? const Color(0xFF4FD1C5);

    final textStyle = theme.textTheme.bodySmall?.copyWith(
      color: textColor,
    );

    final linkStyle = textStyle?.copyWith(
      color: linkColor,
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
            recognizer: _termsRecognizer,
          ),
          const TextSpan(text: 'と'),
          TextSpan(
            text: 'プライバシーポリシー',
            style: linkStyle,
            recognizer: _privacyRecognizer,
          ),
          const TextSpan(text: 'に\n同意したものとみなされます'),
        ],
      ),
    );
  }
}

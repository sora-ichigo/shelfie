import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class RegistrationHeader extends StatelessWidget {
  const RegistrationHeader({
    required this.onBackPressed,
    this.onLoginPressed,
    super.key,
  });

  final VoidCallback onBackPressed;
  final VoidCallback? onLoginPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onBackPressed,
            customBorder: const CircleBorder(),
            child: const Padding(
              padding: EdgeInsets.all(AppSpacing.xs),
              child: Icon(Icons.arrow_back_ios_new),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: colors?.accent,
                child: Icon(
                  Icons.email_outlined,
                  size: 40,
                  color: colors?.background,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                '新規登録',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'アカウントを作成して始めましょう',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors?.foregroundMuted,
                ),
              ),
              if (onLoginPressed != null) ...[
                const SizedBox(height: AppSpacing.xs),
                _LoginLink(
                  onTap: onLoginPressed!,
                  textStyle: theme.textTheme.bodyMedium,
                  mutedColor: colors?.foregroundMuted,
                  accentColor: colors?.accent,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _LoginLink extends StatefulWidget {
  const _LoginLink({
    required this.onTap,
    this.textStyle,
    this.mutedColor,
    this.accentColor,
  });

  final VoidCallback onTap;
  final TextStyle? textStyle;
  final Color? mutedColor;
  final Color? accentColor;

  @override
  State<_LoginLink> createState() => _LoginLinkState();
}

class _LoginLinkState extends State<_LoginLink> {
  late final TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()..onTap = widget.onTap;
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = widget.textStyle?.copyWith(
      color: widget.mutedColor ?? const Color(0xFFA0A0A0),
    );
    final linkStyle = widget.textStyle?.copyWith(
      color: widget.accentColor ?? const Color(0xFF4FD1C5),
    );

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          const TextSpan(text: 'すでにアカウントをお持ちの方は'),
          TextSpan(
            text: 'こちら',
            style: linkStyle,
            recognizer: _recognizer,
          ),
        ],
      ),
    );
  }
}

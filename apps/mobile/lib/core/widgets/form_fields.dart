import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

InputDecoration _buildInputDecoration({
  required AppColors colors,
  String? hintText,
  String? errorText,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    hintText: hintText,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: colors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.xs),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.xs),
      borderSide: errorText != null
          ? BorderSide(color: colors.destructive, width: 1)
          : BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.xs),
      borderSide: BorderSide(
        color: errorText != null ? colors.destructive : colors.primary,
        width: 2,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm,
    ),
  );
}

/// ラベル付きテキストフィールド
///
/// ラベルテキストと統一スタイルの入力フィールドを提供する。
class LabeledTextField extends StatelessWidget {
  const LabeledTextField({
    required this.label,
    this.controller,
    this.hintText,
    this.errorText,
    this.maxLength,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.onChanged,
    this.suffixIcon,
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final int? maxLength;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: controller,
          maxLength: maxLength,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          enabled: enabled,
          onChanged: onChanged,
          style: enabled
              ? null
              : theme.textTheme.bodyLarge?.copyWith(
                  color: colors.textSecondary,
                ),
          decoration: _buildInputDecoration(
            colors: colors,
            hintText: hintText,
            errorText: errorText,
            suffixIcon: suffixIcon,
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            errorText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.destructive,
            ),
          ),
        ],
      ],
    );
  }
}

/// メールアドレス入力フィールド
///
/// メールアドレス用にカスタマイズされた TextFormField を提供する。
/// キーボードタイプがメールアドレス用に設定される。
class EmailField extends StatelessWidget {
  const EmailField({
    required this.value,
    required this.onChanged,
    this.errorText,
    this.hintText = 'example@email.com',
    super.key,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final String? errorText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'メールアドレス',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          initialValue: value,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          autocorrect: false,
          onChanged: onChanged,
          decoration: _buildInputDecoration(
            colors: colors,
            hintText: hintText,
            errorText: errorText,
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            errorText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.destructive,
            ),
          ),
        ],
      ],
    );
  }
}

/// パスワード入力フィールド
///
/// パスワード用にカスタマイズされた TextFormField を提供する。
/// 表示/非表示の切り替え機能を内蔵している。
class PasswordField extends StatelessWidget {
  const PasswordField({
    required this.value,
    required this.isObscured,
    required this.onChanged,
    required this.onToggleVisibility,
    this.label = 'パスワード',
    this.hintText = 'パスワードを入力',
    this.errorText,
    this.textInputAction,
    this.autofillHints = const [AutofillHints.password],
    super.key,
  });

  final String value;
  final bool isObscured;
  final ValueChanged<String> onChanged;
  final VoidCallback onToggleVisibility;
  final String label;
  final String hintText;
  final String? errorText;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          initialValue: value,
          obscureText: isObscured,
          autocorrect: false,
          enableSuggestions: false,
          autofillHints: autofillHints,
          onChanged: onChanged,
          textInputAction: textInputAction,
          decoration: _buildInputDecoration(
            colors: colors,
            hintText: hintText,
            errorText: errorText,
            suffixIcon: IconButton(
              icon: Icon(
                isObscured ? Icons.visibility_off : Icons.visibility,
                color: colors.textSecondary,
              ),
              onPressed: onToggleVisibility,
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            errorText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.destructive,
            ),
          ),
        ],
      ],
    );
  }
}

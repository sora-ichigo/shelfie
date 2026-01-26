import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

/// ラベル付きテキストフィールドの基本レイアウト
///
/// ラベルテキストと入力フィールドを縦に並べる共通レイアウトを提供する。
class LabeledTextField extends StatelessWidget {
  const LabeledTextField({
    required this.label,
    required this.child,
    super.key,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        child,
      ],
    );
  }
}

/// メールアドレス入力フィールド
///
/// メールアドレス用にカスタマイズされた TextFormField を提供する。
/// キーボードタイプがメールアドレス用に設定され、メールアイコンが表示される。
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
    return LabeledTextField(
      label: 'メールアドレス',
      child: TextFormField(
        initialValue: value,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: errorText,
          prefixIcon: const Icon(Icons.email_outlined),
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return LabeledTextField(
      label: label,
      child: TextFormField(
        initialValue: value,
        obscureText: isObscured,
        autocorrect: false,
        enableSuggestions: false,
        onChanged: onChanged,
        textInputAction: textInputAction,
        style: theme.textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.bodyLarge?.copyWith(
            color: colors?.foregroundMuted,
          ),
          errorText: errorText,
          suffixIcon: IconButton(
            icon: Icon(
              isObscured ? Icons.visibility_off : Icons.visibility,
              color: colors?.foregroundMuted,
            ),
            onPressed: onToggleVisibility,
          ),
          filled: true,
          fillColor: colors?.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            borderSide: BorderSide(
              color: colors?.accent ?? Colors.blue,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            borderSide: BorderSide(
              color: colors?.error ?? Colors.red,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            borderSide: BorderSide(
              color: colors?.error ?? Colors.red,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
      ),
    );
  }
}

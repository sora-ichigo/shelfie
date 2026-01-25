import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class ProfileEditForm extends StatelessWidget {
  const ProfileEditForm({
    required this.nameController,
    required this.emailController,
    required this.onNameChanged,
    this.nameError,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final ValueChanged<String> onNameChanged;
  final String? nameError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(theme, colors, '氏名'),
        const SizedBox(height: AppSpacing.xs),
        _buildTextField(
          controller: nameController,
          onChanged: onNameChanged,
          colors: colors,
          theme: theme,
          errorText: nameError,
          keyboardType: TextInputType.name,
        ),
        if (nameError != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          _buildErrorText(theme, nameError!),
        ],
        const SizedBox(height: AppSpacing.lg),
        _buildLabel(theme, colors, 'メールアドレス'),
        const SizedBox(height: AppSpacing.xs),
        _buildDisabledTextField(
          controller: emailController,
          colors: colors,
          theme: theme,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'アカウントのメールアドレスは変更できません',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(ThemeData theme, AppColors? colors, String text) {
    return Text(
      text,
      style: theme.textTheme.titleSmall?.copyWith(
        color: colors?.textPrimary ?? Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    required AppColors? colors,
    required ThemeData theme,
    String? errorText,
    TextInputType? keyboardType,
    bool enabled = true,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      enabled: enabled,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: enabled
            ? (colors?.textPrimary ?? Colors.white)
            : (colors?.textSecondary ?? const Color(0xFFA0A0A0)),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: colors?.surfaceElevated ?? const Color(0xFF1A1A1A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.xs),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.xs),
          borderSide: errorText != null
              ? BorderSide(
                  color: theme.colorScheme.error,
                  width: 1,
                )
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.xs),
          borderSide: BorderSide(
            color: errorText != null
                ? theme.colorScheme.error
                : (colors?.brandPrimary ?? const Color(0xFF4FD1C5)),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
    );
  }

  Widget _buildErrorText(ThemeData theme, String error) {
    return Text(
      error,
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.error,
      ),
    );
  }

  Widget _buildDisabledTextField({
    required TextEditingController controller,
    required AppColors? colors,
    required ThemeData theme,
  }) {
    return TextField(
      controller: controller,
      enabled: false,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: colors?.surfaceElevated ?? const Color(0xFF1A1A1A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.xs),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
    );
  }
}

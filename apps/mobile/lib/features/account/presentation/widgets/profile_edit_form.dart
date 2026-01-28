import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/form_fields.dart';

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
        LabeledTextField(
          label: '氏名',
          controller: nameController,
          onChanged: onNameChanged,
          errorText: nameError,
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: AppSpacing.lg),
        LabeledTextField(
          label: 'メールアドレス',
          controller: emailController,
          enabled: false,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'アカウントのメールアドレスは変更できません',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors?.foregroundMuted,
          ),
        ),
      ],
    );
  }
}

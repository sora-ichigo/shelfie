import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/form_fields.dart';

class ProfileEditForm extends StatelessWidget {
  const ProfileEditForm({
    required this.nameController,
    required this.emailController,
    required this.handleController,
    required this.bioController,
    required this.instagramHandleController,
    required this.onNameChanged,
    required this.onHandleChanged,
    required this.onBioChanged,
    required this.onInstagramHandleChanged,
    this.nameError,
    this.handleError,
    this.bioError,
    this.instagramHandleError,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController handleController;
  final TextEditingController bioController;
  final TextEditingController instagramHandleController;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onHandleChanged;
  final ValueChanged<String> onBioChanged;
  final ValueChanged<String> onInstagramHandleChanged;
  final String? nameError;
  final String? handleError;
  final String? bioError;
  final String? instagramHandleError;

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
          label: 'ハンドル',
          controller: handleController,
          onChanged: onHandleChanged,
          errorText: handleError,
          hintText: 'username',
        ),
        const SizedBox(height: AppSpacing.lg),
        LabeledTextField(
          label: '自己紹介',
          controller: bioController,
          onChanged: onBioChanged,
          errorText: bioError,
          maxLines: 4,
          maxLength: 500,
          hintText: '自己紹介を入力してください',
        ),
        const SizedBox(height: AppSpacing.lg),
        LabeledTextField(
          label: 'Instagram',
          controller: instagramHandleController,
          onChanged: onInstagramHandleChanged,
          errorText: instagramHandleError,
          hintText: 'instagram_handle',
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
            color: colors?.textSecondary,
          ),
        ),
      ],
    );
  }
}

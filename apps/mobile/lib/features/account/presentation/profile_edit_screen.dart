import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/edit_screen_header.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/account/application/profile_edit_notifier.dart';
import 'package:shelfie/features/account/application/profile_form_state.dart';
import 'package:shelfie/features/account/data/image_picker_service.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:shelfie/features/account/presentation/widgets/avatar_editor.dart';
import 'package:shelfie/features/account/presentation/widgets/image_source_bottom_sheet.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_edit_form.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({
    required this.initialProfile,
    required this.onClose,
    required this.onSaveSuccess,
    super.key,
  });

  final UserProfile initialProfile;
  final VoidCallback onClose;
  final VoidCallback onSaveSuccess;

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.initialProfile.name ?? '',
    );
    _emailController = TextEditingController(
      text: widget.initialProfile.email,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileFormStateProvider.notifier).initialize(
            widget.initialProfile,
          );
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final editState = ref.watch(profileEditNotifierProvider);
    final formState = ref.watch(profileFormStateProvider);
    final formNotifier = ref.read(profileFormStateProvider.notifier);

    ref.listen<ProfileEditState>(
      profileEditNotifierProvider,
      (previous, next) {
        next.when(
          initial: () {},
          loading: () {},
          uploading: (_) {},
          success: (profile) {
            ref.read(accountNotifierProvider.notifier).refresh();
            widget.onSaveSuccess();
          },
          error: (message, field) {
            AdaptiveSnackBar.show(
              context,
              message: message,
              type: AdaptiveSnackBarType.error,
            );
          },
        );
      },
    );

    final isLoading = editState is ProfileEditStateLoading ||
        editState is ProfileEditStateUploading;
    final isSaveEnabled = formNotifier.isValid && !isLoading;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                EditScreenHeader(
                  title: 'プロフィール編集',
                  onClose: widget.onClose,
                  onSave: _handleSave,
                  isSaveEnabled: isSaveEnabled,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      children: [
                        const SizedBox(height: AppSpacing.md),
                        AvatarEditor(
                          avatarUrl: widget.initialProfile.avatarUrl,
                          pendingImage: formState.pendingAvatarImage,
                          onTap: _showImageSourceSheet,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        ProfileEditForm(
                          nameController: _nameController,
                          emailController: _emailController,
                          onNameChanged: formNotifier.updateName,
                          nameError: formNotifier.nameError,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (isLoading)
              ColoredBox(
                color: appColors.overlay.withOpacity(0.3),
                child: const LoadingIndicator(fullScreen: true),
              ),
          ],
        ),
      ),
    );
  }

  void _handleSave() {
    ref.read(profileEditNotifierProvider.notifier).save();
  }

  void _showImageSourceSheet() {
    showImageSourceBottomSheet(
      context: context,
      onCameraSelected: () async {
        final imagePickerService = ref.read(imagePickerServiceProvider);
        final image = await imagePickerService.pickFromCamera();
        if (image != null) {
          ref.read(profileFormStateProvider.notifier).setAvatarImage(image);
        }
      },
      onGallerySelected: () async {
        final imagePickerService = ref.read(imagePickerServiceProvider);
        final image = await imagePickerService.pickFromGallery();
        if (image != null) {
          ref.read(profileFormStateProvider.notifier).setAvatarImage(image);
        }
      },
    );
  }
}

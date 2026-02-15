import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';

class AvatarEditor extends StatelessWidget {
  const AvatarEditor({
    required this.avatarUrl,
    required this.pendingImage,
    required this.onTap,
    super.key,
  });

  final String? avatarUrl;
  final XFile? pendingImage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    ImageProvider? imageProvider;
    if (pendingImage != null) {
      imageProvider = FileImage(File(pendingImage!.path));
    }

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          UserAvatar(
            avatarUrl: avatarUrl,
            imageProvider: imageProvider,
            radius: 50,
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: appColors.surfaceLegacy,
                shape: BoxShape.circle,
                border: Border.all(
                  color: appColors.backgroundLegacy,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.edit,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

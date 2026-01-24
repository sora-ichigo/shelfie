import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

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
    final colors = theme.extension<AppColors>();

    ImageProvider? backgroundImage;
    if (pendingImage != null) {
      backgroundImage = FileImage(File(pendingImage!.path));
    } else if (avatarUrl != null) {
      backgroundImage = NetworkImage(avatarUrl!);
    }

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: colors?.brandPrimary ?? const Color(0xFF4FD1C5),
            backgroundImage: backgroundImage,
            child: backgroundImage == null
                ? Icon(
                    Icons.person,
                    size: 50,
                    color: colors?.brandBackground ?? const Color(0xFF0A0A0A),
                  )
                : null,
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: colors?.surfaceElevated ?? const Color(0xFF1A1A1A),
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors?.brandBackground ?? const Color(0xFF0A0A0A),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.edit,
                size: 16,
                color: colors?.textPrimary ?? Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

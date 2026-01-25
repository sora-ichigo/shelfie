import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    this.avatarUrl,
    this.imageProvider,
    this.radius = 24,
    super.key,
  });

  final String? avatarUrl;
  final ImageProvider? imageProvider;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();

    ImageProvider? backgroundImage;
    if (imageProvider != null) {
      backgroundImage = imageProvider;
    } else if (avatarUrl != null) {
      backgroundImage = NetworkImage(avatarUrl!);
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: colors?.brandPrimary ?? const Color(0xFF4FD1C5),
      backgroundImage: backgroundImage,
      child: backgroundImage == null
          ? Icon(
              Icons.person,
              size: radius,
              color: colors?.brandBackground ?? const Color(0xFF0A0A0A),
            )
          : null,
    );
  }
}

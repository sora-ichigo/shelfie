import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/utils/imagekit_url_transformer.dart';

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

    final optimizedUrl = ImageKitUrlTransformer.transformUrl(
      avatarUrl,
      size: (radius * 2).toInt(),
    );

    ImageProvider? backgroundImage;
    if (imageProvider != null) {
      backgroundImage = imageProvider;
    } else if (optimizedUrl != null && optimizedUrl.isNotEmpty) {
      backgroundImage = CachedNetworkImageProvider(optimizedUrl);
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: colors?.brandPrimary ?? const Color(0xFF4FD1C5),
      backgroundImage: backgroundImage,
      onBackgroundImageError: backgroundImage != null
          ? (_, __) {}
          : null,
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/utils/imagekit_url_transformer.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    this.avatarUrl,
    this.imageProvider,
    this.radius = 24,
    this.isLoading = false,
    super.key,
  });

  final String? avatarUrl;
  final ImageProvider? imageProvider;
  final double radius;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _LoadingAvatar(radius: radius);
    }

    if (imageProvider != null) {
      return _ImageAvatar(imageProvider: imageProvider!, radius: radius);
    }

    final optimizedUrl = ImageKitUrlTransformer.transformUrl(
      avatarUrl,
      size: (radius * 2).toInt(),
    );

    if (optimizedUrl == null || optimizedUrl.isEmpty) {
      return _DefaultAvatar(radius: radius);
    }

    return _NetworkAvatar(url: optimizedUrl, radius: radius);
  }
}

class _DefaultAvatar extends StatelessWidget {
  const _DefaultAvatar({required this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();

    return CircleAvatar(
      radius: radius,
      backgroundColor: colors?.brandPrimary ?? const Color(0xFF4FD1C5),
      child: Icon(
        Icons.person,
        size: radius,
        color: colors?.brandBackground ?? const Color(0xFF0A0A0A),
      ),
    );
  }
}

class _LoadingAvatar extends StatelessWidget {
  const _LoadingAvatar({required this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();

    return CircleAvatar(
      radius: radius,
      backgroundColor: colors?.surfaceElevated ?? const Color(0xFF1A1A1A),
      child: Icon(
        Icons.person,
        size: radius,
        color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
      ),
    );
  }
}

class _NetworkAvatar extends StatelessWidget {
  const _NetworkAvatar({required this.url, required this.radius});

  final String url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => _ImageAvatar(
        imageProvider: imageProvider,
        radius: radius,
      ),
      placeholder: (context, url) => _LoadingAvatar(radius: radius),
      errorWidget: (context, url, error) => _DefaultAvatar(radius: radius),
    );
  }
}

class _ImageAvatar extends StatelessWidget {
  const _ImageAvatar({required this.imageProvider, required this.radius});

  final ImageProvider imageProvider;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();

    return CircleAvatar(
      radius: radius,
      backgroundColor: colors?.surfaceElevated ?? const Color(0xFF1A1A1A),
      backgroundImage: imageProvider,
    );
  }
}

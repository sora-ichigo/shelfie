import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/theme/app_typography.dart';
import 'package:shelfie/features/book_share/domain/share_card_data.dart';
import 'package:shelfie/features/book_share/domain/share_card_level.dart';

class ShareCardWidget extends StatelessWidget {
  const ShareCardWidget({
    required this.level,
    required this.data,
    required this.boundaryKey,
    super.key,
  });

  final ShareCardLevel level;
  final ShareCardData data;
  final GlobalKey boundaryKey;

  static const double cardSize = 360;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: boundaryKey,
      child: SizedBox(
        width: cardSize,
        height: cardSize,
        child: _CardContent(level: level, data: data),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({required this.level, required this.data});

  final ShareCardLevel level;
  final ShareCardData data;

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.dark;

    return Container(
      decoration: BoxDecoration(
        color: appColors.surfaceCard,
        borderRadius: AppRadius.circular(AppRadius.lg),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: AppSpacing.all(AppSpacing.lg),
        child: switch (level) {
          ShareCardLevel.simple => _SimpleLayout(data: data, colors: appColors),
          ShareCardLevel.profile =>
            _ProfileLayout(data: data, colors: appColors),
          ShareCardLevel.review =>
            _ReviewLayout(data: data, colors: appColors),
        },
      ),
    );
  }
}

class _SimpleLayout extends StatelessWidget {
  const _SimpleLayout({required this.data, required this.colors});

  final ShareCardData data;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CoverImage(
                thumbnailUrl: data.thumbnailUrl,
                colors: colors,
                width: 130,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      data.title,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.titleMedium.copyWith(
                        color: colors.foreground,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      data.authors.join(', '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodySmall.copyWith(
                        color: colors.foregroundMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        const _ShelfieLogoRow(),
      ],
    );
  }
}

class _ProfileLayout extends StatelessWidget {
  const _ProfileLayout({required this.data, required this.colors});

  final ShareCardData data;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CoverImage(
                thumbnailUrl: data.thumbnailUrl,
                colors: colors,
                width: 120,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      data.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.titleSmall.copyWith(
                        color: colors.foreground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      data.authors.join(', '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.captionSmall.copyWith(
                        color: colors.foregroundMuted,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    if (data.rating != null) _StarRating(rating: data.rating!),
                    const Spacer(),
                    if (data.completedAt != null)
                      Text(
                        '${DateFormat('yyyy.MM.dd').format(data.completedAt!)} 読了',
                        style: AppTypography.captionSmall.copyWith(
                          color: colors.foregroundMuted,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            _UserInfo(data: data, colors: colors),
            const Spacer(),
            const _ShelfieLogoSmall(),
          ],
        ),
      ],
    );
  }
}

class _ReviewLayout extends StatelessWidget {
  const _ReviewLayout({required this.data, required this.colors});

  final ShareCardData data;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CoverImage(
              thumbnailUrl: data.thumbnailUrl,
              colors: colors,
              width: 80,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.titleSmall.copyWith(
                      color: colors.foreground,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    data.authors.join(', '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.captionSmall.copyWith(
                      color: colors.foregroundMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  if (data.rating != null) _StarRating(rating: data.rating!),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: AppSpacing.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: AppRadius.circular(AppRadius.md),
            ),
            child: Text(
              data.note ?? '',
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodySmall.copyWith(
                color: colors.foreground,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            _UserInfo(data: data, colors: colors),
            const Spacer(),
            if (data.completedAt != null)
              Text(
                '${DateFormat('yyyy.MM.dd').format(data.completedAt!)} 読了',
                style: AppTypography.captionSmall.copyWith(
                  color: colors.foregroundMuted,
                ),
              ),
            const SizedBox(width: AppSpacing.xs),
            const _ShelfieLogoSmall(),
          ],
        ),
      ],
    );
  }
}

class _CoverImage extends StatelessWidget {
  const _CoverImage({
    required this.thumbnailUrl,
    required this.colors,
    required this.width,
  });

  final String? thumbnailUrl;
  final AppColors colors;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.circular(AppRadius.md),
      child: SizedBox(
        width: width,
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: thumbnailUrl != null
              ? CachedNetworkImage(
                  imageUrl: thumbnailUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => _buildPlaceholder(),
                  errorWidget: (context, url, error) => _buildPlaceholder(),
                )
              : _buildPlaceholder(),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return ColoredBox(
      color: colors.overlay,
      child: Center(
        child: Icon(Icons.book, size: 32, color: colors.foregroundMuted),
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  const _StarRating({required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final isFilled = index < rating;
        return Icon(
          Icons.star_rounded,
          size: 16,
          color: isFilled
              ? AppColors.dark.accentSecondary
              : AppColors.dark.accentSecondary.withValues(alpha: 0.25),
        );
      }),
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo({required this.data, required this.colors});

  final ShareCardData data;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: colors.surfaceSubtle,
          backgroundImage: data.avatarUrl != null
              ? CachedNetworkImageProvider(data.avatarUrl!)
              : null,
          child: data.avatarUrl == null
              ? Icon(Icons.person, size: 14, color: colors.foregroundMuted)
              : null,
        ),
        const SizedBox(width: AppSpacing.xs),
        if (data.userName != null)
          Text(
            data.userName!,
            style: AppTypography.labelMedium.copyWith(
              color: colors.foreground,
            ),
          ),
      ],
    );
  }
}

class _ShelfieLogoRow extends StatelessWidget {
  const _ShelfieLogoRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: AppRadius.circular(AppRadius.sm),
          child: Image.asset(
            'assets/icons/app_icon.png',
            width: 20,
            height: 20,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          'Shelfie',
          style: AppTypography.labelMedium.copyWith(
            color: AppColors.dark.foregroundMuted,
          ),
        ),
      ],
    );
  }
}

class _ShelfieLogoSmall extends StatelessWidget {
  const _ShelfieLogoSmall();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.circular(AppRadius.sm),
      child: Image.asset(
        'assets/icons/app_icon.png',
        width: 18,
        height: 18,
      ),
    );
  }
}

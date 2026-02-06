import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/theme/app_typography.dart';
import 'package:shelfie/features/book_share/domain/share_card_data.dart';

enum ShareCardStyle { simple, card }

class ShareCardWidget extends StatelessWidget {
  const ShareCardWidget({
    required this.data,
    required this.boundaryKey,
    this.accentColor,
    this.style = ShareCardStyle.card,
    super.key,
  });

  final ShareCardData data;
  final GlobalKey boundaryKey;
  final Color? accentColor;
  final ShareCardStyle style;

  static const double cardWidth = 1080;
  static const double cardHeight = 1350;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: boundaryKey,
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: switch (style) {
          ShareCardStyle.simple => _SimpleContent(
            data: data,
            accentColor: accentColor,
          ),
          ShareCardStyle.card => _CardContent(
            data: data,
            accentColor: accentColor,
          ),
        },
      ),
    );
  }
}

class _SimpleContent extends StatelessWidget {
  const _SimpleContent({required this.data, this.accentColor});

  final ShareCardData data;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.dark;

    return Container(
      decoration: BoxDecoration(color: accentColor ?? appColors.surfaceCard),
      child: Padding(
        padding: AppSpacing.all(48),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: _CoverImage(
                  thumbnailUrl: data.thumbnailUrl,
                  colors: appColors,
                ),
              ),
            ),
            const SizedBox(height: 36),
            Text(
              data.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTypography.titleLarge.copyWith(
                fontSize: 64,
                fontWeight: FontWeight.w600,
                color: appColors.foreground,
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              data.authors.join(', '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.copyWith(
                fontSize: 52,
                color: appColors.foreground,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ClipRRect(
                      borderRadius: AppRadius.circular(AppRadius.sm),
                      child: Image.asset(
                        'assets/icons/app_icon.png',
                        width: 52,
                        height: 52,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Shelfie',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: appColors.foreground,
                      fontSize: 52,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({required this.data, this.accentColor});

  final ShareCardData data;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.dark;

    return ColoredBox(
      color: accentColor ?? appColors.surfaceCard,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 190, vertical: 48),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: const Color(0x66000000),
            borderRadius: AppRadius.circular(32),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Center(
                  child: _CoverImage(
                    thumbnailUrl: data.thumbnailUrl,
                    colors: appColors,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              Text(
                data.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppTypography.titleLarge.copyWith(
                  fontSize: 64,
                  fontWeight: FontWeight.w600,
                  color: appColors.foreground,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                data.authors.join(', '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppTypography.bodyMedium.copyWith(
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  color: appColors.foregroundMuted,
                ),
              ),
              const SizedBox(height: 48),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: AppRadius.circular(AppRadius.sm),
                      child: Image.asset(
                        'assets/icons/app_icon.png',
                        width: 52,
                        height: 52,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Shelfie',
                      style: AppTypography.bodySmall.copyWith(
                        color: appColors.foreground,
                        fontWeight: FontWeight.w600,
                        fontSize: 52,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoverImage extends StatelessWidget {
  const _CoverImage({required this.thumbnailUrl, required this.colors});

  final String? thumbnailUrl;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: AppRadius.circular(20),
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

class BookListCard extends StatelessWidget {
  const BookListCard({
    required this.summary,
    required this.onTap,
    super.key,
  });

  final BookListSummary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: _CardContent(summary: summary),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({required this.summary});

  final BookListSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Container(
      decoration: BoxDecoration(
        color: appColors.surfaceCard,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: summary.coverImages.isEmpty
                  ? _CoverPlaceholder(appColors: appColors)
                  : CoverCollage(coverImages: summary.coverImages),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  summary.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  '${summary.bookCount}冊',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: appColors.foregroundMuted,
                  ),
                ),
                if (summary.description != null) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    summary.description!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: appColors.foregroundMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder({required this.appColors});

  final AppColors appColors;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: appColors.surface,
      child: Center(
        child: Icon(
          Icons.collections_bookmark,
          size: 32,
          color: appColors.foregroundMuted,
        ),
      ),
    );
  }
}

class CoverCollage extends StatelessWidget {
  const CoverCollage({required this.coverImages, super.key});

  final List<String> coverImages;

  @override
  Widget build(BuildContext context) {
    final images = coverImages.take(4).toList();

    return switch (images.length) {
      1 => _SingleImageLayout(imageUrl: images[0]),
      2 => _TwoImagesLayout(imageUrls: images),
      3 => _ThreeImagesLayout(imageUrls: images),
      _ => _FourImagesLayout(imageUrls: images),
    };
  }
}

class _SingleImageLayout extends StatelessWidget {
  const _SingleImageLayout({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return _CoverImage(imageUrl: imageUrl);
  }
}

class _TwoImagesLayout extends StatelessWidget {
  const _TwoImagesLayout({required this.imageUrls});

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _CoverImage(imageUrl: imageUrls[0])),
        const SizedBox(width: 2),
        Expanded(child: _CoverImage(imageUrl: imageUrls[1])),
      ],
    );
  }
}

class _ThreeImagesLayout extends StatelessWidget {
  const _ThreeImagesLayout({required this.imageUrls});

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _CoverImage(imageUrl: imageUrls[0])),
        const SizedBox(height: 2),
        Expanded(
          child: Row(
            children: [
              Expanded(child: _CoverImage(imageUrl: imageUrls[1])),
              const SizedBox(width: 2),
              Expanded(child: _CoverImage(imageUrl: imageUrls[2])),
            ],
          ),
        ),
      ],
    );
  }
}

class _FourImagesLayout extends StatelessWidget {
  const _FourImagesLayout({required this.imageUrls});

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      physics: const NeverScrollableScrollPhysics(),
      children: imageUrls.map((url) => _CoverImage(imageUrl: url)).toList(),
    );
  }
}

class _CoverImage extends StatelessWidget {
  const _CoverImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) => ColoredBox(
        color: appColors.surface,
      ),
      errorWidget: (context, url, error) => ColoredBox(
        color: appColors.surface,
        child: Icon(
          Icons.book,
          color: appColors.foregroundMuted,
        ),
      ),
    );
  }
}

class SingleCoverImage extends StatelessWidget {
  const SingleCoverImage({required this.imageUrl, super.key});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => ColoredBox(
        color: appColors.surface,
      ),
      errorWidget: (context, url, error) => ColoredBox(
        color: appColors.surface,
        child: Icon(
          Icons.book,
          color: appColors.foregroundMuted,
        ),
      ),
    );
  }
}

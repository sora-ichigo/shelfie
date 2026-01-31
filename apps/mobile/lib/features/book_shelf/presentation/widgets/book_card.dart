import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_icon_size.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/theme/app_typography.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

/// 書籍カードコンポーネント
///
/// 本棚画面でグリッド表示される個別書籍のカード。
/// カバー画像、星評価、タイトル、著者名を表示する。
/// 読書状態（rating 等）は shelfStateProvider から取得する。
class BookCard extends ConsumerWidget {
  const BookCard({
    required this.book,
    required this.onTap,
    this.onLongPress,
    super.key,
  });

  final ShelfBookItem book;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    // shelfStateProvider から最新の rating を取得
    final rating = ref.watch(
      shelfStateProvider.select((s) => s[book.externalId]?.rating),
    );
    final hasRating = rating != null;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: _buildCoverImage(appColors),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          if (hasRating) ...[
            _buildRating(appColors, rating),
            const SizedBox(height: AppSpacing.xxs),
          ],
          _buildTitle(theme),
        ],
      ),
    );
  }

  Widget _buildCoverImage(AppColors appColors) {
    if (book.hasCoverImage) {
      return CachedNetworkImage(
        imageUrl: book.coverImageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        placeholder: (context, url) => _buildPlaceholder(appColors),
        errorWidget: (context, url, error) => _buildPlaceholder(appColors),
      );
    }
    return _buildPlaceholder(appColors);
  }

  Widget _buildPlaceholder(AppColors appColors) {
    return ColoredBox(
      color: appColors.overlay,
      child: Center(
        child: Icon(
          Icons.book,
          size: 40,
          color: appColors.foregroundMuted,
        ),
      ),
    );
  }

  Widget _buildRating(AppColors appColors, int rating) {
    return Semantics(
      label: '評価: $ratingつ星（5つ星中）',
      child: ExcludeSemantics(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            final isFilled = index < rating;
            return Icon(
              isFilled ? Icons.star : Icons.star_border,
              size: AppIconSize.xs,
              color: appColors.accentSecondary,
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTitle(ThemeData theme) {
    return Text(
      book.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.bodySmall,
    );
  }
}

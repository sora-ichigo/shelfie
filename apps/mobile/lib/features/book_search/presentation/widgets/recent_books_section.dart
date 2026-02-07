import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_search/domain/recent_book_entry.dart';

/// 検索タブ初期表示時に「最近チェックした本」を表示する UI コンポーネント
///
/// 水平スクロール可能なリスト形式で最近閲覧した書籍を表示する。
/// カバー画像が取得できない場合はプレースホルダーアイコンを表示。
/// 履歴が空の場合はセクション全体を非表示にする。
class RecentBooksSection extends StatelessWidget {
  const RecentBooksSection({
    required this.books,
    required this.onBookTap,
    this.onBookLongPress,
    super.key,
  });

  final List<RecentBookEntry> books;
  final void Function(RecentBookEntry book) onBookTap;
  final void Function(RecentBookEntry book)? onBookLongPress;

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Text(
            '最近チェックした本',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index < books.length - 1 ? AppSpacing.sm : 0,
                ),
                child: _RecentBookCard(
                  book: book,
                  onTap: () => onBookTap(book),
                  onLongPress:
                      onBookLongPress != null ? () => onBookLongPress!(book) : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RecentBookCard extends StatelessWidget {
  const _RecentBookCard({
    required this.book,
    required this.onTap,
    this.onLongPress,
  });

  final RecentBookEntry book;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    const cardWidth = 100.0;
    const imageHeight = 130.0;
    const borderRadius = BorderRadius.all(Radius.circular(8));

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: borderRadius,
      child: SizedBox(
        width: cardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: borderRadius,
              child: SizedBox(
                width: cardWidth,
                height: imageHeight,
                child: _buildCoverImage(context),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Expanded(
              child: Text(
                book.title,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImage(BuildContext context) {
    if (book.coverImageUrl == null) {
      return _buildPlaceholder(context);
    }

    return CachedNetworkImage(
      imageUrl: book.coverImageUrl!,
      fit: BoxFit.cover,
      placeholder: (context, url) => _buildPlaceholder(context),
      errorWidget: (context, url, error) => _buildPlaceholder(context),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return ColoredBox(
      color: appColors.surfaceElevated,
      child: Center(
        child: Icon(
          Icons.book,
          size: 40,
          color: appColors.textSecondary,
        ),
      ),
    );
  }
}

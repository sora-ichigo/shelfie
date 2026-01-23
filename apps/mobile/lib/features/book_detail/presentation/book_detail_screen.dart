import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/presentation/services/share_service.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/book_info_section.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/external_links_section.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/reading_note_modal.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/reading_record_section.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/reading_status_modal.dart';
import 'package:url_launcher/url_launcher.dart';

/// 本詳細画面
///
/// 書籍の詳細情報を表示し、本棚への追加・読書記録の管理機能を提供する。
class BookDetailScreen extends ConsumerStatefulWidget {
  const BookDetailScreen({
    required this.bookId,
    super.key,
  });

  final String bookId;

  @override
  ConsumerState<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends ConsumerState<BookDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookDetailNotifierProvider(widget.bookId).notifier).loadBookDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookDetailNotifierProvider(widget.bookId));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: _CircleIconButton(
            icon: Icons.close,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: _CircleIconButton(
              icon: Icons.share,
              onPressed: _onSharePressed,
            ),
          ),
        ],
      ),
      body: state.when(
        data: (bookDetail) => _buildContent(bookDetail),
        loading: () => const LoadingIndicator(fullScreen: true),
        error: (error, _) => _buildErrorView(error),
      ),
    );
  }

  Widget _buildContent(BookDetail? bookDetail) {
    if (bookDetail == null) {
      return const LoadingIndicator(fullScreen: true);
    }

    return Stack(
      children: [
        _buildBackgroundGradient(),
        SingleChildScrollView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + kToolbarHeight + AppSpacing.md,
            left: AppSpacing.md,
            right: AppSpacing.md,
            bottom: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BookInfoSection(
                bookDetail: bookDetail,
                isInShelf: bookDetail.isInShelf,
                onAddToShelfPressed: _onAddToShelfPressed,
              ),
              const SizedBox(height: AppSpacing.lg),
              if (bookDetail.isInShelf)
                ReadingRecordSection(
                  userBook: bookDetail.userBook!,
                  onStatusTap: _onStatusTap,
                  onNoteTap: _onNoteTap,
                ),
              if (bookDetail.amazonUrl != null || bookDetail.infoLink != null) ...[
                const SizedBox(height: AppSpacing.lg),
                ExternalLinksSection(
                  amazonUrl: bookDetail.amazonUrl,
                  infoLink: bookDetail.infoLink,
                  onLinkTap: _onLinkTap,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundGradient() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 400,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.3),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorView(Object error) {
    final failure = error is Failure
        ? error
        : UnexpectedFailure(message: error.toString());

    return ErrorView(
      failure: failure,
      onRetry: _onRetry,
      retryButtonText: '再試行',
    );
  }

  Future<void> _onSharePressed() async {
    final state = ref.read(bookDetailNotifierProvider(widget.bookId));
    final bookDetail = state.value;
    if (bookDetail == null) return;

    final shareService = ref.read(shareServiceProvider);
    await shareService.shareBook(
      title: bookDetail.title,
      url: bookDetail.amazonUrl ?? bookDetail.infoLink,
    );
  }

  void _onAddToShelfPressed() {
    // TODO: Implement add to shelf functionality
  }

  void _onStatusTap() {
    final state = ref.read(bookDetailNotifierProvider(widget.bookId));
    final userBook = state.value?.userBook;
    if (userBook == null) return;

    showReadingStatusModal(
      context: context,
      currentStatus: userBook.readingStatus,
      userBookId: userBook.id,
      externalId: widget.bookId,
    );
  }

  void _onNoteTap() {
    final state = ref.read(bookDetailNotifierProvider(widget.bookId));
    final userBook = state.value?.userBook;
    if (userBook == null) return;

    showReadingNoteModal(
      context: context,
      currentNote: userBook.note,
      userBookId: userBook.id,
      externalId: widget.bookId,
    );
  }

  Future<void> _onLinkTap(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _onRetry() {
    ref.read(bookDetailNotifierProvider(widget.bookId).notifier).loadBookDetail();
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}

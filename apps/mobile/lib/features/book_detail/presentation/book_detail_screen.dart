import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/presentation/services/share_service.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/book_info_section.dart';
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
      ref
          .read(bookDetailNotifierProvider(widget.bookId).notifier)
          .loadBookDetail();
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.xs),
            child: IconButton(
              icon: const Icon(Icons.share),
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

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top +
            kToolbarHeight +
            AppSpacing.md,
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
            onRemoveFromShelfPressed: _onRemoveFromShelfPressed,
            onLinkTap: _onLinkTap,
          ),
          const SizedBox(height: AppSpacing.lg),
          if (bookDetail.isInShelf)
            ReadingRecordSection(
              userBook: bookDetail.userBook!,
              onStatusTap: _onStatusTap,
              onNoteTap: _onNoteTap,
            ),
        ],
      ),
    );
  }

  Widget _buildErrorView(Object error) {
    final failure =
        error is Failure ? error : UnexpectedFailure(message: error.toString());

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
      url: bookDetail.amazonUrl ?? bookDetail.googleBooksUrl,
    );
  }

  Future<void> _onAddToShelfPressed() async {
    final result = await ref
        .read(bookDetailNotifierProvider(widget.bookId).notifier)
        .addToShelf();

    if (!mounted) return;

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      },
      (_) {},
    );
  }

  Future<void> _onRemoveFromShelfPressed() async {
    final result = await ref
        .read(bookDetailNotifierProvider(widget.bookId).notifier)
        .removeFromShelf();

    if (!mounted) return;

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      },
      (_) {},
    );
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
    ref
        .read(bookDetailNotifierProvider(widget.bookId).notifier)
        .loadBookDetail();
  }
}

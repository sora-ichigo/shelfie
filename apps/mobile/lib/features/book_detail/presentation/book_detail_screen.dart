import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/book_info_section.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/external_links_section.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/reading_record_section.dart';

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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _onSharePressed,
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
      padding: AppSpacing.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookInfoSection(bookDetail: bookDetail),
          const SizedBox(height: AppSpacing.lg),
          if (bookDetail.isInShelf)
            ReadingRecordSection(
              userBook: bookDetail.userBook!,
              onStatusTap: _onStatusTap,
              onNoteTap: _onNoteTap,
            )
          else
            _buildAddToShelfButton(),
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
    );
  }

  Widget _buildAddToShelfButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _onAddToShelfPressed,
        icon: const Icon(Icons.add),
        label: const Text('本棚に追加'),
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

  void _onSharePressed() {
    // TODO: Implement share functionality
  }

  void _onAddToShelfPressed() {
    // TODO: Implement add to shelf functionality
  }

  void _onStatusTap() {
    // TODO: Implement status modal
  }

  void _onNoteTap() {
    // TODO: Implement note modal
  }

  Future<void> _onLinkTap(String url) async {
    // TODO: Implement url_launcher
  }

  void _onRetry() {
    ref.read(bookDetailNotifierProvider(widget.bookId).notifier).loadBookDetail();
  }
}

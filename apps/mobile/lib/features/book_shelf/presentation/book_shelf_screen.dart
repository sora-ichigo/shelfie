import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/empty_state.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/core/widgets/screen_header.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_notifier.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_state.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_grid.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/search_filter_bar.dart';
import 'package:shelfie/routing/app_router.dart';

/// 本棚画面
///
/// ユーザーの登録した書籍を一覧表示し、検索・ソート・グループ化機能を提供する。
/// ローディング、空状態、エラー状態のハンドリングを含む。
class BookShelfScreen extends ConsumerStatefulWidget {
  const BookShelfScreen({super.key});

  @override
  ConsumerState<BookShelfScreen> createState() => _BookShelfScreenState();
}

class _BookShelfScreenState extends ConsumerState<BookShelfScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookShelfNotifierProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookShelfNotifierProvider);
    final accountAsync = ref.watch(accountNotifierProvider);
    final avatarUrl = accountAsync.valueOrNull?.avatarUrl;

    return SafeArea(
      child: Column(
        children: [
          ScreenHeader(
            title: '本棚',
            onProfileTap: () => context.push(AppRoutes.account),
            avatarUrl: avatarUrl,
            isAvatarLoading: accountAsync.isLoading,
          ),
          Expanded(
            child: _buildContent(state),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BookShelfState state) {
    return switch (state) {
      BookShelfInitial() => const LoadingIndicator(fullScreen: true),
      BookShelfLoading() => const LoadingIndicator(fullScreen: true),
      BookShelfLoaded() => _buildLoadedContent(state),
      BookShelfError(:final failure) => ErrorView(
          failure: failure,
          onRetry: () => ref.read(bookShelfNotifierProvider.notifier).refresh(),
          retryButtonText: 'リトライ',
        ),
    };
  }

  Widget _buildLoadedContent(BookShelfLoaded state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          child: SearchFilterBar(
            sortOption: state.sortOption,
            groupOption: state.groupOption,
            onSortChanged: (option) {
              ref
                  .read(bookShelfNotifierProvider.notifier)
                  .setSortOption(option);
            },
            onGroupChanged: (option) {
              ref
                  .read(bookShelfNotifierProvider.notifier)
                  .setGroupOption(option);
            },
          ),
        ),
        Expanded(
          child: _buildBookContent(state),
        ),
      ],
    );
  }

  Widget _buildBookContent(BookShelfLoaded state) {
    if (state.isEmpty) {
      return const EmptyState(
        icon: Icons.auto_stories_outlined,
        message: '本を追加してみましょう',
      );
    }

    return BookGrid(
      books: state.books,
      groupedBooks: state.groupedBooks,
      isGrouped: state.isGrouped,
      hasMore: state.hasMore,
      isLoadingMore: state.isLoadingMore,
      onBookTap: _onBookTap,
      onLoadMore: () {
        ref.read(bookShelfNotifierProvider.notifier).loadMore();
      },
    );
  }

  void _onBookTap(ShelfBookItem book) {
    context.push(AppRoutes.bookDetail(bookId: book.externalId));
  }
}

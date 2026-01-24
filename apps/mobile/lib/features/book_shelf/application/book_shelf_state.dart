import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

part 'book_shelf_state.freezed.dart';

/// 本棚画面の状態
///
/// sealed class により exhaustive なパターンマッチングを強制。
/// 4つの状態を持つ: initial, loading, loaded, error
@freezed
sealed class BookShelfState with _$BookShelfState {
  /// 初期状態
  const factory BookShelfState.initial() = BookShelfInitial;

  /// ローディング中（初回読み込み）
  const factory BookShelfState.loading() = BookShelfLoading;

  /// 読み込み完了
  const factory BookShelfState.loaded({
    /// 書籍リスト
    required List<ShelfBookItem> books,

    /// 現在の検索クエリ
    required String searchQuery,

    /// 現在のソートオプション
    required SortOption sortOption,

    /// 現在のグループ化オプション
    required GroupOption groupOption,

    /// グループ化された書籍マップ（グループ名 → 書籍リスト）
    required Map<String, List<ShelfBookItem>> groupedBooks,

    /// 次のページがあるかどうか
    required bool hasMore,

    /// 追加読み込み中かどうか
    required bool isLoadingMore,

    /// 総件数
    required int totalCount,
  }) = BookShelfLoaded;

  /// エラー
  const factory BookShelfState.error({
    /// エラー情報
    required Failure failure,
  }) = BookShelfError;
}

/// BookShelfLoaded の拡張メソッド
extension BookShelfLoadedX on BookShelfLoaded {
  /// 書籍リストが空かどうか
  bool get isEmpty => books.isEmpty;

  /// 検索クエリが設定されているかどうか
  bool get hasSearchQuery => searchQuery.isNotEmpty;

  /// グループ化が有効かどうか
  bool get isGrouped => groupOption != GroupOption.none;

  /// 追加読み込みが可能かどうか
  bool get canLoadMore => hasMore && !isLoadingMore;
}

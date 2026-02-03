import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';

/// ソートオプションを表す列挙型
///
/// 本棚画面での書籍の並び順を定義する。
/// サーバーサイドでソートが実行される。
enum SortOption {
  /// 追加日（新しい）- デフォルト
  addedAtDesc(
    displayName: '追加日（新しい）',
    sortField: GShelfSortField.ADDED_AT,
    sortOrder: GSortOrder.DESC,
  ),

  /// 追加日（古い）
  addedAtAsc(
    displayName: '追加日（古い）',
    sortField: GShelfSortField.ADDED_AT,
    sortOrder: GSortOrder.ASC,
  ),

  /// 読了日（新しい）
  completedAtDesc(
    displayName: '読了日（新しい）',
    sortField: GShelfSortField.COMPLETED_AT,
    sortOrder: GSortOrder.DESC,
  ),

  /// 読了日（古い）
  completedAtAsc(
    displayName: '読了日（古い）',
    sortField: GShelfSortField.COMPLETED_AT,
    sortOrder: GSortOrder.ASC,
  ),

  /// 発売日（新しい）
  publishedDateDesc(
    displayName: '発売日（新しい）',
    sortField: GShelfSortField.PUBLISHED_DATE,
    sortOrder: GSortOrder.DESC,
  ),

  /// 発売日（古い）
  publishedDateAsc(
    displayName: '発売日（古い）',
    sortField: GShelfSortField.PUBLISHED_DATE,
    sortOrder: GSortOrder.ASC,
  ),

  /// タイトル（A→Z）
  titleAsc(
    displayName: 'タイトル（A→Z）',
    sortField: GShelfSortField.TITLE,
    sortOrder: GSortOrder.ASC,
  ),

  /// 著者名（A→Z）
  authorAsc(
    displayName: '著者名（A→Z）',
    sortField: GShelfSortField.AUTHOR,
    sortOrder: GSortOrder.ASC,
  );

  const SortOption({
    required this.displayName,
    required this.sortField,
    required this.sortOrder,
  });

  /// 日本語の表示名
  final String displayName;

  /// サーバーAPIのソートフィールド
  final GShelfSortField sortField;

  /// サーバーAPIのソート順序
  final GSortOrder sortOrder;

  /// UI表示対象のソートオプション
  static List<SortOption> get visibleValues =>
      values.where((v) => v != titleAsc).toList();

  /// デフォルトのソートオプション
  static SortOption get defaultOption => SortOption.addedAtDesc;
}

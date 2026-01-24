/// ソートオプションを表す列挙型
///
/// 本棚画面での書籍の並び順を定義する。
/// サーバーサイドでソートが実行される。
enum SortOption {
  /// 追加日（新しい順）- デフォルト
  addedAtDesc(
    displayName: '追加日（新しい順）',
    sortField: 'ADDED_AT',
    sortOrder: 'DESC',
  ),

  /// 追加日（古い順）
  addedAtAsc(
    displayName: '追加日（古い順）',
    sortField: 'ADDED_AT',
    sortOrder: 'ASC',
  ),

  /// タイトル（A→Z）
  titleAsc(
    displayName: 'タイトル（A→Z）',
    sortField: 'TITLE',
    sortOrder: 'ASC',
  ),

  /// 著者名（A→Z）
  authorAsc(
    displayName: '著者名（A→Z）',
    sortField: 'AUTHOR',
    sortOrder: 'ASC',
  );

  const SortOption({
    required this.displayName,
    required this.sortField,
    required this.sortOrder,
  });

  /// 日本語の表示名
  final String displayName;

  /// サーバーAPIのソートフィールド
  final String sortField;

  /// サーバーAPIのソート順序
  final String sortOrder;

  /// デフォルトのソートオプション
  static SortOption get defaultOption => SortOption.addedAtDesc;
}

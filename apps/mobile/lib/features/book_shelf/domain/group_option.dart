/// グループ化オプションを表す列挙型
///
/// 本棚画面でのグループ化方式を定義する。
/// クライアント側でグルーピングが実行される。
enum GroupOption {
  /// すべて（グループ化なし）- デフォルト
  none(displayName: 'すべて'),

  /// ステータス別
  byStatus(displayName: 'ステータス別'),

  /// 著者別
  byAuthor(displayName: '著者別');

  const GroupOption({
    required this.displayName,
  });

  /// 日本語の表示名
  final String displayName;

  /// デフォルトのグループ化オプション
  static GroupOption get defaultOption => GroupOption.none;
}

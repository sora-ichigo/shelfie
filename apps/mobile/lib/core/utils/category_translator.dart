const _categoryTranslations = <String, String>{
  // Comics & Graphic Novels
  'Comics & Graphic Novels': 'コミック',
  'Manga': 'マンガ',
  'For boys': '少年向け',
  'For girls': '少女向け',
  'For men': '青年向け',
  'For women': '女性向け',
  'Action & Adventure': 'アクション',
  'Occult & Supernatural': 'オカルト',
  'Fantasy': 'ファンタジー',
  'Science Fiction': 'SF',
  'Horror': 'ホラー',
  'Romance': 'ロマンス',
  'Comedy': 'コメディ',
  'Drama': 'ドラマ',
  'Mystery': 'ミステリー',
  'Thriller': 'スリラー',
  'Historical': '歴史',
  'Slice of Life': '日常',
  'Sports': 'スポーツ',
  'Music': '音楽',
  'School': '学園',

  // Fiction
  'Fiction': '小説',
  'Literary': '文学',
  'Contemporary': '現代',
  'Classics': '古典',
  'Short Stories': '短編',

  // Non-Fiction
  'Nonfiction': 'ノンフィクション',
  'Biography & Autobiography': '伝記',
  'Business & Economics': 'ビジネス',
  'Self-Help': '自己啓発',
  'Psychology': '心理学',
  'Philosophy': '哲学',
  'History': '歴史',
  'Science': '科学',
  'Technology': 'テクノロジー',
  'Computers': 'コンピュータ',
  'Art': 'アート',
  'Photography': '写真',
  'Cooking': '料理',
  'Health & Fitness': '健康',
  'Travel': '旅行',
  'Education': '教育',
  'Religion': '宗教',
  'Politics': '政治',
  'Social Science': '社会科学',
  'Nature': '自然',
  'True Crime': '犯罪実録',

  // Young Adult & Children
  'Young Adult Fiction': 'ヤングアダルト',
  'Juvenile Fiction': '児童書',
  'Children': '子供向け',

  // Light Novels
  'Light Novel': 'ライトノベル',
  'Light Novels': 'ライトノベル',
};

/// Google Books APIから取得した英語カテゴリを日本語に変換する
///
/// カテゴリは "/" で区切られた階層構造になっている場合があるため、
/// 各セグメントを個別に翻訳し、最も具体的な（末尾の）カテゴリを優先して返す。
/// 翻訳が見つからない場合は null を返す。
String? translateCategory(String category) {
  final segments = category.split(' / ');

  // 末尾から翻訳を試みる（より具体的なカテゴリを優先）
  for (var i = segments.length - 1; i >= 0; i--) {
    final segment = segments[i].trim();
    final translation = _categoryTranslations[segment];
    if (translation != null) {
      return translation;
    }
  }

  // 翻訳が見つからない場合は表示しない
  return null;
}

/// カテゴリリストを日本語に変換し、翻訳できないものは除外、重複を除去する
List<String> translateCategories(List<String> categories) {
  final translated = categories
      .map(translateCategory)
      .whereType<String>()
      .toSet()
      .toList();
  return translated;
}

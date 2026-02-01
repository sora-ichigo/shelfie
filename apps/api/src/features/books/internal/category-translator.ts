const googleCategoryTranslations: Record<string, string> = {
  // Comics & Graphic Novels
  "Comics & Graphic Novels": "コミック",
  Manga: "マンガ",
  "For boys": "少年向け",
  "For girls": "少女向け",
  "For men": "青年向け",
  "For women": "女性向け",
  "Action & Adventure": "アクション",
  "Occult & Supernatural": "オカルト",
  Fantasy: "ファンタジー",
  "Science Fiction": "SF",
  Horror: "ホラー",
  Romance: "ロマンス",
  Comedy: "コメディ",
  Drama: "ドラマ",
  Mystery: "ミステリー",
  Thriller: "スリラー",
  Historical: "歴史",
  "Slice of Life": "日常",
  Sports: "スポーツ",
  Music: "音楽",
  School: "学園",

  // Fiction
  Fiction: "小説",
  Literary: "文学",
  Contemporary: "現代",
  Classics: "古典",
  "Short Stories": "短編",

  // Non-Fiction
  Nonfiction: "ノンフィクション",
  "Biography & Autobiography": "伝記",
  "Business & Economics": "ビジネス",
  "Self-Help": "自己啓発",
  Psychology: "心理学",
  Philosophy: "哲学",
  History: "歴史",
  Science: "科学",
  Technology: "テクノロジー",
  Computers: "コンピュータ",
  Art: "アート",
  Photography: "写真",
  Cooking: "料理",
  "Health & Fitness": "健康",
  Travel: "旅行",
  Education: "教育",
  Religion: "宗教",
  Politics: "政治",
  "Social Science": "社会科学",
  Nature: "自然",
  "True Crime": "犯罪実録",

  // Young Adult & Children
  "Young Adult Fiction": "ヤングアダルト",
  "Juvenile Fiction": "児童書",
  Children: "子供向け",

  // Light Novels
  "Light Novel": "ライトノベル",
  "Light Novels": "ライトノベル",
};

/**
 * 楽天ブックスジャンルID → 日本語名の静的マッピング
 * 第2階層（6桁）と第3階層（9桁）をカバー
 */
const rakutenGenreMap: Record<string, string> = {
  // 第2階層
  "001001": "コミック",
  "001002": "語学・学習参考書",
  "001003": "絵本・児童書・図鑑",
  "001004": "ライトノベル",
  "001005": "小説・エッセイ",
  "001006": "ビジネス・経済・就職",
  "001007": "旅行・留学・アウトドア",
  "001008": "人文・思想・社会",
  "001009": "美容・暮らし・健康・料理",
  "001010": "ホビー・スポーツ・美術",
  "001011": "科学・技術",
  "001012": "PC・システム開発",
  "001013": "新書",
  "001016": "資格・検定",
  "001017": "文庫",
  "001018": "文芸",
  "001019": "ノンフィクション",
  "001020": "音楽",
  "001021": "エンタメ",
  "001025": "写真集・タレント",
  "001026": "地図・ガイド",
  "001028": "カレンダー・手帳・家計簿",
  "001029": "その他",

  // コミック 第3階層
  "001001001": "少年コミック",
  "001001002": "少女コミック",
  "001001003": "青年コミック",
  "001001004": "レディースコミック",
  "001001005": "ボーイズラブ",
  "001001006": "ティーンズラブ",
  "001001007": "4コマ",
  "001001008": "同人誌",
  "001001009": "コミックエッセイ",

  // ライトノベル 第3階層
  "001004001": "ライトノベル(少年向け)",
  "001004002": "ライトノベル(少女向け)",
  "001004003": "ライトノベル(その他)",
  "001004008": "ライトノベル(男性向け)",
  "001004009": "ライトノベル(女性向け)",

  // 小説・エッセイ 第3階層
  "001005001": "日本の小説",
  "001005002": "外国の小説",
  "001005003": "エッセイ",
  "001005004": "ミステリー・サスペンス",
  "001005005": "SF・ホラー",
  "001005006": "歴史・時代小説",
  "001005007": "経済・社会小説",
  "001005008": "ロマンス",
  "001005009": "詩歌・俳諧",

  // ビジネス・経済・就職 第3階層
  "001006001": "経済・財政",
  "001006002": "経営",
  "001006003": "マネジメント",
  "001006004": "マーケティング・セールス",
  "001006005": "仕事術・整理法",
  "001006006": "自己啓発",
  "001006007": "起業・開業",
  "001006008": "投資・株・資産運用",

  // 人文・思想・社会 第3階層
  "001008001": "哲学・思想",
  "001008002": "宗教",
  "001008003": "心理学",
  "001008004": "教育",
  "001008005": "社会",
  "001008006": "政治",
  "001008007": "福祉",

  // 科学・技術 第3階層
  "001011001": "数学",
  "001011002": "物理学",
  "001011003": "化学",
  "001011004": "生物学",
  "001011005": "地学・天文学",
  "001011006": "工学",
  "001011007": "建築・土木",
  "001011008": "医学・薬学",

  // PC・システム開発 第3階層
  "001012001": "パソコン入門",
  "001012002": "OS",
  "001012003": "プログラミング",
  "001012004": "インターネット・Web開発",
  "001012005": "データベース",
  "001012006": "ネットワーク",
};

/**
 * Google Booksの英語カテゴリを日本語に翻訳する。
 * 階層カテゴリ（"A / B / C"）は末尾から翻訳を試み、最初にヒットしたものを返す。
 */
export function translateGoogleCategory(category: string): string | null {
  const segments = category.split(" / ");

  for (let i = segments.length - 1; i >= 0; i--) {
    const segment = segments[i].trim();
    const translation = googleCategoryTranslations[segment];
    if (translation) {
      return translation;
    }
  }

  return null;
}

/**
 * Google Booksのカテゴリリストを日本語に翻訳し、null除外・重複除去する。
 */
export function translateGoogleCategories(categories: string[]): string[] {
  const seen = new Set<string>();
  const result: string[] = [];

  for (const category of categories) {
    const translated = translateGoogleCategory(category);
    if (translated && !seen.has(translated)) {
      seen.add(translated);
      result.push(translated);
    }
  }

  return result;
}

/**
 * 楽天ブックスのジャンルID（6桁 or 9桁）を日本語名に解決する。
 * 未知の第3階層IDは親（第2階層）にフォールバック。
 */
export function resolveRakutenGenreName(genreId: string): string | null {
  const direct = rakutenGenreMap[genreId];
  if (direct) {
    return direct;
  }

  if (genreId.length === 9) {
    const parent = genreId.slice(0, 6);
    return rakutenGenreMap[parent] ?? null;
  }

  return null;
}

/**
 * 楽天ブックスの"/"区切りジャンルIDを日本語名リストに解決する。
 * null除外・重複除去。
 */
export function resolveRakutenGenreNames(booksGenreId: string): string[] {
  if (!booksGenreId) {
    return [];
  }

  const ids = booksGenreId.split("/").filter(Boolean);
  const seen = new Set<string>();
  const result: string[] = [];

  for (const id of ids) {
    const name = resolveRakutenGenreName(id);
    if (name && !seen.has(name)) {
      seen.add(name);
      result.push(name);
    }
  }

  return result;
}

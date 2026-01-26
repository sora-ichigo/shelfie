export interface GoogleBooksVolumeInfo {
  title: string;
  authors?: string[];
  publisher?: string;
  publishedDate?: string;
  description?: string;
  industryIdentifiers?: Array<{
    type: "ISBN_10" | "ISBN_13" | string;
    identifier: string;
  }>;
  pageCount?: number;
  categories?: string[];
  imageLinks?: {
    thumbnail?: string;
    smallThumbnail?: string;
  };
}

export interface GoogleBooksVolume {
  kind: string;
  id: string;
  volumeInfo: GoogleBooksVolumeInfo;
}

export interface RakutenBooksItem {
  title: string;
  titleKana?: string;
  subTitle?: string;
  subTitleKana?: string;
  seriesName?: string;
  author: string;
  authorKana?: string;
  publisherName: string;
  isbn: string;
  itemCaption?: string;
  itemPrice: number;
  salesDate: string;
  availability: string;
  itemUrl: string;
  smallImageUrl?: string;
  mediumImageUrl?: string;
  largeImageUrl?: string;
  chirayomiUrl?: string;
  reviewCount: number;
  reviewAverage: string;
  booksGenreId: string;
  size?: string;
  contents?: string;
}

export type BookSource = "rakuten" | "google";

export interface Book {
  id: string;
  title: string;
  authors: string[];
  publisher: string | null;
  publishedDate: string | null;
  isbn: string | null;
  coverImageUrl: string | null;
  source: BookSource;
}

function parseAuthors(author: string): string[] {
  if (!author) {
    return [];
  }
  return author
    .split("/")
    .map((a) => a.trim())
    .filter(Boolean);
}

function parseSalesDate(salesDate: string): string | null {
  if (!salesDate) {
    return null;
  }
  const match = salesDate.match(/(\d{4})年(\d{1,2})月?(\d{1,2})?日?/);
  if (!match) {
    return salesDate;
  }

  const year = match[1];
  const month = match[2].padStart(2, "0");
  const day = match[3]?.padStart(2, "0");

  if (day) {
    return `${year}-${month}-${day}`;
  }
  return `${year}-${month}`;
}

function extractCoverImageUrl(item: RakutenBooksItem): string | null {
  return (
    item.largeImageUrl ?? item.mediumImageUrl ?? item.smallImageUrl ?? null
  );
}

export function mapRakutenBooksItem(item: RakutenBooksItem): Book {
  return {
    id: item.isbn,
    title: item.title,
    authors: parseAuthors(item.author),
    publisher: item.publisherName ?? null,
    publishedDate: parseSalesDate(item.salesDate),
    isbn: item.isbn,
    coverImageUrl: extractCoverImageUrl(item),
    source: "rakuten",
  };
}

export interface BookDetail {
  id: string;
  title: string;
  authors: string[];
  publisher: string | null;
  publishedDate: string | null;
  pageCount: number | null;
  categories: string[] | null;
  description: string | null;
  isbn: string | null;
  coverImageUrl: string | null;
  amazonUrl: string | null;
  /** @deprecated Use rakutenBooksUrl instead */
  googleBooksUrl: string | null;
  rakutenBooksUrl: string | null;
}

function generateAmazonUrl(isbn: string | null): string | null {
  if (!isbn) {
    return null;
  }
  return `https://www.amazon.co.jp/dp/${isbn}`;
}

function extractIsbn(
  identifiers?: GoogleBooksVolumeInfo["industryIdentifiers"],
): string | null {
  if (!identifiers || identifiers.length === 0) {
    return null;
  }

  const isbn13 = identifiers.find((id) => id.type === "ISBN_13");
  if (isbn13) {
    return isbn13.identifier;
  }

  const isbn10 = identifiers.find((id) => id.type === "ISBN_10");
  if (isbn10) {
    return isbn10.identifier;
  }

  return null;
}

function extractGoogleBooksCoverImageUrl(
  imageLinks?: GoogleBooksVolumeInfo["imageLinks"],
): string | null {
  if (!imageLinks) {
    return null;
  }
  return imageLinks.thumbnail ?? imageLinks.smallThumbnail ?? null;
}

export function mapGoogleBooksVolume(volume: GoogleBooksVolume): Book {
  const { volumeInfo } = volume;
  const isbn = extractIsbn(volumeInfo.industryIdentifiers);

  return {
    id: isbn ?? volume.id,
    title: volumeInfo.title,
    authors: volumeInfo.authors ?? [],
    publisher: volumeInfo.publisher ?? null,
    publishedDate: volumeInfo.publishedDate ?? null,
    isbn,
    coverImageUrl: extractGoogleBooksCoverImageUrl(volumeInfo.imageLinks),
    source: "google",
  };
}

export function mapRakutenBooksItemToDetail(
  item: RakutenBooksItem,
): BookDetail {
  const isbn = item.isbn;

  return {
    id: isbn,
    title: item.title,
    authors: parseAuthors(item.author),
    publisher: item.publisherName ?? null,
    publishedDate: parseSalesDate(item.salesDate),
    pageCount: null,
    categories: item.booksGenreId ? [item.booksGenreId] : null,
    description: item.itemCaption ?? null,
    isbn,
    coverImageUrl: extractCoverImageUrl(item),
    amazonUrl: generateAmazonUrl(isbn),
    googleBooksUrl: null,
    rakutenBooksUrl: item.itemUrl ?? null,
  };
}

function generateGoogleBooksUrl(volumeId: string): string {
  return `https://books.google.com/books?id=${volumeId}`;
}

export function mapGoogleBooksVolumeToDetail(
  volume: GoogleBooksVolume,
): BookDetail {
  const { volumeInfo } = volume;
  const isbn = extractIsbn(volumeInfo.industryIdentifiers);

  return {
    id: isbn ?? volume.id,
    title: volumeInfo.title,
    authors: volumeInfo.authors ?? [],
    publisher: volumeInfo.publisher ?? null,
    publishedDate: volumeInfo.publishedDate ?? null,
    pageCount: volumeInfo.pageCount ?? null,
    categories: volumeInfo.categories ?? null,
    description: volumeInfo.description ?? null,
    isbn,
    coverImageUrl: extractGoogleBooksCoverImageUrl(volumeInfo.imageLinks),
    amazonUrl: generateAmazonUrl(isbn),
    googleBooksUrl: generateGoogleBooksUrl(volume.id),
    rakutenBooksUrl: null,
  };
}

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

export interface Book {
  id: string;
  title: string;
  authors: string[];
  publisher: string | null;
  publishedDate: string | null;
  isbn: string | null;
  coverImageUrl: string | null;
}

function parseAuthors(author: string): string[] {
  if (!author) {
    return [];
  }
  return author.split("/").map((a) => a.trim()).filter(Boolean);
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
  return item.largeImageUrl ?? item.mediumImageUrl ?? item.smallImageUrl ?? null;
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

export function mapRakutenBooksItemToDetail(item: RakutenBooksItem): BookDetail {
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

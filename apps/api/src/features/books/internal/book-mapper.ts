export interface GoogleBooksVolume {
  id: string;
  volumeInfo: {
    title: string;
    authors?: string[];
    publisher?: string;
    publishedDate?: string;
    industryIdentifiers?: Array<{ type: string; identifier: string }>;
    imageLinks?: { thumbnail?: string; smallThumbnail?: string };
    categories?: string[];
    pageCount?: number;
    description?: string;
    infoLink?: string;
  };
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

function extractIsbn(
  identifiers?: Array<{ type: string; identifier: string }>,
): string | null {
  if (!identifiers) {
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

function extractCoverImageUrl(imageLinks?: {
  thumbnail?: string;
  smallThumbnail?: string;
}): string | null {
  if (!imageLinks) {
    return null;
  }

  const url = imageLinks.thumbnail ?? imageLinks.smallThumbnail ?? null;

  if (url?.startsWith("http://")) {
    return url.replace("http://", "https://");
  }

  return url;
}

export function mapGoogleBooksVolume(volume: GoogleBooksVolume): Book {
  const { volumeInfo } = volume;

  return {
    id: volume.id,
    title: volumeInfo.title,
    authors: volumeInfo.authors ?? [],
    publisher: volumeInfo.publisher ?? null,
    publishedDate: volumeInfo.publishedDate ?? null,
    isbn: extractIsbn(volumeInfo.industryIdentifiers),
    coverImageUrl: extractCoverImageUrl(volumeInfo.imageLinks),
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
  googleBooksUrl: string | null;
}

function generateAmazonUrl(isbn: string | null): string | null {
  if (!isbn) {
    return null;
  }
  return `https://www.amazon.co.jp/dp/${isbn}`;
}

export function mapGoogleBooksVolumeToDetail(
  volume: GoogleBooksVolume,
): BookDetail {
  const { volumeInfo } = volume;
  const isbn = extractIsbn(volumeInfo.industryIdentifiers);

  return {
    id: volume.id,
    title: volumeInfo.title,
    authors: volumeInfo.authors ?? [],
    publisher: volumeInfo.publisher ?? null,
    publishedDate: volumeInfo.publishedDate ?? null,
    pageCount: volumeInfo.pageCount ?? null,
    categories: volumeInfo.categories ?? null,
    description: volumeInfo.description ?? null,
    isbn,
    coverImageUrl: extractCoverImageUrl(volumeInfo.imageLinks),
    amazonUrl: generateAmazonUrl(isbn),
    googleBooksUrl: volumeInfo.infoLink ?? null,
  };
}

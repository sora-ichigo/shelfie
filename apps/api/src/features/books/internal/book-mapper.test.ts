import { describe, expect, it } from "vitest";
import {
  type Book,
  type GoogleBooksVolume,
  mapGoogleBooksVolume,
} from "./book-mapper.js";

describe("BookMapper", () => {
  describe("mapGoogleBooksVolume", () => {
    it("Google Books API レスポンスを内部 Book 型にマッピングできる", () => {
      const volume: GoogleBooksVolume = {
        id: "test-id",
        volumeInfo: {
          title: "テスト書籍タイトル",
          authors: ["著者1", "著者2"],
          publisher: "テスト出版社",
          publishedDate: "2024-01-15",
          industryIdentifiers: [
            { type: "ISBN_13", identifier: "9784123456789" },
            { type: "ISBN_10", identifier: "4123456789" },
          ],
          imageLinks: {
            thumbnail: "https://example.com/thumbnail.jpg",
            smallThumbnail: "https://example.com/small.jpg",
          },
        },
      };

      const book = mapGoogleBooksVolume(volume);

      expect(book).toEqual({
        id: "test-id",
        title: "テスト書籍タイトル",
        authors: ["著者1", "著者2"],
        publisher: "テスト出版社",
        publishedDate: "2024-01-15",
        isbn: "9784123456789",
        coverImageUrl: "https://example.com/thumbnail.jpg",
      } satisfies Book);
    });

    it("ISBN-13 を優先して抽出する", () => {
      const volume: GoogleBooksVolume = {
        id: "isbn-test",
        volumeInfo: {
          title: "ISBN テスト",
          industryIdentifiers: [
            { type: "ISBN_10", identifier: "4123456789" },
            { type: "ISBN_13", identifier: "9784123456789" },
          ],
        },
      };

      const book = mapGoogleBooksVolume(volume);

      expect(book.isbn).toBe("9784123456789");
    });

    it("ISBN-13 がない場合は ISBN-10 を使用する", () => {
      const volume: GoogleBooksVolume = {
        id: "isbn10-only",
        volumeInfo: {
          title: "ISBN-10 Only",
          industryIdentifiers: [{ type: "ISBN_10", identifier: "4123456789" }],
        },
      };

      const book = mapGoogleBooksVolume(volume);

      expect(book.isbn).toBe("4123456789");
    });

    it("ISBN がない場合は null を返す", () => {
      const volume: GoogleBooksVolume = {
        id: "no-isbn",
        volumeInfo: {
          title: "ISBN なし書籍",
          industryIdentifiers: [{ type: "OTHER", identifier: "12345" }],
        },
      };

      const book = mapGoogleBooksVolume(volume);

      expect(book.isbn).toBeNull();
    });

    it("industryIdentifiers がない場合は isbn が null", () => {
      const volume: GoogleBooksVolume = {
        id: "no-identifiers",
        volumeInfo: {
          title: "識別子なし",
        },
      };

      const book = mapGoogleBooksVolume(volume);

      expect(book.isbn).toBeNull();
    });

    it("authors がない場合は空配列を返す", () => {
      const volume: GoogleBooksVolume = {
        id: "no-authors",
        volumeInfo: {
          title: "著者なし書籍",
        },
      };

      const book = mapGoogleBooksVolume(volume);

      expect(book.authors).toEqual([]);
    });

    it("publisher がない場合は null を返す", () => {
      const volume: GoogleBooksVolume = {
        id: "no-publisher",
        volumeInfo: {
          title: "出版社なし書籍",
        },
      };

      const book = mapGoogleBooksVolume(volume);

      expect(book.publisher).toBeNull();
    });

    it("publishedDate がない場合は null を返す", () => {
      const volume: GoogleBooksVolume = {
        id: "no-date",
        volumeInfo: {
          title: "日付なし書籍",
        },
      };

      const book = mapGoogleBooksVolume(volume);

      expect(book.publishedDate).toBeNull();
    });

    it("imageLinks がない場合は coverImageUrl が null", () => {
      const volume: GoogleBooksVolume = {
        id: "no-image",
        volumeInfo: {
          title: "画像なし書籍",
        },
      };

      const book = mapGoogleBooksVolume(volume);

      expect(book.coverImageUrl).toBeNull();
    });

    it("thumbnail がない場合は smallThumbnail を使用する", () => {
      const volume: GoogleBooksVolume = {
        id: "small-thumb-only",
        volumeInfo: {
          title: "小サムネイルのみ",
          imageLinks: {
            smallThumbnail: "https://example.com/small.jpg",
          },
        },
      };

      const book = mapGoogleBooksVolume(volume);

      expect(book.coverImageUrl).toBe("https://example.com/small.jpg");
    });

    it("thumbnail と smallThumbnail 両方ない場合は null を返す", () => {
      const volume: GoogleBooksVolume = {
        id: "no-thumbnails",
        volumeInfo: {
          title: "サムネなし",
          imageLinks: {},
        },
      };

      const book = mapGoogleBooksVolume(volume);

      expect(book.coverImageUrl).toBeNull();
    });

    it("HTTP の thumbnail URL を HTTPS に変換する", () => {
      const volume: GoogleBooksVolume = {
        id: "http-image",
        volumeInfo: {
          title: "HTTP 画像",
          imageLinks: {
            thumbnail: "http://example.com/thumbnail.jpg",
          },
        },
      };

      const book = mapGoogleBooksVolume(volume);

      expect(book.coverImageUrl).toBe("https://example.com/thumbnail.jpg");
    });

    it("最小限のデータでもマッピングできる", () => {
      const volume: GoogleBooksVolume = {
        id: "minimal",
        volumeInfo: {
          title: "最小データ",
        },
      };

      const book = mapGoogleBooksVolume(volume);

      expect(book).toEqual({
        id: "minimal",
        title: "最小データ",
        authors: [],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
      } satisfies Book);
    });
  });
});

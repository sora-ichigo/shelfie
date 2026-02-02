import { createHash } from "node:crypto";
import { afterEach, describe, expect, it, vi } from "vitest";
import {
  type Book,
  type BookDetail,
  type GoogleBooksVolume,
  type PlaceholderAction,
  isbn13ToIsbn10,
  mapGoogleBooksVolume,
  mapRakutenBooksItem,
  mapRakutenBooksItemToDetail,
  type RakutenBooksItem,
  validateGoogleBooksCoverImageUrl,
} from "./book-mapper.js";

const createRakutenBooksItem = (
  overrides: Partial<RakutenBooksItem> = {},
): RakutenBooksItem => ({
  title: "テスト書籍タイトル",
  author: "著者1/著者2",
  publisherName: "テスト出版社",
  isbn: "9784123456789",
  itemPrice: 1980,
  salesDate: "2024年01月15日",
  availability: "1",
  itemUrl: "https://books.rakuten.co.jp/rb/12345678/",
  largeImageUrl: "https://thumbnail.image.rakuten.co.jp/large.jpg",
  mediumImageUrl: "https://thumbnail.image.rakuten.co.jp/medium.jpg",
  smallImageUrl: "https://thumbnail.image.rakuten.co.jp/small.jpg",
  reviewCount: 100,
  reviewAverage: "4.5",
  booksGenreId: "001004008",
  ...overrides,
});

describe("isbn13ToIsbn10", () => {
  it("978 始まりの ISBN-13 を ISBN-10 に変換する", () => {
    expect(isbn13ToIsbn10("9784101010014")).toBe("4101010013");
  });

  it("チェックディジットが 10 の場合は X を返す", () => {
    expect(isbn13ToIsbn10("9781558608320")).toBe("155860832X");
  });

  it("ISBN-10（10桁）はそのまま返す", () => {
    expect(isbn13ToIsbn10("4123456782")).toBe("4123456782");
  });

  it("979 始まりの ISBN-13 は変換不可で null を返す", () => {
    expect(isbn13ToIsbn10("9791234567896")).toBeNull();
  });

  it("null を渡すと null を返す", () => {
    expect(isbn13ToIsbn10(null)).toBeNull();
  });
});

describe("BookMapper", () => {
  describe("mapRakutenBooksItem", () => {
    it("楽天ブックス API レスポンスを内部 Book 型にマッピングできる", () => {
      const item = createRakutenBooksItem();

      const book = mapRakutenBooksItem(item);

      expect(book).toEqual({
        id: "9784123456789",
        title: "テスト書籍タイトル",
        authors: ["著者1", "著者2"],
        publisher: "テスト出版社",
        publishedDate: "2024-01-15",
        isbn: "9784123456789",
        coverImageUrl: "https://thumbnail.image.rakuten.co.jp/large.jpg",
        source: "rakuten",
      } satisfies Book);
    });

    it("著者を / で分割して配列にする", () => {
      const item = createRakutenBooksItem({
        author: "著者A / 著者B / 著者C",
      });

      const book = mapRakutenBooksItem(item);

      expect(book.authors).toEqual(["著者A", "著者B", "著者C"]);
    });

    it("著者が単一の場合は1要素の配列を返す", () => {
      const item = createRakutenBooksItem({
        author: "単独著者",
      });

      const book = mapRakutenBooksItem(item);

      expect(book.authors).toEqual(["単独著者"]);
    });

    it("著者が空の場合は空配列を返す", () => {
      const item = createRakutenBooksItem({
        author: "",
      });

      const book = mapRakutenBooksItem(item);

      expect(book.authors).toEqual([]);
    });

    it("salesDate を ISO 形式（YYYY-MM-DD）に変換する", () => {
      const item = createRakutenBooksItem({
        salesDate: "2024年03月25日",
      });

      const book = mapRakutenBooksItem(item);

      expect(book.publishedDate).toBe("2024-03-25");
    });

    it("salesDate が年月のみの場合は YYYY-MM 形式に変換する", () => {
      const item = createRakutenBooksItem({
        salesDate: "2024年03月",
      });

      const book = mapRakutenBooksItem(item);

      expect(book.publishedDate).toBe("2024-03");
    });

    it("salesDate が空の場合は null を返す", () => {
      const item = createRakutenBooksItem({
        salesDate: "",
      });

      const book = mapRakutenBooksItem(item);

      expect(book.publishedDate).toBeNull();
    });

    it("salesDate がパースできない形式の場合はそのまま返す", () => {
      const item = createRakutenBooksItem({
        salesDate: "発売日未定",
      });

      const book = mapRakutenBooksItem(item);

      expect(book.publishedDate).toBe("発売日未定");
    });

    it("ISBN を ID として使用する", () => {
      const item = createRakutenBooksItem({
        isbn: "9781234567890",
      });

      const book = mapRakutenBooksItem(item);

      expect(book.id).toBe("9781234567890");
      expect(book.isbn).toBe("9781234567890");
    });

    it("largeImageUrl を優先して使用する", () => {
      const item = createRakutenBooksItem({
        largeImageUrl: "https://example.com/large.jpg",
        mediumImageUrl: "https://example.com/medium.jpg",
        smallImageUrl: "https://example.com/small.jpg",
      });

      const book = mapRakutenBooksItem(item);

      expect(book.coverImageUrl).toBe("https://example.com/large.jpg");
    });

    it("largeImageUrl がない場合は mediumImageUrl を使用する", () => {
      const item = createRakutenBooksItem({
        largeImageUrl: undefined,
        mediumImageUrl: "https://example.com/medium.jpg",
        smallImageUrl: "https://example.com/small.jpg",
      });

      const book = mapRakutenBooksItem(item);

      expect(book.coverImageUrl).toBe("https://example.com/medium.jpg");
    });

    it("largeImageUrl と mediumImageUrl がない場合は smallImageUrl を使用する", () => {
      const item = createRakutenBooksItem({
        largeImageUrl: undefined,
        mediumImageUrl: undefined,
        smallImageUrl: "https://example.com/small.jpg",
      });

      const book = mapRakutenBooksItem(item);

      expect(book.coverImageUrl).toBe("https://example.com/small.jpg");
    });

    it("すべての画像 URL がない場合は null を返す", () => {
      const item = createRakutenBooksItem({
        largeImageUrl: undefined,
        mediumImageUrl: undefined,
        smallImageUrl: undefined,
      });

      const book = mapRakutenBooksItem(item);

      expect(book.coverImageUrl).toBeNull();
    });
  });

  describe("mapRakutenBooksItemToDetail", () => {
    it("楽天ブックス API レスポンスを BookDetail 型にマッピングできる", () => {
      const item = createRakutenBooksItem({
        itemCaption: "これはテスト書籍の説明です。",
      });

      const detail = mapRakutenBooksItemToDetail(item);

      expect(detail).toEqual({
        id: "9784123456789",
        title: "テスト書籍タイトル",
        authors: ["著者1", "著者2"],
        publisher: "テスト出版社",
        publishedDate: "2024-01-15",
        pageCount: null,
        categories: ["001004008"],
        description: "これはテスト書籍の説明です。",
        isbn: "9784123456789",
        coverImageUrl: "https://thumbnail.image.rakuten.co.jp/large.jpg",
        amazonUrl: "https://www.amazon.co.jp/dp/4123456782",
        googleBooksUrl: null,
        rakutenBooksUrl: "https://books.rakuten.co.jp/rb/12345678/",
      } satisfies BookDetail);
    });

    it("pageCount は常に null を返す（楽天 API にはページ数情報がない）", () => {
      const item = createRakutenBooksItem();

      const detail = mapRakutenBooksItemToDetail(item);

      expect(detail.pageCount).toBeNull();
    });

    it("booksGenreId を categories 配列として返す", () => {
      const item = createRakutenBooksItem({
        booksGenreId: "001001001",
      });

      const detail = mapRakutenBooksItemToDetail(item);

      expect(detail.categories).toEqual(["001001001"]);
    });

    it("booksGenreId が空の場合は categories が null を返す", () => {
      const item = createRakutenBooksItem({
        booksGenreId: "",
      });

      const detail = mapRakutenBooksItemToDetail(item);

      expect(detail.categories).toBeNull();
    });

    it("itemCaption がない場合は description が null を返す", () => {
      const item = createRakutenBooksItem({
        itemCaption: undefined,
      });

      const detail = mapRakutenBooksItemToDetail(item);

      expect(detail.description).toBeNull();
    });

    it("ISBN-13 から ISBN-10 に変換して Amazon URL を生成する", () => {
      const item = createRakutenBooksItem({
        isbn: "9781234567890",
      });

      const detail = mapRakutenBooksItemToDetail(item);

      expect(detail.amazonUrl).toBe("https://www.amazon.co.jp/dp/123456789X");
    });

    it("itemUrl を rakutenBooksUrl として返す", () => {
      const item = createRakutenBooksItem({
        itemUrl: "https://books.rakuten.co.jp/rb/99999999/",
      });

      const detail = mapRakutenBooksItemToDetail(item);

      expect(detail.rakutenBooksUrl).toBe(
        "https://books.rakuten.co.jp/rb/99999999/",
      );
    });
  });

  describe("mapGoogleBooksVolume", () => {
    const createGoogleBooksVolume = (
      overrides: Omit<Partial<GoogleBooksVolume>, "volumeInfo"> & {
        volumeInfo?: Partial<GoogleBooksVolume["volumeInfo"]>;
      } = {},
    ): GoogleBooksVolume => {
      const { volumeInfo: volumeInfoOverrides, ...rest } = overrides;
      return {
        kind: "books#volume",
        id: "test-volume-id",
        volumeInfo: {
          title: "Google Books テスト書籍",
          authors: ["著者1", "著者2"],
          publisher: "テスト出版社",
          publishedDate: "2024-01-15",
          description: "これはテスト書籍の説明です",
          industryIdentifiers: [
            { type: "ISBN_13", identifier: "9784123456789" },
            { type: "ISBN_10", identifier: "4123456789" },
          ],
          pageCount: 300,
          categories: ["Computers", "Programming"],
          imageLinks: {
            thumbnail: "https://books.google.com/thumbnail.jpg",
            smallThumbnail: "https://books.google.com/small.jpg",
          },
          ...volumeInfoOverrides,
        },
        ...rest,
      };
    };

    it("Google Books API レスポンスを内部 Book 型にマッピングできる", () => {
      const volume = createGoogleBooksVolume();

      const book = mapGoogleBooksVolume(volume);

      expect(book).toEqual({
        id: "9784123456789",
        title: "Google Books テスト書籍",
        authors: ["著者1", "著者2"],
        publisher: "テスト出版社",
        publishedDate: "2024-01-15",
        isbn: "9784123456789",
        coverImageUrl: "https://books.google.com/thumbnail.jpg?zoom=2",
        source: "google",
      } satisfies Book);
    });

    it("ISBN-13 を優先して使用する", () => {
      const volume = createGoogleBooksVolume({
        volumeInfo: {
          industryIdentifiers: [
            { type: "ISBN_10", identifier: "4123456789" },
            { type: "ISBN_13", identifier: "9784123456789" },
          ],
        },
      });

      const book = mapGoogleBooksVolume(volume);

      expect(book.isbn).toBe("9784123456789");
      expect(book.id).toBe("9784123456789");
    });

    it("ISBN-13 がない場合は ISBN-10 を使用する", () => {
      const volume = createGoogleBooksVolume({
        volumeInfo: {
          industryIdentifiers: [{ type: "ISBN_10", identifier: "4123456789" }],
        },
      });

      const book = mapGoogleBooksVolume(volume);

      expect(book.isbn).toBe("4123456789");
      expect(book.id).toBe("4123456789");
    });

    it("ISBN がない場合は volumeId を id として使用し、isbn は null", () => {
      const volume = createGoogleBooksVolume({
        id: "google-volume-id-123",
        volumeInfo: {
          industryIdentifiers: undefined,
        },
      });

      const book = mapGoogleBooksVolume(volume);

      expect(book.id).toBe("google-volume-id-123");
      expect(book.isbn).toBeNull();
    });

    it("industryIdentifiers が空配列の場合も volumeId を id として使用", () => {
      const volume = createGoogleBooksVolume({
        id: "google-volume-id-456",
        volumeInfo: {
          industryIdentifiers: [],
        },
      });

      const book = mapGoogleBooksVolume(volume);

      expect(book.id).toBe("google-volume-id-456");
      expect(book.isbn).toBeNull();
    });

    it("authors が配列としてそのまま返される", () => {
      const volume = createGoogleBooksVolume({
        volumeInfo: {
          authors: ["Author A", "Author B", "Author C"],
        },
      });

      const book = mapGoogleBooksVolume(volume);

      expect(book.authors).toEqual(["Author A", "Author B", "Author C"]);
    });

    it("authors がない場合は空配列を返す", () => {
      const volume = createGoogleBooksVolume({
        volumeInfo: {
          authors: undefined,
        },
      });

      const book = mapGoogleBooksVolume(volume);

      expect(book.authors).toEqual([]);
    });

    it("publisher がない場合は null を返す", () => {
      const volume = createGoogleBooksVolume({
        volumeInfo: {
          publisher: undefined,
        },
      });

      const book = mapGoogleBooksVolume(volume);

      expect(book.publisher).toBeNull();
    });

    it("publishedDate がない場合は null を返す", () => {
      const volume = createGoogleBooksVolume({
        volumeInfo: {
          publishedDate: undefined,
        },
      });

      const book = mapGoogleBooksVolume(volume);

      expect(book.publishedDate).toBeNull();
    });

    it("thumbnail を優先して coverImageUrl に使用する", () => {
      const volume = createGoogleBooksVolume({
        volumeInfo: {
          imageLinks: {
            thumbnail: "https://example.com/thumbnail.jpg",
            smallThumbnail: "https://example.com/small.jpg",
          },
        },
      });

      const book = mapGoogleBooksVolume(volume);

      expect(book.coverImageUrl).toBe(
        "https://example.com/thumbnail.jpg?zoom=2",
      );
    });

    it("thumbnail がない場合は smallThumbnail を使用する", () => {
      const volume = createGoogleBooksVolume({
        volumeInfo: {
          imageLinks: {
            thumbnail: undefined,
            smallThumbnail: "https://example.com/small.jpg",
          },
        },
      });

      const book = mapGoogleBooksVolume(volume);

      expect(book.coverImageUrl).toBe("https://example.com/small.jpg?zoom=2");
    });

    it("imageLinks がない場合は coverImageUrl が null を返す", () => {
      const volume = createGoogleBooksVolume({
        volumeInfo: {
          imageLinks: undefined,
        },
      });

      const book = mapGoogleBooksVolume(volume);

      expect(book.coverImageUrl).toBeNull();
    });
  });

  describe("validateGoogleBooksCoverImageUrl", () => {
    const computeHash = (data: string) =>
      createHash("sha256").update(Buffer.from(data)).digest("hex");

    const testPlaceholders = new Map<string, PlaceholderAction>([
      [computeHash("placeholder-image"), "fallback"],
      [computeHash("no-cover-image"), "no_cover"],
    ]);

    afterEach(() => {
      vi.restoreAllMocks();
    });

    it("null を渡すと null を返す", async () => {
      const result = await validateGoogleBooksCoverImageUrl(null);

      expect(result).toBeNull();
    });

    it("Google Books 以外の URL はバリデーションせずそのまま返す", async () => {
      const fetchSpy = vi.spyOn(globalThis, "fetch");
      const url = "https://example.com/image.jpg";

      const result = await validateGoogleBooksCoverImageUrl(
        url,
        testPlaceholders,
      );

      expect(result).toBe(url);
      expect(fetchSpy).not.toHaveBeenCalled();
    });

    it("zoom=2 の画像が有効な場合はそのまま返す", async () => {
      vi.spyOn(globalThis, "fetch").mockResolvedValueOnce(
        new Response(Buffer.from("valid-cover-image-data")),
      );

      const url =
        "https://books.google.com/books/content?id=abc&zoom=2&source=gbs_api";

      const result = await validateGoogleBooksCoverImageUrl(
        url,
        testPlaceholders,
      );

      expect(result).toBe(url);
    });

    it("zoom=2 の画像がプレースホルダーの場合は zoom=1 にフォールバックする", async () => {
      vi.spyOn(globalThis, "fetch").mockResolvedValueOnce(
        new Response(Buffer.from("placeholder-image")),
      );

      const url =
        "https://books.google.com/books/content?id=AhSItAEACAAJ&printsec=frontcover&img=1&zoom=2&source=gbs_api";

      const result = await validateGoogleBooksCoverImageUrl(
        url,
        testPlaceholders,
      );

      expect(result).toBe(
        "https://books.google.com/books/content?id=AhSItAEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
      );
    });

    it("カバー画像が存在しないプレースホルダーの場合は null を返す", async () => {
      vi.spyOn(globalThis, "fetch").mockResolvedValueOnce(
        new Response(Buffer.from("no-cover-image")),
      );

      const url =
        "https://books.google.com/books/content?id=abc&zoom=2&source=gbs_api";

      const result = await validateGoogleBooksCoverImageUrl(
        url,
        testPlaceholders,
      );

      expect(result).toBeNull();
    });

    it("fetch がエラーの場合は元の URL を返す", async () => {
      vi.spyOn(globalThis, "fetch").mockRejectedValueOnce(
        new Error("Network error"),
      );

      const url =
        "https://books.google.com/books/content?id=abc&zoom=2&source=gbs_api";

      const result = await validateGoogleBooksCoverImageUrl(
        url,
        testPlaceholders,
      );

      expect(result).toBe(url);
    });

    it("zoom パラメータがない URL はバリデーションせずそのまま返す", async () => {
      const fetchSpy = vi.spyOn(globalThis, "fetch");
      const url =
        "https://books.google.com/books/content?id=abc&source=gbs_api";

      const result = await validateGoogleBooksCoverImageUrl(
        url,
        testPlaceholders,
      );

      expect(result).toBe(url);
      expect(fetchSpy).not.toHaveBeenCalled();
    });
  });
});

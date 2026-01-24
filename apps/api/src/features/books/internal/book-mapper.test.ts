import { describe, expect, it } from "vitest";
import {
  type Book,
  type BookDetail,
  type RakutenBooksItem,
  mapRakutenBooksItem,
  mapRakutenBooksItemToDetail,
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
        amazonUrl: "https://www.amazon.co.jp/dp/9784123456789",
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

    it("ISBN から Amazon URL を生成する", () => {
      const item = createRakutenBooksItem({
        isbn: "9781234567890",
      });

      const detail = mapRakutenBooksItemToDetail(item);

      expect(detail.amazonUrl).toBe(
        "https://www.amazon.co.jp/dp/9781234567890",
      );
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
});

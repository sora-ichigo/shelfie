import { beforeEach, describe, expect, it, vi } from "vitest";
import type { LoggerService } from "../../../logger/index.js";
import type { Book } from "./book-mapper.js";
import {
  type CompositeBookRepository,
  createCompositeBookRepository,
} from "./composite-book-repository.js";
import type { ExternalBookRepository } from "./external-book-repository.js";
import type { GoogleBooksRepository } from "./google-books-repository.js";

describe("CompositeBookRepository", () => {
  let repository: CompositeBookRepository;
  let mockRakutenRepository: ExternalBookRepository;
  let mockGoogleRepository: GoogleBooksRepository;
  let mockLogger: LoggerService;

  const createMockRakutenItem = (isbn: string, title: string) => ({
    title,
    author: "著者",
    publisherName: "出版社",
    isbn,
    itemPrice: 1000,
    salesDate: "2024年01月01日",
    availability: "1",
    itemUrl: "https://books.rakuten.co.jp/",
    reviewCount: 10,
    reviewAverage: "4.0",
    booksGenreId: "001",
  });

  const createMockGoogleItem = (isbn: string | null, title: string) => ({
    kind: "books#volume",
    id: `google-${isbn ?? title}`,
    volumeInfo: {
      title,
      authors: ["著者"],
      publisher: "出版社",
      publishedDate: "2024-01-01",
      industryIdentifiers: isbn
        ? [{ type: "ISBN_13" as const, identifier: isbn }]
        : undefined,
      imageLinks: {
        thumbnail: "https://books.google.com/thumbnail.jpg",
      },
    },
  });

  beforeEach(() => {
    mockRakutenRepository = {
      searchByQuery: vi.fn(),
      searchByISBN: vi.fn(),
      getBookByISBN: vi.fn(),
    };

    mockGoogleRepository = {
      searchByQuery: vi.fn(),
    };

    mockLogger = {
      info: vi.fn(),
      warn: vi.fn(),
      error: vi.fn(),
      debug: vi.fn(),
    };
  });

  describe("searchByQuery", () => {
    describe("楽天優先マージ", () => {
      it("楽天の結果を先に、次にGoogleの結果を表示する", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [
              createMockRakutenItem("9784111111111", "楽天本1"),
              createMockRakutenItem("9784222222222", "楽天本2"),
            ],
            totalItems: 2,
          },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [
              createMockGoogleItem("9784333333333", "Google本1"),
              createMockGoogleItem("9784444444444", "Google本2"),
            ],
            totalItems: 2,
          },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(4);
          expect(result.data.items[0].title).toBe("楽天本1");
          expect(result.data.items[1].title).toBe("楽天本2");
          expect(result.data.items[2].title).toBe("Google本1");
          expect(result.data.items[3].title).toBe("Google本2");
        }
      });

      it("楽天の結果が少ない場合、Googleの結果で補完する", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [createMockRakutenItem("9784111111111", "楽天本1")],
            totalItems: 1,
          },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [
              createMockGoogleItem("9784333333333", "Google本1"),
              createMockGoogleItem("9784444444444", "Google本2"),
              createMockGoogleItem("9784555555555", "Google本3"),
            ],
            totalItems: 3,
          },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(4);
          expect(result.data.items[0].title).toBe("楽天本1");
          expect(result.data.items[1].title).toBe("Google本1");
          expect(result.data.items[2].title).toBe("Google本2");
          expect(result.data.items[3].title).toBe("Google本3");
        }
      });

      it("Googleの結果が少なくても楽天の結果が全て先に表示される", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [
              createMockRakutenItem("9784111111111", "楽天本1"),
              createMockRakutenItem("9784222222222", "楽天本2"),
              createMockRakutenItem("9784666666666", "楽天本3"),
            ],
            totalItems: 3,
          },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [createMockGoogleItem("9784333333333", "Google本1")],
            totalItems: 1,
          },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(4);
          expect(result.data.items[0].title).toBe("楽天本1");
          expect(result.data.items[1].title).toBe("楽天本2");
          expect(result.data.items[2].title).toBe("楽天本3");
          expect(result.data.items[3].title).toBe("Google本1");
        }
      });
    });

    describe("Google Books日本語フィルタリング", () => {
      it("日本のISBN（978-4始まり）を持つGoogle本のみ残す", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: { items: [], totalItems: 0 },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [
              createMockGoogleItem("9784111111111", "Japanese Book"),
              createMockGoogleItem("9781234567890", "English Book"),
              createMockGoogleItem("9784222222222", "Another Japanese"),
            ],
            totalItems: 3,
          },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(2);
          expect(result.data.items[0].isbn).toBe("9784111111111");
          expect(result.data.items[1].isbn).toBe("9784222222222");
        }
      });

      it("日本語タイトルを持つGoogle本は日本ISBN以外でも残す", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: { items: [], totalItems: 0 },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [
              createMockGoogleItem("9781234567890", "プログラミング入門"),
              createMockGoogleItem("9781111111111", "English Only Title"),
            ],
            totalItems: 2,
          },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(1);
          expect(result.data.items[0].title).toBe("プログラミング入門");
        }
      });

      it("ISBNなしでも日本語タイトルがあれば残す", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: { items: [], totalItems: 0 },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [
              createMockGoogleItem(null, "日本語の本"),
              createMockGoogleItem(null, "English Book"),
            ],
            totalItems: 2,
          },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(1);
          expect(result.data.items[0].title).toBe("日本語の本");
        }
      });
    });

    describe("ISBN重複排除", () => {
      it("同じISBNの本は最初に出現したもののみ残す", async () => {
        const sharedIsbn = "9784123456789";

        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [createMockRakutenItem(sharedIsbn, "楽天版・同じ本")],
            totalItems: 1,
          },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [createMockGoogleItem(sharedIsbn, "Google版・同じ本")],
            totalItems: 1,
          },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(1);
          expect(result.data.items[0].title).toBe("楽天版・同じ本");
        }
      });

      it("複数の重複がある場合もすべて排除される", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [
              createMockRakutenItem("9784111111111", "楽天本1"),
              createMockRakutenItem("9784222222222", "楽天本2"),
            ],
            totalItems: 2,
          },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [
              createMockGoogleItem("9784111111111", "Google版・本1（重複）"),
              createMockGoogleItem("9784333333333", "Google本3（ユニーク）"),
            ],
            totalItems: 2,
          },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(3);
          expect(result.data.items.map((b: Book) => b.isbn)).toEqual([
            "9784111111111",
            "9784222222222",
            "9784333333333",
          ]);
        }
      });

      it("ISBNがないGoogle本は重複チェックの対象外", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [createMockRakutenItem("9784111111111", "楽天本1")],
            totalItems: 1,
          },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [
              createMockGoogleItem(null, "ISBNなしのGoogle本1"),
              createMockGoogleItem(null, "ISBNなしのGoogle本2"),
            ],
            totalItems: 2,
          },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(3);
        }
      });
    });

    describe("API失敗時のフォールバック", () => {
      it("楽天APIが失敗してもGoogleの結果を返す", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: false,
          error: { code: "NETWORK_ERROR", message: "Network error" },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [createMockGoogleItem("9784333333333", "Google本1")],
            totalItems: 1,
          },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(1);
          expect(result.data.items[0].title).toBe("Google本1");
        }
      });

      it("GoogleAPIが失敗しても楽天の結果を返す", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [createMockRakutenItem("9784111111111", "楽天本1")],
            totalItems: 1,
          },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: false,
          error: { code: "TIMEOUT_ERROR", message: "Timeout" },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(1);
          expect(result.data.items[0].title).toBe("楽天本1");
        }
      });

      it("両方のAPIが失敗した場合はエラーを返す", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: false,
          error: { code: "NETWORK_ERROR", message: "Rakuten network error" },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: false,
          error: { code: "TIMEOUT_ERROR", message: "Google timeout" },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("NETWORK_ERROR");
        }
      });
    });

    describe("並列リクエスト", () => {
      it("両APIに同時にリクエストを送信する", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: { items: [], totalItems: 0 },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: { items: [], totalItems: 0 },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        await repository.searchByQuery("テスト", 10, 0);

        expect(mockRakutenRepository.searchByQuery).toHaveBeenCalledWith(
          "テスト",
          10,
          0,
        );
        expect(mockGoogleRepository.searchByQuery).toHaveBeenCalledWith(
          "テスト",
          10,
          0,
        );
      });
    });

    describe("totalItems", () => {
      it("両APIの totalItems を合算する", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [createMockRakutenItem("9784111111111", "楽天本1")],
            totalItems: 100,
          },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [createMockGoogleItem("9784333333333", "Google本1")],
            totalItems: 50,
          },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.totalItems).toBe(150);
        }
      });

      it("片方が失敗した場合は成功した方の totalItems のみ", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: {
            items: [createMockRakutenItem("9784111111111", "楽天本1")],
            totalItems: 100,
          },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: false,
          error: { code: "TIMEOUT_ERROR", message: "Timeout" },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.totalItems).toBe(100);
        }
      });
    });

    describe("空の結果", () => {
      it("両方とも結果が0件の場合は空配列を返す", async () => {
        vi.mocked(mockRakutenRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: { items: [], totalItems: 0 },
        });

        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValueOnce({
          success: true,
          data: { items: [], totalItems: 0 },
        });

        repository = createCompositeBookRepository(
          mockRakutenRepository,
          mockGoogleRepository,
          mockLogger,
        );

        const result = await repository.searchByQuery("テスト", 10, 0);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toEqual([]);
          expect(result.data.totalItems).toBe(0);
        }
      });
    });
  });
});

import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  createExternalBookRepository,
  type ExternalBookRepository,
} from "./external-book-repository.js";

describe("ExternalBookRepository", () => {
  let repository: ExternalBookRepository;
  const mockApplicationId = "test-application-id";

  beforeEach(() => {
    vi.useFakeTimers();
    repository = createExternalBookRepository(mockApplicationId);
  });

  afterEach(() => {
    vi.useRealTimers();
    vi.restoreAllMocks();
  });

  const createMockRakutenItem = (overrides = {}) => ({
    title: "テスト書籍",
    author: "著者1/著者2",
    publisherName: "テスト出版社",
    isbn: "9784123456789",
    itemPrice: 1980,
    salesDate: "2024年01月01日",
    availability: "1",
    itemUrl: "https://books.rakuten.co.jp/rb/12345678/",
    largeImageUrl: "https://thumbnail.image.rakuten.co.jp/large.jpg",
    mediumImageUrl: "https://thumbnail.image.rakuten.co.jp/medium.jpg",
    smallImageUrl: "https://thumbnail.image.rakuten.co.jp/small.jpg",
    reviewCount: 10,
    reviewAverage: "4.0",
    booksGenreId: "001004008",
    ...overrides,
  });

  describe("searchByQuery", () => {
    it("キーワード検索で書籍一覧を取得できる", async () => {
      const mockResponse = {
        count: 1,
        page: 1,
        pageCount: 1,
        hits: 1,
        Items: [{ Item: createMockRakutenItem() }],
      };

      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: () => Promise.resolve(mockResponse),
      });

      const result = await repository.searchByQuery("テスト", 10, 0);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.totalItems).toBe(1);
        expect(result.data.items).toHaveLength(1);
        expect(result.data.items[0].isbn).toBe("9784123456789");
        expect(result.data.items[0].title).toBe("テスト書籍");
      }

      expect(fetch).toHaveBeenCalledWith(
        expect.stringContaining("title=%E3%83%86%E3%82%B9%E3%83%88"),
        expect.objectContaining({
          signal: expect.any(AbortSignal),
        }),
      );
    });

    it("ページネーションパラメータが正しく送信される（offset を page に変換）", async () => {
      const mockResponse = {
        count: 100,
        page: 3,
        pageCount: 10,
        hits: 10,
        Items: [],
      };

      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: () => Promise.resolve(mockResponse),
      });

      await repository.searchByQuery("test", 10, 20);

      expect(fetch).toHaveBeenCalledWith(
        expect.stringMatching(/page=3/),
        expect.any(Object),
      );
      expect(fetch).toHaveBeenCalledWith(
        expect.stringMatching(/hits=10/),
        expect.any(Object),
      );
    });

    it("applicationId がリクエストに含まれる", async () => {
      const mockResponse = {
        count: 0,
        page: 1,
        pageCount: 0,
        hits: 0,
        Items: [],
      };

      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: () => Promise.resolve(mockResponse),
      });

      await repository.searchByQuery("test", 10, 0);

      expect(fetch).toHaveBeenCalledWith(
        expect.stringContaining(`applicationId=${mockApplicationId}`),
        expect.any(Object),
      );
    });

    it("検索結果が0件の場合は空配列を返す", async () => {
      const mockResponse = {
        count: 0,
        page: 1,
        pageCount: 0,
        hits: 0,
        Items: [],
      };

      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: () => Promise.resolve(mockResponse),
      });

      const result = await repository.searchByQuery("存在しない書籍", 10, 0);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.items).toEqual([]);
        expect(result.data.totalItems).toBe(0);
      }
    });

    it("ネットワークエラー時に NETWORK_ERROR を返す", async () => {
      global.fetch = vi.fn().mockRejectedValueOnce(new Error("Network error"));

      const result = await repository.searchByQuery("test", 10, 0);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("NETWORK_ERROR");
      }
    });

    it("タイムアウト時に TIMEOUT_ERROR を返す", async () => {
      global.fetch = vi.fn().mockImplementationOnce(
        () =>
          new Promise((_, reject) => {
            const error = new DOMException("Aborted", "AbortError");
            reject(error);
          }),
      );

      const result = await repository.searchByQuery("test", 10, 0);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("TIMEOUT_ERROR");
      }
    });

    it("レートリミット（429）時に RATE_LIMIT_ERROR を返す", async () => {
      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: false,
        status: 429,
        statusText: "Too Many Requests",
      });

      const result = await repository.searchByQuery("test", 10, 0);

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("RATE_LIMIT_ERROR");
      }
    });

    it("API エラー（5xx）時に API_ERROR を返す", async () => {
      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: false,
        status: 500,
        statusText: "Internal Server Error",
      });

      const result = await repository.searchByQuery("test", 10, 0);

      expect(result.success).toBe(false);
      if (!result.success && result.error.code === "API_ERROR") {
        expect(result.error.statusCode).toBe(500);
      }
    });

    it("400 エラー時に API_ERROR を返す", async () => {
      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: false,
        status: 400,
        statusText: "Bad Request",
      });

      const result = await repository.searchByQuery("test", 10, 0);

      expect(result.success).toBe(false);
      if (!result.success && result.error.code === "API_ERROR") {
        expect(result.error.statusCode).toBe(400);
      }
    });

    it("楽天 API のエラーレスポンス形式を処理できる", async () => {
      const mockErrorResponse = {
        error: "wrong_parameter",
        error_description: "パラメータが不正です",
      };

      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: false,
        status: 400,
        statusText: "Bad Request",
        json: () => Promise.resolve(mockErrorResponse),
      });

      const result = await repository.searchByQuery("test", 10, 0);

      expect(result.success).toBe(false);
      if (!result.success && result.error.code === "API_ERROR") {
        expect(result.error.statusCode).toBe(400);
      }
    });
  });

  describe("searchByISBN", () => {
    it("ISBN で単一の書籍を検索できる", async () => {
      const mockResponse = {
        count: 1,
        page: 1,
        pageCount: 1,
        hits: 1,
        Items: [
          {
            Item: createMockRakutenItem({
              title: "ISBN検索書籍",
              isbn: "9784123456789",
            }),
          },
        ],
      };

      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: () => Promise.resolve(mockResponse),
      });

      const result = await repository.searchByISBN("9784123456789");

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data).not.toBeNull();
        expect(result.data?.isbn).toBe("9784123456789");
        expect(result.data?.title).toBe("ISBN検索書籍");
      }

      expect(fetch).toHaveBeenCalledWith(
        expect.stringContaining("isbn=9784123456789"),
        expect.any(Object),
      );
    });

    it("ISBN が見つからない場合は null を返す", async () => {
      const mockResponse = {
        count: 0,
        page: 1,
        pageCount: 0,
        hits: 0,
        Items: [],
      };

      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: () => Promise.resolve(mockResponse),
      });

      const result = await repository.searchByISBN("0000000000000");

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data).toBeNull();
      }
    });

    it("ISBN-10 形式でも検索できる", async () => {
      const mockResponse = {
        count: 1,
        page: 1,
        pageCount: 1,
        hits: 1,
        Items: [
          {
            Item: createMockRakutenItem({
              title: "ISBN-10 書籍",
              isbn: "4123456789",
            }),
          },
        ],
      };

      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: () => Promise.resolve(mockResponse),
      });

      const result = await repository.searchByISBN("4123456789");

      expect(result.success).toBe(true);
      expect(fetch).toHaveBeenCalledWith(
        expect.stringContaining("isbn=4123456789"),
        expect.any(Object),
      );
    });

    it("ネットワークエラー時に NETWORK_ERROR を返す", async () => {
      global.fetch = vi.fn().mockRejectedValueOnce(new Error("Network error"));

      const result = await repository.searchByISBN("9784123456789");

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("NETWORK_ERROR");
      }
    });

    it("タイムアウト時に TIMEOUT_ERROR を返す", async () => {
      global.fetch = vi.fn().mockImplementationOnce(
        () =>
          new Promise((_, reject) => {
            const error = new DOMException("Aborted", "AbortError");
            reject(error);
          }),
      );

      const result = await repository.searchByISBN("9784123456789");

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("TIMEOUT_ERROR");
      }
    });
  });

  describe("getBookByISBN", () => {
    it("ISBN で書籍詳細を取得できる（searchByISBN と同じ動作）", async () => {
      const mockResponse = {
        count: 1,
        page: 1,
        pageCount: 1,
        hits: 1,
        Items: [
          {
            Item: createMockRakutenItem({
              title: "詳細取得書籍",
              isbn: "9784123456789",
              itemCaption: "これは書籍の説明です",
            }),
          },
        ],
      };

      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: () => Promise.resolve(mockResponse),
      });

      const result = await repository.getBookByISBN("9784123456789");

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data).not.toBeNull();
        expect(result.data?.isbn).toBe("9784123456789");
        expect(result.data?.title).toBe("詳細取得書籍");
      }
    });

    it("ISBN が見つからない場合は null を返す", async () => {
      const mockResponse = {
        count: 0,
        page: 1,
        pageCount: 0,
        hits: 0,
        Items: [],
      };

      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: () => Promise.resolve(mockResponse),
      });

      const result = await repository.getBookByISBN("0000000000000");

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data).toBeNull();
      }
    });
  });
});

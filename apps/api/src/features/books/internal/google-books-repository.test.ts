import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  createGoogleBooksRepository,
  type GoogleBooksRepository,
} from "./google-books-repository.js";

describe("GoogleBooksRepository", () => {
  let repository: GoogleBooksRepository;
  const mockApiKey = "test-google-api-key";

  beforeEach(() => {
    vi.useFakeTimers();
    repository = createGoogleBooksRepository(mockApiKey);
  });

  afterEach(() => {
    vi.useRealTimers();
    vi.restoreAllMocks();
  });

  const createMockGoogleBooksItem = (
    overrides: {
      volumeInfo?: Record<string, unknown>;
      [key: string]: unknown;
    } = {},
  ) => {
    const { volumeInfo: volumeInfoOverrides, ...rest } = overrides;
    return {
      kind: "books#volume",
      id: "test-volume-id",
      volumeInfo: {
        title: "テスト書籍",
        authors: ["著者1", "著者2"],
        publisher: "テスト出版社",
        publishedDate: "2024-01-01",
        description: "これはテスト書籍の説明です",
        industryIdentifiers: [
          { type: "ISBN_13", identifier: "9784123456789" },
          { type: "ISBN_10", identifier: "4123456789" },
        ],
        pageCount: 300,
        categories: ["Computers", "Programming"],
        imageLinks: {
          thumbnail: "https://books.google.com/thumbnail.jpg",
          smallThumbnail: "https://books.google.com/small_thumbnail.jpg",
        },
        ...volumeInfoOverrides,
      },
      ...rest,
    };
  };

  describe("searchByQuery", () => {
    it("キーワード検索で書籍一覧を取得できる", async () => {
      const mockResponse = {
        kind: "books#volumes",
        totalItems: 1,
        items: [createMockGoogleBooksItem()],
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
        expect(result.data.items[0].volumeInfo.title).toBe("テスト書籍");
      }

      expect(fetch).toHaveBeenCalledWith(
        expect.stringContaining("q=%E3%83%86%E3%82%B9%E3%83%88"),
        expect.objectContaining({
          signal: expect.any(AbortSignal),
        }),
      );
    });

    it("ページネーションパラメータが正しく送信される（startIndex）", async () => {
      const mockResponse = {
        kind: "books#volumes",
        totalItems: 100,
        items: [],
      };

      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: () => Promise.resolve(mockResponse),
      });

      await repository.searchByQuery("test", 10, 20);

      expect(fetch).toHaveBeenCalledWith(
        expect.stringMatching(/startIndex=20/),
        expect.any(Object),
      );
      expect(fetch).toHaveBeenCalledWith(
        expect.stringMatching(/maxResults=10/),
        expect.any(Object),
      );
    });

    it("API キーがリクエストに含まれる", async () => {
      const mockResponse = {
        kind: "books#volumes",
        totalItems: 0,
        items: [],
      };

      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: () => Promise.resolve(mockResponse),
      });

      await repository.searchByQuery("test", 10, 0);

      expect(fetch).toHaveBeenCalledWith(
        expect.stringContaining(`key=${mockApiKey}`),
        expect.any(Object),
      );
    });

    it("検索結果が0件の場合は空配列を返す", async () => {
      const mockResponse = {
        kind: "books#volumes",
        totalItems: 0,
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

    it("items が undefined の場合は空配列を返す", async () => {
      const mockResponse = {
        kind: "books#volumes",
        totalItems: 5,
      };

      global.fetch = vi.fn().mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: () => Promise.resolve(mockResponse),
      });

      const result = await repository.searchByQuery("test", 10, 0);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.items).toEqual([]);
        expect(result.data.totalItems).toBe(5);
      }
    });
  });
});

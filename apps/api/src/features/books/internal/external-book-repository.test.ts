import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  createExternalBookRepository,
  type ExternalBookRepository,
} from "./external-book-repository.js";

describe("ExternalBookRepository", () => {
  let repository: ExternalBookRepository;
  const mockApiKey = "test-api-key";

  beforeEach(() => {
    vi.useFakeTimers();
    repository = createExternalBookRepository(mockApiKey);
  });

  afterEach(() => {
    vi.useRealTimers();
    vi.restoreAllMocks();
  });

  describe("searchByQuery", () => {
    it("キーワード検索で書籍一覧を取得できる", async () => {
      const mockResponse = {
        kind: "books#volumes",
        totalItems: 1,
        items: [
          {
            id: "test-id-1",
            volumeInfo: {
              title: "テスト書籍",
              authors: ["著者1", "著者2"],
              publisher: "テスト出版社",
              publishedDate: "2024-01-01",
              industryIdentifiers: [
                { type: "ISBN_13", identifier: "9784123456789" },
              ],
              imageLinks: {
                thumbnail: "https://example.com/thumbnail.jpg",
              },
            },
          },
        ],
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
        expect(result.data.items[0].id).toBe("test-id-1");
        expect(result.data.items[0].volumeInfo.title).toBe("テスト書籍");
      }

      expect(fetch).toHaveBeenCalledWith(
        expect.stringContaining("q=%E3%83%86%E3%82%B9%E3%83%88"),
        expect.objectContaining({
          signal: expect.any(AbortSignal),
        }),
      );
    });

    it("ページネーションパラメータが正しく送信される", async () => {
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

      await repository.searchByQuery("test", 20, 40);

      expect(fetch).toHaveBeenCalledWith(
        expect.stringMatching(/startIndex=40/),
        expect.any(Object),
      );
      expect(fetch).toHaveBeenCalledWith(
        expect.stringMatching(/maxResults=20/),
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

    it("API エラー（4xx/5xx）時に API_ERROR を返す", async () => {
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
  });

  describe("searchByISBN", () => {
    it("ISBN で単一の書籍を検索できる", async () => {
      const mockResponse = {
        kind: "books#volumes",
        totalItems: 1,
        items: [
          {
            id: "isbn-book-id",
            volumeInfo: {
              title: "ISBN検索書籍",
              authors: ["著者"],
              publisher: "出版社",
              publishedDate: "2024",
              industryIdentifiers: [
                { type: "ISBN_13", identifier: "9784123456789" },
              ],
              imageLinks: {
                thumbnail: "https://example.com/cover.jpg",
              },
            },
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
        expect(result.data?.id).toBe("isbn-book-id");
        expect(result.data?.volumeInfo.title).toBe("ISBN検索書籍");
      }

      expect(fetch).toHaveBeenCalledWith(
        expect.stringContaining("q=isbn%3A9784123456789"),
        expect.any(Object),
      );
    });

    it("ISBN が見つからない場合は null を返す", async () => {
      const mockResponse = {
        kind: "books#volumes",
        totalItems: 0,
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
        kind: "books#volumes",
        totalItems: 1,
        items: [
          {
            id: "isbn10-book",
            volumeInfo: {
              title: "ISBN-10 書籍",
            },
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
        expect.stringContaining("q=isbn%3A4123456789"),
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
});

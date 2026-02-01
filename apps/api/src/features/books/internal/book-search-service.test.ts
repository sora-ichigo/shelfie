import { beforeEach, describe, expect, it, vi } from "vitest";
import { err, ok } from "../../../errors/result.js";
import type { LoggerService } from "../../../logger/index.js";
import type { GoogleBooksVolume, RakutenBooksItem } from "./book-mapper.js";
import {
  type BookSearchService,
  createBookSearchService,
} from "./book-search-service.js";
import type { ExternalBookRepository } from "./external-book-repository.js";
import type { GoogleBooksRepository } from "./google-books-repository.js";

function createMockLogger(): LoggerService {
  return {
    debug: vi.fn(),
    info: vi.fn(),
    warn: vi.fn(),
    error: vi.fn(),
    child: vi.fn().mockReturnThis(),
  };
}

function createMockRakutenBooksItem(
  overrides: Partial<RakutenBooksItem> = {},
): RakutenBooksItem {
  return {
    title: "Test Book",
    author: "Test Author",
    publisherName: "Test Publisher",
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
  };
}

function createMockGoogleBooksVolume(
  overrides: Partial<GoogleBooksVolume> = {},
): GoogleBooksVolume {
  return {
    kind: "books#volume",
    id: "google-volume-id",
    volumeInfo: {
      title: "Google Book Title",
      authors: ["Google Author"],
      publisher: "Google Publisher",
      publishedDate: "2024-01-01",
      description: "A book from Google Books",
      industryIdentifiers: [{ type: "ISBN_13", identifier: "9784123456789" }],
      pageCount: 300,
      categories: ["Technology"],
      imageLinks: {
        thumbnail: "https://books.google.com/thumbnail.jpg",
      },
    },
    ...overrides,
  };
}

describe("BookSearchService", () => {
  let mockRepository: ExternalBookRepository;
  let mockGoogleRepository: GoogleBooksRepository;
  let mockLogger: LoggerService;
  let service: BookSearchService;

  beforeEach(() => {
    mockRepository = {
      searchByQuery: vi.fn(),
      searchByISBN: vi.fn(),
      getBookByISBN: vi.fn(),
    };
    mockGoogleRepository = {
      searchByQuery: vi
        .fn()
        .mockResolvedValue(ok({ items: [], totalItems: 0 })),
      getVolumeById: vi.fn(),
    };
    mockLogger = createMockLogger();
    service = createBookSearchService(
      mockRepository,
      mockLogger,
      mockGoogleRepository,
    );
  });

  describe("searchBooks", () => {
    describe("successful search", () => {
      it("should return SearchBooksResult with books when search succeeds", async () => {
        const mockItems = [
          createMockRakutenBooksItem({ isbn: "9784123456781" }),
          createMockRakutenBooksItem({ isbn: "9784123456782" }),
        ];

        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: mockItems, totalItems: 100 }),
        );

        const result = await service.searchBooks({
          query: "TypeScript",
          limit: 10,
          offset: 0,
        });

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(2);
          expect(result.data.items[0].id).toBe("9784123456781");
          expect(result.data.items[1].id).toBe("9784123456782");
          expect(result.data.totalCount).toBe(100);
          expect(result.data.hasMore).toBe(true);
        }
      });

      it("should return hasMore=false when no more results", async () => {
        const mockItems = [createMockRakutenBooksItem()];

        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: mockItems, totalItems: 1 }),
        );

        const result = await service.searchBooks({
          query: "rare book",
          limit: 10,
          offset: 0,
        });

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.hasMore).toBe(false);
        }
      });

      it("should return empty items when no books found", async () => {
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: [], totalItems: 0 }),
        );

        const result = await service.searchBooks({
          query: "nonexistent book xyz123",
          limit: 10,
          offset: 0,
        });

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(0);
          expect(result.data.totalCount).toBe(0);
          expect(result.data.hasMore).toBe(false);
        }
      });

      it("should use default limit and offset when not provided", async () => {
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: [], totalItems: 0 }),
        );

        await service.searchBooks({ query: "test" });

        expect(mockRepository.searchByQuery).toHaveBeenCalledWith(
          "test",
          10,
          0,
        );
      });

      it("should map Rakuten Books items to Book type", async () => {
        const mockItem = createMockRakutenBooksItem({
          title: "Mapped Book Title",
          author: "Author One/Author Two",
          publisherName: "Publisher Name",
          salesDate: "2023年05月15日",
          isbn: "9781234567890",
          largeImageUrl: "https://books.rakuten.co.jp/cover.jpg",
        });

        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: [mockItem], totalItems: 1 }),
        );

        const result = await service.searchBooks({ query: "test" });

        expect(result.success).toBe(true);
        if (result.success) {
          const book = result.data.items[0];
          expect(book.id).toBe("9781234567890");
          expect(book.title).toBe("Mapped Book Title");
          expect(book.authors).toEqual(["Author One", "Author Two"]);
          expect(book.publisher).toBe("Publisher Name");
          expect(book.publishedDate).toBe("2023-05-15");
          expect(book.isbn).toBe("9781234567890");
          expect(book.coverImageUrl).toBe(
            "https://books.rakuten.co.jp/cover.jpg",
          );
        }
      });
    });

    describe("validation errors", () => {
      it("should return VALIDATION_ERROR when query is empty", async () => {
        const result = await service.searchBooks({ query: "" });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("VALIDATION_ERROR");
          expect(result.error.message).toContain("query");
        }
      });

      it("should return VALIDATION_ERROR when query is only whitespace", async () => {
        const result = await service.searchBooks({ query: "   " });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("VALIDATION_ERROR");
        }
      });

      it("should return VALIDATION_ERROR when limit is less than 1", async () => {
        const result = await service.searchBooks({ query: "test", limit: 0 });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("VALIDATION_ERROR");
          expect(result.error.message).toContain("limit");
        }
      });

      it("should return VALIDATION_ERROR when limit exceeds maximum (30)", async () => {
        const result = await service.searchBooks({ query: "test", limit: 31 });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("VALIDATION_ERROR");
          expect(result.error.message).toContain("limit");
        }
      });

      it("should return VALIDATION_ERROR when offset is negative", async () => {
        const result = await service.searchBooks({ query: "test", offset: -1 });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("VALIDATION_ERROR");
          expect(result.error.message).toContain("offset");
        }
      });
    });

    describe("external API error handling", () => {
      it("should convert NETWORK_ERROR to BookSearchErrors", async () => {
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          err({ code: "NETWORK_ERROR", message: "Network failure" }),
        );

        const result = await service.searchBooks({ query: "test" });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("NETWORK_ERROR");
        }
      });

      it("should convert TIMEOUT_ERROR to BookSearchErrors", async () => {
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          err({ code: "TIMEOUT_ERROR", message: "Request timeout" }),
        );

        const result = await service.searchBooks({ query: "test" });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("NETWORK_ERROR");
        }
      });

      it("should convert RATE_LIMIT_ERROR to EXTERNAL_API_ERROR", async () => {
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          err({ code: "RATE_LIMIT_ERROR", message: "Rate limit exceeded" }),
        );

        const result = await service.searchBooks({ query: "test" });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("EXTERNAL_API_ERROR");
        }
      });

      it("should convert API_ERROR to EXTERNAL_API_ERROR", async () => {
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          err({
            code: "API_ERROR",
            message: "Internal Server Error",
            statusCode: 500,
          }),
        );

        const result = await service.searchBooks({ query: "test" });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("EXTERNAL_API_ERROR");
        }
      });
    });

    describe("logging", () => {
      it("should log successful search", async () => {
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: [createMockRakutenBooksItem()], totalItems: 1 }),
        );

        await service.searchBooks({ query: "test" });

        expect(mockLogger.info).toHaveBeenCalledWith(
          expect.stringContaining("search"),
          expect.objectContaining({ query: "test" }),
        );
      });

      it("should log errors with warn level for external API errors", async () => {
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          err({ code: "NETWORK_ERROR", message: "Network failure" }),
        );

        await service.searchBooks({ query: "test" });

        expect(mockLogger.warn).toHaveBeenCalled();
      });
    });

    describe("sequential append", () => {
      it("should not call Google when Rakuten has enough results", async () => {
        const rakutenItems = Array.from({ length: 10 }, (_, i) =>
          createMockRakutenBooksItem({
            isbn: `978412345${String(i).padStart(4, "0")}`,
          }),
        );
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: rakutenItems, totalItems: 100 }),
        );

        const result = await service.searchBooks({
          query: "test",
          limit: 10,
          offset: 0,
        });

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(10);
          expect(result.data.items.every((b) => b.source === "rakuten")).toBe(
            true,
          );
          expect(result.data.hasMore).toBe(true);
        }
        expect(mockGoogleRepository.searchByQuery).not.toHaveBeenCalled();
      });

      it("should probe Google for hasMore on Rakuten boundary page", async () => {
        const rakutenItems = Array.from({ length: 10 }, (_, i) =>
          createMockRakutenBooksItem({
            isbn: `978412345${String(i).padStart(4, "0")}`,
          }),
        );
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: rakutenItems, totalItems: 100 }),
        );
        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValue(
          ok({ items: [], totalItems: 50 }),
        );

        const result = await service.searchBooks({
          query: "test",
          limit: 10,
          offset: 90,
        });

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(10);
          expect(result.data.items.every((b) => b.source === "rakuten")).toBe(
            true,
          );
          expect(result.data.totalCount).toBe(150);
          expect(result.data.hasMore).toBe(true);
        }
        expect(mockGoogleRepository.searchByQuery).toHaveBeenCalledWith(
          "test",
          1,
          0,
        );
      });

      it("should fill remaining with Google when Rakuten returns partial page", async () => {
        const rakutenItems = Array.from({ length: 3 }, (_, i) =>
          createMockRakutenBooksItem({
            isbn: `978412345${String(i).padStart(4, "0")}`,
          }),
        );
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: rakutenItems, totalItems: 13 }),
        );

        const googleVolumes = Array.from({ length: 7 }, (_, i) =>
          createMockGoogleBooksVolume({
            id: `google-${i}`,
            volumeInfo: {
              title: `Google本 ${i}`,
              authors: ["著者"],
              industryIdentifiers: [
                {
                  type: "ISBN_13",
                  identifier: `978400000${String(i).padStart(4, "0")}`,
                },
              ],
            },
          }),
        );
        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValue(
          ok({ items: googleVolumes, totalItems: 20 }),
        );

        const result = await service.searchBooks({
          query: "test",
          limit: 10,
          offset: 10,
        });

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items.length).toBeLessThanOrEqual(10);
          expect(
            result.data.items.filter((b) => b.source === "rakuten"),
          ).toHaveLength(3);
          expect(
            result.data.items.filter((b) => b.source === "google").length,
          ).toBeGreaterThan(0);
          expect(result.data.totalCount).toBe(33);
        }
        expect(mockGoogleRepository.searchByQuery).toHaveBeenCalledWith(
          "test",
          7,
          0,
        );
      });

      it("should return only Google results when offset exceeds Rakuten total", async () => {
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: [], totalItems: 5 }),
        );

        const googleVolumes = Array.from({ length: 10 }, (_, i) =>
          createMockGoogleBooksVolume({
            id: `google-${i}`,
            volumeInfo: {
              title: `Google本 ${i}`,
              authors: ["著者"],
              industryIdentifiers: [
                {
                  type: "ISBN_13",
                  identifier: `978400000${String(i).padStart(4, "0")}`,
                },
              ],
            },
          }),
        );
        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValue(
          ok({ items: googleVolumes, totalItems: 30 }),
        );

        const result = await service.searchBooks({
          query: "test",
          limit: 10,
          offset: 10,
        });

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items.every((b) => b.source === "google")).toBe(
            true,
          );
          expect(result.data.totalCount).toBe(35);
          expect(result.data.hasMore).toBe(true);
        }
        expect(mockGoogleRepository.searchByQuery).toHaveBeenCalledWith(
          "test",
          10,
          5,
        );
      });

      it("should fallback to Rakuten only when Google fails", async () => {
        const rakutenItems = Array.from({ length: 3 }, (_, i) =>
          createMockRakutenBooksItem({
            isbn: `978412345${String(i).padStart(4, "0")}`,
          }),
        );
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: rakutenItems, totalItems: 13 }),
        );
        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValue(
          err({ code: "NETWORK_ERROR", message: "Google API down" }),
        );

        const result = await service.searchBooks({
          query: "test",
          limit: 10,
          offset: 10,
        });

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(3);
          expect(result.data.items.every((b) => b.source === "rakuten")).toBe(
            true,
          );
          expect(result.data.totalCount).toBe(13);
          expect(result.data.hasMore).toBe(false);
        }
      });

      it("should deduplicate books with same ISBN across sources", async () => {
        const sharedIsbn = "9784123456789";
        const rakutenItems = [createMockRakutenBooksItem({ isbn: sharedIsbn })];
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: rakutenItems, totalItems: 5 }),
        );

        const googleVolumes = [
          createMockGoogleBooksVolume({
            id: "google-dup",
            volumeInfo: {
              title: "同じ本",
              authors: ["著者"],
              industryIdentifiers: [
                { type: "ISBN_13", identifier: sharedIsbn },
              ],
            },
          }),
        ];
        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValue(
          ok({ items: googleVolumes, totalItems: 10 }),
        );

        const result = await service.searchBooks({
          query: "test",
          limit: 10,
          offset: 0,
        });

        expect(result.success).toBe(true);
        if (result.success) {
          const isbnCounts = result.data.items.filter(
            (b) => b.isbn === sharedIsbn,
          );
          expect(isbnCounts).toHaveLength(1);
          expect(isbnCounts[0].source).toBe("rakuten");
        }
      });

      it("should return empty result when both sources are empty", async () => {
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: [], totalItems: 0 }),
        );
        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValue(
          ok({ items: [], totalItems: 0 }),
        );

        const result = await service.searchBooks({
          query: "nonexistent",
          limit: 10,
          offset: 0,
        });

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(0);
          expect(result.data.totalCount).toBe(0);
          expect(result.data.hasMore).toBe(false);
        }
      });

      it("should return Rakuten only when googleRepository is not provided", async () => {
        const serviceWithoutGoogle = createBookSearchService(
          mockRepository,
          mockLogger,
        );
        const rakutenItems = Array.from({ length: 3 }, (_, i) =>
          createMockRakutenBooksItem({
            isbn: `978412345${String(i).padStart(4, "0")}`,
          }),
        );
        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: rakutenItems, totalItems: 13 }),
        );

        const result = await serviceWithoutGoogle.searchBooks({
          query: "test",
          limit: 10,
          offset: 10,
        });

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(3);
          expect(result.data.items.every((b) => b.source === "rakuten")).toBe(
            true,
          );
          expect(result.data.totalCount).toBe(13);
        }
        expect(mockGoogleRepository.searchByQuery).not.toHaveBeenCalled();
      });
    });
  });

  describe("searchBookByISBN", () => {
    describe("successful search", () => {
      it("should return Book when ISBN is found", async () => {
        const mockItem = createMockRakutenBooksItem({
          title: "ISBN Book",
          author: "ISBN Author",
          isbn: "9784123456789",
        });

        vi.mocked(mockRepository.searchByISBN).mockResolvedValue(ok(mockItem));

        const result = await service.searchBookByISBN({
          isbn: "9784123456789",
        });

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data).not.toBeNull();
          expect(result.data?.id).toBe("9784123456789");
          expect(result.data?.title).toBe("ISBN Book");
        }
      });

      it("should return null when ISBN is not found", async () => {
        vi.mocked(mockRepository.searchByISBN).mockResolvedValue(ok(null));

        const result = await service.searchBookByISBN({ isbn: "0000000000" });

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data).toBeNull();
        }
      });
    });

    describe("validation errors", () => {
      it("should return VALIDATION_ERROR when ISBN is empty", async () => {
        const result = await service.searchBookByISBN({ isbn: "" });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("VALIDATION_ERROR");
          expect(result.error.message).toContain("ISBN");
        }
      });

      it("should return VALIDATION_ERROR when ISBN has invalid format (too short)", async () => {
        const result = await service.searchBookByISBN({ isbn: "123" });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("VALIDATION_ERROR");
          expect(result.error.message).toContain("ISBN");
        }
      });

      it("should return VALIDATION_ERROR when ISBN has invalid format (too long)", async () => {
        const result = await service.searchBookByISBN({
          isbn: "12345678901234567890",
        });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("VALIDATION_ERROR");
          expect(result.error.message).toContain("ISBN");
        }
      });

      it("should accept valid ISBN-10 format", async () => {
        vi.mocked(mockRepository.searchByISBN).mockResolvedValue(ok(null));

        const result = await service.searchBookByISBN({ isbn: "4123456789" });

        expect(result.success).toBe(true);
        expect(mockRepository.searchByISBN).toHaveBeenCalledWith("4123456789");
      });

      it("should accept valid ISBN-13 format", async () => {
        vi.mocked(mockRepository.searchByISBN).mockResolvedValue(ok(null));

        const result = await service.searchBookByISBN({
          isbn: "9784123456789",
        });

        expect(result.success).toBe(true);
        expect(mockRepository.searchByISBN).toHaveBeenCalledWith(
          "9784123456789",
        );
      });

      it("should strip hyphens from ISBN", async () => {
        vi.mocked(mockRepository.searchByISBN).mockResolvedValue(ok(null));

        const result = await service.searchBookByISBN({
          isbn: "978-4-12-345678-9",
        });

        expect(result.success).toBe(true);
        expect(mockRepository.searchByISBN).toHaveBeenCalledWith(
          "9784123456789",
        );
      });
    });

    describe("external API error handling", () => {
      it("should convert NETWORK_ERROR to BookSearchErrors", async () => {
        vi.mocked(mockRepository.searchByISBN).mockResolvedValue(
          err({ code: "NETWORK_ERROR", message: "Network failure" }),
        );

        const result = await service.searchBookByISBN({
          isbn: "9784123456789",
        });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("NETWORK_ERROR");
        }
      });

      it("should convert TIMEOUT_ERROR to NETWORK_ERROR", async () => {
        vi.mocked(mockRepository.searchByISBN).mockResolvedValue(
          err({ code: "TIMEOUT_ERROR", message: "Request timeout" }),
        );

        const result = await service.searchBookByISBN({
          isbn: "9784123456789",
        });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("NETWORK_ERROR");
        }
      });

      it("should convert API_ERROR to EXTERNAL_API_ERROR", async () => {
        vi.mocked(mockRepository.searchByISBN).mockResolvedValue(
          err({
            code: "API_ERROR",
            message: "Server Error",
            statusCode: 500,
          }),
        );

        const result = await service.searchBookByISBN({
          isbn: "9784123456789",
        });

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("EXTERNAL_API_ERROR");
        }
      });
    });

    describe("logging", () => {
      it("should log ISBN search", async () => {
        vi.mocked(mockRepository.searchByISBN).mockResolvedValue(
          ok(createMockRakutenBooksItem()),
        );

        await service.searchBookByISBN({ isbn: "9784123456789" });

        expect(mockLogger.info).toHaveBeenCalledWith(
          expect.stringContaining("ISBN"),
          expect.objectContaining({ isbn: "9784123456789" }),
        );
      });

      it("should log when ISBN book not found", async () => {
        vi.mocked(mockRepository.searchByISBN).mockResolvedValue(ok(null));

        await service.searchBookByISBN({ isbn: "0000000000" });

        expect(mockLogger.info).toHaveBeenCalledWith(
          expect.stringContaining("not found"),
          expect.any(Object),
        );
      });
    });
  });

  describe("getBookDetail", () => {
    describe("successful fetch", () => {
      it("should return BookDetail when ISBN is found", async () => {
        const mockItem = createMockRakutenBooksItem({
          title: "Detail Book",
          author: "Detail Author",
          isbn: "9784123456789",
          itemCaption: "This is a book description",
        });

        vi.mocked(mockRepository.getBookByISBN).mockResolvedValue(ok(mockItem));

        const result = await service.getBookDetail("9784123456789");

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.id).toBe("9784123456789");
          expect(result.data.title).toBe("Detail Book");
          expect(result.data.description).toBe("This is a book description");
          expect(result.data.rakutenBooksUrl).toBe(
            "https://books.rakuten.co.jp/rb/12345678/",
          );
        }
      });

      it("should return NOT_FOUND when ISBN is not found", async () => {
        vi.mocked(mockRepository.getBookByISBN).mockResolvedValue(ok(null));

        const result = await service.getBookDetail("0000000000000");

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("NOT_FOUND");
        }
      });
    });

    describe("validation errors", () => {
      it("should return VALIDATION_ERROR when bookId is empty", async () => {
        const result = await service.getBookDetail("");

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("VALIDATION_ERROR");
        }
      });

      it("should return VALIDATION_ERROR when bookId is only whitespace", async () => {
        const result = await service.getBookDetail("   ");

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("VALIDATION_ERROR");
        }
      });
    });

    describe("external API error handling", () => {
      it("should convert NETWORK_ERROR to BookSearchErrors", async () => {
        vi.mocked(mockRepository.getBookByISBN).mockResolvedValue(
          err({ code: "NETWORK_ERROR", message: "Network failure" }),
        );

        const result = await service.getBookDetail("9784123456789");

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("NETWORK_ERROR");
        }
      });
    });

    describe("logging", () => {
      it("should log successful book detail fetch", async () => {
        vi.mocked(mockRepository.getBookByISBN).mockResolvedValue(
          ok(createMockRakutenBooksItem()),
        );

        await service.getBookDetail("9784123456789");

        expect(mockLogger.info).toHaveBeenCalledWith(
          expect.stringContaining("detail"),
          expect.objectContaining({ bookId: "9784123456789" }),
        );
      });

      it("should log when book not found", async () => {
        vi.mocked(mockRepository.getBookByISBN).mockResolvedValue(ok(null));

        await service.getBookDetail("0000000000000");

        expect(mockLogger.info).toHaveBeenCalledWith(
          expect.stringContaining("not found"),
          expect.any(Object),
        );
      });
    });

    describe("source parameter", () => {
      it("should fetch from Rakuten when source is 'rakuten'", async () => {
        const mockItem = createMockRakutenBooksItem({
          title: "Rakuten Book",
          isbn: "9784123456789",
        });
        vi.mocked(mockRepository.getBookByISBN).mockResolvedValue(ok(mockItem));

        const result = await service.getBookDetail("9784123456789", "rakuten");

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.title).toBe("Rakuten Book");
        }
        expect(mockRepository.getBookByISBN).toHaveBeenCalledWith(
          "9784123456789",
        );
        expect(mockGoogleRepository.getVolumeById).not.toHaveBeenCalled();
      });

      it("should fetch from Google Books when source is 'google'", async () => {
        const mockVolume = createMockGoogleBooksVolume({
          id: "google-volume-123",
          volumeInfo: {
            title: "Google Book",
            authors: ["Google Author"],
            publisher: "Google Publisher",
            publishedDate: "2024-01-01",
            description: "A description",
            industryIdentifiers: [
              { type: "ISBN_13", identifier: "9784123456789" },
            ],
            pageCount: 250,
            categories: ["Programming"],
            imageLinks: { thumbnail: "https://example.com/cover.jpg" },
          },
        });
        vi.mocked(mockGoogleRepository.getVolumeById).mockResolvedValue(
          ok(mockVolume),
        );

        const result = await service.getBookDetail(
          "google-volume-123",
          "google",
        );

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.title).toBe("Google Book");
          expect(result.data.authors).toEqual(["Google Author"]);
          expect(result.data.description).toBe("A description");
          expect(result.data.pageCount).toBe(250);
        }
        expect(mockGoogleRepository.getVolumeById).toHaveBeenCalledWith(
          "google-volume-123",
        );
        expect(mockRepository.getBookByISBN).not.toHaveBeenCalled();
      });

      it("should return NOT_FOUND when Google Books volume is not found", async () => {
        vi.mocked(mockGoogleRepository.getVolumeById).mockResolvedValue(
          ok(null),
        );

        const result = await service.getBookDetail("nonexistent-id", "google");

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("NOT_FOUND");
        }
      });

      it("should handle Google Books API errors", async () => {
        vi.mocked(mockGoogleRepository.getVolumeById).mockResolvedValue(
          err({ code: "NETWORK_ERROR", message: "Network failure" }),
        );

        const result = await service.getBookDetail(
          "google-volume-123",
          "google",
        );

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("NETWORK_ERROR");
        }
      });

      it("should search by ISBN when source is 'google' and bookId is an ISBN-13", async () => {
        const mockVolume = createMockGoogleBooksVolume({
          id: "actual-google-volume-id",
          volumeInfo: {
            title: "ISBN Google Book",
            authors: ["Author"],
            publisher: "Publisher",
            publishedDate: "2024-01-01",
            description: "Description",
            industryIdentifiers: [
              { type: "ISBN_13", identifier: "9784797386479" },
            ],
            pageCount: 300,
            categories: ["Programming"],
            imageLinks: { thumbnail: "https://example.com/cover.jpg" },
          },
        });
        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValue(
          ok({ items: [mockVolume], totalItems: 1 }),
        );

        const result = await service.getBookDetail("9784797386479", "google");

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.title).toBe("ISBN Google Book");
          expect(result.data.isbn).toBe("9784797386479");
        }
        expect(mockGoogleRepository.searchByQuery).toHaveBeenCalledWith(
          "isbn:9784797386479",
          1,
          0,
        );
        expect(mockGoogleRepository.getVolumeById).not.toHaveBeenCalled();
      });

      it("should search by ISBN when source is 'google' and bookId is an ISBN-10", async () => {
        const mockVolume = createMockGoogleBooksVolume({
          id: "actual-google-volume-id",
          volumeInfo: {
            title: "ISBN-10 Google Book",
            authors: ["Author"],
            publishedDate: "2024-01-01",
            industryIdentifiers: [
              { type: "ISBN_10", identifier: "4797386479" },
            ],
            imageLinks: { thumbnail: "https://example.com/cover.jpg" },
          },
        });
        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValue(
          ok({ items: [mockVolume], totalItems: 1 }),
        );

        const result = await service.getBookDetail("4797386479", "google");

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.title).toBe("ISBN-10 Google Book");
        }
        expect(mockGoogleRepository.searchByQuery).toHaveBeenCalledWith(
          "isbn:4797386479",
          1,
          0,
        );
        expect(mockGoogleRepository.getVolumeById).not.toHaveBeenCalled();
      });

      it("should return NOT_FOUND when Google ISBN search returns no results", async () => {
        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValue(
          ok({ items: [], totalItems: 0 }),
        );

        const result = await service.getBookDetail("9784797386479", "google");

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("NOT_FOUND");
        }
      });

      it("should handle Google Books search API errors when searching by ISBN", async () => {
        vi.mocked(mockGoogleRepository.searchByQuery).mockResolvedValue(
          err({
            code: "API_ERROR",
            message: "Service Unavailable",
            statusCode: 503,
          }),
        );

        const result = await service.getBookDetail("9784797386479", "google");

        expect(result.success).toBe(false);
        if (!result.success) {
          expect(result.error.code).toBe("EXTERNAL_API_ERROR");
        }
      });

      it("should use getVolumeById when source is 'google' and bookId is a volume ID", async () => {
        const mockVolume = createMockGoogleBooksVolume({
          id: "google-volume-123",
        });
        vi.mocked(mockGoogleRepository.getVolumeById).mockResolvedValue(
          ok(mockVolume),
        );

        const result = await service.getBookDetail(
          "google-volume-123",
          "google",
        );

        expect(result.success).toBe(true);
        expect(mockGoogleRepository.getVolumeById).toHaveBeenCalledWith(
          "google-volume-123",
        );
        expect(mockGoogleRepository.searchByQuery).not.toHaveBeenCalled();
      });

      it("should default to Rakuten when source is not provided", async () => {
        const mockItem = createMockRakutenBooksItem({
          title: "Default Rakuten Book",
          isbn: "9784123456789",
        });
        vi.mocked(mockRepository.getBookByISBN).mockResolvedValue(ok(mockItem));

        const result = await service.getBookDetail("9784123456789");

        expect(result.success).toBe(true);
        expect(mockRepository.getBookByISBN).toHaveBeenCalled();
        expect(mockGoogleRepository.getVolumeById).not.toHaveBeenCalled();
      });
    });
  });
});

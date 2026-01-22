import { beforeEach, describe, expect, it, vi } from "vitest";
import { err, ok } from "../../../errors/result.js";
import type { LoggerService } from "../../../logger/index.js";
import type { GoogleBooksVolume } from "./book-mapper.js";
import {
  type BookSearchService,
  createBookSearchService,
} from "./book-search-service.js";
import type { ExternalBookRepository } from "./external-book-repository.js";

function createMockLogger(): LoggerService {
  return {
    debug: vi.fn(),
    info: vi.fn(),
    warn: vi.fn(),
    error: vi.fn(),
    child: vi.fn().mockReturnThis(),
  };
}

function createMockGoogleBooksVolume(
  overrides: Partial<GoogleBooksVolume> = {},
): GoogleBooksVolume {
  return {
    id: "test-volume-id",
    volumeInfo: {
      title: "Test Book",
      authors: ["Test Author"],
      publisher: "Test Publisher",
      publishedDate: "2024-01-01",
      industryIdentifiers: [{ type: "ISBN_13", identifier: "9784123456789" }],
      imageLinks: { thumbnail: "https://example.com/thumbnail.jpg" },
    },
    ...overrides,
  };
}

describe("BookSearchService", () => {
  let mockRepository: ExternalBookRepository;
  let mockLogger: LoggerService;
  let service: BookSearchService;

  beforeEach(() => {
    mockRepository = {
      searchByQuery: vi.fn(),
      searchByISBN: vi.fn(),
    };
    mockLogger = createMockLogger();
    service = createBookSearchService(mockRepository, mockLogger);
  });

  describe("searchBooks", () => {
    describe("successful search", () => {
      it("should return SearchBooksResult with books when search succeeds", async () => {
        const mockVolumes = [
          createMockGoogleBooksVolume({ id: "book-1" }),
          createMockGoogleBooksVolume({ id: "book-2" }),
        ];

        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: mockVolumes, totalItems: 100 }),
        );

        const result = await service.searchBooks({
          query: "TypeScript",
          limit: 10,
          offset: 0,
        });

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.items).toHaveLength(2);
          expect(result.data.items[0].id).toBe("book-1");
          expect(result.data.items[1].id).toBe("book-2");
          expect(result.data.totalCount).toBe(100);
          expect(result.data.hasMore).toBe(true);
        }
      });

      it("should return hasMore=false when no more results", async () => {
        const mockVolumes = [createMockGoogleBooksVolume()];

        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: mockVolumes, totalItems: 1 }),
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

      it("should map Google Books volumes to Book type", async () => {
        const mockVolume = createMockGoogleBooksVolume({
          id: "mapped-book",
          volumeInfo: {
            title: "Mapped Book Title",
            authors: ["Author One", "Author Two"],
            publisher: "Publisher Name",
            publishedDate: "2023-05-15",
            industryIdentifiers: [
              { type: "ISBN_13", identifier: "9781234567890" },
            ],
            imageLinks: {
              thumbnail: "https://books.google.com/cover.jpg",
            },
          },
        });

        vi.mocked(mockRepository.searchByQuery).mockResolvedValue(
          ok({ items: [mockVolume], totalItems: 1 }),
        );

        const result = await service.searchBooks({ query: "test" });

        expect(result.success).toBe(true);
        if (result.success) {
          const book = result.data.items[0];
          expect(book.id).toBe("mapped-book");
          expect(book.title).toBe("Mapped Book Title");
          expect(book.authors).toEqual(["Author One", "Author Two"]);
          expect(book.publisher).toBe("Publisher Name");
          expect(book.publishedDate).toBe("2023-05-15");
          expect(book.isbn).toBe("9781234567890");
          expect(book.coverImageUrl).toBe("https://books.google.com/cover.jpg");
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

      it("should return VALIDATION_ERROR when limit exceeds maximum (40)", async () => {
        const result = await service.searchBooks({ query: "test", limit: 41 });

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
          ok({ items: [createMockGoogleBooksVolume()], totalItems: 1 }),
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
  });

  describe("searchBookByISBN", () => {
    describe("successful search", () => {
      it("should return Book when ISBN is found", async () => {
        const mockVolume = createMockGoogleBooksVolume({
          id: "isbn-book",
          volumeInfo: {
            title: "ISBN Book",
            authors: ["ISBN Author"],
            industryIdentifiers: [
              { type: "ISBN_13", identifier: "9784123456789" },
            ],
          },
        });

        vi.mocked(mockRepository.searchByISBN).mockResolvedValue(
          ok(mockVolume),
        );

        const result = await service.searchBookByISBN({
          isbn: "9784123456789",
        });

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data).not.toBeNull();
          expect(result.data?.id).toBe("isbn-book");
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
          ok(createMockGoogleBooksVolume()),
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
});

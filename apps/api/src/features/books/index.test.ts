import { describe, expect, it } from "vitest";
import {
  type Book,
  createExternalBookRepository,
  type ExternalApiErrors,
  type ExternalBookRepository,
  type GoogleBooksVolume,
  mapGoogleBooksVolume,
} from "./index.js";

describe("books Feature public API", () => {
  describe("exports", () => {
    it("mapGoogleBooksVolume 関数がエクスポートされている", () => {
      expect(typeof mapGoogleBooksVolume).toBe("function");
    });

    it("createExternalBookRepository 関数がエクスポートされている", () => {
      expect(typeof createExternalBookRepository).toBe("function");
    });

    it("Book 型がエクスポートされている", () => {
      const book: Book = {
        id: "test",
        title: "Test",
        authors: [],
        publisher: null,
        publishedDate: null,
        isbn: null,
        coverImageUrl: null,
      };
      expect(book.id).toBe("test");
    });

    it("GoogleBooksVolume 型がエクスポートされている", () => {
      const volume: GoogleBooksVolume = {
        id: "test",
        volumeInfo: {
          title: "Test",
        },
      };
      expect(volume.id).toBe("test");
    });

    it("ExternalBookRepository 型がエクスポートされている", () => {
      const repo: ExternalBookRepository = createExternalBookRepository(
        "test-key",
      );
      expect(typeof repo.searchByQuery).toBe("function");
      expect(typeof repo.searchByISBN).toBe("function");
    });

    it("ExternalApiErrors 型がエクスポートされている", () => {
      const error: ExternalApiErrors = {
        code: "NETWORK_ERROR",
        message: "test",
      };
      expect(error.code).toBe("NETWORK_ERROR");
    });
  });
});

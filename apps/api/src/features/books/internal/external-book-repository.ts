import { err, ok, type Result } from "../../../errors/result.js";
import type { GoogleBooksVolume } from "./book-mapper.js";

export type ExternalApiErrors =
  | { code: "NETWORK_ERROR"; message: string }
  | { code: "TIMEOUT_ERROR"; message: string }
  | { code: "RATE_LIMIT_ERROR"; message: string }
  | { code: "API_ERROR"; message: string; statusCode: number };

interface GoogleBooksResponse {
  kind: string;
  totalItems: number;
  items?: GoogleBooksVolume[];
}

export interface ExternalBookRepository {
  searchByQuery(
    query: string,
    limit: number,
    offset: number,
  ): Promise<
    Result<
      { items: GoogleBooksVolume[]; totalItems: number },
      ExternalApiErrors
    >
  >;

  searchByISBN(
    isbn: string,
  ): Promise<Result<GoogleBooksVolume | null, ExternalApiErrors>>;

  getBookById(
    bookId: string,
  ): Promise<Result<GoogleBooksVolume | null, ExternalApiErrors>>;
}

const GOOGLE_BOOKS_API_BASE_URL = "https://www.googleapis.com/books/v1/volumes";
const TIMEOUT_MS = 3000;

function buildSearchUrl(
  apiKey: string,
  query: string,
  maxResults: number,
  startIndex: number,
): string {
  const params = new URLSearchParams({
    q: query,
    maxResults: maxResults.toString(),
    startIndex: startIndex.toString(),
    key: apiKey,
  });

  return `${GOOGLE_BOOKS_API_BASE_URL}?${params.toString()}`;
}

function isAbortError(error: unknown): boolean {
  return error instanceof DOMException && error.name === "AbortError";
}

async function fetchWithTimeout(
  url: string,
  timeoutMs: number,
): Promise<Result<Response, ExternalApiErrors>> {
  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), timeoutMs);

  try {
    const response = await fetch(url, { signal: controller.signal });
    clearTimeout(timeoutId);
    return ok(response);
  } catch (error) {
    clearTimeout(timeoutId);

    if (isAbortError(error)) {
      return err({
        code: "TIMEOUT_ERROR",
        message: `Request timed out after ${timeoutMs}ms`,
      });
    }

    return err({
      code: "NETWORK_ERROR",
      message: error instanceof Error ? error.message : "Unknown network error",
    });
  }
}

function handleHttpError(response: Response): ExternalApiErrors {
  if (response.status === 429) {
    return {
      code: "RATE_LIMIT_ERROR",
      message: "Rate limit exceeded",
    };
  }

  return {
    code: "API_ERROR",
    message: `Google Books API error: ${response.status} ${response.statusText}`,
    statusCode: response.status,
  };
}

export function createExternalBookRepository(
  apiKey: string,
): ExternalBookRepository {
  return {
    async searchByQuery(
      query: string,
      limit: number,
      offset: number,
    ): Promise<
      Result<
        { items: GoogleBooksVolume[]; totalItems: number },
        ExternalApiErrors
      >
    > {
      const url = buildSearchUrl(apiKey, query, limit, offset);
      const fetchResult = await fetchWithTimeout(url, TIMEOUT_MS);

      if (!fetchResult.success) {
        return fetchResult;
      }

      const response = fetchResult.data;

      if (!response.ok) {
        return err(handleHttpError(response));
      }

      const data = (await response.json()) as GoogleBooksResponse;

      return ok({
        items: data.items ?? [],
        totalItems: data.totalItems,
      });
    },

    async searchByISBN(
      isbn: string,
    ): Promise<Result<GoogleBooksVolume | null, ExternalApiErrors>> {
      const query = `isbn:${isbn}`;
      const url = buildSearchUrl(apiKey, query, 1, 0);
      const fetchResult = await fetchWithTimeout(url, TIMEOUT_MS);

      if (!fetchResult.success) {
        return fetchResult;
      }

      const response = fetchResult.data;

      if (!response.ok) {
        return err(handleHttpError(response));
      }

      const data = (await response.json()) as GoogleBooksResponse;

      if (!data.items || data.items.length === 0) {
        return ok(null);
      }

      return ok(data.items[0]);
    },

    async getBookById(
      bookId: string,
    ): Promise<Result<GoogleBooksVolume | null, ExternalApiErrors>> {
      const url = `${GOOGLE_BOOKS_API_BASE_URL}/${encodeURIComponent(bookId)}?key=${apiKey}`;
      const fetchResult = await fetchWithTimeout(url, TIMEOUT_MS);

      if (!fetchResult.success) {
        return fetchResult;
      }

      const response = fetchResult.data;

      if (response.status === 404) {
        return ok(null);
      }

      if (!response.ok) {
        return err(handleHttpError(response));
      }

      const data = (await response.json()) as GoogleBooksVolume;
      return ok(data);
    },
  };
}

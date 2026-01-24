import { err, ok, type Result } from "../../../errors/result.js";
import type { RakutenBooksItem } from "./book-mapper.js";

export type ExternalApiErrors =
  | { code: "NETWORK_ERROR"; message: string }
  | { code: "TIMEOUT_ERROR"; message: string }
  | { code: "RATE_LIMIT_ERROR"; message: string }
  | { code: "API_ERROR"; message: string; statusCode: number };

interface RakutenBooksResponse {
  count: number;
  page: number;
  pageCount: number;
  hits: number;
  Items: Array<{ Item: RakutenBooksItem }>;
}

export interface ExternalBookRepository {
  searchByQuery(
    query: string,
    limit: number,
    offset: number,
  ): Promise<
    Result<
      { items: RakutenBooksItem[]; totalItems: number },
      ExternalApiErrors
    >
  >;

  searchByISBN(
    isbn: string,
  ): Promise<Result<RakutenBooksItem | null, ExternalApiErrors>>;

  getBookByISBN(
    isbn: string,
  ): Promise<Result<RakutenBooksItem | null, ExternalApiErrors>>;
}

const RAKUTEN_BOOKS_API_URL =
  "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404";
const TIMEOUT_MS = 3000;
const MAX_HITS = 30;

function offsetToPage(offset: number, limit: number): number {
  return Math.floor(offset / limit) + 1;
}

function buildSearchUrl(
  applicationId: string,
  params: Record<string, string | number>,
): string {
  const searchParams = new URLSearchParams({
    applicationId,
    format: "json",
    ...Object.fromEntries(
      Object.entries(params).map(([k, v]) => [k, String(v)]),
    ),
  });

  return `${RAKUTEN_BOOKS_API_URL}?${searchParams.toString()}`;
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
    message: `Rakuten Books API error: ${response.status} ${response.statusText}`,
    statusCode: response.status,
  };
}

function extractItems(response: RakutenBooksResponse): RakutenBooksItem[] {
  if (!response.Items || response.Items.length === 0) {
    return [];
  }
  return response.Items.map((wrapper) => wrapper.Item);
}

export function createExternalBookRepository(
  applicationId: string,
): ExternalBookRepository {
  return {
    async searchByQuery(
      query: string,
      limit: number,
      offset: number,
    ): Promise<
      Result<
        { items: RakutenBooksItem[]; totalItems: number },
        ExternalApiErrors
      >
    > {
      const hits = Math.min(limit, MAX_HITS);
      const page = offsetToPage(offset, hits);

      const url = buildSearchUrl(applicationId, {
        title: query,
        hits,
        page,
      });

      const fetchResult = await fetchWithTimeout(url, TIMEOUT_MS);

      if (!fetchResult.success) {
        return fetchResult;
      }

      const response = fetchResult.data;

      if (!response.ok) {
        return err(handleHttpError(response));
      }

      const data = (await response.json()) as RakutenBooksResponse;

      return ok({
        items: extractItems(data),
        totalItems: data.count,
      });
    },

    async searchByISBN(
      isbn: string,
    ): Promise<Result<RakutenBooksItem | null, ExternalApiErrors>> {
      const url = buildSearchUrl(applicationId, {
        isbn,
        hits: 1,
      });

      const fetchResult = await fetchWithTimeout(url, TIMEOUT_MS);

      if (!fetchResult.success) {
        return fetchResult;
      }

      const response = fetchResult.data;

      if (!response.ok) {
        return err(handleHttpError(response));
      }

      const data = (await response.json()) as RakutenBooksResponse;
      const items = extractItems(data);

      if (items.length === 0) {
        return ok(null);
      }

      return ok(items[0]);
    },

    async getBookByISBN(
      isbn: string,
    ): Promise<Result<RakutenBooksItem | null, ExternalApiErrors>> {
      return this.searchByISBN(isbn);
    },
  };
}

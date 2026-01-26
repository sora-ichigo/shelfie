import { err, ok, type Result } from "../../../errors/result.js";
import type {
  GoogleBooksVolume,
  GoogleBooksVolumeInfo,
} from "./book-mapper.js";
import type { ExternalApiErrors } from "./external-book-repository.js";

export type { GoogleBooksVolume, GoogleBooksVolumeInfo };

interface GoogleBooksResponse {
  kind: string;
  totalItems: number;
  items?: GoogleBooksVolume[];
}

export interface GoogleBooksRepository {
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
}

const GOOGLE_BOOKS_API_URL = "https://www.googleapis.com/books/v1/volumes";
const TIMEOUT_MS = 3000;
const MAX_RESULTS = 40;

function buildSearchUrl(
  apiKey: string,
  params: Record<string, string | number>,
): string {
  const searchParams = new URLSearchParams({
    key: apiKey,
    ...Object.fromEntries(
      Object.entries(params).map(([k, v]) => [k, String(v)]),
    ),
  });

  return `${GOOGLE_BOOKS_API_URL}?${searchParams.toString()}`;
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

function extractItems(response: GoogleBooksResponse): GoogleBooksVolume[] {
  if (!response.items || response.items.length === 0) {
    return [];
  }
  return response.items;
}

export function createGoogleBooksRepository(
  apiKey: string,
): GoogleBooksRepository {
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
      const maxResults = Math.min(limit, MAX_RESULTS);

      const url = buildSearchUrl(apiKey, {
        q: query,
        maxResults,
        startIndex: offset,
        // orderBy: "newest",
        printType: "books",
        langRestrict: "ja",
      });

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
        items: extractItems(data),
        totalItems: data.totalItems,
      });
    },
  };
}

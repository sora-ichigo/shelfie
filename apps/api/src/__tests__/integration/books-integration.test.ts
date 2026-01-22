import type { Server } from "node:http";
import type { ApolloServer } from "@apollo/server";
import { expressMiddleware } from "@as-integrations/express4";
import { sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/node-postgres";
import express, { type Express } from "express";
import { Pool } from "pg";
import { afterAll, beforeAll, beforeEach, describe, expect, it } from "vitest";
import { config } from "../../config/index.js";
import type { GraphQLContext } from "../../graphql/context.js";
import { createApolloServer } from "../../graphql/server.js";

interface GraphQLResponse<T = unknown> {
  data?: T;
  errors?: Array<{
    message: string;
    extensions?: {
      code?: string;
      [key: string]: unknown;
    };
  }>;
}

function createTestExpressApp(server: ApolloServer<GraphQLContext>): Express {
  const app = express();

  app.use(
    "/graphql",
    express.json(),
    expressMiddleware(server, {
      context: async ({ req }) => {
        const testUserUid = req.headers["x-test-user-uid"] as
          | string
          | undefined;

        if (testUserUid) {
          return {
            requestId: "test-request-id",
            user: {
              uid: testUserUid,
              email: `${testUserUid}@test.com`,
              emailVerified: true,
            },
          };
        }

        return {
          requestId: "test-request-id",
          user: null,
        };
      },
    }),
  );

  return app;
}

describe("Books Feature Integration Tests", () => {
  let server: ApolloServer<GraphQLContext>;
  let app: Express;
  let httpServer: Server;
  let baseUrl: string;
  let pool: Pool;

  beforeAll(async () => {
    pool = new Pool({
      connectionString: config.get("DATABASE_URL"),
      max: 5,
    });
    const db = drizzle(pool);

    await db.execute(sql`
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        email TEXT NOT NULL UNIQUE,
        firebase_uid TEXT NOT NULL UNIQUE,
        created_at TIMESTAMP NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMP NOT NULL DEFAULT NOW()
      )
    `);

    await db.execute(sql`
      CREATE INDEX IF NOT EXISTS idx_users_firebase_uid ON users(firebase_uid)
    `);

    await db.execute(sql`
      CREATE TABLE IF NOT EXISTS user_books (
        id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        external_id TEXT NOT NULL,
        title TEXT NOT NULL,
        authors TEXT[] NOT NULL DEFAULT '{}',
        publisher TEXT,
        published_date TEXT,
        isbn TEXT,
        cover_image_url TEXT,
        added_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
        UNIQUE(user_id, external_id)
      )
    `);

    await db.execute(sql`
      CREATE INDEX IF NOT EXISTS idx_user_books_user_id ON user_books(user_id)
    `);

    server = createApolloServer();
    await server.start();
    app = createTestExpressApp(server);
    httpServer = app.listen(0);
    const port = (httpServer.address() as { port: number }).port;
    baseUrl = `http://localhost:${port}/graphql`;
  });

  afterAll(async () => {
    await server.stop();
    httpServer.close();
    await pool.end();
  });

  beforeEach(async () => {
    const db = drizzle(pool);
    await db.execute(sql`TRUNCATE TABLE user_books RESTART IDENTITY CASCADE`);
    await db.execute(sql`TRUNCATE TABLE users RESTART IDENTITY CASCADE`);
  });

  async function executeQuery<T>(
    query: string,
    variables?: Record<string, unknown>,
    headers?: Record<string, string>,
  ): Promise<GraphQLResponse<T>> {
    const response = await fetch(baseUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        ...headers,
      },
      body: JSON.stringify({ query, variables }),
    });
    return response.json() as Promise<GraphQLResponse<T>>;
  }

  async function createTestUser(): Promise<{
    id: number;
    firebaseUid: string;
  }> {
    const db = drizzle(pool);
    const result = await db.execute<{ id: number; firebase_uid: string }>(sql`
      INSERT INTO users (email, firebase_uid)
      VALUES ('test@example.com', 'test-firebase-uid-123')
      RETURNING id, firebase_uid
    `);
    const row = result.rows[0];
    return { id: row.id, firebaseUid: row.firebase_uid };
  }

  const authHeaders = { "x-test-user-uid": "test-user-for-search" };

  describe("Task 10.1: 検索 Query の統合テスト", () => {
    describe("searchBooks Query - Validation", () => {
      it("should return validation error when query is empty", async () => {
        const result = await executeQuery<{
          searchBooks: { items: Array<{ id: string }> };
        }>(
          `
          query SearchBooks($query: String!) {
            searchBooks(query: $query) {
              items {
                id
              }
            }
          }
        `,
          { query: "   " },
          authHeaders,
        );

        expect(result.errors).toBeDefined();
        expect(result.errors?.[0].extensions?.code).toBe("VALIDATION_ERROR");
      });

      it("should return validation error when limit is out of range", async () => {
        const result = await executeQuery<{
          searchBooks: { items: Array<{ id: string }> };
        }>(
          `
          query SearchBooks($query: String!, $limit: Int) {
            searchBooks(query: $query, limit: $limit) {
              items {
                id
              }
            }
          }
        `,
          { query: "test", limit: 100 },
          authHeaders,
        );

        expect(result.errors).toBeDefined();
        expect(result.errors?.[0].extensions?.code).toBe("VALIDATION_ERROR");
      });

      it("should return validation error when limit is negative", async () => {
        const result = await executeQuery<{
          searchBooks: { items: Array<{ id: string }> };
        }>(
          `
          query SearchBooks($query: String!, $limit: Int) {
            searchBooks(query: $query, limit: $limit) {
              items {
                id
              }
            }
          }
        `,
          { query: "test", limit: -1 },
          authHeaders,
        );

        expect(result.errors).toBeDefined();
        expect(result.errors?.[0].extensions?.code).toBe("VALIDATION_ERROR");
      });
    });

    describe("searchBookByISBN Query - Validation", () => {
      it("should return validation error when ISBN is empty", async () => {
        const result = await executeQuery<{
          searchBookByISBN: { id: string } | null;
        }>(
          `
          query SearchBookByISBN($isbn: String!) {
            searchBookByISBN(isbn: $isbn) {
              id
            }
          }
        `,
          { isbn: "" },
          authHeaders,
        );

        expect(result.errors).toBeDefined();
        expect(result.errors?.[0].extensions?.code).toBe("VALIDATION_ERROR");
      });

      it("should return validation error when ISBN length is invalid", async () => {
        const result = await executeQuery<{
          searchBookByISBN: { id: string } | null;
        }>(
          `
          query SearchBookByISBN($isbn: String!) {
            searchBookByISBN(isbn: $isbn) {
              id
            }
          }
        `,
          { isbn: "12345" },
          authHeaders,
        );

        expect(result.errors).toBeDefined();
        expect(result.errors?.[0].extensions?.code).toBe("VALIDATION_ERROR");
      });

      it("should return validation error when ISBN contains only non-digit characters", async () => {
        const result = await executeQuery<{
          searchBookByISBN: { id: string } | null;
        }>(
          `
          query SearchBookByISBN($isbn: String!) {
            searchBookByISBN(isbn: $isbn) {
              id
            }
          }
        `,
          { isbn: "abcdefghijk" },
          authHeaders,
        );

        expect(result.errors).toBeDefined();
        expect(result.errors?.[0].extensions?.code).toBe("VALIDATION_ERROR");
      });
    });
  });

  describe("Task 10.2: 本棚追加 Mutation の統合テスト", () => {
    describe("addBookToShelf Mutation", () => {
      it("should add a book to the user shelf successfully", async () => {
        const testUser = await createTestUser();

        const result = await executeQuery<{
          addBookToShelf: {
            id: number;
            externalId: string;
            title: string;
            authors: string[];
            publisher: string | null;
            isbn: string | null;
            addedAt: string;
          };
        }>(
          `
          mutation AddBookToShelf($bookInput: AddBookInput!) {
            addBookToShelf(bookInput: $bookInput) {
              id
              externalId
              title
              authors
              publisher
              isbn
              addedAt
            }
          }
        `,
          {
            bookInput: {
              externalId: "google-book-123",
              title: "Test Book Title",
              authors: ["Test Author"],
              publisher: "Test Publisher",
              publishedDate: "2024-01-01",
              isbn: "9784000000000",
              coverImageUrl: "https://example.com/cover.jpg",
            },
          },
          {
            "X-Test-User-Uid": testUser.firebaseUid,
          },
        );

        expect(result.errors).toBeUndefined();
        expect(result.data?.addBookToShelf).toBeDefined();
        expect(result.data?.addBookToShelf.externalId).toBe("google-book-123");
        expect(result.data?.addBookToShelf.title).toBe("Test Book Title");
        expect(result.data?.addBookToShelf.authors).toEqual(["Test Author"]);
        expect(result.data?.addBookToShelf.id).toBeGreaterThan(0);
        expect(result.data?.addBookToShelf.addedAt).toBeDefined();
      });

      it("should return duplicate error when adding same book twice", async () => {
        const testUser = await createTestUser();

        const bookInput = {
          externalId: "duplicate-book-123",
          title: "Duplicate Book",
          authors: ["Author"],
          publisher: null,
          publishedDate: null,
          isbn: null,
          coverImageUrl: null,
        };

        const headers = {
          "X-Test-User-Uid": testUser.firebaseUid,
        };

        await executeQuery(
          `
          mutation AddBookToShelf($bookInput: AddBookInput!) {
            addBookToShelf(bookInput: $bookInput) {
              id
            }
          }
        `,
          { bookInput },
          headers,
        );

        const secondResult = await executeQuery<{
          addBookToShelf: { id: number };
        }>(
          `
          mutation AddBookToShelf($bookInput: AddBookInput!) {
            addBookToShelf(bookInput: $bookInput) {
              id
            }
          }
        `,
          { bookInput },
          headers,
        );

        expect(secondResult.errors).toBeDefined();
        expect(secondResult.errors?.[0].extensions?.code).toBe(
          "DUPLICATE_BOOK",
        );
      });

      it("should return authentication error when not authenticated", async () => {
        const result = await executeQuery<{
          addBookToShelf: { id: number };
        }>(
          `
          mutation AddBookToShelf($bookInput: AddBookInput!) {
            addBookToShelf(bookInput: $bookInput) {
              id
            }
          }
        `,
          {
            bookInput: {
              externalId: "test-book",
              title: "Test",
              authors: [],
              publisher: null,
              publishedDate: null,
              isbn: null,
              coverImageUrl: null,
            },
          },
        );

        expect(result.errors).toBeDefined();
      });

      it("should allow different users to add the same book", async () => {
        const db = drizzle(pool);

        const user1Result = await db.execute<{
          id: number;
          firebase_uid: string;
        }>(sql`
          INSERT INTO users (email, firebase_uid)
          VALUES ('user1@example.com', 'firebase-uid-user1')
          RETURNING id, firebase_uid
        `);
        const user1 = {
          id: user1Result.rows[0].id,
          firebaseUid: user1Result.rows[0].firebase_uid,
        };

        const user2Result = await db.execute<{
          id: number;
          firebase_uid: string;
        }>(sql`
          INSERT INTO users (email, firebase_uid)
          VALUES ('user2@example.com', 'firebase-uid-user2')
          RETURNING id, firebase_uid
        `);
        const user2 = {
          id: user2Result.rows[0].id,
          firebaseUid: user2Result.rows[0].firebase_uid,
        };

        const bookInput = {
          externalId: "shared-book-123",
          title: "Shared Book",
          authors: ["Shared Author"],
          publisher: "Publisher",
          publishedDate: "2024-01-01",
          isbn: "9784000000000",
          coverImageUrl: null,
        };

        const result1 = await executeQuery<{
          addBookToShelf: { id: number };
        }>(
          `
          mutation AddBookToShelf($bookInput: AddBookInput!) {
            addBookToShelf(bookInput: $bookInput) {
              id
            }
          }
        `,
          { bookInput },
          {
            "X-Test-User-Uid": user1.firebaseUid,
          },
        );

        const result2 = await executeQuery<{
          addBookToShelf: { id: number };
        }>(
          `
          mutation AddBookToShelf($bookInput: AddBookInput!) {
            addBookToShelf(bookInput: $bookInput) {
              id
            }
          }
        `,
          { bookInput },
          {
            "X-Test-User-Uid": user2.firebaseUid,
          },
        );

        expect(result1.errors).toBeUndefined();
        expect(result2.errors).toBeUndefined();
        expect(result1.data?.addBookToShelf.id).not.toBe(
          result2.data?.addBookToShelf.id,
        );
      });

      it("should store all book fields correctly", async () => {
        const testUser = await createTestUser();

        const bookInput = {
          externalId: "full-book-123",
          title: "Full Book Title",
          authors: ["Author One", "Author Two"],
          publisher: "Great Publisher",
          publishedDate: "2024-06-15",
          isbn: "9784123456789",
          coverImageUrl: "https://example.com/full-cover.jpg",
        };

        const result = await executeQuery<{
          addBookToShelf: {
            id: number;
            externalId: string;
            title: string;
            authors: string[];
            publisher: string | null;
            publishedDate: string | null;
            isbn: string | null;
            coverImageUrl: string | null;
          };
        }>(
          `
          mutation AddBookToShelf($bookInput: AddBookInput!) {
            addBookToShelf(bookInput: $bookInput) {
              id
              externalId
              title
              authors
              publisher
              publishedDate
              isbn
              coverImageUrl
            }
          }
        `,
          { bookInput },
          {
            "X-Test-User-Uid": testUser.firebaseUid,
          },
        );

        expect(result.errors).toBeUndefined();
        expect(result.data?.addBookToShelf.externalId).toBe(
          bookInput.externalId,
        );
        expect(result.data?.addBookToShelf.title).toBe(bookInput.title);
        expect(result.data?.addBookToShelf.authors).toEqual(bookInput.authors);
        expect(result.data?.addBookToShelf.publisher).toBe(bookInput.publisher);
        expect(result.data?.addBookToShelf.publishedDate).toBe(
          bookInput.publishedDate,
        );
        expect(result.data?.addBookToShelf.isbn).toBe(bookInput.isbn);
        expect(result.data?.addBookToShelf.coverImageUrl).toBe(
          bookInput.coverImageUrl,
        );
      });

      it("should handle books with empty authors array", async () => {
        const testUser = await createTestUser();

        const result = await executeQuery<{
          addBookToShelf: {
            id: number;
            authors: string[];
          };
        }>(
          `
          mutation AddBookToShelf($bookInput: AddBookInput!) {
            addBookToShelf(bookInput: $bookInput) {
              id
              authors
            }
          }
        `,
          {
            bookInput: {
              externalId: "no-author-book",
              title: "Book Without Authors",
              authors: [],
              publisher: null,
              publishedDate: null,
              isbn: null,
              coverImageUrl: null,
            },
          },
          {
            "X-Test-User-Uid": testUser.firebaseUid,
          },
        );

        expect(result.errors).toBeUndefined();
        expect(result.data?.addBookToShelf.authors).toEqual([]);
      });

      it("should handle books with null optional fields", async () => {
        const testUser = await createTestUser();

        const result = await executeQuery<{
          addBookToShelf: {
            id: number;
            publisher: string | null;
            publishedDate: string | null;
            isbn: string | null;
            coverImageUrl: string | null;
          };
        }>(
          `
          mutation AddBookToShelf($bookInput: AddBookInput!) {
            addBookToShelf(bookInput: $bookInput) {
              id
              publisher
              publishedDate
              isbn
              coverImageUrl
            }
          }
        `,
          {
            bookInput: {
              externalId: "minimal-book",
              title: "Minimal Book",
              authors: ["Author"],
              publisher: null,
              publishedDate: null,
              isbn: null,
              coverImageUrl: null,
            },
          },
          {
            "X-Test-User-Uid": testUser.firebaseUid,
          },
        );

        expect(result.errors).toBeUndefined();
        expect(result.data?.addBookToShelf.publisher).toBeNull();
        expect(result.data?.addBookToShelf.publishedDate).toBeNull();
        expect(result.data?.addBookToShelf.isbn).toBeNull();
        expect(result.data?.addBookToShelf.coverImageUrl).toBeNull();
      });
    });
  });
});

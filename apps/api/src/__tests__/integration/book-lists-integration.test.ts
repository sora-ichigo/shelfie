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

describe("BookLists Feature Integration Tests", () => {
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
        name TEXT,
        avatar_url TEXT,
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
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
        source TEXT NOT NULL DEFAULT 'rakuten',
        added_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
        reading_status TEXT NOT NULL DEFAULT 'backlog',
        completed_at TIMESTAMP WITH TIME ZONE,
        note TEXT,
        note_updated_at TIMESTAMP WITH TIME ZONE,
        rating INTEGER,
        UNIQUE(user_id, external_id)
      )
    `);

    await db.execute(sql`
      CREATE INDEX IF NOT EXISTS idx_user_books_user_id ON user_books(user_id)
    `);

    await db.execute(sql`
      CREATE TABLE IF NOT EXISTS book_lists (
        id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        title TEXT NOT NULL,
        description TEXT,
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
      )
    `);

    await db.execute(sql`
      CREATE INDEX IF NOT EXISTS idx_book_lists_user_id ON book_lists(user_id)
    `);

    await db.execute(sql`
      CREATE TABLE IF NOT EXISTS book_list_items (
        id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        list_id INTEGER NOT NULL REFERENCES book_lists(id) ON DELETE CASCADE,
        user_book_id INTEGER NOT NULL REFERENCES user_books(id) ON DELETE CASCADE,
        position INTEGER NOT NULL DEFAULT 0,
        added_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
        UNIQUE(list_id, user_book_id)
      )
    `);

    await db.execute(sql`
      CREATE INDEX IF NOT EXISTS idx_book_list_items_list_id ON book_list_items(list_id)
    `);

    await db.execute(sql`
      CREATE INDEX IF NOT EXISTS idx_book_list_items_user_book_id ON book_list_items(user_book_id)
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
    await db.execute(
      sql`TRUNCATE TABLE book_list_items RESTART IDENTITY CASCADE`,
    );
    await db.execute(sql`TRUNCATE TABLE book_lists RESTART IDENTITY CASCADE`);
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

  async function createTestUser(
    email = "test@example.com",
    firebaseUid = "test-firebase-uid-123",
  ): Promise<{
    id: number;
    firebaseUid: string;
  }> {
    const db = drizzle(pool);
    const result = await db.execute<{ id: number; firebase_uid: string }>(sql`
      INSERT INTO users (email, firebase_uid)
      VALUES (${email}, ${firebaseUid})
      RETURNING id, firebase_uid
    `);
    const row = result.rows[0];
    return { id: row.id, firebaseUid: row.firebase_uid };
  }

  async function createTestUserBook(
    userId: number,
    externalId = "test-book-123",
  ): Promise<{ id: number }> {
    const db = drizzle(pool);
    const result = await db.execute<{ id: number }>(sql`
      INSERT INTO user_books (user_id, external_id, title, authors, source)
      VALUES (${userId}, ${externalId}, 'Test Book', ARRAY['Author'], 'rakuten')
      RETURNING id
    `);
    return { id: result.rows[0].id };
  }

  describe("Task 12.1: E2E Flow - リスト作成から本追加・並べ替え・削除まで", () => {
    it("should complete full E2E flow: create list, add books, reorder, delete", async () => {
      const testUser = await createTestUser();
      const headers = { "X-Test-User-Uid": testUser.firebaseUid };

      const createResult = await executeQuery<{
        createBookList: { id: number; title: string };
      }>(
        `
        mutation CreateBookList($input: CreateBookListInput!) {
          createBookList(input: $input) {
            id
            title
          }
        }
      `,
        { input: { title: "My Reading List", description: "Books to read" } },
        headers,
      );

      expect(createResult.errors).toBeUndefined();
      expect(createResult.data?.createBookList.title).toBe("My Reading List");
      const listId = createResult.data?.createBookList.id;
      expect(listId).toBeDefined();

      const book1 = await createTestUserBook(testUser.id, "book-1");
      const book2 = await createTestUserBook(testUser.id, "book-2");
      const book3 = await createTestUserBook(testUser.id, "book-3");

      const addBook1 = await executeQuery<{
        addBookToList: { id: number; position: number };
      }>(
        `
        mutation AddBookToList($listId: Int!, $userBookId: Int!) {
          addBookToList(listId: $listId, userBookId: $userBookId) {
            id
            position
          }
        }
      `,
        { listId, userBookId: book1.id },
        headers,
      );

      expect(addBook1.errors).toBeUndefined();
      expect(addBook1.data?.addBookToList.position).toBe(0);

      const addBook2 = await executeQuery<{
        addBookToList: { id: number; position: number };
      }>(
        `
        mutation AddBookToList($listId: Int!, $userBookId: Int!) {
          addBookToList(listId: $listId, userBookId: $userBookId) {
            id
            position
          }
        }
      `,
        { listId, userBookId: book2.id },
        headers,
      );

      expect(addBook2.errors).toBeUndefined();
      expect(addBook2.data?.addBookToList.position).toBe(1);

      const addBook3 = await executeQuery<{
        addBookToList: { id: number; position: number };
      }>(
        `
        mutation AddBookToList($listId: Int!, $userBookId: Int!) {
          addBookToList(listId: $listId, userBookId: $userBookId) {
            id
            position
          }
        }
      `,
        { listId, userBookId: book3.id },
        headers,
      );

      expect(addBook3.errors).toBeUndefined();
      expect(addBook3.data?.addBookToList.position).toBe(2);

      const itemId = addBook3.data?.addBookToList.id;
      const reorderResult = await executeQuery<{
        reorderBookInList: boolean;
      }>(
        `
        mutation ReorderBookInList($listId: Int!, $itemId: Int!, $newPosition: Int!) {
          reorderBookInList(listId: $listId, itemId: $itemId, newPosition: $newPosition)
        }
      `,
        { listId, itemId, newPosition: 0 },
        headers,
      );

      expect(reorderResult.errors).toBeUndefined();
      expect(reorderResult.data?.reorderBookInList).toBe(true);

      const detailResult = await executeQuery<{
        bookListDetail: {
          id: number;
          title: string;
          items: Array<{ id: number; position: number }>;
        };
      }>(
        `
        query BookListDetail($listId: Int!) {
          bookListDetail(listId: $listId) {
            id
            title
            items {
              id
              position
            }
          }
        }
      `,
        { listId },
        headers,
      );

      expect(detailResult.errors).toBeUndefined();
      expect(detailResult.data?.bookListDetail.items).toHaveLength(3);
      expect(detailResult.data?.bookListDetail.items[0].position).toBe(0);
      expect(detailResult.data?.bookListDetail.items[1].position).toBe(1);
      expect(detailResult.data?.bookListDetail.items[2].position).toBe(2);

      const removeResult = await executeQuery<{
        removeBookFromList: boolean;
      }>(
        `
        mutation RemoveBookFromList($listId: Int!, $userBookId: Int!) {
          removeBookFromList(listId: $listId, userBookId: $userBookId)
        }
      `,
        { listId, userBookId: book2.id },
        headers,
      );

      expect(removeResult.errors).toBeUndefined();
      expect(removeResult.data?.removeBookFromList).toBe(true);

      const afterRemoveDetail = await executeQuery<{
        bookListDetail: {
          items: Array<{ id: number }>;
        };
      }>(
        `
        query BookListDetail($listId: Int!) {
          bookListDetail(listId: $listId) {
            items {
              id
            }
          }
        }
      `,
        { listId },
        headers,
      );

      expect(afterRemoveDetail.data?.bookListDetail.items).toHaveLength(2);

      const deleteResult = await executeQuery<{
        deleteBookList: boolean;
      }>(
        `
        mutation DeleteBookList($listId: Int!) {
          deleteBookList(listId: $listId)
        }
      `,
        { listId },
        headers,
      );

      expect(deleteResult.errors).toBeUndefined();
      expect(deleteResult.data?.deleteBookList).toBe(true);

      const afterDeleteResult = await executeQuery<{
        bookListDetail: { id: number } | null;
      }>(
        `
        query BookListDetail($listId: Int!) {
          bookListDetail(listId: $listId) {
            id
          }
        }
      `,
        { listId },
        headers,
      );

      expect(afterDeleteResult.errors).toBeDefined();
      expect(afterDeleteResult.errors?.[0].extensions?.code).toBe(
        "LIST_NOT_FOUND",
      );
    });
  });

  describe("Task 12.1: カスケード削除のテスト", () => {
    it("should cascade delete BookListItems when BookList is deleted", async () => {
      const testUser = await createTestUser();
      const headers = { "X-Test-User-Uid": testUser.firebaseUid };

      const createResult = await executeQuery<{
        createBookList: { id: number };
      }>(
        `
        mutation CreateBookList($input: CreateBookListInput!) {
          createBookList(input: $input) {
            id
          }
        }
      `,
        { input: { title: "Cascade Test List" } },
        headers,
      );

      const listId = createResult.data?.createBookList.id;

      const book1 = await createTestUserBook(testUser.id, "cascade-book-1");
      const book2 = await createTestUserBook(testUser.id, "cascade-book-2");

      await executeQuery(
        `
        mutation AddBookToList($listId: Int!, $userBookId: Int!) {
          addBookToList(listId: $listId, userBookId: $userBookId) {
            id
          }
        }
      `,
        { listId, userBookId: book1.id },
        headers,
      );

      await executeQuery(
        `
        mutation AddBookToList($listId: Int!, $userBookId: Int!) {
          addBookToList(listId: $listId, userBookId: $userBookId) {
            id
          }
        }
      `,
        { listId, userBookId: book2.id },
        headers,
      );

      const db = drizzle(pool);
      const itemsBefore = await db.execute<{ count: number }>(sql`
        SELECT COUNT(*)::int as count FROM book_list_items WHERE list_id = ${listId}
      `);
      expect(itemsBefore.rows[0].count).toBe(2);

      await executeQuery(
        `
        mutation DeleteBookList($listId: Int!) {
          deleteBookList(listId: $listId)
        }
      `,
        { listId },
        headers,
      );

      const itemsAfter = await db.execute<{ count: number }>(sql`
        SELECT COUNT(*)::int as count FROM book_list_items WHERE list_id = ${listId}
      `);
      expect(itemsAfter.rows[0].count).toBe(0);
    });

    it("should not delete UserBook when removed from list", async () => {
      const testUser = await createTestUser();
      const headers = { "X-Test-User-Uid": testUser.firebaseUid };

      const createResult = await executeQuery<{
        createBookList: { id: number };
      }>(
        `
        mutation CreateBookList($input: CreateBookListInput!) {
          createBookList(input: $input) {
            id
          }
        }
      `,
        { input: { title: "UserBook Preserve Test" } },
        headers,
      );

      const listId = createResult.data?.createBookList.id;

      const book = await createTestUserBook(testUser.id, "preserve-book");

      await executeQuery(
        `
        mutation AddBookToList($listId: Int!, $userBookId: Int!) {
          addBookToList(listId: $listId, userBookId: $userBookId) {
            id
          }
        }
      `,
        { listId, userBookId: book.id },
        headers,
      );

      await executeQuery(
        `
        mutation RemoveBookFromList($listId: Int!, $userBookId: Int!) {
          removeBookFromList(listId: $listId, userBookId: $userBookId)
        }
      `,
        { listId, userBookId: book.id },
        headers,
      );

      const db = drizzle(pool);
      const userBookExists = await db.execute<{ count: number }>(sql`
        SELECT COUNT(*)::int as count FROM user_books WHERE id = ${book.id}
      `);
      expect(userBookExists.rows[0].count).toBe(1);
    });

    it("should not delete UserBook when BookList is deleted", async () => {
      const testUser = await createTestUser();
      const headers = { "X-Test-User-Uid": testUser.firebaseUid };

      const createResult = await executeQuery<{
        createBookList: { id: number };
      }>(
        `
        mutation CreateBookList($input: CreateBookListInput!) {
          createBookList(input: $input) {
            id
          }
        }
      `,
        { input: { title: "List Delete UserBook Test" } },
        headers,
      );

      const listId = createResult.data?.createBookList.id;

      const book = await createTestUserBook(testUser.id, "list-delete-book");

      await executeQuery(
        `
        mutation AddBookToList($listId: Int!, $userBookId: Int!) {
          addBookToList(listId: $listId, userBookId: $userBookId) {
            id
          }
        }
      `,
        { listId, userBookId: book.id },
        headers,
      );

      await executeQuery(
        `
        mutation DeleteBookList($listId: Int!) {
          deleteBookList(listId: $listId)
        }
      `,
        { listId },
        headers,
      );

      const db = drizzle(pool);
      const userBookExists = await db.execute<{ count: number }>(sql`
        SELECT COUNT(*)::int as count FROM user_books WHERE id = ${book.id}
      `);
      expect(userBookExists.rows[0].count).toBe(1);
    });
  });

  describe("Task 12.1: 認証・認可エラーのテスト", () => {
    it("should return UNAUTHENTICATED error when creating list without auth", async () => {
      const result = await executeQuery<{
        createBookList: { id: number };
      }>(
        `
        mutation CreateBookList($input: CreateBookListInput!) {
          createBookList(input: $input) {
            id
          }
        }
      `,
        { input: { title: "Unauthorized List" } },
      );

      expect(result.errors).toBeDefined();
    });

    it("should return FORBIDDEN error when accessing another users list", async () => {
      const user1 = await createTestUser("user1@test.com", "firebase-uid-1");
      const user2 = await createTestUser("user2@test.com", "firebase-uid-2");

      const createResult = await executeQuery<{
        createBookList: { id: number };
      }>(
        `
        mutation CreateBookList($input: CreateBookListInput!) {
          createBookList(input: $input) {
            id
          }
        }
      `,
        { input: { title: "User1 Private List" } },
        { "X-Test-User-Uid": user1.firebaseUid },
      );

      const listId = createResult.data?.createBookList.id;

      const accessResult = await executeQuery<{
        bookListDetail: { id: number };
      }>(
        `
        query BookListDetail($listId: Int!) {
          bookListDetail(listId: $listId) {
            id
          }
        }
      `,
        { listId },
        { "X-Test-User-Uid": user2.firebaseUid },
      );

      expect(accessResult.errors).toBeDefined();
      expect(accessResult.errors?.[0].extensions?.code).toBe("FORBIDDEN");
    });

    it("should return FORBIDDEN error when trying to update another users list", async () => {
      const user1 = await createTestUser("owner@test.com", "owner-uid");
      const user2 = await createTestUser("hacker@test.com", "hacker-uid");

      const createResult = await executeQuery<{
        createBookList: { id: number };
      }>(
        `
        mutation CreateBookList($input: CreateBookListInput!) {
          createBookList(input: $input) {
            id
          }
        }
      `,
        { input: { title: "Owner List" } },
        { "X-Test-User-Uid": user1.firebaseUid },
      );

      const listId = createResult.data?.createBookList.id;

      const updateResult = await executeQuery<{
        updateBookList: { id: number };
      }>(
        `
        mutation UpdateBookList($input: UpdateBookListInput!) {
          updateBookList(input: $input) {
            id
          }
        }
      `,
        { input: { listId, title: "Hacked Title" } },
        { "X-Test-User-Uid": user2.firebaseUid },
      );

      expect(updateResult.errors).toBeDefined();
      expect(updateResult.errors?.[0].extensions?.code).toBe("FORBIDDEN");
    });

    it("should return FORBIDDEN error when trying to delete another users list", async () => {
      const user1 = await createTestUser("owner2@test.com", "owner-uid-2");
      const user2 = await createTestUser("attacker@test.com", "attacker-uid");

      const createResult = await executeQuery<{
        createBookList: { id: number };
      }>(
        `
        mutation CreateBookList($input: CreateBookListInput!) {
          createBookList(input: $input) {
            id
          }
        }
      `,
        { input: { title: "Protected List" } },
        { "X-Test-User-Uid": user1.firebaseUid },
      );

      const listId = createResult.data?.createBookList.id;

      const deleteResult = await executeQuery<{
        deleteBookList: boolean;
      }>(
        `
        mutation DeleteBookList($listId: Int!) {
          deleteBookList(listId: $listId)
        }
      `,
        { listId },
        { "X-Test-User-Uid": user2.firebaseUid },
      );

      expect(deleteResult.errors).toBeDefined();
      expect(deleteResult.errors?.[0].extensions?.code).toBe("FORBIDDEN");
    });

    it("should return FORBIDDEN error when trying to add book to another users list", async () => {
      const user1 = await createTestUser("listowner@test.com", "listowner-uid");
      const user2 = await createTestUser("bookadder@test.com", "bookadder-uid");

      const createResult = await executeQuery<{
        createBookList: { id: number };
      }>(
        `
        mutation CreateBookList($input: CreateBookListInput!) {
          createBookList(input: $input) {
            id
          }
        }
      `,
        { input: { title: "Owner Only List" } },
        { "X-Test-User-Uid": user1.firebaseUid },
      );

      const listId = createResult.data?.createBookList.id;
      const book = await createTestUserBook(user2.id, "attacker-book");

      const addResult = await executeQuery<{
        addBookToList: { id: number };
      }>(
        `
        mutation AddBookToList($listId: Int!, $userBookId: Int!) {
          addBookToList(listId: $listId, userBookId: $userBookId) {
            id
          }
        }
      `,
        { listId, userBookId: book.id },
        { "X-Test-User-Uid": user2.firebaseUid },
      );

      expect(addResult.errors).toBeDefined();
      expect(addResult.errors?.[0].extensions?.code).toBe("FORBIDDEN");
    });

    it("should return DUPLICATE_BOOK error when adding same book twice", async () => {
      const testUser = await createTestUser(
        "duplicate@test.com",
        "duplicate-uid",
      );
      const headers = { "X-Test-User-Uid": testUser.firebaseUid };

      const createResult = await executeQuery<{
        createBookList: { id: number };
      }>(
        `
        mutation CreateBookList($input: CreateBookListInput!) {
          createBookList(input: $input) {
            id
          }
        }
      `,
        { input: { title: "Duplicate Test List" } },
        headers,
      );

      const listId = createResult.data?.createBookList.id;
      const book = await createTestUserBook(testUser.id, "duplicate-book");

      await executeQuery(
        `
        mutation AddBookToList($listId: Int!, $userBookId: Int!) {
          addBookToList(listId: $listId, userBookId: $userBookId) {
            id
          }
        }
      `,
        { listId, userBookId: book.id },
        headers,
      );

      const duplicateResult = await executeQuery<{
        addBookToList: { id: number };
      }>(
        `
        mutation AddBookToList($listId: Int!, $userBookId: Int!) {
          addBookToList(listId: $listId, userBookId: $userBookId) {
            id
          }
        }
      `,
        { listId, userBookId: book.id },
        headers,
      );

      expect(duplicateResult.errors).toBeDefined();
      expect(duplicateResult.errors?.[0].extensions?.code).toBe(
        "DUPLICATE_BOOK",
      );
    });

    it("should return LIST_NOT_FOUND error when accessing non-existent list", async () => {
      const testUser = await createTestUser(
        "notfound@test.com",
        "notfound-uid",
      );

      const result = await executeQuery<{
        bookListDetail: { id: number };
      }>(
        `
        query BookListDetail($listId: Int!) {
          bookListDetail(listId: $listId) {
            id
          }
        }
      `,
        { listId: 99999 },
        { "X-Test-User-Uid": testUser.firebaseUid },
      );

      expect(result.errors).toBeDefined();
      expect(result.errors?.[0].extensions?.code).toBe("LIST_NOT_FOUND");
    });
  });
});

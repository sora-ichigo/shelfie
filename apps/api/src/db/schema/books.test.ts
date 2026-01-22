import { sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/node-postgres";
import { beforeEach, describe, expect, it } from "vitest";
import { getGlobalTestPool } from "../../../vitest.setup.js";
import { userBooks } from "./books.js";
import { users } from "./users.js";

function getDb() {
  return drizzle(getGlobalTestPool());
}

describe("books schema", () => {
  describe("user_books table", () => {
    let userId: number;

    beforeEach(async () => {
      const db = getDb();
      const [user] = await db
        .insert(users)
        .values({
          email: "test@example.com",
          firebaseUid: "firebase-uid-123",
        })
        .returning();
      userId = user.id;
    });

    it("should create a user_book with all fields", async () => {
      const db = getDb();
      const [userBook] = await db
        .insert(userBooks)
        .values({
          userId,
          externalId: "google-123",
          title: "Clean Code",
          authors: ["Robert C. Martin"],
          publisher: "Prentice Hall",
          publishedDate: "2008-08-01",
          isbn: "9780132350884",
          coverImageUrl: "https://example.com/cover.jpg",
        })
        .returning();

      expect(userBook.id).toBe(1);
      expect(userBook.userId).toBe(userId);
      expect(userBook.externalId).toBe("google-123");
      expect(userBook.title).toBe("Clean Code");
      expect(userBook.authors).toEqual(["Robert C. Martin"]);
      expect(userBook.publisher).toBe("Prentice Hall");
      expect(userBook.publishedDate).toBe("2008-08-01");
      expect(userBook.isbn).toBe("9780132350884");
      expect(userBook.coverImageUrl).toBe("https://example.com/cover.jpg");
      expect(userBook.addedAt).toBeInstanceOf(Date);
    });

    it("should create a user_book with minimal required fields", async () => {
      const db = getDb();
      const [userBook] = await db
        .insert(userBooks)
        .values({
          userId,
          externalId: "google-456",
          title: "Test Book",
        })
        .returning();

      expect(userBook.id).toBe(1);
      expect(userBook.userId).toBe(userId);
      expect(userBook.externalId).toBe("google-456");
      expect(userBook.title).toBe("Test Book");
      expect(userBook.authors).toEqual([]);
      expect(userBook.publisher).toBeNull();
      expect(userBook.publishedDate).toBeNull();
      expect(userBook.isbn).toBeNull();
      expect(userBook.coverImageUrl).toBeNull();
    });

    it("should create a user_book with multiple authors", async () => {
      const db = getDb();
      const [userBook] = await db
        .insert(userBooks)
        .values({
          userId,
          externalId: "google-789",
          title: "Multi-author Book",
          authors: ["Author One", "Author Two", "Author Three"],
        })
        .returning();

      expect(userBook.authors).toEqual([
        "Author One",
        "Author Two",
        "Author Three",
      ]);
    });

    it("should enforce unique constraint on user_id and external_id combination", async () => {
      const db = getDb();
      await db.insert(userBooks).values({
        userId,
        externalId: "google-123",
        title: "Book 1",
      });

      await expect(
        db.insert(userBooks).values({
          userId,
          externalId: "google-123",
          title: "Book 2",
        }),
      ).rejects.toThrow();
    });

    it("should allow same user to add different books", async () => {
      const db = getDb();
      await db.insert(userBooks).values({
        userId,
        externalId: "google-123",
        title: "Book 1",
      });
      await db.insert(userBooks).values({
        userId,
        externalId: "google-456",
        title: "Book 2",
      });

      const allUserBooks = await db.select().from(userBooks);
      expect(allUserBooks).toHaveLength(2);
    });

    it("should allow different users to add same book (independent snapshots)", async () => {
      const db = getDb();
      const [user2] = await db
        .insert(users)
        .values({
          email: "test2@example.com",
          firebaseUid: "firebase-uid-456",
        })
        .returning();

      await db.insert(userBooks).values({
        userId,
        externalId: "google-123",
        title: "Clean Code",
      });
      await db.insert(userBooks).values({
        userId: user2.id,
        externalId: "google-123",
        title: "Clean Code",
      });

      const allUserBooks = await db.select().from(userBooks);
      expect(allUserBooks).toHaveLength(2);
    });

    it("should cascade delete when user is deleted", async () => {
      const db = getDb();
      await db.insert(userBooks).values({
        userId,
        externalId: "google-123",
        title: "Test Book",
      });

      await db.delete(users).where(sql`id = ${userId}`);

      const allUserBooks = await db.select().from(userBooks);
      expect(allUserBooks).toHaveLength(0);
    });

    it("should allow same isbn for different users", async () => {
      const db = getDb();
      const [user2] = await db
        .insert(users)
        .values({
          email: "test2@example.com",
          firebaseUid: "firebase-uid-456",
        })
        .returning();

      await db.insert(userBooks).values({
        userId,
        externalId: "google-123",
        title: "Clean Code",
        isbn: "9780132350884",
      });
      await db.insert(userBooks).values({
        userId: user2.id,
        externalId: "google-123",
        title: "Clean Code",
        isbn: "9780132350884",
      });

      const allUserBooks = await db.select().from(userBooks);
      expect(allUserBooks).toHaveLength(2);
    });

    it("should allow multiple books without isbn for same user", async () => {
      const db = getDb();
      await db.insert(userBooks).values({
        userId,
        externalId: "google-123",
        title: "Book 1",
      });
      await db.insert(userBooks).values({
        userId,
        externalId: "google-456",
        title: "Book 2",
      });

      const allUserBooks = await db.select().from(userBooks);
      expect(allUserBooks).toHaveLength(2);
      expect(allUserBooks[0].isbn).toBeNull();
      expect(allUserBooks[1].isbn).toBeNull();
    });

    describe("reading status and note fields", () => {
      it("should create a user_book with default reading_status as backlog", async () => {
        const db = getDb();
        const [userBook] = await db
          .insert(userBooks)
          .values({
            userId,
            externalId: "google-123",
            title: "Test Book",
          })
          .returning();

        expect(userBook.readingStatus).toBe("backlog");
        expect(userBook.completedAt).toBeNull();
        expect(userBook.note).toBeNull();
        expect(userBook.noteUpdatedAt).toBeNull();
      });

      it("should create a user_book with explicit reading_status", async () => {
        const db = getDb();
        const [userBook] = await db
          .insert(userBooks)
          .values({
            userId,
            externalId: "google-123",
            title: "Test Book",
            readingStatus: "reading",
          })
          .returning();

        expect(userBook.readingStatus).toBe("reading");
      });

      it("should store all reading_status enum values", async () => {
        const db = getDb();
        const statuses = ["backlog", "reading", "completed", "dropped"] as const;

        for (const [index, status] of statuses.entries()) {
          const [userBook] = await db
            .insert(userBooks)
            .values({
              userId,
              externalId: `google-${index}`,
              title: `Test Book ${index}`,
              readingStatus: status,
            })
            .returning();

          expect(userBook.readingStatus).toBe(status);
        }
      });

      it("should store completed_at timestamp when provided", async () => {
        const db = getDb();
        const completedAt = new Date("2026-01-22T10:00:00Z");
        const [userBook] = await db
          .insert(userBooks)
          .values({
            userId,
            externalId: "google-123",
            title: "Test Book",
            readingStatus: "completed",
            completedAt,
          })
          .returning();

        expect(userBook.readingStatus).toBe("completed");
        expect(userBook.completedAt).toEqual(completedAt);
      });

      it("should store note and note_updated_at when provided", async () => {
        const db = getDb();
        const noteUpdatedAt = new Date("2026-01-22T10:00:00Z");
        const [userBook] = await db
          .insert(userBooks)
          .values({
            userId,
            externalId: "google-123",
            title: "Test Book",
            note: "This is a great book!",
            noteUpdatedAt,
          })
          .returning();

        expect(userBook.note).toBe("This is a great book!");
        expect(userBook.noteUpdatedAt).toEqual(noteUpdatedAt);
      });

      it("should store empty note string", async () => {
        const db = getDb();
        const [userBook] = await db
          .insert(userBooks)
          .values({
            userId,
            externalId: "google-123",
            title: "Test Book",
            note: "",
          })
          .returning();

        expect(userBook.note).toBe("");
      });

      it("should create user_book with all reading record fields", async () => {
        const db = getDb();
        const completedAt = new Date("2026-01-20T15:00:00Z");
        const noteUpdatedAt = new Date("2026-01-21T09:00:00Z");

        const [userBook] = await db
          .insert(userBooks)
          .values({
            userId,
            externalId: "google-123",
            title: "Clean Code",
            authors: ["Robert C. Martin"],
            publisher: "Prentice Hall",
            readingStatus: "completed",
            completedAt,
            note: "A must-read for developers",
            noteUpdatedAt,
          })
          .returning();

        expect(userBook.readingStatus).toBe("completed");
        expect(userBook.completedAt).toEqual(completedAt);
        expect(userBook.note).toBe("A must-read for developers");
        expect(userBook.noteUpdatedAt).toEqual(noteUpdatedAt);
      });
    });
  });
});

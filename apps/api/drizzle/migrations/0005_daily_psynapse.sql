CREATE TYPE "public"."book_source" AS ENUM('rakuten', 'google');--> statement-breakpoint
ALTER TABLE "user_books" ADD COLUMN "source" "book_source" DEFAULT 'rakuten' NOT NULL;
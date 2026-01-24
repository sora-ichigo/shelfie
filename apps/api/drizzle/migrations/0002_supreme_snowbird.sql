CREATE TYPE "public"."reading_status" AS ENUM('backlog', 'reading', 'completed', 'dropped');--> statement-breakpoint
ALTER TABLE "user_books" ADD COLUMN "reading_status" "reading_status" DEFAULT 'backlog' NOT NULL;--> statement-breakpoint
ALTER TABLE "user_books" ADD COLUMN "completed_at" timestamp with time zone;--> statement-breakpoint
ALTER TABLE "user_books" ADD COLUMN "note" text;--> statement-breakpoint
ALTER TABLE "user_books" ADD COLUMN "note_updated_at" timestamp with time zone;
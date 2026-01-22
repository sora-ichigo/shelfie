CREATE TABLE "user_books" (
	"id" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "user_books_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"user_id" integer NOT NULL,
	"external_id" text NOT NULL,
	"title" text NOT NULL,
	"authors" text[] DEFAULT '{}' NOT NULL,
	"publisher" text,
	"published_date" text,
	"isbn" text,
	"cover_image_url" text,
	"added_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "user_books_user_id_external_id_unique" UNIQUE("user_id","external_id")
);
--> statement-breakpoint
ALTER TABLE "user_books" ADD CONSTRAINT "user_books_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;
--> statement-breakpoint
CREATE INDEX "idx_user_books_user_id" ON "user_books" USING btree ("user_id");

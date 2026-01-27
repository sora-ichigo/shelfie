CREATE TABLE "book_list_items" (
	"id" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "book_list_items_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"list_id" integer NOT NULL,
	"user_book_id" integer NOT NULL,
	"position" integer DEFAULT 0 NOT NULL,
	"added_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "book_list_items_list_id_user_book_id_unique" UNIQUE("list_id","user_book_id")
);
--> statement-breakpoint
CREATE TABLE "book_lists" (
	"id" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "book_lists_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"user_id" integer NOT NULL,
	"title" text NOT NULL,
	"description" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "book_list_items" ADD CONSTRAINT "book_list_items_list_id_book_lists_id_fk" FOREIGN KEY ("list_id") REFERENCES "public"."book_lists"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "book_list_items" ADD CONSTRAINT "book_list_items_user_book_id_user_books_id_fk" FOREIGN KEY ("user_book_id") REFERENCES "public"."user_books"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "book_lists" ADD CONSTRAINT "book_lists_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "idx_book_list_items_list_id" ON "book_list_items" USING btree ("list_id");--> statement-breakpoint
CREATE INDEX "idx_book_list_items_user_book_id" ON "book_list_items" USING btree ("user_book_id");--> statement-breakpoint
CREATE INDEX "idx_book_lists_user_id" ON "book_lists" USING btree ("user_id");
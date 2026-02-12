CREATE TABLE "follow_requests" (
	"id" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "follow_requests_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"sender_id" integer NOT NULL,
	"receiver_id" integer NOT NULL,
	"status" text DEFAULT 'pending' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "uq_follow_request" UNIQUE("sender_id","receiver_id"),
	CONSTRAINT "chk_no_self_request" CHECK ("follow_requests"."sender_id" != "follow_requests"."receiver_id")
);
--> statement-breakpoint
CREATE TABLE "follows" (
	"id" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "follows_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"user_id_a" integer NOT NULL,
	"user_id_b" integer NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "uq_follow" UNIQUE("user_id_a","user_id_b"),
	CONSTRAINT "chk_ordered" CHECK ("follows"."user_id_a" < "follows"."user_id_b")
);
--> statement-breakpoint
ALTER TABLE "follow_requests" ADD CONSTRAINT "follow_requests_sender_id_users_id_fk" FOREIGN KEY ("sender_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "follow_requests" ADD CONSTRAINT "follow_requests_receiver_id_users_id_fk" FOREIGN KEY ("receiver_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "follows" ADD CONSTRAINT "follows_user_id_a_users_id_fk" FOREIGN KEY ("user_id_a") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "follows" ADD CONSTRAINT "follows_user_id_b_users_id_fk" FOREIGN KEY ("user_id_b") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "idx_follow_requests_receiver_status" ON "follow_requests" USING btree ("receiver_id","status");--> statement-breakpoint
CREATE INDEX "idx_follow_requests_sender" ON "follow_requests" USING btree ("sender_id");--> statement-breakpoint
CREATE INDEX "idx_follows_user_a" ON "follows" USING btree ("user_id_a");--> statement-breakpoint
CREATE INDEX "idx_follows_user_b" ON "follows" USING btree ("user_id_b");
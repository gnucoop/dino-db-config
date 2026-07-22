CREATE TABLE IF NOT EXISTS "public"."log" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "created_at" timestamptz NOT NULL DEFAULT now(),
  "updated_at" timestamptz NOT NULL DEFAULT now(),
  "_deleted" boolean NOT NULL DEFAULT false,
  "_rev" text,
  "_attachments" jsonb DEFAULT jsonb_build_array(),
  "is_deleted" boolean NOT NULL DEFAULT false,
  "text" text,
  "form_schema_ref_id" uuid NOT NULL,
  "form_data_ref_id" uuid NOT NULL,
  "author" text NOT NULL,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("form_data_ref_id") REFERENCES "public"."form_data"("id") ON UPDATE cascade ON DELETE no action,
  FOREIGN KEY ("form_schema_ref_id") REFERENCES "public"."form_schema"("id") ON UPDATE cascade ON DELETE no action
);

DROP TRIGGER IF EXISTS set_public_log_updated_at on public.log;

CREATE TRIGGER "set_public_log_updated_at" BEFORE
UPDATE
  ON "public"."log" FOR EACH ROW EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();

COMMENT ON TRIGGER "set_public_log_updated_at" ON "public"."log" IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TABLE IF NOT EXISTS "public"."notification" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "created_at" date NOT NULL DEFAULT now(),
  "updated_at" timestamptz NOT NULL DEFAULT now(),
  "_deleted" boolean NOT NULL DEFAULT false,
  "_rev" text,
  "_attachments" jsonb DEFAULT jsonb_build_array(),
  "is_deleted" boolean NOT NULL DEFAULT false,
  "recipients" jsonb NOT NULL DEFAULT jsonb_build_array(),
  "readers" jsonb NOT NULL DEFAULT jsonb_build_array(),
  "text" text,
  "type" text,
  "icon" text,
  "redirect_url" text,
  PRIMARY KEY ("id")
);

DROP TRIGGER IF EXISTS set_public_notification_updated_at on public.notification;

CREATE TRIGGER "set_public_notification_updated_at" BEFORE
UPDATE
  ON "public"."notification" FOR EACH ROW EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();

COMMENT ON TRIGGER "set_public_notification_updated_at" ON "public"."notification" IS 'trigger to set value of column "updated_at" to current timestamp on row update';
alter table "public"."form_schema" add column IF NOT EXISTS "form_schema_metrics" jsonb
 null default jsonb_build_array();

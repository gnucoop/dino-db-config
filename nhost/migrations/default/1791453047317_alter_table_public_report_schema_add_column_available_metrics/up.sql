alter table "public"."report_schema" add column if not exists "available_metrics" JSONB
 not null default jsonb_build_array();

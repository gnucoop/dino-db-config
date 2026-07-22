alter table "public"."report_data" add column if not exists "data" jsonb
 not null default jsonb_build_object();

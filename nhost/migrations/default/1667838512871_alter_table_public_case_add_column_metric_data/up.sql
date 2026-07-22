alter table "public"."case" add column if not exists "metric_data" jsonb
 null;

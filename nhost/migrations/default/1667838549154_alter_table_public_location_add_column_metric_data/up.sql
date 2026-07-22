alter table "public"."location" add column if not exists "metric_data" jsonb
 null;

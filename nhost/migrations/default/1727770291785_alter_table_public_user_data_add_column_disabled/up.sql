alter table "public"."user_data" add column if not exists "disabled" boolean
 not null default 'false';

alter table "public"."project" add column if not exists "code_auto" serial
 not null unique;

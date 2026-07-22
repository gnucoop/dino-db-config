SET
    check_function_bodies = false;

DROP FUNCTION IF EXISTS public.set_current_timestamp_updated_at;

CREATE
OR REPLACE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE _new record;

BEGIN _new := NEW;

_new."updated_at" = NOW();

RETURN _new;

END;

$$;

CREATE TABLE IF NOT EXISTS public.area (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    created_at date DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    parent_id uuid,
    parent_name text,
    _deleted boolean DEFAULT false NOT NULL,
    _rev text,
    _attachments jsonb DEFAULT jsonb_build_array(),
    is_deleted boolean DEFAULT false NOT NULL
);

CREATE TABLE IF NOT EXISTS public."case" (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    created_at date DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    parent_id uuid,
    parent_name text,
    _deleted boolean DEFAULT false NOT NULL,
    _rev text,
    _attachments jsonb DEFAULT jsonb_build_array(),
    is_deleted boolean DEFAULT false NOT NULL,
    code integer UNIQUE NOT NULL,
    notes text
);

CREATE SEQUENCE IF NOT EXISTS public.case_code_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER SEQUENCE public.case_code_seq OWNED BY public."case".code;

CREATE TABLE IF NOT EXISTS public.form_data (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    created_at date DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    user_data_ref_id uuid NOT NULL,
    form_schema_ref_id uuid NOT NULL,
    data jsonb NOT NULL,
    area_ref_id uuid,
    location_ref_id uuid,
    organization_ref_id uuid,
    project_ref_id uuid,
    _deleted boolean DEFAULT false NOT NULL,
    _rev text,
    _attachments jsonb DEFAULT jsonb_build_array(),
    is_deleted boolean DEFAULT false NOT NULL,
    case_ref_id uuid,
    form_status_ref_id uuid
);

CREATE TABLE IF NOT EXISTS public.form_schema (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    created_at date DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text UNIQUE NOT NULL,
    schema jsonb NOT NULL,
    label text,
    icon text,
    _deleted boolean DEFAULT false NOT NULL,
    _rev text,
    _attachments jsonb DEFAULT jsonb_build_array(),
    is_deleted boolean DEFAULT false NOT NULL,
    visibility smallint DEFAULT '0' :: smallint NOT NULL,
    form_schema_deps_ref_id uuid,
    form_status_ref_id jsonb DEFAULT jsonb_build_array()
);

CREATE TABLE IF NOT EXISTS public.form_schema_deps (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    created_at date DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deps_origin jsonb DEFAULT jsonb_build_array() NOT NULL,
    metric_data_to_show jsonb DEFAULT jsonb_build_array() NOT NULL,
    _deleted boolean DEFAULT false NOT NULL,
    _rev text,
    _attachments jsonb DEFAULT jsonb_build_array(),
    is_deleted boolean DEFAULT false NOT NULL
);

CREATE TABLE IF NOT EXISTS public.form_status (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    created_at date DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text UNIQUE NOT NULL,
    label text,
    color text,
    status_level integer DEFAULT 0,
    _deleted boolean DEFAULT false NOT NULL,
    _rev text,
    _attachments jsonb DEFAULT jsonb_build_array(),
    is_deleted boolean DEFAULT false NOT NULL
);

CREATE TABLE IF NOT EXISTS public.lang (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    name character varying UNIQUE NOT NULL,
    schema jsonb NOT NULL,
    created_at date DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    _deleted boolean DEFAULT false NOT NULL,
    _rev text,
    _attachments jsonb DEFAULT jsonb_build_array(),
    is_deleted boolean DEFAULT false NOT NULL
);

CREATE TABLE IF NOT EXISTS public.location (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    created_at date DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    parent_id uuid,
    parent_name text,
    coordinates jsonb,
    _deleted boolean DEFAULT false NOT NULL,
    _rev text,
    _attachments jsonb DEFAULT jsonb_build_array(),
    is_deleted boolean DEFAULT false NOT NULL
);

CREATE TABLE IF NOT EXISTS public.organization (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    created_at date DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    parent_id uuid,
    parent_name text,
    logo_path text,
    website_url text,
    _deleted boolean DEFAULT false NOT NULL,
    _rev text,
    _attachments jsonb DEFAULT jsonb_build_array(),
    is_deleted boolean DEFAULT false NOT NULL
);

CREATE TABLE IF NOT EXISTS public.project (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    created_at date DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    parent_id uuid,
    parent_name text,
    code text NOT NULL,
    sectors_of_intervention text,
    donors text,
    start_date date,
    end_date date,
    _deleted boolean DEFAULT false NOT NULL,
    _rev text,
    _attachments jsonb DEFAULT jsonb_build_array(),
    is_deleted boolean DEFAULT false NOT NULL
);

CREATE TABLE IF NOT EXISTS public.report_data (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    created_at date DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    user_data_ref_id uuid NOT NULL,
    report_schema_ref_id uuid NOT NULL,
    metadata jsonb DEFAULT jsonb_build_object() NOT NULL,
    area_ref_id uuid,
    location_ref_id uuid,
    organization_ref_id uuid,
    project_ref_id uuid,
    date_start date,
    date_end date,
    _deleted boolean DEFAULT false NOT NULL,
    _rev text,
    _attachments jsonb DEFAULT jsonb_build_array(),
    is_deleted boolean DEFAULT false NOT NULL,
    case_ref_id uuid
);

CREATE TABLE IF NOT EXISTS public.report_schema (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name text UNIQUE NOT NULL,
    schema jsonb NOT NULL,
    label text,
    icon text,
    form_schema_ids jsonb DEFAULT jsonb_build_array() NOT NULL,
    _deleted boolean DEFAULT false NOT NULL,
    _rev text,
    _attachments jsonb DEFAULT jsonb_build_array(),
    is_deleted boolean DEFAULT false NOT NULL
);

CREATE TABLE IF NOT EXISTS public.user_data (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    full_name text NOT NULL,
    user_group_ids jsonb DEFAULT jsonb_build_array() NOT NULL,
    email text,
    _deleted boolean DEFAULT false NOT NULL,
    _rev text,
    _attachments jsonb DEFAULT jsonb_build_array(),
    is_deleted boolean DEFAULT false NOT NULL,
    user_auth_ref_id uuid
);

CREATE TABLE IF NOT EXISTS public.user_group (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    user_role_ref_id uuid NOT NULL,
    "groupFormSchemaIds" jsonb DEFAULT jsonb_build_array() NOT NULL,
    "groupReportSchemaIds" jsonb DEFAULT jsonb_build_array() NOT NULL,
    "groupName" text NOT NULL,
    _attachments jsonb,
    _rev text,
    _deleted boolean DEFAULT false NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    area_ref_id json DEFAULT jsonb_build_array() NOT NULL,
    location_ref_id json DEFAULT jsonb_build_array() NOT NULL,
    organization_ref_id json DEFAULT jsonb_build_array() NOT NULL,
    project_ref_id json DEFAULT jsonb_build_array() NOT NULL,
    case_ref_id json DEFAULT jsonb_build_array() NOT NULL,
    form_status_ref_id jsonb DEFAULT jsonb_build_array()
);

CREATE TABLE IF NOT EXISTS public.user_role (
    id uuid DEFAULT public.gen_random_uuid() PRIMARY KEY,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    "roleName" text NOT NULL,
    "rolePermissions" jsonb NOT NULL,
    _deleted boolean DEFAULT false NOT NULL,
    _rev text,
    _attachments jsonb DEFAULT jsonb_build_array(),
    is_deleted boolean DEFAULT false NOT NULL
);

ALTER TABLE
    ONLY public."case"
ALTER COLUMN
    code
SET
    DEFAULT nextval('public.case_code_seq' :: regclass);

DROP TRIGGER IF EXISTS set_public_area_updated_at on public.area;

CREATE TRIGGER set_public_area_updated_at BEFORE
UPDATE
    ON public.area FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_case_updated_at on public."case";

CREATE TRIGGER set_public_case_updated_at BEFORE
UPDATE
    ON public."case" FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_form_data_updated_at on public.form_data;

CREATE TRIGGER set_public_form_data_updated_at BEFORE
UPDATE
    ON public.form_data FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_form_schema_deps_updated_at on public.form_schema_deps;

CREATE TRIGGER set_public_form_schema_deps_updated_at BEFORE
UPDATE
    ON public.form_schema_deps FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_form_schema_updated_at on public.form_schema;

CREATE TRIGGER set_public_form_schema_updated_at BEFORE
UPDATE
    ON public.form_schema FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_form_status_updated_at on public.form_status;

CREATE TRIGGER set_public_form_status_updated_at BEFORE
UPDATE
    ON public.form_status FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_lang_updated_at on public.lang;

CREATE TRIGGER set_public_lang_updated_at BEFORE
UPDATE
    ON public.lang FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_location_updated_at on public.location;

CREATE TRIGGER set_public_location_updated_at BEFORE
UPDATE
    ON public.location FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_organization_updated_at on public.organization;

CREATE TRIGGER set_public_organization_updated_at BEFORE
UPDATE
    ON public.organization FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_project_updated_at on public.project;

CREATE TRIGGER set_public_project_updated_at BEFORE
UPDATE
    ON public.project FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_report_data_updated_at on public.report_data;

CREATE TRIGGER set_public_report_data_updated_at BEFORE
UPDATE
    ON public.report_data FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_report_schema_updated_at on public.report_schema;

CREATE TRIGGER set_public_report_schema_updated_at BEFORE
UPDATE
    ON public.report_schema FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_user_group_updated_at on public.user_group;

CREATE TRIGGER set_public_user_group_updated_at BEFORE
UPDATE
    ON public.user_group FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_user_model_updated_at on public.user_data;

CREATE TRIGGER set_public_user_model_updated_at BEFORE
UPDATE
    ON public.user_data FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_user_role_updated_at on public.user_role;

CREATE TRIGGER set_public_user_role_updated_at BEFORE
UPDATE
    ON public.user_role FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

ALTER TABLE
    ONLY public.form_data DROP CONSTRAINT IF EXISTS form_data_area_ref_id_fkey;

ALTER TABLE
    ONLY public.form_data
ADD
    CONSTRAINT form_data_area_ref_id_fkey FOREIGN KEY (area_ref_id) REFERENCES public.area(id) ON UPDATE CASCADE ON DELETE
SET
    DEFAULT;

ALTER TABLE
    ONLY public.form_data DROP CONSTRAINT IF EXISTS form_data_case_ref_id_fkey;

ALTER TABLE
    ONLY public.form_data
ADD
    CONSTRAINT form_data_case_ref_id_fkey FOREIGN KEY (case_ref_id) REFERENCES public."case"(id) ON UPDATE CASCADE ON DELETE
SET
    DEFAULT;

ALTER TABLE
    ONLY public.form_data DROP CONSTRAINT IF EXISTS form_data_form_schema_ref_id_fkey;

ALTER TABLE
    ONLY public.form_data
ADD
    CONSTRAINT form_data_form_schema_ref_id_fkey FOREIGN KEY (form_schema_ref_id) REFERENCES public.form_schema(id) ON UPDATE CASCADE;

ALTER TABLE
    ONLY public.form_data DROP CONSTRAINT IF EXISTS form_data_form_status_ref_id_fkey;

ALTER TABLE
    ONLY public.form_data
ADD
    CONSTRAINT form_data_form_status_ref_id_fkey FOREIGN KEY (form_status_ref_id) REFERENCES public.form_status(id) ON UPDATE CASCADE;

ALTER TABLE
    ONLY public.form_data DROP CONSTRAINT IF EXISTS form_data_location_ref_id_fkey;

ALTER TABLE
    ONLY public.form_data
ADD
    CONSTRAINT form_data_location_ref_id_fkey FOREIGN KEY (location_ref_id) REFERENCES public.location(id) ON UPDATE CASCADE ON DELETE
SET
    DEFAULT;

ALTER TABLE
    ONLY public.form_data DROP CONSTRAINT IF EXISTS form_data_organization_ref_id_fkey;

ALTER TABLE
    ONLY public.form_data
ADD
    CONSTRAINT form_data_organization_ref_id_fkey FOREIGN KEY (organization_ref_id) REFERENCES public.organization(id) ON UPDATE CASCADE ON DELETE
SET
    DEFAULT;

ALTER TABLE
    ONLY public.form_data DROP CONSTRAINT IF EXISTS form_data_project_ref_id_fkey;

ALTER TABLE
    ONLY public.form_data
ADD
    CONSTRAINT form_data_project_ref_id_fkey FOREIGN KEY (project_ref_id) REFERENCES public.project(id) ON UPDATE CASCADE ON DELETE
SET
    DEFAULT;

ALTER TABLE
    ONLY public.form_data DROP CONSTRAINT IF EXISTS form_data_user_data_ref_id_fkey;

ALTER TABLE
    ONLY public.form_data
ADD
    CONSTRAINT form_data_user_data_ref_id_fkey FOREIGN KEY (user_data_ref_id) REFERENCES public.user_data(id) ON UPDATE CASCADE;

ALTER TABLE
    ONLY public.form_schema DROP CONSTRAINT IF EXISTS form_schema_form_deps_ref_id_fkey;

ALTER TABLE
    ONLY public.form_schema
ADD
    CONSTRAINT form_schema_form_deps_ref_id_fkey FOREIGN KEY (form_schema_deps_ref_id) REFERENCES public.form_schema_deps(id) ON UPDATE CASCADE;

ALTER TABLE
    ONLY public.report_data DROP CONSTRAINT IF EXISTS report_data_area_ref_id_fkey;

ALTER TABLE
    ONLY public.report_data
ADD
    CONSTRAINT report_data_area_ref_id_fkey FOREIGN KEY (area_ref_id) REFERENCES public.area(id) ON UPDATE CASCADE ON DELETE
SET
    DEFAULT;

ALTER TABLE
    ONLY public.report_data DROP CONSTRAINT IF EXISTS report_data_case_ref_id_fkey;

ALTER TABLE
    ONLY public.report_data
ADD
    CONSTRAINT report_data_case_ref_id_fkey FOREIGN KEY (case_ref_id) REFERENCES public."case"(id) ON UPDATE CASCADE ON DELETE
SET
    DEFAULT;

ALTER TABLE
    ONLY public.report_data DROP CONSTRAINT IF EXISTS report_data_location_ref_id_fkey;

ALTER TABLE
    ONLY public.report_data
ADD
    CONSTRAINT report_data_location_ref_id_fkey FOREIGN KEY (location_ref_id) REFERENCES public.location(id) ON UPDATE CASCADE ON DELETE
SET
    DEFAULT;

ALTER TABLE
    ONLY public.report_data DROP CONSTRAINT IF EXISTS report_data_organization_ref_id_fkey;

ALTER TABLE
    ONLY public.report_data
ADD
    CONSTRAINT report_data_organization_ref_id_fkey FOREIGN KEY (organization_ref_id) REFERENCES public.organization(id) ON UPDATE CASCADE ON DELETE
SET
    DEFAULT;

ALTER TABLE
    ONLY public.report_data DROP CONSTRAINT IF EXISTS report_data_project_ref_id_fkey;

ALTER TABLE
    ONLY public.report_data
ADD
    CONSTRAINT report_data_project_ref_id_fkey FOREIGN KEY (project_ref_id) REFERENCES public.project(id) ON UPDATE CASCADE ON DELETE
SET
    DEFAULT;

ALTER TABLE
    ONLY public.report_data DROP CONSTRAINT IF EXISTS report_data_report_schema_ref_id_fkey;

ALTER TABLE
    ONLY public.report_data
ADD
    CONSTRAINT report_data_report_schema_ref_id_fkey FOREIGN KEY (report_schema_ref_id) REFERENCES public.report_schema(id) ON UPDATE CASCADE;

ALTER TABLE
    ONLY public.report_data DROP CONSTRAINT IF EXISTS report_data_user_data_ref_id_fkey;

ALTER TABLE
    ONLY public.report_data
ADD
    CONSTRAINT report_data_user_data_ref_id_fkey FOREIGN KEY (user_data_ref_id) REFERENCES public.user_data(id) ON UPDATE CASCADE;
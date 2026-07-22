DROP TRIGGER IF EXISTS set_public_area_updated_at on public.area;

CREATE TRIGGER set_public_area_updated_at BEFORE
INSERT OR UPDATE
    ON public.area FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_case_updated_at on public."case";

CREATE TRIGGER set_public_case_updated_at BEFORE
INSERT OR UPDATE
    ON public."case" FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_form_data_updated_at on public.form_data;

CREATE TRIGGER set_public_form_data_updated_at BEFORE
INSERT OR UPDATE
    ON public.form_data FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_form_schema_deps_updated_at on public.form_schema_deps;

CREATE TRIGGER set_public_form_schema_deps_updated_at BEFORE
INSERT OR UPDATE
    ON public.form_schema_deps FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_form_schema_updated_at on public.form_schema;

CREATE TRIGGER set_public_form_schema_updated_at BEFORE
INSERT OR UPDATE
    ON public.form_schema FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_form_status_updated_at on public.form_status;

CREATE TRIGGER set_public_form_status_updated_at BEFORE
INSERT OR UPDATE
    ON public.form_status FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_lang_updated_at on public.lang;

CREATE TRIGGER set_public_lang_updated_at BEFORE
INSERT OR UPDATE
    ON public.lang FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_location_updated_at on public.location;

CREATE TRIGGER set_public_location_updated_at BEFORE
INSERT OR UPDATE
    ON public.location FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_organization_updated_at on public.organization;

CREATE TRIGGER set_public_organization_updated_at BEFORE
INSERT OR UPDATE
    ON public.organization FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_project_updated_at on public.project;

CREATE TRIGGER set_public_project_updated_at BEFORE
INSERT OR UPDATE
    ON public.project FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_report_data_updated_at on public.report_data;

CREATE TRIGGER set_public_report_data_updated_at BEFORE
INSERT OR UPDATE
    ON public.report_data FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_report_schema_updated_at on public.report_schema;

CREATE TRIGGER set_public_report_schema_updated_at BEFORE
INSERT OR UPDATE
    ON public.report_schema FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_user_group_updated_at on public.user_group;

CREATE TRIGGER set_public_user_group_updated_at BEFORE
INSERT OR UPDATE
    ON public.user_group FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_user_model_updated_at on public.user_data;

CREATE TRIGGER set_public_user_model_updated_at BEFORE
INSERT OR UPDATE
    ON public.user_data FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

DROP TRIGGER IF EXISTS set_public_user_role_updated_at on public.user_role;

CREATE TRIGGER set_public_user_role_updated_at BEFORE
INSERT OR UPDATE
    ON public.user_role FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();

CREATE UNIQUE INDEX IF NOT EXISTS area_permissions_idx ON public.area_permissions(user_id, metric_id, group_id);
CREATE UNIQUE INDEX IF NOT EXISTS case_permissions_idx ON public.case_permissions(user_id, metric_id, group_id);
CREATE UNIQUE INDEX IF NOT EXISTS location_permissions_idx ON public.location_permissions(user_id, metric_id, group_id);
CREATE UNIQUE INDEX IF NOT EXISTS organization_permissions_idx ON public.organization_permissions(user_id, metric_id, group_id);
CREATE UNIQUE INDEX IF NOT EXISTS project_permissions_idx ON public.project_permissions(user_id, metric_id, group_id);
CREATE UNIQUE INDEX IF NOT EXISTS form_permissions_idx ON public.form_permissions(
   user_id,
   form_schema_id,
   form_data_permissions,
   form_schema_permissions,
   group_id
);
CREATE UNIQUE INDEX IF NOT EXISTS report_permissions_idx ON public.report_permissions(
   user_id,
   report_schema_id,
   report_data_permissions,
   report_schema_permissions,
   group_id
);

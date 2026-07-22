CREATE MATERIALIZED VIEW IF NOT EXISTS "public"."form_permissions" AS
SELECT
   ud.full_name as user_name,
   ud.user_auth_ref_id as user_id,
   ug.id as group_id,
   jsonb_array_elements_text(
      jsonb_agg(
         CASE
            WHEN item = 'all' THEN '7044761a-a850-4c37-b6bc-c2d2ca2a3280' :: uuid
            ELSE item :: uuid
         END
      )
   ) :: uuid as form_schema_id,
   (ur."rolePermissions" ->> 'form_data') :: jsonb as form_data_permissions,
   (ur."rolePermissions" ->> 'form_schema') :: jsonb as form_schema_permissions
FROM
   user_group as ug
   JOIN user_data as ud ON ud.user_group_ids ? ug.id :: text
   JOIN user_role as ur ON ug.user_role_ref_id = ur.id
   CROSS JOIN jsonb_array_elements_text(ug."groupFormSchemaIds") as item
WHERE
   JSONB_ARRAY_LENGTH(ug."groupFormSchemaIds") > 0 AND
   ud.is_deleted = 'false' AND
   ug.is_deleted = 'false'
GROUP BY
   ud.full_name,
   ud.user_auth_ref_id,
   ur."rolePermissions",
   ug.id;

CREATE OR REPLACE FUNCTION disable_user() 
  RETURNS trigger
AS
$disable_user$
BEGIN
  UPDATE auth.users
    SET disabled = new.disabled
  WHERE id = new.user_auth_ref_id;
  RETURN new;
END
$disable_user$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS disable_user on public.user_data;

CREATE TRIGGER disable_user
AFTER UPDATE OF disabled ON public.user_data
FOR EACH ROW
EXECUTE PROCEDURE disable_user();

CREATE OR REPLACE FUNCTION delete_user() 
  RETURNS trigger
AS
$delete_user$
BEGIN
  IF new.is_deleted = true THEN
    DELETE FROM auth.users
    WHERE id = new.user_auth_ref_id;
  END IF;
  RETURN new;
END
$delete_user$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS delete_user on public.user_data;

CREATE TRIGGER delete_user
AFTER UPDATE OF is_deleted ON public.user_data
FOR EACH ROW
EXECUTE PROCEDURE delete_user();

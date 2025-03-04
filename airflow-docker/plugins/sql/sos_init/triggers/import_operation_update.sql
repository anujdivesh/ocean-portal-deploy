CREATE TRIGGER import_operation_update
    AFTER INSERT OR UPDATE 
    ON public.import_operation
    FOR EACH ROW
    WHEN (new.statut::text = 'SUCCESS'::text)
    EXECUTE PROCEDURE sos.update_sos_schema();

CREATE TRIGGER plateforme_delete
    AFTER DELETE
    ON public.plateforme
    FOR EACH ROW
    EXECUTE PROCEDURE sos.deleteplateforme();

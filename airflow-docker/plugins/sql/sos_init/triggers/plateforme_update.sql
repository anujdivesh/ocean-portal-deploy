CREATE TRIGGER plateforme_update
    AFTER INSERT OR UPDATE 
    ON public.plateforme
    FOR EACH ROW
    EXECUTE PROCEDURE sos.insertorupdateplateforme();

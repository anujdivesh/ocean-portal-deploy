CREATE TRIGGER parametrephysique_delete
    AFTER DELETE
    ON public.parametre_physique
    FOR EACH ROW
    EXECUTE PROCEDURE sos.deleteparametrephysique();

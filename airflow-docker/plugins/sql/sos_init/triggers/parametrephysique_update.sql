CREATE TRIGGER parametrephysique_update
    AFTER INSERT OR UPDATE 
    ON public.parametre_physique
    FOR EACH ROW
    EXECUTE PROCEDURE sos.insertorupdateparametrephysique();

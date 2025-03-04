-- FUNCTION: sos.cycle_mesure_delete()

-- DROP FUNCTION IF EXISTS sos.cycle_mesure_delete();

CREATE OR REPLACE FUNCTION sos.cycle_mesure_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
    
BEGIN
	delete from import_operation where id_cycle_mesure = OLD.id;
	delete from sos.procedure where identifier like '%'||OLD.libelle;
	RETURN OLD;
END;
$BODY$;

ALTER FUNCTION sos.cycle_mesure_delete()
    OWNER TO postgres;

CREATE TRIGGER cycle_mesure_delete
    BEFORE DELETE
    ON public.cycle_mesure
    FOR EACH ROW
    EXECUTE PROCEDURE sos.cycle_mesure_delete();

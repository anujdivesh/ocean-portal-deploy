-- FUNCTION: sos.mesure_delete()

-- DROP FUNCTION IF EXISTS sos.mesure_delete();

CREATE OR REPLACE FUNCTION sos.mesure_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
    
    BEGIN
	delete from sos.observationhasoffering where observationid=OLD.id;
	delete from sos.numericvalue where observationid=OLD.id;
	delete from sos.observation where observationid=OLD.id;
	RETURN OLD;
    END;
$BODY$;

ALTER FUNCTION sos.mesure_delete()
    OWNER TO postgres;


CREATE TRIGGER mesure_delete
    AFTER DELETE
    ON public.mesure
    FOR EACH ROW
    EXECUTE PROCEDURE sos.mesure_delete();

-- FUNCTION: sos.procedure_delete()

-- DROP FUNCTION IF EXISTS sos.procedure_delete();

CREATE OR REPLACE FUNCTION sos.procedure_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
    BEGIN
	delete from sos.sensorsystem where childsensorid = OLD.procedureid;
	RETURN OLD;
    END;
$BODY$;

ALTER FUNCTION sos.procedure_delete()
    OWNER TO postgres;


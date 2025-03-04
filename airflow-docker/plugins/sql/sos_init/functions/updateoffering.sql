-- FUNCTION: sos.updateoffering(integer)

-- DROP FUNCTION IF EXISTS sos.updateoffering(integer);

CREATE OR REPLACE FUNCTION sos.updateoffering(
	integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$
    BEGIN
	UPDATE sos.offering
	    set name=libelle,description=descriptif
	FROM public.plateforme p where p.id=$1;
    END;
$BODY$;

ALTER FUNCTION sos.updateoffering(integer)
    OWNER TO postgres;


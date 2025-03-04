-- FUNCTION: sos.updateobservableproperty(integer)

-- DROP FUNCTION IF EXISTS sos.updateobservableproperty(integer);

CREATE OR REPLACE FUNCTION sos.updateobservableproperty(
	integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$
BEGIN
	UPDATE sos.observableproperty 
	    set name=pp.libelle from parametre_physique pp 
		where pp.id=sos.observableproperty.observablepropertyid 
		and sos.observableproperty.observablepropertyid=$1;
    END;
$BODY$;

ALTER FUNCTION sos.updateobservableproperty(integer)
    OWNER TO postgres;


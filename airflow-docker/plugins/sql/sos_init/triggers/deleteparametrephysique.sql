-- FUNCTION: sos.deleteparametrephysique()

-- DROP FUNCTION IF EXISTS sos.deleteparametrephysique();

CREATE OR REPLACE FUNCTION sos.deleteparametrephysique()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
        delete from sos.observableproperty where observablepropertyid=OLD.id;
		RETURN OLD;
    END;
$BODY$;

ALTER FUNCTION sos.deleteparametrephysique()
    OWNER TO postgres;


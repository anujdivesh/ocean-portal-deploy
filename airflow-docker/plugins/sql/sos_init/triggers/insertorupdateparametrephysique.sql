-- FUNCTION: sos.insertorupdateparametrephysique()

-- DROP FUNCTION IF EXISTS sos.insertorupdateparametrephysique();

CREATE OR REPLACE FUNCTION sos.insertorupdateparametrephysique()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            perform sos.insertobservableproperty(NEW.id);
            RETURN NEW;
        ELSIF (TG_OP = 'UPDATE') THEN
	    perform sos.updateobservableproperty(NEW.id);
            RETURN NEW;
        END IF;
    END;
$BODY$;

ALTER FUNCTION sos.insertorupdateparametrephysique()
    OWNER TO postgres;


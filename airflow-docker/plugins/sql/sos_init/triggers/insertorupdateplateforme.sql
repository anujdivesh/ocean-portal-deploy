-- FUNCTION: sos.insertorupdateplateforme()

-- DROP FUNCTION IF EXISTS sos.insertorupdateplateforme();

CREATE OR REPLACE FUNCTION sos.insertorupdateplateforme()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$

    BEGIN
        IF (TG_OP = 'INSERT') THEN
            perform sos.insertfoi(NEW.id);
	    	perform sos.insertoffering(NEW.id);
            RETURN NEW;
        ELSIF (TG_OP = 'UPDATE') THEN
	    	perform sos.updatefoi(NEW.id);
	    	perform sos.updateoffering(NEW.id);
            RETURN NEW;
        END IF;
    END;

$BODY$;

ALTER FUNCTION sos.insertorupdateplateforme()
    OWNER TO postgres;


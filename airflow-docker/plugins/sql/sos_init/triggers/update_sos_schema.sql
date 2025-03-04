-- FUNCTION: sos.update_sos_schema()

-- DROP FUNCTION IF EXISTS sos.update_sos_schema();

CREATE OR REPLACE FUNCTION sos.update_sos_schema()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$

    DECLARE
	ids  integer;
    BEGIN
    	FOR ids IN (SELECT mesure.id_serie from mesure,type_mesure WHERE mesure.id_type_mesure=type_mesure.id AND type_mesure.id_cycle_mesure=NEW.id_cycle_mesure GROUP BY mesure.id_serie)
       LOOP
        IF EXISTS (SELECT 1 FROM serie where id=ids and publique=true and id_famille_instrument=(
    select f.id from famille_instrument f, type_instrument t, instrument i where i.id=NEW.id_instrument and i.id_type_instrument=t.id and t.id_famille_instrument=f.id)) THEN
          IF EXISTS (SELECT 1 FROM sos.series where seriesid=ids) THEN
           RAISE DEBUG 'sos.series % already exists.', ids;
          ELSE
           RAISE DEBUG 'creating sos.series %', ids;
           PERFORM sos.insertproceduresystem(ids);
          END IF;	          
	      PERFORM sos.insertprocedurecomponent(ids, NEW.id_cycle_mesure);	
        END IF;	
       END LOOP;
        RETURN NEW;
    END;

$BODY$;

ALTER FUNCTION sos.update_sos_schema()
    OWNER TO postgres;


-- FUNCTION: sos.update_sos_schema(integer, integer)

-- DROP FUNCTION IF EXISTS sos.update_sos_schema(integer, integer);

CREATE OR REPLACE FUNCTION sos.update_sos_schema(
	integer,
	integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$
DECLARE
    cm_id ALIAS FOR $1;
    instrument_id ALIAS FOR $2;
	ids  integer;
    BEGIN
    	FOR ids IN (SELECT mesure.id_serie from mesure,type_mesure WHERE mesure.id_type_mesure=type_mesure.id AND type_mesure.id_cycle_mesure=cm_id GROUP BY mesure.id_serie)
       LOOP
        IF EXISTS (SELECT 1 FROM sos.serie where id=ids and publique=true and id_famille_instrument=(
    select f.id from famille_instrument f, type_instrument t, instrument i where i.id=instrument_id and i.id_type_instrument=t.id and t.id_famille_instrument=f.id)) THEN
          IF EXISTS (SELECT 1 FROM sos.series where seriesid=ids) THEN
           RAISE DEBUG 'sos.series % already exists.', ids;
          ELSE
           RAISE DEBUG 'creating sos.series %', ids;
           PERFORM sos.insertproceduresystem(ids);
		   PERFORM sos.insertprocedurecomponent(ids, ccm_id);	
          END IF;	          
	      -- PERFORM sos.insertprocedurecomponent(ids, ccm_id);	
        END IF;	
       END LOOP;
    END;
$BODY$;

ALTER FUNCTION sos.update_sos_schema(integer, integer)
    OWNER TO postgres;


-- FUNCTION: sos.update_sos_schema(integer)

-- DROP FUNCTION IF EXISTS sos.update_sos_schema(integer);

CREATE OR REPLACE FUNCTION sos.update_sos_schema(
	integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$
DECLARE
    cmid ALIAS FOR $1;
    ids  integer;
    serie_created boolean default false;
    BEGIN
	RAISE LOG 'update_sos_schema Cycle Id %', cmid;
    	FOR ids IN (SELECT mesure.id_serie from mesure,type_mesure WHERE mesure.id_type_mesure=type_mesure.id AND type_mesure.id_cycle_mesure=cmid GROUP BY mesure.id_serie)
       LOOP
        IF (SELECT publique FROM serie where id=ids) THEN
          IF serie_created OR EXISTS (SELECT 1 FROM sos.series where seriesid=ids) THEN
           RAISE LOG 'sos.series % already exists.', ids;
          ELSE
           RAISE LOG 'creating sos.series %', ids;
           SELECT true into serie_created;
           PERFORM sos.insertproceduresystem(ids);
          END IF;
		   PERFORM sos.insertprocedurecomponent(ids, cmid);		  
        END IF;	
        SELECT false into serie_created;
       END LOOP;
    END;
$BODY$;

ALTER FUNCTION sos.update_sos_schema(integer)
    OWNER TO postgres;


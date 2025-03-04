-- FUNCTION: sos.insertobservationfromcm(integer, integer)

-- DROP FUNCTION IF EXISTS sos.insertobservationfromcm(integer, integer);

CREATE OR REPLACE FUNCTION sos.insertobservationfromcm(
	integer,
	integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$
DECLARE
cmid ALIAS FOR $1;
sid ALIAS FOR $2;
    BEGIN
	RAISE LOG 'insertobservationfromcm Cycle Id % Serie Id %',cmid,sid;
	-- insert new observations
	RAISE LOG 'Insert into sos.observation';
	INSERT INTO sos.observation(observationid, seriesid, phenomenontimestart, phenomenontimeend, 
            resulttime, identifier, codespace, name, codespacename, description,deleted, validtimestart, validtimeend, unitid, samplinggeometry)
	  SELECT m.id,s.id,dm.date,dm.date,dm.date,m.id,1,null,1,null,
  	    (CASE WHEN (m.id_qualite_cor in (0,1,2)) THEN 'F' ELSE 'T' END),dm.date,dm.date,u.unitid,pm."position"
  	  FROM 
          public.mesure m, 
          public.date_mesure dm, 
          public.position_mesure pm, 
          public.parametre_physique pp, 
          public.serie s,
          sos.unit u,
          public.type_mesure tm
  	  where m.id_type_mesure=tm.id and tm.id_cycle_mesure=cmid and m.id_date_mesure=dm.id and m.id_position_mesure=pm.id and m.id_parametre_physique=pp.id and pp.unite=u.unit and m.id_serie=s.id and s.id=sid;
	-- insert new observations values
	RAISE LOG 'Insert into sos.numericvalue';
	INSERT INTO sos.numericvalue(observationid, value)
	  SELECT m.id,nullif(m.valeur_cor, 'NaN')
	  FROM mesure m, type_mesure tm where m.id_type_mesure=tm.id and tm.id_cycle_mesure=cmid and m.id_serie=sid;
	-- insert new observations has offering
	RAISE LOG 'Insert into sos.observationhasoffering';
	INSERT INTO sos.observationhasoffering(observationid, offeringid)
  	  SELECT m.id, cm.id_plateforme
  	  FROM mesure m, type_mesure tm,cycle_mesure cm where m.id_type_mesure=tm.id and tm.id_cycle_mesure=cm.id and cm.id=cmid and m.id_serie=sid;
    END;
$BODY$;

ALTER FUNCTION sos.insertobservationfromcm(integer, integer)
    OWNER TO postgres;


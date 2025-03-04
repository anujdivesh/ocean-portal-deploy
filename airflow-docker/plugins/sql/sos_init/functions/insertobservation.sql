-- FUNCTION: sos.insertobservation(integer)

-- DROP FUNCTION IF EXISTS sos.insertobservation(integer);

CREATE OR REPLACE FUNCTION sos.insertobservation(
	integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$
BEGIN
	-- insert new observations
	INSERT INTO sos.observation(observationid, seriesid, phenomenontimestart, phenomenontimeend, 
            resulttime, identifier, codespace, name, codespacename, description,deleted, validtimestart, validtimeend, unitid, samplinggeometry)
	  SELECT m.id,s.id,dm.date,dm.date,dm.date,m.id,1,null,1,null,
  	    (CASE WHEN (m.id_qualite_cor in (0,1,2)) THEN 'F' ELSE 'T' END),dm.date,dm.date,u.unitid,pm."position"
  	  FROM public.mesure m, public.serie s, public.date_mesure dm, public.position_mesure pm, public.parametre_physique pp, sos.unit u
  	  where m.id_serie=s.id and m.id_date_mesure=dm.id and m.id_position_mesure=pm.id and m.id_parametre_physique=pp.id and pp.unite=u.unit 
	  and s.id=$1 ON CONFLICT DO NOTHING;
	-- insert new observations values
	INSERT INTO sos.numericvalue(observationid, value)
	  SELECT m.id,nullif(m.valeur_cor, 'NaN')
	  FROM mesure m where id_serie=$1 and m.id not in (select observationid from numericvalue);
	-- insert new observations has offering
	INSERT INTO sos.observationhasoffering(observationid, offeringid)
  	  SELECT m.id, s.id_plateforme
  	  FROM mesure m, serie s where m.id_serie=s.id and s.id=$1 and m.id not in (select observationid from observationhasoffering);
    END;
$BODY$;

ALTER FUNCTION sos.insertobservation(integer)
    OWNER TO postgres;


-- FUNCTION: sos.updateseriesdates(integer)

-- DROP FUNCTION IF EXISTS sos.updateseriesdates(integer);

CREATE OR REPLACE FUNCTION sos.updateseriesdates(
	integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$
BEGIN
	-- set start date series
	RAISE LOG 'insertseriesdates Serie Id %', $1;
	CREATE TEMPORARY TABLE "tmpObsValue"
	(
    	observationid integer,
    	seriesid integer,
    	phenomenontimestart timestamp,
	  	"value" double precision
	); 
	INSERT INTO "tmpObsValue" (observationid,seriesid,phenomenontimestart,"value")
		select o.observationid, o.seriesid, o.phenomenontimestart,nv.value 
		from sos.observation o, sos.numericvalue nv 
		where o.seriesid=$1 and o.observationid=nv.observationid and nv.value != double precision 'NaN'
		order by o.phenomenontimestart;
	-- first date and firt numeric value
	--IF((SELECT firsttimestamp from series where seriesid=$1) is null) THEN
		UPDATE sos.series set firsttimestamp=tov.phenomenontimestart,firstnumericvalue=tov.value from (select * from "tmpObsValue" limit 1) as tov where sos.series.seriesid=$1;
	--END IF;
	-- last date and last numeric value
	UPDATE sos.series set lasttimestamp=tov.phenomenontimestart,lastnumericvalue=tov.value from (select * from "tmpObsValue" order by phenomenontimestart desc limit 1) as tov where sos.series.seriesid=$1;

	DROP TABLE "tmpObsValue";
END;	
$BODY$;

ALTER FUNCTION sos.updateseriesdates(integer)
    OWNER TO postgres;


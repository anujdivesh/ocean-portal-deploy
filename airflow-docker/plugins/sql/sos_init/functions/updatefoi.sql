-- FUNCTION: sos.updatefoi(integer)

-- DROP FUNCTION IF EXISTS sos.updatefoi(integer);

CREATE OR REPLACE FUNCTION sos.updatefoi(
	integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$

    DECLARE
	idp ALIAS FOR $1;
    BEGIN
	UPDATE sos.featureofinterest 
	    set identifier=oceano.code_plateforme,name=oceano.libelle,description=oceano.descriptif,
		url=(select sos.get_absolute_path_prefix('WFS'))||'service=wfs&version=1.0.0&request=getfeature&typename=topp:reeftemps_network&CQL_FILTER=code_plateforme=%27'|| oceano.code_plateforme || '%27&outputFormat=json',geom=ST_GeomFromText('POINT('||oceano.longitude||' '||oceano.latitude||')',4326) 
	FROM (SELECT p.id as id,p.code_plateforme,p.libelle,p.descriptif,pm.latitude as latitude,pm.longitude as longitude
	    FROM position_mesure pm, plateforme AS p
	    LEFT JOIN serie AS s ON p.id=s.id_plateforme AND s.id = (SELECT MAX(z.id) FROM serie AS z WHERE z.id_plateforme=idp)
	    WHERE pm.id=(select id_position_mesure from mesure where id_serie=s.id limit 1)) oceano
	WHERE featureofinterest.featureofinterestid=oceano.id and featureofinterest.featureofinterestid=idp;
    END;

$BODY$;

ALTER FUNCTION sos.updatefoi(integer)
    OWNER TO postgres;


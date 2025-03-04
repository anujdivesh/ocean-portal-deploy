-- FUNCTION: sos.insertfoi(integer)

-- DROP FUNCTION IF EXISTS sos.insertfoi(integer);

CREATE OR REPLACE FUNCTION sos.insertfoi(
	integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$
DECLARE
	idp integer;
	foii integer;	
	rfi integer;
    BEGIN
        SELECT $1 into idp;
        IF EXISTS (SELECT 1 FROM sos.featureofinterest where featureofinterestid=idp) THEN
          RAISE LOG 'foi already exists aborting insert feature of interest id %', $1;
          RETURN;
        ELSE
	  RAISE LOG 'insertfoi feature of interest id %', $1;
        END IF;
	-- insert featureofinterest
	RAISE LOG 'Insert into sos.featureofinterest';
	INSERT INTO sos.featureofinterest (featureofinterestid, hibernatediscriminator, featureofinteresttypeid, 
            identifier, codespace, name, codespacename, description,  
            descriptionxml, url)
    	SELECT 
  	    p.id,'T',1,p.code_plateforme,1,p.libelle,1,p.descriptif,null,
  	    (select sos.get_absolute_path_prefix('WFS'))||'service=wfs&version=1.0.0&request=getfeature&typename=topp:reeftemps_network&CQL_FILTER=code_plateforme=%27'|| p.code_plateforme || '%27&outputFormat=json' FROM plateforme p where id=idp 
	RETURNING featureofinterestid into foii;
	-- set the geom
	RAISE LOG 'Update sos.featureofinterest';
	UPDATE sos.featureofinterest 
	    set geom=ST_GeomFromText('POINT('||oceano.longitude||' '||oceano.latitude||')',4326) 
	FROM (SELECT p.id as id,pm.latitude as latitude,pm.longitude as longitude
	    FROM position_mesure pm, plateforme AS p
	    LEFT JOIN serie AS s ON p.id=s.id_plateforme AND s.id = (SELECT MAX(z.id) FROM serie AS z WHERE z.id_plateforme=idp)
	    WHERE pm.id=(select id_position_mesure from mesure where id_serie=s.id limit 1)) oceano
	WHERE featureofinterest.featureofinterestid=oceano.id and featureofinterest.featureofinterestid=idp;
	-- insert related feature
	RAISE LOG 'Insert into sos.relatedfeature';
	INSERT INTO sos.relatedfeature(relatedfeatureid, featureofinterestid) values(nextval('sos.relatedfeatureid_seq'),foii) RETURNING relatedfeatureid into rfi;
	-- insert relatedfeaturehasrole
	RAISE LOG 'Insert into sos.relatedfeaturehasrole';
	INSERT INTO sos.relatedfeaturehasrole(relatedfeatureid, relatedfeatureroleid) values(rfi,1);
    END;
$BODY$;

ALTER FUNCTION sos.insertfoi(integer)
    OWNER TO postgres;


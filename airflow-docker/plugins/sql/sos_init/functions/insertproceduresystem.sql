-- FUNCTION: sos.insertproceduresystem(integer)

-- DROP FUNCTION IF EXISTS sos.insertproceduresystem(integer);

CREATE OR REPLACE FUNCTION sos.insertproceduresystem(
	integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE
AS $BODY$
DECLARE
    pid integer;
    foid integer;
    BEGIN
        IF EXISTS (SELECT 1 FROM sos.procedure, serie where sos.procedure.identifier=serie.libelle and serie.id=$1) THEN
          RAISE LOG 'Series already exists aborting insertproceduresystem Serie Id %', $1;
          RETURN;
        END IF;
	-- insert procedure system
	RAISE LOG 'insertproceduresystem Serie Id %', $1;
	RAISE LOG 'Insert into sos.procedure';
	INSERT INTO sos.procedure(
            procedureid, hibernatediscriminator, proceduredescriptionformatid, 
            identifier, codespace, name, codespacename, description, deleted, 
            disabled, descriptionfile, referenceflag)
    	SELECT nextval('sos.procedureid_seq'),'T',1,s.libelle,1,s.libelle,1,
  	    'Plateforme : '||p.code_plateforme||', Paramètre physique : '||pp.code_roscop||', Traitement type mesure : '||tm.libelle||', Famille instrument : '||fi.libelle as description,
  	    'F',(CASE WHEN (s.publique) THEN 'F' ELSE 'T' END),null,'F'
    	FROM serie s, parametre_physique pp, plateforme p, traitement_type_mesure tm, famille_instrument fi
    	where s.id_parametre_physique=pp.id and s.id_plateforme=p.id and s.id_parametre_physique=pp.id and s.id_traitement_type_mesure=tm.id and s.id_famille_instrument=fi.id and s.publique=true and s.id=$1
	RETURNING procedureid into pid;
	-- insert series
	RAISE LOG 'Insert into sos.series';
	INSERT INTO sos.series(seriesid, featureofinterestid, observablepropertyid, procedureid,offeringid, deleted, published, unitid)	
	SELECT s.id, foi.featureofinterestid, op.observablepropertyid, proc.procedureid, o.offeringid, 'F',
	    (CASE WHEN (s.publique) THEN 'T' ELSE 'F' END) as published,u.unitid
   	FROM sos.featureofinterest foi,sos.observableproperty op,sos.procedure proc,sos.unit u,sos.offering o,
	    public.plateforme p,public.parametre_physique pp,public.serie s
    	WHERE foi.identifier=o.identifier and foi.identifier=p.code_plateforme and s.libelle=proc.identifier
	    and s.id_plateforme=p.id and s.id_parametre_physique=pp.id and pp.code_roscop=op.identifier and pp.unite=u.unit and proc.procedureid=pid
    RETURNING featureofinterestid into foid;
    PERFORM sos.updatefoi(foid);
    END;
$BODY$;

ALTER FUNCTION sos.insertproceduresystem(integer)
    OWNER TO postgres;


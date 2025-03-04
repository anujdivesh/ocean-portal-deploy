-- FUNCTION: sos.serie_update()

-- DROP FUNCTION IF EXISTS sos.serie_update();

CREATE OR REPLACE FUNCTION sos.serie_update()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	-- update procedure component depending on the serie
	RAISE LOG 'UPDATE procedure component for serie %', NEW.id;
	UPDATE sos.procedure
		SET 
			identifier = t.identifier,
			name = t.name,
			description = t.description,
			disabled = t.disabled
		FROM (SELECT 
				NEW.libelle||':'||ti.code_instrument||'_'||i.numero_serie||'_'||cm.libelle AS identifier,
				OLD.libelle||':'||ti.code_instrument||'_'||i.numero_serie||'_'||cm.libelle AS old_identifier,
				NEW.libelle||':'||ti.code_instrument||'_'||i.numero_serie||'_'||cm.libelle AS name,
				'Serie : '||NEW.libelle||', Instrument code : '||ti.libelle||', numéro série : '||i.numero_serie||', cycle de mesure : '||cm.libelle AS description,
				(CASE WHEN (pl.en_activite) THEN 'T' ELSE 'F' END) AS disabled
			  FROM mesure m, type_mesure tm, instrument i, type_instrument ti, cycle_mesure cm, plateforme pl
				  where m.id_serie=NEW.id and m.id_type_mesure=tm.id and tm.id_instrument=i.id and i.id_type_instrument=ti.id and tm.id_cycle_mesure=cm.id and pl.id=NEW.id_plateforme
			  group by ti.code_instrument,ti.libelle,i.numero_serie,cm.libelle,pl.en_activite) t
		WHERE sos.procedure.identifier=t.old_identifier;
	-- update procedure system depending on the serie
	RAISE LOG 'UPDATE procedure system for serie %', NEW.id;
	UPDATE sos.procedure
		SET 
			identifier=NEW.libelle,
			name=NEW.libelle, 
			description='Plateforme : '||p.code_plateforme||', Paramètre physique : '||pp.code_roscop||', Traitement type mesure : '||tm.libelle||', Famille instrument : '||fi.libelle,
			disabled=(CASE WHEN (NEW.publique) THEN 'F' ELSE 'T' END)
	FROM parametre_physique pp, plateforme p, traitement_type_mesure tm, famille_instrument fi
	where NEW.id_parametre_physique=pp.id and NEW.id_plateforme=p.id and NEW.id_parametre_physique=pp.id and NEW.id_traitement_type_mesure=tm.id and NEW.id_famille_instrument=fi.id and NEW.publique=true AND sos.procedure.identifier=OLD.libelle;
	-- update series from serie
	RAISE LOG 'UPDATE series for serie %', NEW.id;
	UPDATE sos.series
		SET 
			featureofinterestid=foi.featureofinterestid,
			observablepropertyid=op.observablepropertyid,
			offeringid=o.offeringid,
			unitid=u.unitid,
			published=(CASE WHEN (NEW.publique) THEN 'T' ELSE 'F' END)
	FROM sos.featureofinterest foi,sos.observableproperty op,sos.unit u,sos.offering o,
	public.plateforme p,public.parametre_physique pp
	WHERE foi.identifier=o.identifier and foi.identifier=p.code_plateforme
	and NEW.id_plateforme=p.id and NEW.id_parametre_physique=pp.id and pp.code_roscop=op.identifier and pp.unite=u.unit and series.seriesid=NEW.id;
	-- check if name of netcdf export file has changed, if yes add serie to export_operation
	IF NEW.url_rel_netcdf!=OLD.url_rel_netcdf THEN
		INSERT INTO export_operation(id_serie, date_debut, statut) VALUES (NEW.id, NOW(), 'CREATED');
	END IF;
	RETURN NEW;
END;
$BODY$;

CREATE TRIGGER serie_update
    AFTER UPDATE 
    ON public.serie
    FOR EACH ROW
    EXECUTE PROCEDURE sos.serie_update();
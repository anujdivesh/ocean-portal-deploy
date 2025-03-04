-- FUNCTION: sos.deleteplateforme()

-- DROP FUNCTION IF EXISTS sos.deleteplateforme();

CREATE OR REPLACE FUNCTION sos.deleteplateforme()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
		delete from sos.relatedfeaturehasrole where relatedfeatureid=(
			select relatedfeatureid from sos.relatedfeature where featureofinterestid=OLD.id);
		delete from sos.relatedfeature where featureofinterestid=OLD.id;
        delete from sos.featureofinterest where featureofinterestid=OLD.id;
		delete from sos.offeringallowedfeaturetype where offeringid=OLD.id;
		delete from sos.offeringallowedobservationtype where offeringid=OLD.id;
        delete from sos.offering where offeringid=OLD.id;
		RETURN NULL;
END;
$BODY$;

ALTER FUNCTION sos.deleteplateforme()
    OWNER TO postgres;


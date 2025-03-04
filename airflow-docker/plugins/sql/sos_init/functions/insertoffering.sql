-- FUNCTION: sos.insertoffering(integer)

-- DROP FUNCTION IF EXISTS sos.insertoffering(integer);

CREATE OR REPLACE FUNCTION sos.insertoffering(
	integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$
    BEGIN
        IF EXISTS (SELECT 1 FROM sos.offering WHERE offeringid=$1) THEN
          RAISE LOG 'offeringid already exists aborting insertoffering %', $1;
          RETURN;
        END IF;
	INSERT INTO sos.offering(
            offeringid, hibernatediscriminator, identifier, codespace, name, 
            codespacename, description, disabled)
 	SELECT p.id,'T',code_plateforme,1,libelle,1,descriptif,
	    (CASE WHEN (en_activite) THEN 'F' ELSE 'T' END)
  	FROM public.plateforme p where p.id=$1;
	INSERT INTO sos.offeringallowedfeaturetype(offeringid, featureofinteresttypeid) values($1,1);
	INSERT INTO sos.offeringallowedobservationtype(offeringid, observationtypeid) values($1,1);
    END;
$BODY$;

ALTER FUNCTION sos.insertoffering(integer)
    OWNER TO postgres;


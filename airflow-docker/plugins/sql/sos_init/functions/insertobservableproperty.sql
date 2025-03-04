-- FUNCTION: sos.insertobservableproperty(integer)

-- DROP FUNCTION IF EXISTS sos.insertobservableproperty(integer);

CREATE OR REPLACE FUNCTION sos.insertobservableproperty(
	integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$
BEGIN
	INSERT INTO sos.observableproperty(
            observablepropertyid, hibernatediscriminator, identifier, codespace, 
            name, codespacename, description, disabled)
  	SELECT pp.id,'F',pp.code_roscop,1,pp.code_roscop,1 ,pp.libelle,'F'
  	FROM parametre_physique pp where pp.id=$1 AND NOT EXISTS (SELECT 1 FROM sos.observableproperty WHERE observablepropertyid=pp.id);
	-- IF((SELECT unitid from sos.unit where unit=pp.unite) is null) THEN
	IF( (SELECT unitid from sos.unit where unit=(SELECT pp.unite FROM parametre_physique pp where pp.id=$1)) is null ) THEN
		INSERT INTO sos.unit(unitid, unit) SELECT nextval('sos.unitid_seq'),pp.unite FROM parametre_physique pp where pp.id=$1;
    END IF;
END;
$BODY$;

ALTER FUNCTION sos.insertobservableproperty(integer)
    OWNER TO postgres;


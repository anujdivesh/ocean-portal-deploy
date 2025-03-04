-- FUNCTION: sos.insertprocedurecomponent(integer, integer)

-- DROP FUNCTION IF EXISTS sos.insertprocedurecomponent(integer, integer);

CREATE OR REPLACE FUNCTION sos.insertprocedurecomponent(
	integer,
	integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$
DECLARE
    pid integer; -- procedure id of this component
    pids integer; -- procdure id of the system
    sids integer; -- series id of the system
    BEGIN
    IF ( select EXISTS(select sp.identifier from sos.procedure sp, serie s, mesure m, type_mesure tm, instrument i, type_instrument ti, cycle_mesure cm
        where sp.identifier = s.libelle||':'||ti.code_instrument||'_'||i.numero_serie||'_'||cm.libelle
        and s.id=m.id_serie and m.id_type_mesure=tm.id and tm.id_instrument=i.id and i.id_type_instrument=ti.id and tm.id_cycle_mesure=cm.id and s.publique=true and s.id=$1 and cm.id=$2
           GROUP by sp.identifier ))
       THEN
           RAISE LOG 'insertprocedurecomponent identifier already exist.';
           RETURN;     
       ELSE
            RAISE LOG 'insertprocedurecomponent Cycle Id % Serie Id %', $2, $1;
            -- insert procedure component
            RAISE LOG 'Insert into sos.procedure';
            INSERT INTO sos.procedure(
                    procedureid, hibernatediscriminator, proceduredescriptionformatid,
                    identifier, codespace, name, codespacename, description, deleted,
                    disabled, descriptionfile, referenceflag)
                  SELECT
                nextval('sos.procedureid_seq'),'T',1,s.libelle||':'||ti.code_instrument||'_'||i.numero_serie||'_'||cm.libelle,1,
                s.libelle||':'||ti.code_instrument||'_'||i.numero_serie||'_'||cm.libelle,1,
                'Serie : '||s.libelle||', Instrument code : '||ti.libelle||', numéro série : '||i.numero_serie||', cycle de mesure : '||cm.libelle,
                'F',(CASE WHEN (pl.en_activite) THEN 'T' ELSE 'F' END),null,'F'
                  FROM serie s, mesure m, type_mesure tm, instrument i, type_instrument ti, cycle_mesure cm, plateforme pl
                where s.id=m.id_serie and m.id_type_mesure=tm.id and tm.id_instrument=i.id and i.id_type_instrument=ti.id and tm.id_cycle_mesure=cm.id and s.publique=true and s.id=$1 and cm.id=$2 and pl.id=s.id_plateforme
                group by ti.code_instrument,ti.libelle,i.numero_serie,cm.libelle,s.libelle,pl.en_activite
              RETURNING procedureid into pid;

            -- insert sensorsystem (used to link the procedure with associated system procedure)
            RAISE LOG 'Insert into sos.sensorsystem';
            INSERT INTO sos.sensorsystem(parentsensorid, childsensorid)
                SELECT p1.procedureid, p2.procedureid
                FROM sos.procedure p1, sos.procedure p2
                WHERE p2.procedureid=pid and p1.identifier=substring(p2.identifier from 0 for position(':' in p2.identifier)) and p1.procedureid<>p2.procedureid and position(':' in p2.identifier)>0;   
        END IF;
    -- get parentsensorid to get seriesid
    SELECT parentsensorid from sos.sensorsystem where childsensorid=pid limit 1 into pids;
    -- get seriesid to update series dates
    SELECT seriesid from sos.series where procedureid=pids into sids;
    -- insert new observations
    PERFORM sos.insertobservationfromCM($2,sids);
    -- update series dates
    PERFORM sos.updateseriesdates(sids);
    END;
$BODY$;

ALTER FUNCTION sos.insertprocedurecomponent(integer, integer)
    OWNER TO postgres;


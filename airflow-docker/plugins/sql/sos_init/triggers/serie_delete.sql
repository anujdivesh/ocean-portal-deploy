-- FUNCTION: sos.serie_delete()

-- DROP FUNCTION IF EXISTS sos.serie_delete();

CREATE OR REPLACE FUNCTION sos.serie_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	delete from export_operation where id_serie = OLD.id;
	delete from sos.series where procedureid in (select procedureid from sos.procedure where identifier like OLD.libelle||'%');
	delete from sos.procedure where identifier like OLD.libelle||'%';
	RETURN OLD;
END;
$BODY$;

ALTER FUNCTION sos.serie_delete()
    OWNER TO postgres;

CREATE TRIGGER serie_delete
    BEFORE DELETE
    ON public.serie
    FOR EACH ROW
    EXECUTE PROCEDURE sos.serie_delete();

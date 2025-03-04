-- Table: sos.procedure

-- DROP TABLE IF EXISTS sos.procedure;

CREATE TABLE IF NOT EXISTS sos.procedure
(
    procedureid bigint NOT NULL,
    hibernatediscriminator character(1) COLLATE pg_catalog."default" NOT NULL,
    proceduredescriptionformatid bigint NOT NULL,
    identifier character varying(255) COLLATE pg_catalog."default" NOT NULL,
    codespace bigint,
    name character varying(255) COLLATE pg_catalog."default",
    codespacename bigint,
    description character varying(255) COLLATE pg_catalog."default",
    deleted character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'F'::bpchar,
    disabled character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'F'::bpchar,
    descriptionfile text COLLATE pg_catalog."default",
    referenceflag character(1) COLLATE pg_catalog."default" DEFAULT 'F'::bpchar,
    CONSTRAINT procedure_pkey PRIMARY KEY (procedureid),
    CONSTRAINT procidentifieruk UNIQUE (identifier),
    CONSTRAINT proccodespaceidentifierfk FOREIGN KEY (codespace)
        REFERENCES sos.codespace (codespaceid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT proccodespacenamefk FOREIGN KEY (codespacename)
        REFERENCES sos.codespace (codespaceid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT procprocdescformatfk FOREIGN KEY (proceduredescriptionformatid)
        REFERENCES sos.proceduredescriptionformat (proceduredescriptionformatid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT procedure_referenceflag_check CHECK (referenceflag = ANY (ARRAY['T'::bpchar, 'F'::bpchar])),
    CONSTRAINT procedure_disabled_check CHECK (disabled = ANY (ARRAY['T'::bpchar, 'F'::bpchar])),
    CONSTRAINT procedure_deleted_check CHECK (deleted = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.procedure
    OWNER to postgres;
COMMENT ON TABLE sos.procedure
    IS 'Table to store the procedure/sensor. Mapping file: mapping/core/Procedure.hbm.xml';

COMMENT ON COLUMN sos.procedure.procedureid
    IS 'Table primary key, used for relations';

COMMENT ON COLUMN sos.procedure.proceduredescriptionformatid
    IS 'Relation/foreign key to the procedureDescriptionFormat table. Describes the format of the procedure description.';

COMMENT ON COLUMN sos.procedure.identifier
    IS 'The identifier of the procedure, gml:identifier. Used as parameter for queries. Unique';

COMMENT ON COLUMN sos.procedure.codespace
    IS 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';

COMMENT ON COLUMN sos.procedure.name
    IS 'The name of the procedure, gml:name. Optional';

COMMENT ON COLUMN sos.procedure.codespacename
    IS 'Relation/foreign key to the codespace table. Contains the gml:name codespace. Optional';

COMMENT ON COLUMN sos.procedure.description
    IS 'Description of the procedure, gml:description. Optional';

COMMENT ON COLUMN sos.procedure.deleted
    IS 'Flag to indicate that this procedure is deleted or not (OGC SWES 2.0 - DeleteSensor operation)';

COMMENT ON COLUMN sos.procedure.disabled
    IS 'For later use by the SOS. Indicator if this procedure should not be provided by the SOS.';

COMMENT ON COLUMN sos.procedure.descriptionfile
    IS 'Field for full (XML) encoded procedure description or link to a procedure description file. Optional';

COMMENT ON COLUMN sos.procedure.referenceflag
    IS 'Flag to indicate that this procedure is a reference procedure of another procedure. Not used by the SOS but by the Sensor Web REST-API';

-- Trigger: procedure_delete

DROP TRIGGER IF EXISTS procedure_delete ON sos.procedure;

CREATE TRIGGER procedure_delete
    BEFORE DELETE
    ON sos.procedure
    FOR EACH ROW
    EXECUTE PROCEDURE sos.procedure_delete();

CREATE SEQUENCE IF NOT EXISTS sos.procedureid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.procedureid_seq
    OWNER TO postgres;

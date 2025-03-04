-- Table: sos.validproceduretime

-- DROP TABLE IF EXISTS sos.validproceduretime;

CREATE TABLE IF NOT EXISTS sos.validproceduretime
(
    validproceduretimeid bigint NOT NULL,
    procedureid bigint NOT NULL,
    proceduredescriptionformatid bigint NOT NULL,
    starttime timestamp without time zone NOT NULL,
    endtime timestamp without time zone,
    descriptionxml text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT validproceduretime_pkey PRIMARY KEY (validproceduretimeid),
    CONSTRAINT validproceduretimeprocedurefk FOREIGN KEY (procedureid)
        REFERENCES sos.procedure (procedureid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT validprocprocdescformatfk FOREIGN KEY (proceduredescriptionformatid)
        REFERENCES sos.proceduredescriptionformat (proceduredescriptionformatid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.validproceduretime
    OWNER to postgres;
COMMENT ON TABLE sos.validproceduretime
    IS 'Table to store procedure descriptions which were inserted or updated via the transactional Profile. Mapping file: mapping/transactionl/ValidProcedureTime.hbm.xml';

COMMENT ON COLUMN sos.validproceduretime.validproceduretimeid
    IS 'Table primary key';

COMMENT ON COLUMN sos.validproceduretime.procedureid
    IS 'Foreign Key (FK) to the related procedure. Contains "procedure".procedureid';

COMMENT ON COLUMN sos.validproceduretime.proceduredescriptionformatid
    IS 'Foreign Key (FK) to the related procedureDescriptionFormat. Contains "procedureDescriptionFormat".procedureDescriptionFormatid';

COMMENT ON COLUMN sos.validproceduretime.starttime
    IS 'Timestamp since this procedure description is valid';

COMMENT ON COLUMN sos.validproceduretime.endtime
    IS 'Timestamp since this procedure description is invalid';

COMMENT ON COLUMN sos.validproceduretime.descriptionxml
    IS 'Procedure description as XML string';
-- Index: validproceduretimeendtimeidx

-- DROP INDEX IF EXISTS sos.validproceduretimeendtimeidx;

CREATE INDEX IF NOT EXISTS validproceduretimeendtimeidx
    ON sos.validproceduretime USING btree
    (endtime ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: validproceduretimestarttimeidx

-- DROP INDEX IF EXISTS sos.validproceduretimestarttimeidx;

CREATE INDEX IF NOT EXISTS validproceduretimestarttimeidx
    ON sos.validproceduretime USING btree
    (starttime ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE SEQUENCE IF NOT EXISTS sos.validproceduretimeid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.validproceduretimeid_seq
    OWNER TO postgres;

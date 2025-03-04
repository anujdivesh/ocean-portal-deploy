-- Table: sos.proceduredescriptionformat

-- DROP TABLE IF EXISTS sos.proceduredescriptionformat;

CREATE TABLE IF NOT EXISTS sos.proceduredescriptionformat
(
    proceduredescriptionformatid bigint NOT NULL,
    proceduredescriptionformat character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT proceduredescriptionformat_pkey PRIMARY KEY (proceduredescriptionformatid),
    CONSTRAINT procdescformatuk UNIQUE (proceduredescriptionformat)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.proceduredescriptionformat
    OWNER to postgres;
COMMENT ON TABLE sos.proceduredescriptionformat
    IS 'Table to store the ProcedureDescriptionFormat information of procedures. Mapping file: mapping/core/ProcedureDescriptionFormat.hbm.xml';

COMMENT ON COLUMN sos.proceduredescriptionformat.proceduredescriptionformatid
    IS 'Table primary key, used for relations';

COMMENT ON COLUMN sos.proceduredescriptionformat.proceduredescriptionformat
    IS 'The procedureDescriptionFormat value, e.g. http://www.opengis.net/sensorML/1.0.1 for procedures descriptions as specified in OGC SensorML 1.0.1';

CREATE SEQUENCE IF NOT EXISTS sos.procdescformatid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.procdescformatid_seq
    OWNER TO postgres;

INSERT INTO sos.proceduredescriptionformat(proceduredescriptionformatid, proceduredescriptionformat) 
SELECT 1, 'http://www.opengis.net/sensorML/1.0.1'
 FROM centre
  WHERE NOT EXISTS (SELECT 1 FROM sos.proceduredescriptionformat WHERE proceduredescriptionformatid=1)
  LIMIT 1;


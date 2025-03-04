-- Table: sos.observationtype

-- DROP TABLE IF EXISTS sos.observationtype;

CREATE TABLE IF NOT EXISTS sos.observationtype
(
    observationtypeid bigint NOT NULL,
    observationtype character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT observationtype_pkey PRIMARY KEY (observationtypeid),
    CONSTRAINT observationtypeuk UNIQUE (observationtype)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.observationtype
    OWNER to postgres;
COMMENT ON TABLE sos.observationtype
    IS 'Table to store the observationTypes. Mapping file: mapping/core/ObservationType.hbm.xml';

COMMENT ON COLUMN sos.observationtype.observationtypeid
    IS 'Table primary key, used for relations';

COMMENT ON COLUMN sos.observationtype.observationtype
    IS 'The observationType value, e.g. http://www.opengis.net/def/observationType/OGC-OM/2.0/OM_Measurement (OGC OM 2.0 specification) for OM_Measurement';

CREATE SEQUENCE IF NOT EXISTS sos.observationtypeid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.observationtypeid_seq
    OWNER TO postgres;

INSERT INTO sos.observationtype(observationtypeid, observationtype) 
SELECT 1, 'http://www.opengis.net/def/observationType/OGC-OM/2.0/OM_Measurement'
  FROM centre
  WHERE NOT EXISTS (SELECT 1 FROM sos.observationtype WHERE observationtypeid=1)
  LIMIT 1;

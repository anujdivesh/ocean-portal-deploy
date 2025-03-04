-- Table: sos.parameter

-- DROP TABLE IF EXISTS sos.parameter;

CREATE TABLE IF NOT EXISTS sos.parameter
(
    parameterid bigint NOT NULL,
    observationid bigint NOT NULL,
    definition character varying(255) COLLATE pg_catalog."default" NOT NULL,
    title character varying(255) COLLATE pg_catalog."default",
    value oid NOT NULL,
    CONSTRAINT parameter_pkey PRIMARY KEY (parameterid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.parameter
    OWNER to postgres;
COMMENT ON TABLE sos.parameter
    IS 'NOT YET USED! Table to store additional obervation information (om:parameter). Mapping file: mapping/transactional/Parameter.hbm.xml';

COMMENT ON COLUMN sos.parameter.parameterid
    IS 'Table primary key';

COMMENT ON COLUMN sos.parameter.observationid
    IS 'Foreign Key (FK) to the related observation. Contains "observation".observationid';

COMMENT ON COLUMN sos.parameter.definition
    IS 'Definition of the additional information';

COMMENT ON COLUMN sos.parameter.title
    IS 'optional title of the additional information. Optional';

COMMENT ON COLUMN sos.parameter.value
    IS 'Value of the additional information';

CREATE SEQUENCE IF NOT EXISTS sos.parameterid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.parameterid_seq
    OWNER TO postgres;

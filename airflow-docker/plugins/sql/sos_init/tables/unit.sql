-- Table: sos.unit

-- DROP TABLE IF EXISTS sos.unit;

CREATE TABLE IF NOT EXISTS sos.unit
(
    unitid bigint NOT NULL,
    unit character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT unit_pkey PRIMARY KEY (unitid),
    CONSTRAINT unituk UNIQUE (unit)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.unit
    OWNER to postgres;
COMMENT ON TABLE sos.unit
    IS 'Table to store the unit of measure information, used in observations. Mapping file: mapping/core/Unit.hbm.xml';

COMMENT ON COLUMN sos.unit.unitid
    IS 'Table primary key, used for relations';

COMMENT ON COLUMN sos.unit.unit
    IS 'The unit of measure of observations. See http://unitsofmeasure.org/ucum.html';

CREATE SEQUENCE IF NOT EXISTS sos.unitid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.unitid_seq
    OWNER TO postgres;

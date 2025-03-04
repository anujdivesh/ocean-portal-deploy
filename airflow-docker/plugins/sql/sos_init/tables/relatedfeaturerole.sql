-- Table: sos.relatedfeaturerole

-- DROP TABLE IF EXISTS sos.relatedfeaturerole;

CREATE TABLE IF NOT EXISTS sos.relatedfeaturerole
(
    relatedfeatureroleid bigint NOT NULL,
    relatedfeaturerole character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT relatedfeaturerole_pkey PRIMARY KEY (relatedfeatureroleid),
    CONSTRAINT relfeatroleuk UNIQUE (relatedfeaturerole)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.relatedfeaturerole
    OWNER to postgres;
COMMENT ON TABLE sos.relatedfeaturerole
    IS 'Table to store related feature role information used in the OGC SOS 2.0 Capabilities (See also OGC SWES 2.0). Mapping file: mapping/transactionl/RelatedFeatureRole.hbm.xml';

COMMENT ON COLUMN sos.relatedfeaturerole.relatedfeatureroleid
    IS 'Table primary key, used for relations';

COMMENT ON COLUMN sos.relatedfeaturerole.relatedfeaturerole
    IS 'The related feature role definition. See OGC SWES 2.0 specification';

CREATE SEQUENCE IF NOT EXISTS sos.relatedfeatureroleid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.relatedfeatureroleid_seq
    OWNER TO postgres;

INSERT INTO sos.relatedfeaturerole(relatedfeatureroleid, relatedfeaturerole) 
SELECT 1, 'http://www.opengis.net/def/nil/OGC/0/unknown'
  FROM centre
  WHERE NOT EXISTS (SELECT 1 FROM sos.relatedfeaturerole WHERE relatedfeatureroleid=1)
  LIMIT 1;


-- Table: sos.codespace

-- DROP TABLE IF EXISTS sos.codespace;

CREATE TABLE IF NOT EXISTS sos.codespace
(
    codespaceid bigint NOT NULL,
    codespace character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT codespace_pkey PRIMARY KEY (codespaceid),
    CONSTRAINT codespaceuk UNIQUE (codespace)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.codespace
    OWNER to postgres;
COMMENT ON TABLE sos.codespace
    IS 'Table to store the gml:identifier and gml:name codespace information. Mapping file: mapping/core/Codespace.hbm.xml';

COMMENT ON COLUMN sos.codespace.codespaceid
    IS 'Table primary key, used for relations';

COMMENT ON COLUMN sos.codespace.codespace
    IS 'The codespace value';

CREATE SEQUENCE IF NOT EXISTS sos.codespaceid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.codespaceid_seq
    OWNER TO postgres;

INSERT INTO sos.codespace(codespaceid, codespace) 
SELECT 1, 'http://www.opengis.net/def/nil/OGC/0/unknown'
  FROM centre 
  WHERE NOT EXISTS (SELECT 1 FROM sos.codespace WHERE codespaceid=1)
  LIMIT 1;

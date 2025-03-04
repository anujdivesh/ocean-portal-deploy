-- Table: sos.offering

-- DROP TABLE IF EXISTS sos.offering;

CREATE TABLE IF NOT EXISTS sos.offering
(
    offeringid bigint NOT NULL,
    hibernatediscriminator character(1) COLLATE pg_catalog."default" NOT NULL,
    identifier character varying(255) COLLATE pg_catalog."default" NOT NULL,
    codespace bigint,
    name character varying(255) COLLATE pg_catalog."default",
    codespacename bigint,
    description character varying(255) COLLATE pg_catalog."default",
    disabled character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'F'::bpchar,
    CONSTRAINT offering_pkey PRIMARY KEY (offeringid),
    CONSTRAINT offidentifieruk UNIQUE (identifier),
    CONSTRAINT offcodespaceidentifierfk FOREIGN KEY (codespace)
        REFERENCES sos.codespace (codespaceid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT offcodespacenamefk FOREIGN KEY (codespacename)
        REFERENCES sos.codespace (codespaceid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT offering_disabled_check CHECK (disabled = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.offering
    OWNER to postgres;
COMMENT ON TABLE sos.offering
    IS 'Table to store the offering information. Mapping file: mapping/core/Offering.hbm.xml';

COMMENT ON COLUMN sos.offering.offeringid
    IS 'Table primary key, used for relations';

COMMENT ON COLUMN sos.offering.identifier
    IS 'The identifier of the offering, gml:identifier. Used as parameter for queries. Unique';

COMMENT ON COLUMN sos.offering.codespace
    IS 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';

COMMENT ON COLUMN sos.offering.name
    IS 'The name of the offering, gml:name. If available, displyed in the contents of the Capabilites. Optional';

COMMENT ON COLUMN sos.offering.codespacename
    IS 'Relation/foreign key to the codespace table. Contains the gml:name codespace. Optional';

COMMENT ON COLUMN sos.offering.description
    IS 'Description of the offering, gml:description. Optional';

COMMENT ON COLUMN sos.offering.disabled
    IS 'For later use by the SOS. Indicator if this offering should not be provided by the SOS.';

CREATE SEQUENCE IF NOT EXISTS sos.offeringid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.offeringid_seq
    OWNER TO postgres;

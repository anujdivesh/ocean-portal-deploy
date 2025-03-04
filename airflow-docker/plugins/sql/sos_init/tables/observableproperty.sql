-- Table: sos.observableproperty

-- DROP TABLE IF EXISTS sos.observableproperty;

CREATE TABLE IF NOT EXISTS sos.observableproperty
(
    observablepropertyid bigint NOT NULL,
    hibernatediscriminator character(1) COLLATE pg_catalog."default" NOT NULL,
    identifier character varying(255) COLLATE pg_catalog."default" NOT NULL,
    codespace bigint,
    name character varying(255) COLLATE pg_catalog."default",
    codespacename bigint,
    description character varying(255) COLLATE pg_catalog."default",
    disabled character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'F'::bpchar,
    CONSTRAINT observableproperty_pkey PRIMARY KEY (observablepropertyid),
    CONSTRAINT obspropidentifieruk UNIQUE (identifier),
    CONSTRAINT obspropcodespaceidentifierfk FOREIGN KEY (codespace)
        REFERENCES sos.codespace (codespaceid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT obspropcodespacenamefk FOREIGN KEY (codespacename)
        REFERENCES sos.codespace (codespaceid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT observableproperty_disabled_check CHECK (disabled = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.observableproperty
    OWNER to postgres;
COMMENT ON TABLE sos.observableproperty
    IS 'Table to store the ObservedProperty/Phenomenon information. Mapping file: mapping/core/ObservableProperty.hbm.xml';

COMMENT ON COLUMN sos.observableproperty.observablepropertyid
    IS 'Table primary key, used for relations';

COMMENT ON COLUMN sos.observableproperty.identifier
    IS 'The identifier of the observableProperty, gml:identifier. Used as parameter for queries. Unique';

COMMENT ON COLUMN sos.observableproperty.codespace
    IS 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';

COMMENT ON COLUMN sos.observableproperty.name
    IS 'The name of the observableProperty, gml:name. Optional';

COMMENT ON COLUMN sos.observableproperty.codespacename
    IS 'Relation/foreign key to the codespace table. Contains the gml:name codespace. Optional';

COMMENT ON COLUMN sos.observableproperty.description
    IS 'Description of the observableProperty, gml:description. Optional';

COMMENT ON COLUMN sos.observableproperty.disabled
    IS 'For later use by the SOS. Indicator if this observableProperty should not be provided by the SOS.';

CREATE SEQUENCE IF NOT EXISTS sos.observablepropertyid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.observablepropertyid_seq
    OWNER TO postgres;

-- Table: sos.featureofinterest

-- DROP TABLE IF EXISTS sos.featureofinterest;

CREATE TABLE IF NOT EXISTS sos.featureofinterest
(
    featureofinterestid bigint NOT NULL,
    hibernatediscriminator character(1) COLLATE pg_catalog."default" NOT NULL,
    featureofinteresttypeid bigint NOT NULL,
    identifier character varying(255) COLLATE pg_catalog."default",
    codespace bigint,
    name character varying(255) COLLATE pg_catalog."default",
    codespacename bigint,
    description character varying(255) COLLATE pg_catalog."default",
    geom geometry(Point,4326),
    descriptionxml text COLLATE pg_catalog."default",
    url character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT featureofinterest_pkey PRIMARY KEY (featureofinterestid),
    CONSTRAINT featureurl UNIQUE (url),
    CONSTRAINT foiidentifieruk UNIQUE (identifier),
    CONSTRAINT featurecodespaceidentifierfk FOREIGN KEY (codespace)
        REFERENCES sos.codespace (codespaceid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT featurecodespacenamefk FOREIGN KEY (codespacename)
        REFERENCES sos.codespace (codespaceid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT featurefeaturetypefk FOREIGN KEY (featureofinteresttypeid)
        REFERENCES sos.featureofinteresttype (featureofinteresttypeid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.featureofinterest
    OWNER to postgres;
COMMENT ON TABLE sos.featureofinterest
    IS 'Table to store the FeatureOfInterest information. Mapping file: mapping/core/FeatureOfInterest.hbm.xml';

COMMENT ON COLUMN sos.featureofinterest.featureofinterestid
    IS 'Table primary key, used for relations';

COMMENT ON COLUMN sos.featureofinterest.featureofinteresttypeid
    IS 'Relation/foreign key to the featureOfInterestType table. Describes the type of the featureOfInterest. Contains "featureOfInterestType".featureOfInterestTypeId';

COMMENT ON COLUMN sos.featureofinterest.identifier
    IS 'The identifier of the featureOfInterest, gml:identifier. Used as parameter for queries. Optional but unique';

COMMENT ON COLUMN sos.featureofinterest.codespace
    IS 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';

COMMENT ON COLUMN sos.featureofinterest.name
    IS 'The name of the featureOfInterest, gml:name. Optional';

COMMENT ON COLUMN sos.featureofinterest.codespacename
    IS 'The name of the featureOfInterest, gml:name. Optional';

COMMENT ON COLUMN sos.featureofinterest.description
    IS 'Description of the featureOfInterest, gml:description. Optional';

COMMENT ON COLUMN sos.featureofinterest.geom
    IS 'The geometry of the featureOfInterest (composed of the “latitude” and “longitude”) . Optional';

COMMENT ON COLUMN sos.featureofinterest.descriptionxml
    IS 'XML description of the feature, used when transactional profile is supported . Optional';

COMMENT ON COLUMN sos.featureofinterest.url
    IS 'Reference URL to the feature if it is stored in another service, e.g. WFS. Optional but unique';


CREATE SEQUENCE IF NOT EXISTS sos.featureofinterestid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.featureofinterestid_seq
    OWNER TO postgres;

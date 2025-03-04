-- Table: sos.featureofinteresttype

-- DROP TABLE IF EXISTS sos.featureofinteresttype;

CREATE TABLE IF NOT EXISTS sos.featureofinteresttype
(
    featureofinteresttypeid bigint NOT NULL,
    featureofinteresttype character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT featureofinteresttype_pkey PRIMARY KEY (featureofinteresttypeid),
    CONSTRAINT featuretypeuk UNIQUE (featureofinteresttype)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.featureofinteresttype
    OWNER to postgres;
COMMENT ON TABLE sos.featureofinteresttype
    IS 'Table to store the FeatureOfInterestType information. Mapping file: mapping/core/FeatureOfInterestType.hbm.xml';

COMMENT ON COLUMN sos.featureofinteresttype.featureofinteresttypeid
    IS 'Table primary key, used for relations';

COMMENT ON COLUMN sos.featureofinteresttype.featureofinteresttype
    IS 'The featureOfInterestType value, e.g. http://www.opengis.net/def/samplingFeatureType/OGC-OM/2.0/SF_SamplingPoint (OGC OM 2.0 specification) for point features';

CREATE SEQUENCE IF NOT EXISTS sos.featureofinteresttypeid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.featureofinteresttypeid_seq
    OWNER TO postgres;

INSERT INTO sos.featureofinteresttype(featureofinteresttypeid, featureofinteresttype) 
SELECT 1, 'http://www.opengis.net/def/samplingFeatureType/OGC-OM/2.0/SF_SamplingPoint' 
  FROM centre
  WHERE NOT EXISTS (SELECT 1 FROM sos.featureofinteresttype WHERE featureofinteresttypeid=1)
  LIMIT 1;

INSERT INTO sos.featureofinteresttype(featureofinteresttypeid, featureofinteresttype) 
SELECT 2, 'http://www.opengis.net/def/nil/OGC/0/unknown'
  FROM centre
  WHERE NOT EXISTS (SELECT 1 FROM sos.featureofinteresttype WHERE featureofinteresttypeid=2)
  LIMIT 1;

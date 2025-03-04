-- Table: sos.relatedfeature

-- DROP TABLE IF EXISTS sos.relatedfeature;

CREATE TABLE IF NOT EXISTS sos.relatedfeature
(
    relatedfeatureid bigint NOT NULL,
    featureofinterestid bigint NOT NULL,
    CONSTRAINT relatedfeature_pkey PRIMARY KEY (relatedfeatureid),
    CONSTRAINT relatedfeaturefeaturefk FOREIGN KEY (featureofinterestid)
        REFERENCES sos.featureofinterest (featureofinterestid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.relatedfeature
    OWNER to postgres;
COMMENT ON TABLE sos.relatedfeature
    IS 'Table to store related feature information used in the OGC SOS 2.0 Capabilities (See also OGC SWES 2.0). Mapping file: mapping/transactionl/RelatedFeature.hbm.xml';

COMMENT ON COLUMN sos.relatedfeature.relatedfeatureid
    IS 'Table primary key, used for relations';

COMMENT ON COLUMN sos.relatedfeature.featureofinterestid
    IS 'Foreign Key (FK) to the related featureOfInterest. Contains "featureOfInterest".featureOfInterestid';

CREATE SEQUENCE IF NOT EXISTS sos.relatedfeatureid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.relatedfeatureid_seq
    OWNER TO postgres;

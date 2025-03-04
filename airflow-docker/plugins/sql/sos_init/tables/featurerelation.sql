-- Table: sos.featurerelation

-- DROP TABLE IF EXISTS sos.featurerelation;

CREATE TABLE IF NOT EXISTS sos.featurerelation
(
    parentfeatureid bigint NOT NULL,
    childfeatureid bigint NOT NULL,
    CONSTRAINT featurerelation_pkey PRIMARY KEY (childfeatureid, parentfeatureid),
    CONSTRAINT featureofinterestchildfk FOREIGN KEY (childfeatureid)
        REFERENCES sos.featureofinterest (featureofinterestid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT featureofinterestparentfk FOREIGN KEY (parentfeatureid)
        REFERENCES sos.featureofinterest (featureofinterestid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.featurerelation
    OWNER to postgres;
COMMENT ON TABLE sos.featurerelation
    IS 'Relation table to store feature hierarchies. E.g. define a parent in a query and all childs are also contained in the response. Mapping file: mapping/transactional/TFeatureOfInterest.hbm.xml';

COMMENT ON COLUMN sos.featurerelation.parentfeatureid
    IS 'Foreign Key (FK) to the related parent featureOfInterest. Contains "featureOfInterest".featureOfInterestid';

COMMENT ON COLUMN sos.featurerelation.childfeatureid
    IS 'Foreign Key (FK) to the related child featureOfInterest. Contains "featureOfInterest".featureOfInterestid';

-- Table: sos.offeringhasrelatedfeature

-- DROP TABLE IF EXISTS sos.offeringhasrelatedfeature;

CREATE TABLE IF NOT EXISTS sos.offeringhasrelatedfeature
(
    relatedfeatureid bigint NOT NULL,
    offeringid bigint NOT NULL,
    CONSTRAINT offeringhasrelatedfeature_pkey PRIMARY KEY (offeringid, relatedfeatureid),
    CONSTRAINT offeringrelatedfeaturefk FOREIGN KEY (relatedfeatureid)
        REFERENCES sos.relatedfeature (relatedfeatureid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT relatedfeatureofferingfk FOREIGN KEY (offeringid)
        REFERENCES sos.offering (offeringid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.offeringhasrelatedfeature
    OWNER to postgres;
COMMENT ON TABLE sos.offeringhasrelatedfeature
    IS 'Table to store relations between offering and associated relatedFeatures. Mapping file: mapping/transactional/TOffering.hbm.xml';

COMMENT ON COLUMN sos.offeringhasrelatedfeature.relatedfeatureid
    IS 'Foreign Key (FK) to the related relatedFeature. Contains "relatedFeature".relatedFeatureid';

COMMENT ON COLUMN sos.offeringhasrelatedfeature.offeringid
    IS 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';

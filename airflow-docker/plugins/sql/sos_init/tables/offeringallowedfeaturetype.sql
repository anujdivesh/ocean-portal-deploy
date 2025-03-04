-- Table: sos.offeringallowedfeaturetype

-- DROP TABLE IF EXISTS sos.offeringallowedfeaturetype;

CREATE TABLE IF NOT EXISTS sos.offeringallowedfeaturetype
(
    offeringid bigint NOT NULL,
    featureofinteresttypeid bigint NOT NULL,
    CONSTRAINT offeringallowedfeaturetype_pkey PRIMARY KEY (offeringid, featureofinteresttypeid),
    CONSTRAINT fk_6vvrdxvd406n48gkm706ow1pt FOREIGN KEY (offeringid)
        REFERENCES sos.offering (offeringid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT offeringfeaturetypefk FOREIGN KEY (featureofinteresttypeid)
        REFERENCES sos.featureofinteresttype (featureofinteresttypeid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.offeringallowedfeaturetype
    OWNER to postgres;
COMMENT ON TABLE sos.offeringallowedfeaturetype
    IS 'Table to store relations between offering and allowed featureOfInterestTypes, defined in InsertSensor request. Mapping file: mapping/transactional/TOffering.hbm.xml';

COMMENT ON COLUMN sos.offeringallowedfeaturetype.offeringid
    IS 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';

COMMENT ON COLUMN sos.offeringallowedfeaturetype.featureofinteresttypeid
    IS 'Foreign Key (FK) to the related featureOfInterestTypeId. Contains "featureOfInterestType".featureOfInterestTypeId';

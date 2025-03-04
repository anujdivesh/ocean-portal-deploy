-- Table: sos.relatedfeaturehasrole

-- DROP TABLE IF EXISTS sos.relatedfeaturehasrole;

CREATE TABLE IF NOT EXISTS sos.relatedfeaturehasrole
(
    relatedfeatureid bigint NOT NULL,
    relatedfeatureroleid bigint NOT NULL,
    CONSTRAINT relatedfeaturehasrole_pkey PRIMARY KEY (relatedfeatureid, relatedfeatureroleid),
    CONSTRAINT fk_6ynwkk91xe8p1uibmjt98sog3 FOREIGN KEY (relatedfeatureid)
        REFERENCES sos.relatedfeature (relatedfeatureid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT relatedfeatrelatedfeatrolefk FOREIGN KEY (relatedfeatureroleid)
        REFERENCES sos.relatedfeaturerole (relatedfeatureroleid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.relatedfeaturehasrole
    OWNER to postgres;
COMMENT ON TABLE sos.relatedfeaturehasrole
    IS 'Relation table to store relatedFeatures and their associated relatedFeatureRoles. Mapping file: mapping/transactionl/RelatedFeature.hbm.xml';

COMMENT ON COLUMN sos.relatedfeaturehasrole.relatedfeatureid
    IS 'Foreign Key (FK) to the related relatedFeature. Contains "relatedFeature".relatedFeatureid';

COMMENT ON COLUMN sos.relatedfeaturehasrole.relatedfeatureroleid
    IS 'Foreign Key (FK) to the related relatedFeatureRole. Contains "relatedFeatureRole".relatedFeatureRoleid';

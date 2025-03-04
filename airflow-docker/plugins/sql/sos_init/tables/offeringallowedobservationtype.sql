-- Table: sos.offeringallowedobservationtype

-- DROP TABLE IF EXISTS sos.offeringallowedobservationtype;

CREATE TABLE IF NOT EXISTS sos.offeringallowedobservationtype
(
    offeringid bigint NOT NULL,
    observationtypeid bigint NOT NULL,
    CONSTRAINT offeringallowedobservationtype_pkey PRIMARY KEY (offeringid, observationtypeid),
    CONSTRAINT fk_lkljeohulvu7cr26pduyp5bd0 FOREIGN KEY (offeringid)
        REFERENCES sos.offering (offeringid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT offeringobservationtypefk FOREIGN KEY (observationtypeid)
        REFERENCES sos.observationtype (observationtypeid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.offeringallowedobservationtype
    OWNER to postgres;
COMMENT ON TABLE sos.offeringallowedobservationtype
    IS 'Table to store relations between offering and allowed observationTypes, defined in InsertSensor request. Mapping file: mapping/transactional/TOffering.hbm.xml';

COMMENT ON COLUMN sos.offeringallowedobservationtype.offeringid
    IS 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';

COMMENT ON COLUMN sos.offeringallowedobservationtype.observationtypeid
    IS 'Foreign Key (FK) to the related observationType. Contains "observationType".observationTypeId';

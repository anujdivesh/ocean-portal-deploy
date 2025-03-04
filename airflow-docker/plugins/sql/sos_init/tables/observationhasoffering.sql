-- Table: sos.observationhasoffering

-- DROP TABLE IF EXISTS sos.observationhasoffering;

CREATE TABLE IF NOT EXISTS sos.observationhasoffering
(
    observationid bigint NOT NULL,
    offeringid bigint NOT NULL,
    CONSTRAINT observationhasoffering_pkey PRIMARY KEY (observationid, offeringid),
    CONSTRAINT fk_9ex7hawh3dbplkllmw5w3kvej FOREIGN KEY (observationid)
        REFERENCES sos.observation (observationid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT observationofferingfk FOREIGN KEY (offeringid)
        REFERENCES sos.offering (offeringid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.observationhasoffering
    OWNER to postgres;
COMMENT ON TABLE sos.observationhasoffering
    IS 'Table to store relations between observation and associated offerings. Mapping file: mapping/ereporting/EReportingObservation.hbm.xml';

COMMENT ON COLUMN sos.observationhasoffering.observationid
    IS 'Foreign Key (FK) to the related observation. Contains "observation".oobservationid';

COMMENT ON COLUMN sos.observationhasoffering.offeringid
    IS 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';
-- Index: obshasoffobservationidx

-- DROP INDEX IF EXISTS sos.obshasoffobservationidx;

CREATE INDEX IF NOT EXISTS obshasoffobservationidx
    ON sos.observationhasoffering USING btree
    (observationid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: obshasoffofferingidx

-- DROP INDEX IF EXISTS sos.obshasoffofferingidx;

CREATE INDEX IF NOT EXISTS obshasoffofferingidx
    ON sos.observationhasoffering USING btree
    (offeringid ASC NULLS LAST)
    TABLESPACE pg_default;

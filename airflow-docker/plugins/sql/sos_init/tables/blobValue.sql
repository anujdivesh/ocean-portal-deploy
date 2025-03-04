-- Table: sos.blobvalue

-- DROP TABLE IF EXISTS sos.blobvalue;

CREATE TABLE IF NOT EXISTS sos.blobvalue
(
    observationid bigint NOT NULL,
    value oid,
    CONSTRAINT blobvalue_pkey PRIMARY KEY (observationid),
    CONSTRAINT observationblobvaluefk FOREIGN KEY (observationid)
        REFERENCES sos.observation (observationid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.blobvalue
    OWNER to postgres;
COMMENT ON TABLE sos.blobvalue
    IS 'Value table for blob observation';

COMMENT ON COLUMN sos.blobvalue.observationid
    IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';

COMMENT ON COLUMN sos.blobvalue.value
    IS 'Blob observation value';

-- Table: sos.swedataarrayvalue

-- DROP TABLE IF EXISTS sos.swedataarrayvalue;

CREATE TABLE IF NOT EXISTS sos.swedataarrayvalue
(
    observationid bigint NOT NULL,
    value text COLLATE pg_catalog."default",
    CONSTRAINT swedataarrayvalue_pkey PRIMARY KEY (observationid),
    CONSTRAINT observationswedataarrayvaluefk FOREIGN KEY (observationid)
        REFERENCES sos.observation (observationid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.swedataarrayvalue
    OWNER to postgres;
COMMENT ON TABLE sos.swedataarrayvalue
    IS 'Value table for SweDataArray observation';

COMMENT ON COLUMN sos.swedataarrayvalue.observationid
    IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';

COMMENT ON COLUMN sos.swedataarrayvalue.value
    IS 'SweDataArray observation value';

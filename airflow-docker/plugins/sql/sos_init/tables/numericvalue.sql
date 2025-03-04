-- Table: sos.numericvalue

-- DROP TABLE IF EXISTS sos.numericvalue;

CREATE TABLE IF NOT EXISTS sos.numericvalue
(
    observationid bigint NOT NULL,
    value double precision,
    CONSTRAINT numericvalue_pkey PRIMARY KEY (observationid),
    CONSTRAINT observationnumericvaluefk FOREIGN KEY (observationid)
        REFERENCES sos.observation (observationid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.numericvalue
    OWNER to postgres;
COMMENT ON TABLE sos.numericvalue
    IS 'Value table for numeric/Measurment observation';

COMMENT ON COLUMN sos.numericvalue.observationid
    IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';

COMMENT ON COLUMN sos.numericvalue.value
    IS 'Numeric/Measurment observation value';

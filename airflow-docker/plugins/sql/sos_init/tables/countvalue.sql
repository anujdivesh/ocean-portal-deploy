-- Table: sos.countvalue

-- DROP TABLE IF EXISTS sos.countvalue;

CREATE TABLE IF NOT EXISTS sos.countvalue
(
    observationid bigint NOT NULL,
    value integer,
    CONSTRAINT countvalue_pkey PRIMARY KEY (observationid),
    CONSTRAINT observationcountvaluefk FOREIGN KEY (observationid)
        REFERENCES sos.observation (observationid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.countvalue
    OWNER to postgres;
COMMENT ON TABLE sos.countvalue
    IS 'Value table for count observation';

COMMENT ON COLUMN sos.countvalue.observationid
    IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';

COMMENT ON COLUMN sos.countvalue.value
    IS 'Count observation value';

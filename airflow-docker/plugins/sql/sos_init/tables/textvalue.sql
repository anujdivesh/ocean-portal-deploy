-- Table: sos.textvalue

-- DROP TABLE IF EXISTS sos.textvalue;

CREATE TABLE IF NOT EXISTS sos.textvalue
(
    observationid bigint NOT NULL,
    value text COLLATE pg_catalog."default",
    CONSTRAINT textvalue_pkey PRIMARY KEY (observationid),
    CONSTRAINT observationtextvaluefk FOREIGN KEY (observationid)
        REFERENCES sos.observation (observationid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.textvalue
    OWNER to postgres;
COMMENT ON TABLE sos.textvalue
    IS 'Value table for text observation';

COMMENT ON COLUMN sos.textvalue.observationid
    IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';

COMMENT ON COLUMN sos.textvalue.value
    IS 'Text observation value';

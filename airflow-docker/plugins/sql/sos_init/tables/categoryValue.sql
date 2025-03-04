-- Table: sos.categoryvalue

-- DROP TABLE IF EXISTS sos.categoryvalue;

CREATE TABLE IF NOT EXISTS sos.categoryvalue
(
    observationid bigint NOT NULL,
    value character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT categoryvalue_pkey PRIMARY KEY (observationid),
    CONSTRAINT observationcategoryvaluefk FOREIGN KEY (observationid)
        REFERENCES sos.observation (observationid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.categoryvalue
    OWNER to postgres;
COMMENT ON TABLE sos.categoryvalue
    IS 'Value table for category observation';

COMMENT ON COLUMN sos.categoryvalue.observationid
    IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';

COMMENT ON COLUMN sos.categoryvalue.value
    IS 'Category observation value';

-- Table: sos.booleanvalue

-- DROP TABLE IF EXISTS sos.booleanvalue;

CREATE TABLE IF NOT EXISTS sos.booleanvalue
(
    observationid bigint NOT NULL,
    value character(1) COLLATE pg_catalog."default",
    CONSTRAINT booleanvalue_pkey PRIMARY KEY (observationid),
    CONSTRAINT observationbooleanvaluefk FOREIGN KEY (observationid)
        REFERENCES sos.observation (observationid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT booleanvalue_value_check1 CHECK (value = ANY (ARRAY['T'::bpchar, 'F'::bpchar])),
    CONSTRAINT booleanvalue_value_check CHECK (value = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.booleanvalue
    OWNER to postgres;
COMMENT ON TABLE sos.booleanvalue
    IS 'Value table for boolean observation';

COMMENT ON COLUMN sos.booleanvalue.observationid
    IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';

COMMENT ON COLUMN sos.booleanvalue.value
    IS 'Boolean observation value';

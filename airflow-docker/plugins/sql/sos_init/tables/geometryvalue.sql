-- Table: sos.geometryvalue

-- DROP TABLE IF EXISTS sos.geometryvalue;

CREATE TABLE IF NOT EXISTS sos.geometryvalue
(
    observationid bigint NOT NULL,
    value geometry(Point,4326),
    CONSTRAINT geometryvalue_pkey PRIMARY KEY (observationid),
    CONSTRAINT observationgeometryvaluefk FOREIGN KEY (observationid)
        REFERENCES sos.observation (observationid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.geometryvalue
    OWNER to postgres;
COMMENT ON TABLE sos.geometryvalue
    IS 'Value table for geometry observation';

COMMENT ON COLUMN sos.geometryvalue.observationid
    IS 'Foreign Key (FK) to the related observation from the observation table. Contains "observation".observationid';

COMMENT ON COLUMN sos.geometryvalue.value
    IS 'Geometry observation value';

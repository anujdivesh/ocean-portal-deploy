-- Table: sos.observation

-- DROP TABLE IF EXISTS sos.observation;

CREATE TABLE IF NOT EXISTS sos.observation
(
    observationid bigint NOT NULL,
    seriesid bigint NOT NULL,
    phenomenontimestart timestamp without time zone NOT NULL,
    phenomenontimeend timestamp without time zone NOT NULL,
    resulttime timestamp without time zone NOT NULL,
    identifier character varying(255) COLLATE pg_catalog."default",
    codespace bigint,
    name character varying(255) COLLATE pg_catalog."default",
    codespacename bigint,
    description character varying(255) COLLATE pg_catalog."default",
    deleted character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'F'::bpchar,
    validtimestart timestamp without time zone,
    validtimeend timestamp without time zone,
    unitid bigint,
    samplinggeometry geometry(Point,4326),
    CONSTRAINT observation_pkey PRIMARY KEY (observationid),
    CONSTRAINT obscodespaceidentifierfk FOREIGN KEY (codespace)
        REFERENCES sos.codespace (codespaceid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT obscodespacenamefk FOREIGN KEY (codespacename)
        REFERENCES sos.codespace (codespaceid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT observationseriesfk FOREIGN KEY (seriesid)
        REFERENCES sos.series (seriesid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT observationunitfk FOREIGN KEY (unitid)
        REFERENCES sos.unit (unitid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT observation_deleted_check CHECK (deleted = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.observation
    OWNER to postgres;
COMMENT ON TABLE sos.observation
    IS 'Stores the observations. Mapping file: mapping/series/observation/SeriesObservation.hbm.xml';

COMMENT ON COLUMN sos.observation.observationid
    IS 'Table primary key, used in relations';

COMMENT ON COLUMN sos.observation.seriesid
    IS 'Relation/foreign key to the associated series table. Contains "series".seriesId';

COMMENT ON COLUMN sos.observation.phenomenontimestart
    IS 'Time stamp when the observation was started or phenomenon was observed';

COMMENT ON COLUMN sos.observation.phenomenontimeend
    IS 'Time stamp when the observation was stopped or phenomenon was observed';

COMMENT ON COLUMN sos.observation.resulttime
    IS 'Time stamp when the observation was published or result was published/available';

COMMENT ON COLUMN sos.observation.identifier
    IS 'The identifier of the observation, gml:identifier. Used as parameter for queries. Optional but unique';

COMMENT ON COLUMN sos.observation.codespace
    IS 'Relation/foreign key to the codespace table. Contains the gml:identifier codespace. Optional';

COMMENT ON COLUMN sos.observation.name
    IS 'The name of the observation, gml:name. Optional';

COMMENT ON COLUMN sos.observation.codespacename
    IS 'The name of the observation, gml:name. Optional';

COMMENT ON COLUMN sos.observation.description
    IS 'Description of the observation, gml:description. Optional';

COMMENT ON COLUMN sos.observation.deleted
    IS 'Flag to indicate that this observation is deleted or not (OGC SWES 2.0 - DeleteSensor operation or not specified DeleteObservation)';

COMMENT ON COLUMN sos.observation.validtimestart
    IS 'Start time stamp for which the observation/result is valid, e.g. used for forecasting. Optional';

COMMENT ON COLUMN sos.observation.validtimeend
    IS 'End time stamp for which the observation/result is valid, e.g. used for forecasting. Optional';

COMMENT ON COLUMN sos.observation.unitid
    IS 'Foreign Key (FK) to the related unit of measure. Contains "unit".unitid. Optional';

COMMENT ON COLUMN sos.observation.samplinggeometry
    IS 'Sampling geometry describes exactly where the measurement has taken place. Used for OGC SOS 2.0 Spatial Filtering Profile. Optional';
-- Index: obsphentimeendidx

-- DROP INDEX IF EXISTS sos.obsphentimeendidx;

CREATE INDEX IF NOT EXISTS obsphentimeendidx
    ON sos.observation USING btree
    (phenomenontimeend ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: obsphentimestartidx

-- DROP INDEX IF EXISTS sos.obsphentimestartidx;

CREATE INDEX IF NOT EXISTS obsphentimestartidx
    ON sos.observation USING btree
    (phenomenontimestart ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: obsresulttimeidx

-- DROP INDEX IF EXISTS sos.obsresulttimeidx;

CREATE INDEX IF NOT EXISTS obsresulttimeidx
    ON sos.observation USING btree
    (resulttime ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: obsseriesidx

-- DROP INDEX IF EXISTS sos.obsseriesidx;

CREATE INDEX IF NOT EXISTS obsseriesidx
    ON sos.observation USING btree
    (seriesid ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE SEQUENCE IF NOT EXISTS sos.observationid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.observationid_seq
    OWNER TO postgres;

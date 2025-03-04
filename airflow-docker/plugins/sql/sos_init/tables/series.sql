-- Table: sos.series

-- DROP TABLE IF EXISTS sos.series;

CREATE TABLE IF NOT EXISTS sos.series
(
    seriesid bigint NOT NULL,
    featureofinterestid bigint NOT NULL,
    observablepropertyid bigint NOT NULL,
    procedureid bigint NOT NULL,
    offeringid bigint,
    deleted character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'F'::bpchar,
    published character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'T'::bpchar,
    firsttimestamp timestamp without time zone,
    lasttimestamp timestamp without time zone,
    firstnumericvalue double precision,
    lastnumericvalue double precision,
    unitid bigint,
    CONSTRAINT series_pkey PRIMARY KEY (seriesid),
    CONSTRAINT seriesidentity UNIQUE (featureofinterestid, observablepropertyid, procedureid, offeringid),
    CONSTRAINT seriesfeaturefk FOREIGN KEY (featureofinterestid)
        REFERENCES sos.featureofinterest (featureofinterestid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT seriesobpropfk FOREIGN KEY (observablepropertyid)
        REFERENCES sos.observableproperty (observablepropertyid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT seriesofferingfk FOREIGN KEY (offeringid)
        REFERENCES sos.offering (offeringid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT seriesprocedurefk FOREIGN KEY (procedureid)
        REFERENCES sos.procedure (procedureid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT seriesunitfk FOREIGN KEY (unitid)
        REFERENCES sos.unit (unitid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT series_published_check CHECK (published = ANY (ARRAY['T'::bpchar, 'F'::bpchar])),
    CONSTRAINT series_deleted_check CHECK (deleted = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.series
    OWNER to postgres;
COMMENT ON TABLE sos.series
    IS 'Table to store a (time-) series which consists of featureOfInterest, observableProperty, and procedure. Mapping file: mapping/series/Series.hbm.xml';

COMMENT ON COLUMN sos.series.seriesid
    IS 'Table primary key, used for relations';

COMMENT ON COLUMN sos.series.featureofinterestid
    IS 'Foreign Key (FK) to the related featureOfInterest. Contains "featureOfInterest".featureOfInterestId';

COMMENT ON COLUMN sos.series.observablepropertyid
    IS 'Foreign Key (FK) to the related observableProperty. Contains "observableproperty".observablepropertyid';

COMMENT ON COLUMN sos.series.procedureid
    IS 'Foreign Key (FK) to the related procedure. Contains "procedure".procedureid';

COMMENT ON COLUMN sos.series.offeringid
    IS 'Foreign Key (FK) to the related procedure. Contains "offering".offeringid';

COMMENT ON COLUMN sos.series.deleted
    IS 'Flag to indicate that this series is deleted or not. Set if the related procedure is deleted via DeleteSensor operation (OGC SWES 2.0 - DeleteSensor operation)';

COMMENT ON COLUMN sos.series.published
    IS 'Flag to indicate that this series is published or not. A not published series is not contained in GetObservation and GetDataAvailability responses';

COMMENT ON COLUMN sos.series.firsttimestamp
    IS 'The time stamp of the first (temporal) observation associated to this series';

COMMENT ON COLUMN sos.series.lasttimestamp
    IS 'The time stamp of the last (temporal) observation associated to this series';

COMMENT ON COLUMN sos.series.firstnumericvalue
    IS 'The value of the first (temporal) observation associated to this series';

COMMENT ON COLUMN sos.series.lastnumericvalue
    IS 'The value of the last (temporal) observation associated to this series';

COMMENT ON COLUMN sos.series.unitid
    IS 'Foreign Key (FK) to the related unit of the first/last numeric values . Contains "unit".unitid';
-- Index: seriesfeatureidx

-- DROP INDEX IF EXISTS sos.seriesfeatureidx;

CREATE INDEX IF NOT EXISTS seriesfeatureidx
    ON sos.series USING btree
    (featureofinterestid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: seriesobspropidx

-- DROP INDEX IF EXISTS sos.seriesobspropidx;

CREATE INDEX IF NOT EXISTS seriesobspropidx
    ON sos.series USING btree
    (observablepropertyid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: seriesofferingidx

-- DROP INDEX IF EXISTS sos.seriesofferingidx;

CREATE INDEX IF NOT EXISTS seriesofferingidx
    ON sos.series USING btree
    (offeringid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: seriesprocedureidx

-- DROP INDEX IF EXISTS sos.seriesprocedureidx;

CREATE INDEX IF NOT EXISTS seriesprocedureidx
    ON sos.series USING btree
    (procedureid ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE SEQUENCE IF NOT EXISTS sos.seriesid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.seriesid_seq
    OWNER TO postgres;

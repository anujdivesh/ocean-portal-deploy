-- Table: sos.observationconstellation

-- DROP TABLE IF EXISTS sos.observationconstellation;

CREATE TABLE IF NOT EXISTS sos.observationconstellation
(
    observationconstellationid bigint NOT NULL,
    observablepropertyid bigint NOT NULL,
    procedureid bigint NOT NULL,
    observationtypeid bigint,
    offeringid bigint NOT NULL,
    deleted character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'F'::bpchar,
    hiddenchild character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'F'::bpchar,
    CONSTRAINT observationconstellation_pkey PRIMARY KEY (observationconstellationid),
    CONSTRAINT obsnconstellationidentity UNIQUE (observablepropertyid, procedureid, offeringid),
    CONSTRAINT obsconstobservationiypefk FOREIGN KEY (observationtypeid)
        REFERENCES sos.observationtype (observationtypeid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT obsconstobspropfk FOREIGN KEY (observablepropertyid)
        REFERENCES sos.observableproperty (observablepropertyid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT obsconstofferingfk FOREIGN KEY (offeringid)
        REFERENCES sos.offering (offeringid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT obsnconstprocedurefk FOREIGN KEY (procedureid)
        REFERENCES sos.procedure (procedureid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT observationconstellation_hiddenchild_check CHECK (hiddenchild = ANY (ARRAY['T'::bpchar, 'F'::bpchar])),
    CONSTRAINT observationconstellation_deleted_check CHECK (deleted = ANY (ARRAY['T'::bpchar, 'F'::bpchar]))
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.observationconstellation
    OWNER to postgres;
COMMENT ON TABLE sos.observationconstellation
    IS 'Table to store the ObservationConstellation information. Contains information about the constellation of observableProperty, procedure, offering and the observationType. Mapping file: mapping/core/ObservationConstellation.hbm.xml';

COMMENT ON COLUMN sos.observationconstellation.observationconstellationid
    IS 'Table primary key, used for relations';

COMMENT ON COLUMN sos.observationconstellation.observablepropertyid
    IS 'Foreign Key (FK) to the related observableProperty. Contains "observableproperty".observablepropertyid';

COMMENT ON COLUMN sos.observationconstellation.procedureid
    IS 'Foreign Key (FK) to the related procedure. Contains "procedure".procedureid';

COMMENT ON COLUMN sos.observationconstellation.observationtypeid
    IS 'Foreign Key (FK) to the related observableProperty. Contains "observationtype".observationtypeid';

COMMENT ON COLUMN sos.observationconstellation.offeringid
    IS 'Foreign Key (FK) to the related observableProperty. Contains "offering".offeringid';

COMMENT ON COLUMN sos.observationconstellation.deleted
    IS 'Flag to indicate that this observationConstellation is deleted or not. Set if the related procedure is deleted via DeleteSensor operation (OGC SWES 2.0 - DeleteSensor operation)';

COMMENT ON COLUMN sos.observationconstellation.hiddenchild
    IS 'Flag to indicate that this observationConstellations procedure is a child procedure of another procedure. If true, the related procedure is not contained in OGC SOS 2.0 Capabilities but in OGC SOS 1.0.0 Capabilities.';
-- Index: obsconstobspropidx

-- DROP INDEX IF EXISTS sos.obsconstobspropidx;

CREATE INDEX IF NOT EXISTS obsconstobspropidx
    ON sos.observationconstellation USING btree
    (observablepropertyid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: obsconstofferingidx

-- DROP INDEX IF EXISTS sos.obsconstofferingidx;

CREATE INDEX IF NOT EXISTS obsconstofferingidx
    ON sos.observationconstellation USING btree
    (offeringid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: obsconstprocedureidx

-- DROP INDEX IF EXISTS sos.obsconstprocedureidx;

CREATE INDEX IF NOT EXISTS obsconstprocedureidx
    ON sos.observationconstellation USING btree
    (procedureid ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE SEQUENCE IF NOT EXISTS sos.observationconstellationid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.observationconstellationid_seq
    OWNER TO postgres;

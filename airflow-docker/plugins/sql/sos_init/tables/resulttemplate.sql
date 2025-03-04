-- Table: sos.resulttemplate

-- DROP TABLE IF EXISTS sos.resulttemplate;

CREATE TABLE IF NOT EXISTS sos.resulttemplate
(
    resulttemplateid bigint NOT NULL,
    offeringid bigint NOT NULL,
    observablepropertyid bigint NOT NULL,
    procedureid bigint NOT NULL,
    featureofinterestid bigint NOT NULL,
    identifier character varying(255) COLLATE pg_catalog."default" NOT NULL,
    resultstructure text COLLATE pg_catalog."default" NOT NULL,
    resultencoding text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT resulttemplate_pkey PRIMARY KEY (resulttemplateid),
    CONSTRAINT resulttemplatefeatureidx FOREIGN KEY (featureofinterestid)
        REFERENCES sos.featureofinterest (featureofinterestid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT resulttemplateobspropfk FOREIGN KEY (observablepropertyid)
        REFERENCES sos.observableproperty (observablepropertyid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT resulttemplateofferingidx FOREIGN KEY (offeringid)
        REFERENCES sos.offering (offeringid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT resulttemplateprocedurefk FOREIGN KEY (procedureid)
        REFERENCES sos.procedure (procedureid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.resulttemplate
    OWNER to postgres;
COMMENT ON TABLE sos.resulttemplate
    IS 'Table to store resultTemplates (OGC SOS 2.0 result handling profile). Mapping file: mapping/transactionl/ResultTemplate.hbm.xml';

COMMENT ON COLUMN sos.resulttemplate.resulttemplateid
    IS 'Table primary key';

COMMENT ON COLUMN sos.resulttemplate.offeringid
    IS 'Foreign Key (FK) to the related offering. Contains "offering".offeringid';

COMMENT ON COLUMN sos.resulttemplate.observablepropertyid
    IS 'Foreign Key (FK) to the related observableProperty. Contains "observableProperty".observablePropertyId';

COMMENT ON COLUMN sos.resulttemplate.procedureid
    IS 'Foreign Key (FK) to the related procedure. Contains "procedure".procedureId';

COMMENT ON COLUMN sos.resulttemplate.featureofinterestid
    IS 'Foreign Key (FK) to the related featureOfInterest. Contains "featureOfInterest".featureOfInterestid';

COMMENT ON COLUMN sos.resulttemplate.identifier
    IS 'The resultTemplate identifier, required for InsertResult requests.';

COMMENT ON COLUMN sos.resulttemplate.resultstructure
    IS 'The resultStructure as XML string. Describes the types and order of the values in a GetResultResponse/InsertResultRequest';

COMMENT ON COLUMN sos.resulttemplate.resultencoding
    IS 'The resultEncoding as XML string. Describes the encoding of the values in a GetResultResponse/InsertResultRequest';
-- Index: resulttempeobspropidx

-- DROP INDEX IF EXISTS sos.resulttempeobspropidx;

CREATE INDEX IF NOT EXISTS resulttempeobspropidx
    ON sos.resulttemplate USING btree
    (observablepropertyid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: resulttempidentifieridx

-- DROP INDEX IF EXISTS sos.resulttempidentifieridx;

CREATE INDEX IF NOT EXISTS resulttempidentifieridx
    ON sos.resulttemplate USING btree
    (identifier COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: resulttempofferingidx

-- DROP INDEX IF EXISTS sos.resulttempofferingidx;

CREATE INDEX IF NOT EXISTS resulttempofferingidx
    ON sos.resulttemplate USING btree
    (offeringid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: resulttempprocedureidx

-- DROP INDEX IF EXISTS sos.resulttempprocedureidx;

CREATE INDEX IF NOT EXISTS resulttempprocedureidx
    ON sos.resulttemplate USING btree
    (procedureid ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE SEQUENCE IF NOT EXISTS sos.resulttemplateid_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE sos.resulttemplateid_seq
    OWNER TO postgres;

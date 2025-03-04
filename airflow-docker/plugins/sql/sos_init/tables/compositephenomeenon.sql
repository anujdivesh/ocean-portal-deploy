-- Table: sos.compositephenomenon

-- DROP TABLE IF EXISTS sos.compositephenomenon;

CREATE TABLE IF NOT EXISTS sos.compositephenomenon
(
    parentobservablepropertyid bigint NOT NULL,
    childobservablepropertyid bigint NOT NULL,
    CONSTRAINT compositephenomenon_pkey PRIMARY KEY (childobservablepropertyid, parentobservablepropertyid),
    CONSTRAINT observablepropertychildfk FOREIGN KEY (childobservablepropertyid)
        REFERENCES sos.observableproperty (observablepropertyid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT observablepropertyparentfk FOREIGN KEY (parentobservablepropertyid)
        REFERENCES sos.observableproperty (observablepropertyid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.compositephenomenon
    OWNER to postgres;
COMMENT ON TABLE sos.compositephenomenon
    IS 'NOT YET USED! Relation table to store observableProperty hierarchies, aka compositePhenomenon. E.g. define a parent in a query and all childs are also contained in the response. Mapping file: mapping/transactional/TObservableProperty.hbm.xml';

COMMENT ON COLUMN sos.compositephenomenon.parentobservablepropertyid
    IS 'Foreign Key (FK) to the related parent observableProperty. Contains "observableProperty".observablePropertyid';

COMMENT ON COLUMN sos.compositephenomenon.childobservablepropertyid
    IS 'Foreign Key (FK) to the related child observableProperty. Contains "observableProperty".observablePropertyid';

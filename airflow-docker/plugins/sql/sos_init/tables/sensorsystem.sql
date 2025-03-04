-- Table: sos.sensorsystem

-- DROP TABLE IF EXISTS sos.sensorsystem;

CREATE TABLE IF NOT EXISTS sos.sensorsystem
(
    parentsensorid bigint NOT NULL,
    childsensorid bigint NOT NULL,
    CONSTRAINT sensorsystem_pkey PRIMARY KEY (childsensorid, parentsensorid),
    CONSTRAINT procedurechildfk FOREIGN KEY (childsensorid)
        REFERENCES sos.procedure (procedureid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT procedureparenffk FOREIGN KEY (parentsensorid)
        REFERENCES sos.procedure (procedureid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sos.sensorsystem
    OWNER to postgres;
COMMENT ON TABLE sos.sensorsystem
    IS 'Relation table to store procedure hierarchies. E.g. define a parent in a query and all childs are also contained in the response. Mapping file: mapping/transactional/TProcedure.hbm.xml';

COMMENT ON COLUMN sos.sensorsystem.parentsensorid
    IS 'Foreign Key (FK) to the related parent procedure. Contains "procedure".procedureid';

COMMENT ON COLUMN sos.sensorsystem.childsensorid
    IS 'Foreign Key (FK) to the related child procedure. Contains "procedure".procedureid';

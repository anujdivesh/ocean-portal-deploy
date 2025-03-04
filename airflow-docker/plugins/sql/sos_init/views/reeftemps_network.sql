-- View: sos.reeftemps_network

-- DROP VIEW sos.reeftemps_network;

CREATE OR REPLACE VIEW sos.reeftemps_network
 AS
 SELECT r.libelle AS reseau_libelle,
    r.descriptif AS reseau_descriptif,
    c.libelle AS producteur_name,
    c.descriptif AS producteur_descriptif,
    ((pi.titre::text || ' '::text) || (pi.prenom::text || ' '::text)) || pi.nom::text AS pi_name,
    pi.libelle AS pi_desc,
    pi.email AS pi_email,
    proc.identifier AS procedure_id,
    proc.description AS procedure_desc,
    op.identifier AS observable_property_code,
    op.name AS observable_property_desc,
    foi.featureofinterestid AS featureofinterest_code,
    foi.description AS featureofinterest_desc,
    proc.disabled AS procedure_disabled,
    ss.firsttimestamp AS series_firsttimestamp,
    ss.lasttimestamp AS series_lasttimestamp,
    st_x(foi.geom) AS longitude,
    st_y(foi.geom) AS latitude,
    foi.url AS url_wms,
    sos.get_absolute_path_prefix('netcdf_serie'::character varying::text) || s.url_rel_netcdf::text AS url_netcdf_data,
    (sos.get_absolute_path_prefix('url_thredds_data'::character varying::text) || s.url_rel_netcdf::text) || '.html'::text AS url_thredds_data,
    ((((sos.get_absolute_path_prefix('csv_data'::character varying::text) || 'dataset='::text) || sos.get_absolute_path_prefix('url_thredds_data'::character varying::text)) || s.url_rel_netcdf::text) || '&variable='::text) || op.identifier::text AS url_csv_data,
    ((((sos.get_absolute_path_prefix('data_graph'::character varying::text) || 'dataset='::text) || sos.get_absolute_path_prefix('url_thredds_data'::character varying::text)) || s.url_rel_netcdf::text) || '&y_variable='::text) || op.identifier::text AS data_graph,
    sos.get_absolute_path_prefix('metadata'::character varying::text) || r.uuid_fiche_catalogue::text AS url_metadata,
    foi.geom::geometry(Geometry,4326) AS featureofinterest_geom,
    r.doi_url AS url_doi
   FROM reseau r,
    sos.procedure proc,
    sos.observableproperty op,
    sos.featureofinterest foi,
    sos.series ss,
    serie s,
    plateforme p,
    centre c,
    pi
  WHERE r.id = s.id_reseau AND ss.procedureid = proc.procedureid AND ss.featureofinterestid = foi.featureofinterestid AND ss.observablepropertyid = op.observablepropertyid AND ss.published = 'T'::bpchar AND ss.seriesid = s.id AND p.id = foi.featureofinterestid AND p.id_centre = c.id AND pi.id_centre = c.id;

ALTER TABLE sos.reeftemps_network
    OWNER TO postgres;



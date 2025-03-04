-- FUNCTION: sos.get_absolute_path_prefix(text)

-- DROP FUNCTION IF EXISTS sos.get_absolute_path_prefix(text);

CREATE OR REPLACE FUNCTION sos.get_absolute_path_prefix(
	text)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE 
AS $BODY$
DECLARE
service_type ALIAS FOR $1;
BEGIN 
IF service_type = 'netcdf_serie' THEN
RETURN 'https://www.reeftemps.science/thredds/fileServer/';
END IF; 
IF service_type = 'csv_data' THEN 
RETURN 'https://www.reeftemps.science/dap2csv?'; 
END IF;
IF service_type = 'url_thredds_data' THEN
RETURN 'https://www.reeftemps.science/thredds/dodsC/'; 
END IF; 
IF service_type = 'data_graph' THEN
RETURN 'https://www.reeftemps.science/dap2graph?';
END IF;
IF service_type = 'metadata' THEN
RETURN 'https://www.reeftemps.science/geonetwork/srv/fre/catalog.search#/metadata/'; 
END IF;
IF service_type = 'WMS' THEN
RETURN 'https://www.reeftemps.science/geoserver/wms?'; 
END IF;
IF service_type = 'WFS' THEN
RETURN 'https://www.reeftemps.science/geoserver/wfs?'; 
END IF;
END;
$BODY$;

ALTER FUNCTION sos.get_absolute_path_prefix(text)
    OWNER TO postgres;


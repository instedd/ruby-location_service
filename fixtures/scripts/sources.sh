# Loads sources for location service that match the specs
GEO_PATH=$1
SERVICE_PATH=$2

$SERVICE_PATH/bin/importer -source=ne   $GEO_PATH/naturalearth/ne_10m_admin_0_countries/ne_10m_admin_0_countries.shp
$SERVICE_PATH/bin/importer -source=ne   $GEO_PATH/naturalearth/ne_10m_admin_1_states_provinces/ne_10m_admin_1_states_provinces.shp
$SERVICE_PATH/bin/importer -source=gadm $GEO_PATH/gadm/ARG_adm0.shp
$SERVICE_PATH/bin/importer -source=gadm $GEO_PATH/gadm/ARG_adm1.shp
$SERVICE_PATH/bin/importer -source=gadm $GEO_PATH/gadm/ARG_adm2.shp
$SERVICE_PATH/bin/importer -source=gadm $GEO_PATH/gadm/ARG_adm3.shp
$SERVICE_PATH/bin/importer -source=gadm $GEO_PATH/gadm/USA_adm0.shp
$SERVICE_PATH/bin/importer -source=gadm $GEO_PATH/gadm/USA_adm1.shp
$SERVICE_PATH/bin/importer -source=gadm $GEO_PATH/gadm/USA_adm2.shp
$SERVICE_PATH/bin/importer -source=gadm $GEO_PATH/gadm/USA_adm3.shp

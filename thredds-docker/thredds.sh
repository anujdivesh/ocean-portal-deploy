baseURL="/mnt/data"
rootPath="${baseURL}/ocean_portal"
config="${rootPath}/config"
threddsConfig="${config}/thredds_config"
dataRoot="${rootPath}/datasets"

cd "${threddsConfig}/thredds-docker"

PORT="8081" 
THREDDS="${threddsConfig}/thredds-docker" 
TOMCAT_USERS="${threddsConfig}/thredds-docker/files"\
DATA="${dataRoot}"

docker-compose down thredds-production
#docker-compose restart

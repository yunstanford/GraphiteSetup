SERVICE_NAME=zillow-graphite
D=/Users/yunx/stash/SERVICES/zillow-graphite
CONFIG_FOLDER=$D/config/current/graphite-relay
STORAGE_DIR=/opt/zillow/app_data/zillow-graphite/storage

# export env variables
# Specify graphite storage dir and graphite conf dir
CARBON_RELAY_NG_LOG=/opt/zillow/app_data/zillow-graphite/log/carbon-relay-ng/
mkdir -p $STORAGE_DIR/carbon-relay-ng-1/
mkdir -p $CARBON_RELAY_NG_LOG
echo "=== Start Carbon-relay-ng"
$D/bin/carbon-relay-ng $CONFIG_FOLDER/carbon-relay-ng-1.ini > $CARBON_RELAY_NG_LOG/carbon-relay-ng-1-stdout 2> $CARBON_RELAY_NG_LOG/carbon-relay-ng-1-stderr
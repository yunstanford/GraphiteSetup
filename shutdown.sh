#!/bin/bash

CACHE_INSTANCES_NUM=8
RELAY_INSTANCES_NUM=2
NAMING_FORMATE="l"

# "/opt/graphite/bin/"
SCRIPT_PATH="/Users/yunx/Documents/PROJECTS/graphite/bin"

echo "[INFO] ===== Shutting down Graphite ===== "

echo "[INFO] == Shutting down Carbon-Relay instances =="

python $SCRIPT_PATH/carbon_relay.py stop $NAMING_FORMATE $RELAY_INSTANCES_NUM 

echo "[INFO] == Carbon-Relay stopped =="

echo "[INFO] == Shutting down Carbon-Cache instances =="

python $SCRIPT_PATH/carbon_cache.py stop $NAMING_FORMATE $CACHE_INSTANCES_NUM

echo "[INFO] == Carbon-Cache stoped =="

echo "[INFO] ===== Finished ====="
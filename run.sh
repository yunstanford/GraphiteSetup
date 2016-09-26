#!/bin/bash

CACHE_INSTANCES_NUM=8
RELAY_INSTANCES_NUM=2
NAMING_FORMATE="l"

# "/opt/graphite/bin/"
SCRIPT_PATH="PATH/TO/SCRIPT"

echo "[INFO] ===== Starting Graphite ===== "

echo "[INFO] == Starting Carbon-Relay =="

python $SCRIPT_PATH/carbon_relay.py start $NAMING_FORMATE $RELAY_INSTANCES_NUM 

echo "[INFO] == Carbon-Relay Started =="

echo "[INFO] == Starting Carbon-Cache =="

python $SCRIPT_PATH/carbon_cache.py start $NAMING_FORMATE $CACHE_INSTANCES_NUM

echo "[INFO] == Carbon-Cache Started =="

echo "[INFO] ===== Finished ====="

echo "[NOTE] You should start graphite webapp server manually."
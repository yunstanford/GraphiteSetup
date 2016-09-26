#!/bin/bash

MAX=1000
INTERVAL=60
MIN_METRIC=$1
MAX_METRIC=$2

# Send Data to METRIC
for i in `seq 1 $MAX`
do
	for j in `seq $MIN_METRIC $MAX_METRIC`
	do
		METRIC="test.foo$j"
		echo "$METRIC $i `date +%s`" | nc localhost 2003
		echo "Send Data: $i to Metric ($METRIC)"
	done
	sleep $INTERVAL
done
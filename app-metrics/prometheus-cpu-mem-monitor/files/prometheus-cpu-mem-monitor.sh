#!/bin/bash
# Extract per-process CPU and memory usage from "ps aux" and send the data to prometheus
#

TARGET_URL="http://localhost:9091/metrics/job/top/instance/vps-02.friedli.info"

z=$(ps aux)

while read -r z
do
	cpustats=$cpustats$(awk '{print "cpu_usage{process=\""$11"\", pid=\""$2"\"}", $3z}');
	memstats=$memstats$(awk '{print "memory_usage{process=\""$11"\", pid=\""$2"\"}", $4z}');
done <<< "$z"

curl -X POST -H "Content-Type: text/plain" --data "$cpustats
" ${TARGET_URL}

curl -X POST -H "Content-Type: text/plain" --data "$memstats
" ${TARGET_URL}

#!/bin/bash

[ $# -ne 2 ] && echo "Usage: $0 <log file> <ioc file>" && exit 1

logFile="$1"
iocFile="$2"

iocLogs=$(grep -f "$iocFile" "$logFile")
report=$(awk '{print $1, substr($4,2), $7}' <<< "$iocLogs")
echo "$report" > report.txt

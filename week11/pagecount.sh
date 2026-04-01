#!/bin/bash

function pageCount() {
	if [ $# -ne 1 ]; then
		echo "Usage: $0 <logfile>"
		return 1
	fi

	logfile="$1"

	awk '{print $7}' "$logfile" | sort | uniq -c
}

function countingCurlAccess() {
	if [ $# -ne 1 ]; then
		echo "Usage: $0 <logfile>"
		return 1
	fi

	logfile="$1"

	cat $logfile | cut -f12- -d' ' | grep "curl" | sort | uniq -c
}
countingCurlAccess access.log

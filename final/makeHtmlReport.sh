#!/bin/bash

[ $# -ne 1 ] && echo "Usage: $0 <report file>" && exit 1

input="$1"
output="/var/www/html/report.html"

{
	echo "<html>"
	echo "<body>"
	echo "<p>Access logs with IOC indicators:</p>"
	echo "<table border='1'>"

	awk '{
		print "<tr>"
		print "<td>" $1 "</td>"
		print "<td>" $2 "</td>"
		print "<td>" $3 "</td>"
		print "</tr>"
	}' "$input"

	echo "</table>"
	echo "</body>"
	echo "</html>"
} > "$output"


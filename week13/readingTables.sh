#!/bin/bash

url="http://10.0.17.6/Assignment.html"
page=$(curl -s "$url")

temp_rows=$(xmlstarlet format --html --recover 2>/dev/null <<< "$page" | xmlstarlet sel -T -t \
	-m "(//table)[1]//tr[position()>1]" \
	-v "normalize-space(td[1])" -o "|" \
	-v "normalize-space(td[2])" -n)

press_rows=$(xmlstarlet format --html --recover 2>/dev/null <<< "$page" | xmlstarlet sel -T -t \
	-m "(//table)[2]//tr[position()>1]" \
	-v "normalize-space(td[1])" -o "|" \
	-v "normalize-space(td[2])" -n)

paste <(echo "$press_rows") <(echo "$temp_rows") | awk -F'\t' '
{
	split($1, p, /\|/)
	split($2, t, /\|/)
	print p[1], t[1], t[2]
}
'

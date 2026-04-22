#!/bin/bash

logpath="/home/champuser/SYS-320/week15/fileaccesslog.txt"
emailform="/home/champuser/SYS-320/week15/emailform.txt"

echo "File was accessed $(date)" >> "$logpath"

echo "To: aidan.stewart@mymail.champlain.edu" > "$emailform"
echo "Subject: Userlogs-1.bash access" >> "$emailform"
echo >> "$emailform"
cat "$logpath" >> "$emailform"

cat "$emailform" | /usr/sbin/ssmtp aidan.stewart@mymail.champlain.edu

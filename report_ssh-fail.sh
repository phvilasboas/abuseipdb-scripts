#!/bin/bash
cat /var/log/auth.log | grep failure |grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sort -n  | uniq -c  > /tmp/ssh_fails.txt

while read line; do

QTD=$(echo $line | awk {'print $1'})
IP=$(echo $line | awk {'print $2'})

if [ $QTD -gt 5 ]; then
#echo $IP - $QTD

curl -g -6 https://api.abuseipdb.com/api/v2/report \
  --data-urlencode "ip=$IP" \
  -d categories=18,22 \
  --data-urlencode "comment=SSH login many attempts failure" \
  -H "Key: YOURAPIKEY" \
  -H "Accept: application/json"
echo
fi

done < /tmp/ssh_fails.txt

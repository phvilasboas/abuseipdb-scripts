#!/bin/bash
ipset create drop_ips hash:net
for ips in `cat /root/logftp.txt |grep -i --text 'connect'| awk {'print $6'}| grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'| egrep -v '192.168.1|172.30|172.29|10.254'|sort -n| uniq`
do

ipset add drop_ips $ips

done


#criar regra para bloquear antes
#iptables -I INPUT -m set --match-set drop_ips src -j DROP


#!/bin/bash
while true; do nc -vlnp 21 <ftp.txt 2>>/root/logftp.txt 1>>&2;echo `date` >> /root/logftp.txt;done

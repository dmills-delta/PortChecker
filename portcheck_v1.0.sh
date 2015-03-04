#!/bin/bash

#Checks whether the SSH port is open.

nc -z -w5 213.104.177.5 9999; echo "$?" > portcheck_log.txt

if grep -q 1 portcheck_log.txt; then
        echo "Port Scan Failed - $(date -u)" > alerts.txt
        cat alerts.txt | mail -s "Port Scan Failed" "dmills@deltatestingltd.com"
else
        echo "Port Scan Complete - $(date -u)" >> complete_log.txt
fi
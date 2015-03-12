#!/bin/bash

#Checks whether the SSH port is open.

nc -z -w5 213.104.177.5 9999; echo "$?" > portcheck_log.txt

while true; do

val=$(cat portcheck_log.txt)

  if [[ "$val" -eq "1" ]]; then
   echo "Port Scan Failed - $(date -u)" >> errors.txt 
   if [ ! -f "check_failure" ]; then
      echo "Port Scan Failed - $(date -u)" | mail -s "Port Scan Failed" dmills@deltatestingltd.com
      touch check_failure

      if [ -f "check_success" ]; then
        rm check_success
      fi

    fi

  else

    if [ ! -f "check_success" ]; then
      echo "Port Scan Successful - $(date -u)" > complete_log.txt
      touch check_success

      if [ -f "check_failure" ]; then
        rm check_failure
      fi

    fi

  fi

sleep 60

done

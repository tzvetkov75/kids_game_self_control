#!/bin/bash
set -e

# content is page even error code 
printf "Content-type: text/html\n\n"

. ./bin/funcs.sh 

# find out the device 
if [[ "$QUERY_STRING" =~ "ps4" ]]; then 
	device="ps4"
else
	device="phone"
fi

# Get the current date to stop 
stop_date=$(cat "./db/${device}_stop_date.txt")

n=$(date +"%s")

if [[ $stop_date > $n ]]; then 
   seconds_to_return=$(( $stop_date - $n ))
   # add to total 
   rest=$(cat ./db/rest.txt)
   echo $(($rest+$seconds_to_return)) > ./db/rest.txt 
   echo $(( $n - 1)) > "./db/${device}_stop_date.txt"
   #  block internet access  
   ./bin/api_command.sh ${device} stop
   set_jobs
   logger -p local0.notice "CaleControl: Stoppped  device:[$device] seconds_to_return:[$seconds_to_return]"
else
   logger -p local0.notice "CaleControl: Already Stoppped  device:[$device]. Doing nothing"
fi 

redirect

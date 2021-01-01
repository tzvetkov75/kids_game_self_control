#!/bin/bash
set -e

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

# if the time is over then exit 
if [[ $stop_date < $n ]]; then 
	redirect
	exit 
fi 

seconds_to_return=$(( $stop_date - $n ))

# add to total 
rest=$(cat ./db/rest.txt)
echo $(($rest+$seconds_to_return)) > ./db/rest.txt 
echo $(( $n - 1)) > "./db/${device}_stop_date.txt"

redirect
set_jobs

#  block internet access  
./bin/${device}_stop.sh

logger -p local0.notice "CaleControl: Stoppped  device:[$device] seconds_to_return:[$seconds_to_return]"

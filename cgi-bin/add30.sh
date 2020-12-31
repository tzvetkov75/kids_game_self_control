#!/bin/bash
#set -xve
set -e 

# const
# deduction time  - 30 min
time_to_add=1800

cd bin
. ./funcs.sh 

rest=$(cat ../db/rest.txt)

# check if time avalable possible
if [[ $rest < 0 ]]; then 
	# play time finished 
	redirect
	exit 
fi

# substract from total 
echo $(( $rest - $time_to_add )) > ../db/rest.txt 

# find out the device 
if [[ "$QUERY_STRING" =~ "ps4" ]]; then 
	device="ps4"
else
	device="phone"
fi

# Get the current date to stop 
stop_date=$(cat "../db/${device}_stop_date.txt")

n=$(date +"%s")

# if the time is over start again
if [[ $stop_date < $n ]]; then 
        logger -p local0.notice "CaleControl: Start internet device:[$device]"
	stop_date=$(date +"%s")
	./${device}_start.sh
fi 

# Add some time
new_stop_date=$(( $stop_date + $time_to_add )) 

# Store the new end date 
echo $new_stop_date > "../db/${device}_stop_date.txt"

redirect
cd ../db/
set_jobs

logger -p local0.notice "CaleControl: Added 30 min device:[$device] new_stop_date:["$(date -d "@$new_stop_date")"]"



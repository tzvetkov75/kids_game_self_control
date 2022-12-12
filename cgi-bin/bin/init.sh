week_to_play_seconds="72000" # 2.5 x 7 x 3600

date +"%s" > ./db/ps4_stop_date.txt
date +"%s" > ./db/phone_stop_date.txt
echo $week_to_play_seconds > ./db/total.txt


logger -p local0.notice "CaleControl: Starting Init"
if test -f "./db/rest.txt"; then 
	rest=$(cat ./db/rest.txt)
	logger -p local0.notice "CaleControl: Rest time [$rest] min"
	# if time is save then double the time
        if ((rest>0)); then 
		rest=$((rest*2)); 
		logger -p local0.notice "CaleControl: Dubble time [$rest] min since saved :-)"
       	else 
		rest="0"
	fi

	rest=$(($rest + $week_to_play_seconds))
	echo $rest > ./db/rest.txt
else
	echo $week_to_play_seconds > ./db/rest.txt
fi 

rest=$(cat ./db/rest.txt)
logger -p local0.notice "CaleControl: Total time now [$rest] min"

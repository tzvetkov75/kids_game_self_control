week_to_play_seconds="63000" # 2.5 x 7 x 3600

date +"%s" > ./db/ps4_stop_date.txt
date +"%s" > ./db/phone_stop_date.txt
echo $week_to_play_seconds > ./db/total.txt

if test -f "./db/rest.txt"; then 
	rest=$(cat ./db/rest.txt) 
	rest=$(($rest + $week_to_play_seconds))
	echo $rest > ./db/rest.txt
else
	echo $week_to_play_seconds > ./db/rest.txt
fi 

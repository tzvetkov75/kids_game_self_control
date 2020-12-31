week_to_play_seconds="63000" # 2.5 x 7 x 3600

cd ../db 

date +"%s" > ps4_stop_date.txt
date +"%s" > phone_stop_date.txt
echo $week_to_play_seconds > total.txt

if test -f "rest.txt"; then 
	rest=$(cat rest.txt) 
	rest=$(($rest + $week_to_play_seconds))
	echo $rest > rest.txt
else
	echo $week_to_play_seconds > rest.txt
fi 

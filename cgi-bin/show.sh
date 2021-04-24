#!/bin/bash
set -e

# content is page even error code 
printf "Content-type: text/html\n\n"

phone_stop_date=$(cat ./db/phone_stop_date.txt)
ps4_stop_date=$(cat ./db/ps4_stop_date.txt)

n=$(date +"%s")

phone_2_play=$(( $phone_stop_date - $n))
ps4_2_play=$(( $ps4_stop_date - $n))
total=$(cat ./db/total.txt)
totalFormated=$(($total / 3600 ))"h"$(($total / 60 % 60))"min"
total_txt=$((total / 60 ))"min ($totalFormated)"

rest=$(cat ./db/rest.txt)
restFormated=$(($rest / 3600 ))"h"$(($rest / 60 % 60))"min"
rest_txt=$(( rest / 60 ))"min ($restFormated)" 

played=$((total-rest))
playedFormated=$(($played / 3600 ))"h"$(($played / 60 % 60))"min"
played_txt=$(( played / 60 ))"min ($playedFormated)" 

if test -f "/tmp/calecontrol.lock"; then
    status="locked"
else
    status="unlocked"
fi

cat ./index.template | sed  "s/\${phone_2_play}/$phone_2_play/" | sed  "s/\${total}/$total_txt/" | sed  "s/\${rest}/$rest_txt/" \
  	           | sed  "s/\${ps4_2_play}/$ps4_2_play/" | sed  "s/\${status}/$status/" |  sed  "s/\${played}/$played_txt/" 

msg="CaleControl: Showed total:[$total] rest:[$rest] phone:["$(date -d "@$phone_stop_date")"] ps4:["$(date -d "@$ps4_stop_date")"]"
logger -p local0.notice $msg


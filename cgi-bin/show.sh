#!/bin/bash


phone_stop_date=$(cat ./db/phone_stop_date.txt)
ps4_stop_date=$(cat ./db/ps4_stop_date.txt)

n=$(date +"%s")

phone_2_play=$(( $phone_stop_date - $n))
ps4_2_play=$(( $ps4_stop_date - $n))
total=$(cat ./db/total.txt)
total=$((total / 60 ))

rest=$(cat ./db/rest.txt)
restFormated=$(($rest / 3600 ))"h"$(($rest / 60 % 60))"min"
rest=$(( rest / 60 ))"min ($restFormated)" 


printf "Content-type: text/html\n\n"

cat ./index.template | sed  "s/\${phone_2_play}/$phone_2_play/" | sed  "s/\${total}/$total/" | sed  "s/\${rest}/$rest/" \
  	           | sed  "s/\${ps4_2_play}/$ps4_2_play/"

msg="CaleControl: Showed total:[$total] rest:[$rest] phone:["$(date -d "@$phone_stop_date")"] ps4:["$(date -d "@$ps4_stop_date")"]"
logger -p local0.notice $msg


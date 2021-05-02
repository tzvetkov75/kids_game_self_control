#!/bin/bash
# 
#
#  Executes Curl command to AVM router 
#
. ./bin/avm_login.sh

device=$1
oper=$2

ps4_start="back_to_page=%2Finternet%2Fkids_profilelist.lua&edit=filtprof6035&name=PS4&time=unlimited&timer_item_0=1900%3B1%3B127&timer_item_1=0300%3B0%3B127&budget=unlimited&bpjm=on&netappschosen=&choosenetapps=choose&apply=&lang=de&page=kids_profileedit"

ps4_stop="back_to_page=%2Finternet%2Fkids_profilelist.lua&edit=filtprof6035&name=PS4&time=limited&graphState=0&timer_item_0=1915%3B1%3B127&timer_item_1=0300%3B0%3B127&budget=unlimited&disallow_guest=on&parental=on&filtertype=white&netappschosen=&choosenetapps=choose&apply=&lang=de&page=kids_profileedit"

phone_start="back_to_page=%2Finternet%2Fkids_profilelist.lua&edit=filtprof5323&name=Kinder&time=unlimited&budget=unlimited&disallow_guest=on&netappschosen=&choosenetapps=choose&apply=&lang=de&page=kids_profileedit" 

phone_stop="back_to_page=%2Finternet%2Fkids_profilelist.lua&edit=filtprof5323&name=Kinder&time=never&timer_item_0=0000%3B1%3B1&timer_complete=1&budget=unlimited&disallow_guest=on&parental=on&filtertype=black&bpjm=on&netappschosen=&choosenetapps=choose&apply=&lang=de&page=kids_profileedit"

all_status="page=kidPro"


tmp="${device}_${oper}"
instruction=${!tmp}


out=$(curl -s 'http://192.168.1.1/data.lua' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:87.0) Gecko/20100101 Firefox/87.0' -H 'Accept: */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: http://192.168.1.1'  -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' --data-raw "xhr=1&sid=${avmsid}&${instruction}")

if [[ $? == 0 ]]; then 
   if [[ "$out" == *"ok"* ]]; then 
   	logger -p local0.notice "CaleControl: $device internet  $oper"
	if [[ "$tmp" == "all_status" ]]; then 
		echo "$out"
	fi
   else
   	logger -p local0.notice "CaleControl: Error $device internet $oper  msg $out"
        echo "Error in control of $device internet $oper"
	echo "$out"
	exit
   fi
else
   logger -p local0.notice "CaleControl: Error on $device internet $oper"
   exit
fi 

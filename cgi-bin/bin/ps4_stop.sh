#!/bin/bash
# 

. ./avm_login.sh

o=$(curl -s http://$avmfbip/data.lua -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0) Gecko/20100101 Firefox/84.0' -H 'Accept: */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: http://192.168.1.1' -H 'Connection: keep-alive' -H 'Referer: http://192.168.1.1/' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' --data-raw "xhr=1&sid=$avmsid&back_to_page=%2Finternet%2Fkids_profilelist.lua&edit=filtprof6035&name=PS4&time=limited&graphState=1&timer_item_0=1900%3B1%3B127&timer_item_1=0300%3B0%3B127&budget=unlimited&bpjm=on&netappschosen=&choosenetapps=choose&apply=&lang=de&page=kids_profileedit")

o=$(curl -s http://$avmfbip/data.lua -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0) Gecko/20100101 Firefox/84.0' -H 'Accept: */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Content-Type: application/x-www-form-urlencoded' -H 'Origin: http://192.168.1.1' -H 'Connection: keep-alive' -H 'Referer: http://192.168.1.1/' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' --data-raw "xhr=1&sid=$avmsid&lang=de&no_sidrenew=&oldpage=%2Finternet%2Fkids_profilelist.lua&initalRefreshParamsSaved=true")

if [[ $? != 0 ]]; then 
   logger -p local0.notice "CaleControl: PS4 internet stopped"
fi 

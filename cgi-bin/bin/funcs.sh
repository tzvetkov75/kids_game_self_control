

lock_file="db/calecontrol.lock"

function redirect {

  echo """
  <!DOCTYPE HTML>
  <html>
  <head>
  <meta http-equiv="refresh" content="0\;url=show.sh" />
  </head>
  <body>
  Working...wait
  </body>
  </html>
  """
  if [[ $1 != "nounlock" ]]; then 
	unlock
  fi
}

function header_lock {
	# content is page even error code 
	printf "Content-type: text/html\n\n"
	lock
}

function set_jobs {
  # clear all jobs
  for i in `atq | awk '{print $1}'`;do atrm $i;done
  logger -p local0.notice "CaleControl: scheduled jobs (at) for stopping internet cleared (deleted)"
  
  # set a new job to stop 

  n=$(date +"%s")
  ps4_stop_date=$(cat ./db/ps4_stop_date.txt)
  phone_stop_date=$(cat ./db/phone_stop_date.txt)
  
  if [[ $n < $ps4_stop_date ]]; then 
    echo "./bin/api_command.sh ps4 stop" | at $(date -d "@$ps4_stop_date" +"%H:%M") > /dev/null 
    logger -p local0.notice "CaleControl: set job to stop internet on device:[ps4] at ps4_stop_date:["$(date -d "@$ps4_stop_date")"]"

  fi 
  if [[ $n < $phone_stop_date ]]; then
    echo "./bin/api_command.sh phone stop" | at $(date -d "@$phone_stop_date" +"%H:%M") > /dev/null
    logger -p local0.notice "CaleControl: set job to stop internet on  device:[phone] at phone_stop_date:["$(date -d "@$phone_stop_date")"]"
  fi
}

function lock {
  logger -p local0.notice "CaleControl: check for lock (parallel execution)"
  find $lock_file -cmin +1 -exec rm {} \; || true
  if test -f "$lock_file"; then 
	logger -p local0.notice "CaleControl: already locked exiting (parallel execution)"
	sleep 5
        redirect nounlock
	exit
  else
	logger -p local0.notice "CaleControl: locked"
	touch $lock_file
  fi 
}

function unlock {
  logger -p local0.notice "CaleControl: unlock (parallel execution)"
  rm  $lock_file || logger -p local0.notice "CaleControl: nolock"
}

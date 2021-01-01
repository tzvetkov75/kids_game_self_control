
function redirect {
  # provide the reditect web page 
  printf "Content-type: text/html\n\n"

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
}

function set_jobs {
  # clear all jobs
  for i in `atq | awk '{print $1}'`;do atrm $i;done
  logger -p local0.notice "CaleControl: scheduled jobs (at) for stopping internet cleared (deleted)"
  
  redirect
  # set a new job to stop 

  n=$(date +"%s")
  ps4_stop_date=$(cat ./db/ps4_stop_date.txt)
  phone_stop_date=$(cat ./db/phone_stop_date.txt)
  
  if [[ $n < $ps4_stop_date ]]; then 
    echo "./bin/ps4_stop.sh" | at $(date -d "@$ps4_stop_date" +"%H:%M") 
    logger -p local0.notice "CaleControl: set job to stop internet on device:[ps4] at ps4_stop_date:["$(date -d "@$ps4_stop_date")"]"

  fi 
  if [[ $n < $phone_stop_date ]]; then
    echo "./bin/phone_stop.sh" | at $(date -d "@$phone_stop_date" +"%H:%M") 
    logger -p local0.notice "CaleControl: set job to stop internet on  device:[phone] at phone_stop_date:["$(date -d "@$phone_stop_date")"]"
  fi
}

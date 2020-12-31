
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
  
  redirect
  # set a new job to stop 

  n=$(date +"%s")
  ps4_stop_date=$(cat ps4_stop_date.txt)
  phone_stop_date=$(cat phone_stop_date.txt)
  
  if [[ $n < $ps4_stop_date ]]; then 
    echo "ps4_stop.sh" | at $(date -d "@$(<ps4_stop_date.txt)" +"%H:%M") 
  fi 
  if [[ $n < $phone_stop_date ]]; then
    echo "phone_stop.sh" | at $(date -d "@$(<phone_stop_date.txt)" +"%H:%M") 
  fi
}

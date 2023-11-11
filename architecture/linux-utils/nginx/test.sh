#!/bin/bash
###########
# sudo apt install inotify-tools
#
while true
do
#  inotifywait --exclude .swp -e create -e modify -e delete -e move /etc/nginx/conf.d
#  nginx -t
  inotifywait --exclude .swp -e create -e modify -e delete -e move ./
  echo "Detected Nginx Configuration Change "
#  if [ $? -eq 0 ]
#  then
#   echo "Detected Nginx Configuration Change"
#   echo "Executing: nginx -s reload"
#  fi
done

#!/bin/bash

if [ ! -e /etc/minidlna.configured ]
then
  sed -i s@media_dir=@\#media_dir=@g /etc/minidlna.conf

  echo "friendly_name=$SRVNAME" >> /etc/minidlna.conf

  for folder in $( echo $FOLDERS | xargs -d',' )
  do
    echo "media_dir=$folder" >> /etc/minidlna.conf
  done

  [ -z $PORT ] && { PORT=8200; }
  sed -i "s@port.*00@port $PORT@g" /etc/minidlna.conf 

  date > /etc/minidlna.configured
fi

# remove stucked pid file
rm -f /run/minidlna/minidlna.pid
# start minidlna
minidlnad -d

#/bin/bash

#!/bin/bash

if [ ! -e /etc/minidlna.configured ]
then
  sed -i s@media_dir=@\#media_dir=@g /etc/minidlna.conf

  echo "friendly_name=$SRVNAME" >> /etc/minidlna.conf

  for folder in $( echo $FOLDERS | xargs -d',' )
  do
    echo "media_dir=$folder" >> /etc/minidlna.conf
  done

  date > /etc/minidlna.configured
fi

minidlnad -d

#/bin/bash

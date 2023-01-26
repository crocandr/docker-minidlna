#!/bin/bash

if [ ! -e /etc/minidlna.configured ]
then
  # set friendly name
  sed -i "s@.*friendly_name=.*@friendly_name=$SRVNAME@g" /etc/minidlna.conf
  # set port
  [ -z $PORT ] && { PORT=8201; }
  sed -i "s@port=.*00@port=$PORT@g" /etc/minidlna.conf

  # remove media folders
  sed -i s@media_dir=@\#media_dir=@g /etc/minidlna.conf
  # add media folders to the end of file
  for folder in $( echo $FOLDERS | xargs -d',' )
  do
    echo "media_dir=$folder" >> /etc/minidlna.conf
  done

  date > /etc/minidlna.configured
fi

# minissdp
#  get interfaces
if [ -z "$SSDP_IFACE" ]
then
  SSDP_INTERFACE="$( ip addr | grep -i up | egrep -iv '(lo|br-|veth|docker).*:' | cut -f2 -d':' | tr -d ' ' )"
  if [ $( echo "$INTERFACE" | wc -l ) -gt 1 ]
  then
    echo -e "You have more than one interface, choose one!:\n$SSDP_INTERFACE"
    exit 1
  fi
  SSDP_IFACE=$SSDP_INTERFACE
fi
if [ $( ss -lntpu | grep -i 1900 | wc -l ) -gt 0 ]
then
  echo "Warning, another UPNP service use same UDP port!"
  echo " Please stop another server and try again."
fi
minissdpd -i $SSDP_IFACE || { echo "SSDP service start problem"; exit 1; }


# remove stucked pid file
rm -f /run/minidlna/minidlna.pid
# start minidlna
minidlnad -d -v

#/bin/bash

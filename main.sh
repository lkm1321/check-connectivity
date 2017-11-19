#!/bin/bash

active_interfaces=`nmcli -t -f type c s -a`
connections_up=`nmcli -t -f name c s -a`

for ifname in $active_interfaces; do 
  if [ "$ifname" = "802-11-wireless" ]; then 
    echo "WiFi is up"
    exit
  fi
done

echo "WiFi seems down.. Checking if hotspot is still on"

for conname in $connections_up; do 
  if [ "$conname" = "hotspot" ]; then
    echo "hotspot is up"
    exit
  fi
done

echo "Hotspot is down... bringing up hotspot" 
nmcli c up hotspot
systemctl restart mavlink-router
exit 

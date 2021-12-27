#!/bin/bash

set -e

# get sudo access
sudo ls > /dev/null	

function connected_to_vpn {
  surfshark-vpn status | grep -q "Connected to Surfshark VPN"
  return $?
}


$(connected_to_vpn)
name=$(nmcli connection show --active | grep surfshark | awk '{ print $1 }')
nmcli connection down $name
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0
echo "VPN shut down and IPv6 enabled"


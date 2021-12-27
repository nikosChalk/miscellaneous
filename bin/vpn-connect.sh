#!/bin/bash

set -e

# get sudo access
sudo ls > /dev/null	

function connected_to_vpn {
  surfshark-vpn status | grep -q "Connected to Surfshark VPN"
  return $?
}


vpn_choice="nl-ams.prod.surfshark.com_udp"
# vpn_choice="gr-ath.prod.surfshark.com_udp"

$(! connected_to_vpn)
nmcli connection up $vpn_choice
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
echo "VPN up and IPv6 disabled"


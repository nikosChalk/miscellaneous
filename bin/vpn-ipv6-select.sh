#!/bin/bash

set -e

# get sudo access
sudo ls > /dev/null	

function connected_to_vpn {
  surfshark-vpn status | grep -q "Connected to Surfshark VPN"
  return $?
}


# ipv6_disabled="$(sysctl net.ipv6.conf.all.disable_ipv6 | awk '{print $NF}')"
if connected_to_vpn -eq 0; then
  sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
  echo "IPv6 disabled"
else
  sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0
  echo "IPv6 enabled"
fi


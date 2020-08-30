#!/bin/sh

connection_name=AlexaHotSpot
hotspot_ssid=nikoschalk-Alexa-HotSpot

if [ "$1" = "--create" ]; then

	nmcli con down $connection_name
	nmcli con delete $connection_name

	nmcli con add type wifi ifname wlp5s0 con-name $connection_name autoconnect no ssid $hotspot_ssid &&
	nmcli con modify $connection_name 802-11-wireless.mode ap 802-11-wireless.band bg &&
	nmcli con modify $connection_name 802-11-wireless.channel 1 &&
	nmcli con modify $connection_name 802-11-wireless.mac-address F4:06:69:54:2F:31 &&
	nmcli con modify $connection_name ipv4.method shared &&

	nmcli con modify $connection_name wifi-sec.key-mgmt wpa-psk &&
	nmcli con modify $connection_name wifi-sec.proto '' &&
	nmcli con modify $connection_name +wifi-sec.proto wpa &&

	nmcli con modify $connection_name 802-11-wireless-security.pairwise '' &&
	nmcli con modify $connection_name +802-11-wireless-security.pairwise tkip &&
	nmcli con modify $connection_name +802-11-wireless-security.pairwise ccmp &&


	nmcli con modify $connection_name 802-11-wireless-security.group '' &&
	nmcli con modify $connection_name +802-11-wireless-security.group tkip &&
	nmcli con modify $connection_name +802-11-wireless-security.group ccmp &&


	nmcli con modify $connection_name wifi-sec.psk "abcd1234"
elif [ "$1" = "--up" ]; then
	nmcli con up $connection_name
elif [ "$1" = "--down" ]; then
	nmcli con down $connection_name
else
	echo "valid parameters are --create, --up, --down"
fi;
	
#sudo service network-manager restart


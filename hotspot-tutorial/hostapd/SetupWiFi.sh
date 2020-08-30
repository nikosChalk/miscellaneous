#!/bin/bash


sed -i 's#^DAEMON_CONF=.*#DAEMON_CONF=/etc/hostapd/hostapd.conf#' /etc/init.d/hostapd

cat <<EOF > /etc/dnsmasq.conf
log-facility=/var/log/dnsmasq.log
#address=/#/10.0.0.1
#address=/google.com/10.0.0.1
interface=wlp5s0
dhcp-range=10.0.0.10,10.0.0.250,12h
dhcp-option=3,10.0.0.1
dhcp-option=6,10.0.0.1
#no-resolv
log-queries
EOF

service dnsmasq start

ifconfig wlp5s0 up
ifconfig wlp5s0 10.0.0.1/24

iptables -t nat -F
iptables -F
iptables -t nat -A POSTROUTING -o enp4s0 -j MASQUERADE
iptables -A FORWARD -i wlp5s0 -o enp4s0 -j ACCEPT
echo '1' > /proc/sys/net/ipv4/ip_forward

cat <<EOF > /etc/hostapd/hostapd.conf
interface=wlp5s0
driver=nl80211
channel=1

ssid=nikoschalk-Alexa-HotSpot
wpa=1 #1=WPA1 only, 2=WPA2 only
wpa_key_mgmt=WPA-PSK
wpa_passphrase=abcd1234
wpa_pairwise=TKIP CCMP CCMP-256
# Change the broadcasted/multicasted keys after this many seconds.
wpa_group_rekey=600
# Change the master key after this many seconds. Master key is used as a basis
wpa_gmk_rekey=86400

EOF

service hostapd start

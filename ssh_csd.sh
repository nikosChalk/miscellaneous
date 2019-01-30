#!/bin/sh

params=1
gate1="gate1"
gate2="gate2"

ORANGE='\033[0;33m'
BLUE='\033[0;34m'
LIGHT_GREEN='\033[1;32m' #Light Green
NC='\033[0m' # No Color

clear
echo
echo "${LIGHT_GREEN}Starting ssh to csd.uoc.gr ... ${NC}"

if [ "$#" -lt "$params" ]; then
	echo "${ORANGE}Gate parameter omitted. Default gate is: ${BLUE}$gate2${NC}"
	gate=$gate2
else
	gate=$1
fi


if [ "$gate" != "$gate1" ] && [ "$gate" != "$gate2" ]; then
	echo "Invalid parameter. Valid parameters are only \"$gate1\" and \"$gate2\""
	exit 2
fi

old_term=$TERM
TERM=xterm-color
ssh csd3638@$gate.csd.uoc.gr -o HostKeyAlgorithms=+ssh-dss -o PubKeyAcceptedKeyTypes=+dsa
TERM=$old_term

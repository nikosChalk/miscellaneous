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
	machine="kiwi"
	echo "${ORANGE}Machine parameter omitted. Default machine is: ${BLUE}$machine${NC}"
else
	machine=$1
fi

old_term=$TERM
TERM=xterm-color
ssh csd3638@$machine.csd.uoc.gr #-o HostKeyAlgorithms=+ssh-dss -o PubKeyAcceptedKeyTypes=+dsa
TERM=$old_term

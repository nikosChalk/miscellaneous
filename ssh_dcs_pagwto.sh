#!/bin/sh

ORANGE='\033[0;33m'
BLUE='\033[0;34m'
LIGHT_GREEN='\033[1;32m' #Light Green
NC='\033[0m' # No Color

clear
echo
echo "${LIGHT_GREEN}Starting ssh to 139.91.70.66 (pagwto) on port 3215 ... ${NC}"

old_term=$TERM
#TERM=xterm-color
ssh nikoschalk@139.91.70.66 -p 3215
#TERM=$old_term

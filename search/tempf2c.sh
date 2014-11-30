#!/bin/bash
# tempf2c.sh
# Author: Ken O Burtch
# Description: Convert Fahrenheit to Celsius

shopt -s -o nounset 

declare -i FTEMP
declare -i CTEMP

read -p "Enter a Fahrenheit temperature: " FTEMP

CTEMP="(5*(FTEMP-32))/9"
printf "The Celsius temperature is %d\n" "$CTEMP"

exit 0

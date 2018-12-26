#!/bin/bash

# This script puts a wireless interface into monitor mode

echo '*** Monitor Mode Toggler with Airmon-Ng! ***' # introduce script

read -p "PROMPT: Enter wireless interface name. '(Hit enter for default wlan0)'" wlanInt # define wlan0

# check if wlan0 has been defined, and if not then set to wlan0
if [ -z $wlanInt ]; then 
	echo Nothing entered... 
	wlanInt=wlan0
	echo Wireless interface now set to: $wlanInt
fi

# confirm with user if they want to kill services that could block entering monitor mode
read -p "PROMPT: Kill services blocking monitor mode? (Y/N)" confirm

# begin entering interface into monitor mode
echo "***Taking down wireless interface.***" && ifconfig $wlanInt down
if [[ $confirm == [yY] ]]; then # if user confirmed, kill the services
	echo "***Killing services.***" && airmon-ng check kill
fi
echo "***Configuring monitor mode.***" && airmon-ng start $wlanInt
echo "***Bringing up interfance.***" && ifconfig wlan0mon up

# display iwconfig settings and confirm to user new interface setup
iwconfig
echo "*** Congratulations. You're now in monitor mode! $wlanInt has now become wlan0mon. ***"
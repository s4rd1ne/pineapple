#!/bin/bash
#Pineapple grow control rev1
#Inverts the value of a given GPIO ID
#
#Under CC BY-NC-SA
#Distribution, redesign or tweaking encouraged, although noncommercial.
#For further information, visit https://creativecommons.org/licenses/

touch /var/log/pineapple.log

if [ $# == 1 ]; then

		#If the called GPIO is not yet prepared for usage, do it now.
		# > Preparing it for further implementation
		# > Making it an output pin
		if ! [ -a /sys/class/gpio/gpio$1 ]; then
				echo "$1" > /sys/class/gpio/export
				echo "out" > /sys/class/gpio/gpio$0/direction
				echo "[$(date +%d-%m-%Y) $(date +%H:%M:%S)][ok] gpioinvert.sh called: Setting up the GPIO$1" >> /var/log/pineapple.log
		fi

		VALUE = cat /sys/class/gpio/gpio$1/value

		#Inverting the value
		if [ VALUE == 0 ]; then
			echo "1" > /sys/class/gpio/gpio$1/value
			echo "[$(date +%d-%m-%Y) $(date +%H:%M:%S)][ok] gpioinvert.sh called: Setting GPIO$1 to HIGH" >> /var/log/pineapple.log

		else
			echo "0" > /sys/class/gpio/gpio$1/value
			echo "[$(date +%d-%m-%Y) $(date +%H:%M:%S)][ok] gpioinvert.sh called: Setting GPIO$1 to LOW" >> /var/log/pineapple.log
		fi
fi
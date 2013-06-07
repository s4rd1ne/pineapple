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
                echo "out" > /sys/class/gpio/gpio$1/direction
                echo -e "[$(date +%d-%m-%Y) $(date +%H:%M:%S)][\e[32mok\e[0m] gpioinvert.sh called: Setting up the GPIO$1" >> /var/log/pineapple.log
        fi

        #Inverting the value
        if [ $(cat /sys/class/gpio/gpio$1/value) = "1" ]; then
                echo "0" > /sys/class/gpio/gpio$1/value
                echo -e "[$(date +%d-%m-%Y) $(date +%H:%M:%S)][\e[32mok\e[0m] gpioinvert.sh called: Setting GPIO$1 to LOW" >> /var/log/pineapple.log

        elif [ $(cat /sys/class/gpio/gpio$1/value) = "0" ]; then
                echo "1" > /sys/class/gpio/gpio$1/value
                echo -e "[$(date +%d-%m-%Y) $(date +%H:%M:%S)][\e[32mok\e[0m] gpioinvert.sh called: Setting GPIO$1 to HIGH" >> /var/log/pineapple.log

        #If anything breaks, log an alert
        else
                 echo -e "[$(date +%d-%m-%Y) $(date +%H:%M:%S)][\e[31mALERT\e[0m] gpioinvert.sh called: CAN NOT SWITCH GPIO" >> /var/log/pineapple.log
        fi
fi
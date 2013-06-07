#!/bin/bash
#Pineapple grow control rev1
#Script temp.sh
#Reads temperature values of cpu|GPIO sensor and logs it
#
#Under CC BY-NC-SA
#Distribution, redesign or tweaking encouraged, although noncommercial.
#For further information, visit https://creativecommons.org/licenses/

touch /var/log/pineapple.log

#Collects the Milligrades, processes them into bash readable format (non floating point)
#using bc
cputempmilli=$(cat /sys/class/thermal/thermal_zone0/temp)
cputempfloat=$(echo "scale=2; $cputempmilli / 1000.0" | bc)
cputemp=$(echo "scale=0; $cputempmilli / 1000" | bc)

#Debug
#
#echo $cputemp
#echo $cputempfloat
#echo $cputempmilli

if [[ "$cputemp" > 60 ]]; then

        #Log an alert if cpu temperature is over 60, hopefully never needed
        echo -e "[$(date +%d-%m-%Y) $(date +%H:%M:%S)][\e[31mALERT\e[0m] temp.sh called: CPU temperature at \e[31m$cputempfloat\e[0m TOO HOT!" >> /var/log/pineapple.log

elif [[ "$cputemp" < 61 ]]; then

        #Log the cpu temperature, everything working within expected parameters
        echo -e "[$(date +%d-%m-%Y) $(date +%H:%M:%S)][\e[32mok\e[0m] temp.sh called: CPU temperature at $cputempfloat" >> /var/log/pineapple.log

else
        #If anything doesnt go as expected, e.g. temperature not readable
        echo -e "[$(date +%d-%m-%Y) $(date +%H:%M:%S)][\e[33mwarning\e[0m] temp.sh called: CPU temperature could not be measured." >> /var/log/pineapple.log
fi
#Bash script for pinging subnet
#Author: Marek Bohm
#Copyright HiLASE 2016 :)


#!/bin/bash
INPUT=data.csv
OLDIFS=$IFS
IFS=,

is_alive_ping()
{
  ping -i 0.2 -w 1   $1 > /dev/null
  [ $? -eq 0 ] && echo Node with IP: $IP is up.
  [ $? -eq 1 ] && echo Node with IP: $IP did not reply.
  [ $? -eq 2 ] && echo Node with IP: $IP - Error code 2 - other error.
}

# Bash Menu Example
echo "Bash script for pingign HiLASE 100J Control System Parts"
PS3='Please enter your choice: '
options=("1 - Check node via PV name" "2 - Ping through whole subnet" "3 - Quit")
select opt in "${options[@]}"
do
    case $opt in
        "1 - Check node via PV name")
            echo "Enter the node name you want to check:"
            INPUT=data.csv
            OLDIFS=$IFS
            IFS=,
            read devname
            [ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
            while read name IP 
            do

            if test "$name" = "$devname"; then
               
	       echo "Name : $name"
	       echo "IP : $IP"
               is_alive_ping $IP

            fi
            
            done < $INPUT
            IFS=$OLDIFS

            ;;
        "2 - Ping through whole subnet")
            echo "Pinging through subnet according to data.csv..."
            INPUT=data.csv
            OLDIFS=$IFS
            IFS=,

            [ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
            while read name IP 
            do
	       echo "Name : $name"
	       echo "IP : $IP"
               is_alive_ping $IP

            done < $INPUT
            IFS=$OLDIFS
            ;;
        "3 - Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done





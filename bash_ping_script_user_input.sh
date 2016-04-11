#!/bin/bash
#start=`date +%s`
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

echo "Enter the node name you want to check:"
read devname
#grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' file.txt
IP_raw=$(grep -F $devname data.csv)
echo $IP_raw

IP=${IP_raw#$devname}
echo $IP

IP_NO_WHITESPACE="$(echo -e "${IP}" | tr -d '[[:space:]]')"
echo $IP_NO_WHITESPACE

IP_NO_LEAD_SPACE="$(echo -e "${IP}" | sed -e 's/^[[:space:]]*//')"
echo $IP_NO_LEAD_SPACE


ping $IP_NO_WHITESPACE
#ping -i 0.2 -w 1 $IP_NO_LEAD_SPACE

#FOO_NO_LEAD_SPACE="$(echo -e "${FOO}" | sed -e 's/^[[:space:]]*//')"


#[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
#while read name IP 
#do
#	echo "Name : $name"
#	echo "IP : $IP"
#        #ping -i 0.2 -w 1 $IP
#        is_alive_ping $IP

#done < $INPUT
#IFS=$OLDIFS


#end=`date +%s`
#runtime=$((end-start))
#echo "The runtime: $runtime second(s)."

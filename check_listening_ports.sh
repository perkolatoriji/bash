#!/bin/bash

#################################################################
# Creation: Edouard Lamoine
# Last Modification: 13 mai 2015
# This script is verifying if no unregistered ports are listening on the localhost.
#
# USAGE: ./check_listening_ports enter_your_authorized_ports_then_services_here_separed_with_spaces
#
# ex: ./check_listening_ports 22 80 25 nrpe mysqld
#
#################################################################

#Memo for Nagios outputs
#STATE_OK=0
#STATE_WARNING=1
#STATE_CRITICAL=2
#STATE_UNKNOWN=3

#
##
###
####
#####
######
#######
########
#########
##########

#Plugin made by Edouard Lamoine
#All rights reserved.

##########
#########
########
#######
######
#####
####
###
##
#

#MAIN


if [[ ! $* ]]; then
echo "Error: no ports/services were specified."
exit 3
fi

allowed_ports=$*
MAX_PORTS=25

STATE=$(netstat -lnt | awk '{print $4}' | awk -F ":" '{print $NF}')
STATE=${STATE//[!0-9]/ }

STATENAMES=$(netstat -lntp | awk '{print $7}' | awk -F "/" '{print $NF}')
STATENAMES=`echo $STATENAMES |cut -d " " -f2-`

#Remove any SE SERVER ID IDLE or PR PRIVATE
STATENAMES=`echo ${STATENAMES/"(SERVER)"/}`
STATENAMES=`echo ${STATENAMES/"(SE"/}`
STATENAMES=`echo ${STATENAMES/"(IDLE)"/}`
STATENAMES=`echo ${STATENAMES/"(ID"/}`
STATENAMES=`echo ${STATENAMES/"(PRIVATE)"/}`
STATENAMES=`echo ${STATENAMES/"(PR"/}`

#update number of ports, will be used in loops
res="${STATE//[^ ]}"
MAX_PORTS=${#res}
MAX_PORTS=$((MAX_PORTS/2))

#Calculate number of ports in input
res="${allowed_ports//[^ ]}"
res=${#res}
res=$((res + 1))

#If more ports were passed in argument than current running ports, update number of ports
if [ $res -gt $MAX_PORTS ]; then
MAX_PORTS=$res;
fi

#remove identics ports&services names found by netstat
for i in $(eval echo "{1..$MAX_PORTS}")
do
SUBSTRINGDB=`echo $STATE| cut -d' ' -f $i`

        if [ $SUBSTRINGDB ]; then

        countdb=0
                for j in $(eval echo "{1..$MAX_PORTS}")
                do
                SUBSTRINGDB2=`echo $STATEDB| cut -d' ' -f $j`

                        if [ $SUBSTRINGDB2 ]; then
                                 if [ $SUBSTRINGDB == $SUBSTRINGDB2 ];
                                then

                                 countdb=$((countdb+1))
                                fi
                        fi
                done
        fi

if [ $countdb == 0 ]; then
SERVICENAME=`echo $STATENAMES| cut -d' ' -f $i`
STATESERVICEDB="$STATESERVICEDB $SERVICENAME"
STATEDB="$STATEDB $SUBSTRINGDB"
fi

done


error=0
error_string="CRITICAL - Unexpected listening ports: "

#Test for allowed ports vs listening ports
for i in $(eval echo "{1..$MAX_PORTS}")
do
SUBSTRING=`echo $STATEDB| cut -d' ' -f $i`
SUBSTRINGSNAME=`echo $STATESERVICEDB| cut -d' ' -f $i`

        if [ $SUBSTRING ]; then

        count=0
                for j in $(eval echo "{1..$MAX_PORTS}")
                do
                SUBSTRING2=`echo $allowed_ports| cut -d' ' -f $j`

                        if [ $SUBSTRING2 ]; then
                                 if [ $SUBSTRING == $SUBSTRING2 ];
                                then

                                 count=$((count+1))
                                fi

                                if [ $SUBSTRINGSNAME == $SUBSTRING2 ];
                                then

                                 count=$((count+1))
                                fi

                        fi
                done
        fi

if [[ $count == 0 && $SUBSTRING ]]; then
error=$((error+1))
error_string="$error_string $SUBSTRING/$SUBSTRINGSNAME"
fi

done

        if [ $error != 0 ];
        then
        echo $error_string
        exit 2
        fi

        if [ $error == 0 ];
        then
        echo "OK - No unexpected ports are listening"
        exit 0
        fi
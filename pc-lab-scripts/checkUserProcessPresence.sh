#!/bin/bash
#
# A tool to count user processes on selected computers within the network
#
# V2 07/2019 Sebastian Engel


read -d '' USAGEINFO << EOF

	How to use this script:
		./checkUserProcessPresence.sh ALL
			Counts the User Processes on computer in the cluster.

		./checkUserProcessPresence.sh allserver
			Counts the User Processes on the Opti-Cluster.

		./checkUserProcessPresence.sh allws
			Counts the User Processes all Workstations.

		./ceckUserProcessPresence.sh list ws01 ws04 ws15 server01
		Counts the User Processes only selected computers. 

	
		./ceckUserProcessPresence.sh help
			Shows the above information.

EOF




if [ -z "$1" ]; then
	echo -e "\nWARNING. Input insufficient. Arguments needed.\n\n"
	echo "$USAGEINFO"
	exit
fi	


case "$1" in
        "allserver" ) selected="server$(seq -s' server' -w 01 08)" ;;
        "allws" ) selected="ws$(seq -s' ws' -w 01 15)" ;;
        "ALL" ) selected="server$(seq -s' server' -w 01 08) ws$(seq -s' ws' -w 01 15) master server" ;;
        "list" )
                 if [ -z "${@:2}" ]; then
                        echo -e "\nWARNING. Input insufficient. More arguments needed.\nSee this example:\n"
                        echo -e "\t\t./ceckUserProcessPresence.sh list ws01 ws04 ws15 server01\n\t\t\tCounts the User Processes only selected computers.\n"
                        exit
                else
                        selected="${@:2}"
                fi ;;
	"help" ) echo "$USAGEINFO"
		exit ;;
        * )     echo -e "\nWARNING. Input is not understood.\n\n"
                echo "$USAGEINFO" 
		exit ;;
esac

echo "Counting User processes on these computers:"
for s in $selected
do
	if $(nc -z $s 22 > /dev/null 2>&1)
	then
	        echo "checking ${s}:"
                # Filter, specific for pc-lab
                STATUS=$(timeout 4s ssh $s ps aux | tail -n +2 | sed '/sshd/d;/ps aux/d' |cut -d' ' -f1 |sort| sed '/root/d;/munge/d;/dbus/d;/nslcd/d;/postfix/d;/68/d;/ganglia/d;/ntp/d;/rpc/d;/rpcuser/d;/rtkit/d;/apache/d;/ldap/d;/pdnsd/d' | uniq -c )
                RESPOND=$(echo $STATUS | wc -w)
 
                if [ $RESPOND -eq 0 ]; then echo "";
                else echo "$STATUS"; fi
            else
                echo "WARNING! ${s} couldn't be reached. Timed out, or unknown."
            fi
done
 
wait
echo "Survey done"


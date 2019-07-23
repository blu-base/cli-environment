#!/bin/bash

# A tool to kill all Starccm processes and related MPI sessions on selected computers.
#
# V2 07/2019 Sebastian Engel





read -d '' USAGEINFO << EOF

    How to use this script:

	./starccmCleanup.sh allserver
		Cleans up your StarCCM sessions on the Opti-Cluster.

	./starccmCleanup.sh allws
		Cleans up your StarCCM sessions all Workstations.

	./starccmCleanup.sh ALL
		Cleans up your StarCCM sessions on all computers in the PC-Cluster network.

	./starccmCleanup.sh list ws01 ws04 ws15 server01
		Cleans up your StarCCM sessions only selected computers.  


	./starccmCleanup.sh help
		Shows the above information.
EOF







 	if [ -z "$1" ]; then
		echo -e "\nWARNING. Input insufficient. An option needed:\n\n"
		echo "$USAGEINFO"
		exit
	fi	


case "$1" in
	"allserver" ) selected="server$(seq -s' server' -w 01 08)" ;;
	"allws" ) selected="ws$(seq -s' ws' -w 01 15)" ;;
	"ALL" ) selected="server$(seq -s' server' -w 01 08) ws$(seq -s' ws' -w 01 15) master" ;;
	"list" )
	         if [ -z "${@:2}" ]; then
        	        echo -e "\nWARNING. Input insufficient. See the example:\n\t./starccmCleanup.sh list ws01 ws04 ws15 server01\n\n"
                	exit
        	else
			selected="${@:2}" 
		fi ;;
	"help" ) echo "$USAGEINFO"; exit ;;
	* ) 	echo -e "\nWARNING. Input is not understood.\n\n"
		echo "$USAGEINFO"
		exit ;;
esac


    echo "Manually cleaning up starccm processes running on these computers:"
    for s in $selected
    do
	    if $(nc -z $s 22 > /dev/null 2>&1)
	    then 
            	echo "cleaning $s"         
            	ssh -o ConnectTimeout=5 $s pkill -9 starccm+ 2>/dev/null
            	ssh -o ConnectTimeout=5 $s pkill -9 star-ccm+ 2>/dev/null
            	ssh -o ConnectTimeout=5 $s pkill -9 mpid 2>/dev/null
	    else 
		echo "WARNING! Computer $s couldn't be reached. Timed out, or unknown."
	    fi
    done



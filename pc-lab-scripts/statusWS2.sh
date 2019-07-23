#!/bin/bash
# Checking load and logins on workstations in pc-cluster with use of "w"
# by Sebastian Engel, 2014,2015

function callStatus {
		# calling information
		ALLUSAGE=$(timeout 10s ssh $1 '/home/engel/findFreeWS/currentUsage.sh -c')

		echo -e "$ALLUSAGE" >> tempStatus
}

function statusWS
{
	rm -f tempStatus*
	echo -e "Name\tUser\tCPU/%\tMemory/%"
	PCLIST="master ws01 ws02 ws03 ws04 ws05 ws06 ws07 ws08 ws09 ws10 ws11 ws12 ws13 ws14 ws15 server01 server02 server03 server04 server05 server06 server07 server08 server"

	for PC in $PCLIST
	do
		callStatus $PC &
	done

	wait

	while read -r line
	do
		if [ $(echo -e "$line" | cut -d$'\t' -f3 | cut -d. -f1) -gt 5 ] ||  [ $(echo -e "$line" | cut -d$'\t' -f4 | cut -d. -f1) -gt 5 ]
		then
			echo -e "$line" >> tempStatus2
		fi
	done < tempStatus | sort

	for PC in $PCLIST
	do
		if grep -q "$PC" ./tempStatus2 
		then
			continue	
		else
			FREEPC="$PC $FREEPC"
		fi
	done
	
	cat tempStatus2 | sort
		
	echo ""
	echo "Currently Unsed Machines"
	echo "${FREEPC}"


	
	rm -f tempStatus*
}

statusWS 

exit

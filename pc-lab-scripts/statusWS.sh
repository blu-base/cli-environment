#!/bin/bash
# Checking load and logins on workstations in pc-cluster with use of "w"
# by Sebastian Engel, 2014,2015

function callStatus {
		# calling information
		wstat=$(timeout 2s ssh $1 'w -sf')
                # uniq user logins
		users=$(echo "$wstat" | cut -d' ' -f1 | tail -n +3 | sort | uniq )
		logins=$(echo "$wstat" | tail -n +3 | awk '{ print $2; }' | awk '!/pts\//' | uniq | wc -w) 
		# 1 min load
		load=$(echo "$wstat" | head -1)
		load=$(echo ${load:${#load}-19} | cut -d',' -f1|cut -d' ' -f2)

		echo -e "$1    \t$logins\t$load\t$(echo "$users" | tr -s "\n" " ")" >> tempStatus
}

function statusWS
{
	rm -f tempStatus
	echo "unique Desktop Logins, Terminal logins and pc load status."
	echo -e "Name\t\tLogins\tLoad\tAll Users"
	#for i in master server ws01 ws02 ws03 ws04 ws05 ws06 ws07 ws08 ws09 ws10 ws11 ws12 ws13 ws14 ws15 server01 server02 server03 server04 server05 server06 server07 server08
	for i in master server ws01 ws02 ws03 ws04 ws05 ws06 ws07 ws09 ws10 ws11 ws12 ws13 ws14 ws15 server01 server02 server03 server04 server05 server06 server07 server08
	do
		callStatus $i &
	done

	wait
	
	cat "./tempStatus" | sort
	rm -f tempStatus
}

statusWS 

exit

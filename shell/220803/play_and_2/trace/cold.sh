#!/bin/bash

	for num in {1..8}
	do
		file="trace_$num.txt"
		cat $file | grep "total sent cold" | grep  swap_counter_dump | awk -F "remote: " '{print $2}' 
	done


	for num in {1..8}
	do
		file="trace_$num.txt"
		cat $file | grep "total faulted cold" | grep  swap_counter_dump | awk -F "remote: " '{print $2}' 
	done


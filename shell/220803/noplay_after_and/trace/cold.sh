#!/bin/bash

	for num in {1..8}
	do
		file="trace_$num.txt"
		cat $file | grep "total sent cold" | grep -v swap_counter_dump | awk -F "remote: " '{print $2}' 
		cat $file | grep "total faulted cold" | grep -v swap_counter_dump | awk -F "remote: " '{print $2}' 
	done


#!/bin/bash

for id in {0..8}
do
	for file in trace_*.txt
	do
		target=`cat $file | grep "target sent id $id" | wc -l`
		hit=`cat $file | grep "prefetch hit id $id" | wc -l`
		fault=`cat $file | grep "prefetch fault id $id" | awk -F "do_swap_page:" '{print $2}' | awk '!x[$0]++ {print $0}' |  wc -l`
		echo "$file id $id: $target $hit $fault"
	done
done


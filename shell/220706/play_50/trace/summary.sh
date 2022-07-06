#!/bin/bash

for id in {0..8}
do
	for num in {0..0}
	do
		file="trace_$num.txt"
		
		target=`cat $file | grep "target sent id $id" | wc -l`
		hit=`cat $file | grep "prefetch hit id $id" | wc -l`
		fault=`cat $file | grep "prefetch fault id $id" | awk -F "do_swap_page:" '{print $2}' | awk '!x[$0]++ {print $0}' |  wc -l`
		miss=`cat $file | grep "prefetch miss id $id"  |  wc -l`
		echo "$file id $id: $target $hit $fault $miss"

	done


	for num in {1..8}
	do
		file="trace_$num.txt"
		file_before="trace_$(($num-1)).txt"
		cat $file_before | sed -n "/prefetch_handler.*$id,*/,\$p" > temp1
		cat $file | sed -n "1,/prefetch_handler.*$id,*/p" > temp2
		target1=`cat temp1 | grep "target sent id $id" | wc -l`
		target2=`cat temp2 | grep "target sent id $id" | wc -l`
		target=$(($target1 + $target2))
		rm temp1 temp2
		hit=`cat $file | grep "prefetch hit id $id" | wc -l`
		fault=`cat $file | grep "prefetch fault id $id" | awk -F "do_swap_page:" '{print $2}' | awk '!x[$0]++ {print $0}' |  wc -l`
		miss=`cat $file | grep "prefetch miss id $id"  |  wc -l`
		echo "$file id $id: $target $hit $fault $miss"
	done
done


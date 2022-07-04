#!/bin/bash


for file in no*.txt
do
	target=`cat $file | grep "target sent" | wc -l`
	hit=`cat $file | grep "prefetch hit" | wc -l`
	fault=`cat $file | grep "prefetch fault" | awk -F "do_swap_page:" '{print $2}' | awk '!x[$0]++ {print $0}' |  wc -l`
	miss=`cat $file | grep "prefetch miss" | wc -l`
	echo $file $target $hit $fault $miss
done


for file in yes*.txt
do
	target=`cat $file | grep "target sent" | wc -l`
	hit=`cat $file | grep "prefetch hit" | wc -l`
	fault=`cat $file | grep "prefetch fault" | awk -F "do_swap_page:" '{print $2}' | awk '!x[$0]++ {print $0}' |  wc -l`
	miss=`cat $file | grep "prefetch miss" | wc -l`
	echo $file $target $hit $fault $miss
done

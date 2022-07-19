#!/bin/bash


for file in no*.txt
do
	target=`cat $file | grep "target sent id 2" | wc -l`
	hit=`cat $file | grep "prefetch hit id 2" | wc -l`
	fault=`cat $file | grep "prefetch fault id 2" | awk -F "do_swap_page:" '{print $2}' | awk '!x[$0]++ {print $0}' |  wc -l`
	miss=`cat $file | grep "prefetch miss id 2" |  wc -l`
	echo $file $target $hit $fault $miss
done


for file in yes*.txt
do
	target=`cat $file | grep "target sent id 2" | wc -l`
	hit=`cat $file | grep "prefetch hit id 2" | wc -l`
	fault=`cat $file | grep "prefetch fault id 2" | awk -F "do_swap_page:" '{print $2}' | awk '!x[$0]++ {print $0}' |  wc -l`
	miss=`cat $file | grep "prefetch miss id 2" |  wc -l`
	echo $file $target $hit $fault $miss
done

for file in no*.txt
do
	target=`cat $file | grep "target sent id 4" | wc -l`
	hit=`cat $file | grep "prefetch hit id 4" | wc -l`
	fault=`cat $file | grep "prefetch fault id 4" | awk -F "do_swap_page:" '{print $2}' | awk '!x[$0]++ {print $0}' |  wc -l`
	miss=`cat $file | grep "prefetch miss id 4" |  wc -l`
	echo $file $target $hit $fault $miss
done


for file in yes*.txt
do
	target=`cat $file | grep "target sent id 4" | wc -l`
	hit=`cat $file | grep "prefetch hit id 4" | wc -l`
	fault=`cat $file | grep "prefetch fault id 4" | awk -F "do_swap_page:" '{print $2}' | awk '!x[$0]++ {print $0}' |  wc -l`
	miss=`cat $file | grep "prefetch miss id 4" |  wc -l`
	echo $file $target $hit $fault $miss
done

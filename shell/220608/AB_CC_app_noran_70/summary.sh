#!/bin/bash


for num in {1..8}
do

	echo "#####id $num #####"


for file in no*.txt
do
	target=`cat $file | grep "target sent id $num" | wc -l`
	hit=`cat $file | grep "prefetch hit id $num" | wc -l`
	fault=`cat $file | grep "prefetch fault id $num" | awk -F "do_swap_page:" '{print $2}' | awk '!x[$0]++ {print $0}' |  wc -l`
	miss=`cat $file | grep "prefetch miss id $num" | wc -l`
	echo $file $target $hit $fault $miss
done


for file in yes*.txt
do
	target=`cat $file | grep "target sent id $num" | wc -l`
	hit=`cat $file | grep "prefetch hit id $num" | wc -l`
	fault=`cat $file | grep "prefetch fault id $num" | awk -F "do_swap_page:" '{print $2}' | awk '!x[$0]++ {print $0}' |  wc -l`
	miss=`cat $file | grep "prefetch miss id $num" | wc -l`
	echo $file $target $hit $fault $miss
done

done

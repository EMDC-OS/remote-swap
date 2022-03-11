#!/bin/bash

for file in {0..6}
do
#	echo $file.txt
#	echo =================
	for var in {0..8}
	do
		min=$(($var*10))
		max=$(($min+10))
		cat $file.txt | grep TOTAL | awk "NR>$min&&NR<=$max" | awk '{sum1 += $2} {sum2+= $5} END { print sum1"  " sum2 }'
	done
#	echo =================

done


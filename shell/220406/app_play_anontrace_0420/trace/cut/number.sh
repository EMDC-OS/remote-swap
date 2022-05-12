#!/bin/bash

echo "arg is {app}"
app=${1}


for num in {0..9}
do

	awk '!x[$2$4]++ {print $0}' cut_${app}_${num}.txt > temp3
	total=`cat temp3 | wc -l`


	i=1

	echo 0 >> temp1
	while [ "$i" != "$total" ]
	do

		j=$(($(($total/10))+1))
		echo $(($i/$j)) >> temp1

        i=$(($i+1))
	
	done


	paste -d ' ' temp3 temp1 > temp2

	mv temp2 cut_${app}_${num}.txt 

	rm temp1
	rm temp3

 

done



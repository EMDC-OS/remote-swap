#!/bin/bash

echo "arg is {app} {tgids(file)}"
app=${1}
file=${2}


for num in {0..9}
do
	while read line
	do
		cat cut_${app}_${num}.txt | grep -v "tgid $line " > temp1
		mv temp1 cut_${app}_${num}.txt
	done < $file

done




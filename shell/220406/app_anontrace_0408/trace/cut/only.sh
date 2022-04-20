#!/bin/bash

echo "arg is {app} {tgid or name}"
app=${1}
v=${2}
r=${v//[0-9]/}


for num in {0..9}
do

	if [ -z "$r" ] ; then
		cat cut_${app}_${num}.txt | grep "tgid $v " > temp1
	else
		cat cut_${app}_${num}.txt | grep "$v" > temp1
	fi
	
	mv temp1 cut_${app}_${num}.txt
 

done




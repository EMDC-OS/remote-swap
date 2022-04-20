#!/bin/bash
app=${1}


for num in {0..9}
do

	

	cat ${app}_${num}.txt| grep "swapin tgid" | awk -F "swapin" '{print $2}' | awk '{$3=""; print $0}' | awk -F "\" " '{print $1 "\" " }' > temp1
	cat ${app}_${num}.txt| grep "swapin tgid" | awk -F "swapin" '{print $2}' | awk '{$3=""; print $0}' | awk -F "\" " '{print $2}' | awk '{print $1}' > temp2
	

	paste -d ' ' temp1 temp2 > cut/cut_${app}_${num}.txt


done

rm temp1 temp2



#!/bin/bash
app=${1}

rm temp1


for num in {0..9}
do

	

	cat ${app}_${num}.txt| grep "swapin tgid" | awk -F "swapin" '{print $2}' | awk '{$3=""; print $0}' | awk -F "\" " '{print $1 "\" " }' | awk '{print $2}' >>temp1



done


cat temp1 | sort -u -n > temp2

rm temp3

while read tgid
do
	tgidname=`cat ../${app}.txt | awk -v str=$tgid '{if($8!=""&&$2==str)print $0}' | awk '{print $2 " " $8}'`
		

	if [ "$tgidname" != "" ] ; then
	
		echo $tgidname >> temp3
	
	else 

		echo $tgid "???" >> temp3
	
	fi
	

done <  temp2


for num in {0..9}
do

	rm temp4

	while read tgid
	do
		cat ${app}_${num}.txt| grep "swapin tgid" | awk -F "swapin" '{print $2}' | awk -v str=$tgid '{if($2==str)print $0}' | awk -F "\".*\"" '{print $1 " " $2}'| awk '{print $1 " " $2  " " $4}'|sort -u | wc -l >> temp4
	
	done <  temp2


	paste -d ' ' temp3 temp4 > temp5

	mv temp5 temp3

done

cat temp3 > ${app}_per_proc.txt

rm temp1
rm temp2
rm temp3
rm temp4


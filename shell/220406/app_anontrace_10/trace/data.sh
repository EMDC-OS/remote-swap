#!/bin/bash
app=${1}


for num in {9..1}
do

	cur=${app}_${num}.txt
	before=${app}_$(($num - 1 )).txt

	echo $cur $before
	last=`sed -n '$p' ${before} | awk '{print $4}'`
	lastvm=`sed -n '$p' ${before} | awk '{print $NF}'`

	sed -n "/$last.*$lastvm/,\$p" ${cur} | sed '1d'| grep vma | grep "swapin tgid" | awk -F "swapin" '{print $2}' > ./cut/${cur}


done


cat ${app}_0.txt | sed '1,11d' | grep vma | grep "swapin tgid" | awk -F "swapin" '{print $2}'  > ./cut/${before}


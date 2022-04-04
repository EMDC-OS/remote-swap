#!/bin/bash
app=${1}

cur=${app}_3.txt
before=${app}_2.txt

last=`sed -n '$p' ${before} | awk '{print $4}'`
lastvm=`sed -n '$p' ${before} | awk '{print $NF}'`

sed -n "/$last.*$lastvm/,\$p" ${cur} | sed '1d'| grep vma | grep "swapin tgid" | awk -F "swapin" '{print $2}' > ./cut/${cur}


cur=${app}_2.txt
before=${app}_1.txt

last=`sed -n '$p' ${before} | awk '{print $4}'`
lastvm=`sed -n '$p' ${before} | awk '{print $NF}'`

sed -n "/$last.*$lastvm/,\$p" ${cur} | sed '1d'| grep vma | grep "swapin tgid" | awk -F "swapin" '{print $2}' > ./cut/${cur}


cat ${before} | sed '1,11d' | grep vma | grep "swapin tgid" | awk -F "swapin" '{print $2}'  > ./cut/${before}


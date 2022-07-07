#!/bin/bash
num=${1}
id=${2}

rm unknown_1

file="trace_$num.txt"
file_before="trace_$(($num-1)).txt"
cat $file_before | sed -n "/id $id, table . || 0:/,\$p" > temp1
cat $file | sed -n "1,/id $id, table . || 0:/p" >> temp1
cat temp1 | grep "target sent id $id" | awk '{print $NF}' > target_1
rm temp1
cat $file | grep "prefetch fault id $id" | awk '{print $NF}' > faultmiss_1
cat $file | grep "prefetch miss id $id" | awk '{print $NF}' >> faultmiss_1

while read target
do
	abc=`cat faultmiss_1 | grep $target`
	if [ -z "$abc" ]; then
    echo $target >> unknown_1
	fi

done < target_1



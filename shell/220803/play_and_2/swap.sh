#!/bin/bash

for var in {0..19}
do
	cat ${var}.txt | grep "/dev/block/zram0" | awk '{print $4}'   >> temp1
done



for var in {0..19}
do
	cat ${var}.txt | grep "/dev/nbd0" | awk '{print $4}' >> temp2
done


paste -d ' ' temp1 temp2

rm temp1
rm temp2


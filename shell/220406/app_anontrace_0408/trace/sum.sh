#!/bin/bash
app=${1}

for num in {3..12}
do

	

	cat ${app}_per_proc.txt | awk -v num=$num '{sum += $num} END { print sum }'



done

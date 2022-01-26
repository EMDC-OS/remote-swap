#!/bin/bash
name=${1}

for file in cut*${name}*.txt
do
	csplit -f ${file} ${file} '/before/'
	rm ${file}00
	mv ${file}01 ${file}
done



for file in cut*${name}*.txt
do
	csplit -f _${file:0:-4}_ ${file} '/after/'	
done

for file in _cut*${name}*
do
	cat ${file} | awk -F \" '{print "\""$2"\"", $3;}' | awk -F vma '{print $1,$2;}' > 2${file}.txt
	rm ${file}
done

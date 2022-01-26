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
	cat ${file} | awk -F tgid '{print $2;}' | awk '{print $1;}' > temp${file}
	cat ${file} | awk -F \" '{print "\""$2"\"", $3;}' | awk -F vma '{print $1,$2;}' > temp2${file}
	paste -d ' ' temp${file} temp2${file} > 2${file}.txt
	rm ${file} temp${file} temp2${file}
done
for file in out*.txt
do
	cat ${file} | awk -F tgid '{print $2;}' | awk '{print $1;}' > temp${file}
	cat ${file} | awk -F \" '{print "\""$2"\"", $3;}' | awk -F vma '{print $1,$2;}' > temp2${file}
	paste -d ' ' temp${file} temp2${file} > 2_${file}
	rm temp${file} temp2${file}
done

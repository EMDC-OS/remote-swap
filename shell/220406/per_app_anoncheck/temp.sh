#!/bin/bash


for file in rss*txt
do
	cat $file | awk '{if($3!="") print $1 " " $2 " " $3 " " $4 " " $5}' > 1_$file
	cp 1_$file $file
	rm 1_$file
done




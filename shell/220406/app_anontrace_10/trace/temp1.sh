#!/bin/bash

rm output
while read line
do
	tgid=`echo $line | awk '{print $1}'`
	num=`cat cut/cut_gmail_0.txt | grep "tgid $tgid " | wc -l`
	echo $line $num >> output
done < temp





#!/bin/bash


for file in *Q
do
	echo -n $file: 
	cat $file | grep IOPS
done


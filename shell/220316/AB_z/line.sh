#!/bin/bash

for file in ./*
do
	STR1=`cat ${file} | wc -l`
	echo -n ${file}
	echo -n "  "
	echo  ${STR1}
done


#!/bin/bash

for var in {0..19}
do
	cat $var.txt | grep cmp=com.king -A 21 -B 22 | sed -n '1p'
	cat $var.txt | grep cmp=com.king -A 21 -B 22 | sed -n '$p'
	echo " "
done


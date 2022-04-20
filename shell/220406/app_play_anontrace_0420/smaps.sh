#!/bin/bash
app=${1}






mkdir ${app}_smaps/





for var in `adb shell ps -ef |awk '{print $2}'`
do
	adb shell cat /proc/$var/smaps > ${app}_smaps/$var.txt
		
done


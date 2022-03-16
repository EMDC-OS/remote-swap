#!/bin/bash

echo "PID CMD TGID TOTAL SWAP"



for var in `adb shell ps -ef |awk '{print $2}'`

do
	sum=`adb shell dumpsys meminfo $var | grep TOTAL | grep -v SWAP | awk '{print $2}'`
	tgid=`adb shell cat /proc/$var/status | grep Tgid | awk '{print $2}'`

	if [ $sum -ne 0 ]
	then
		echo -n $var " "
		adb shell ps | awk "\$2==${var} {printf \"%s \",\$9}"
		echo -n $tgid " "
		adb shell dumpsys meminfo $var | grep TOTAL | grep -v SWAP | awk '{print $2 " " $5}'
	fi
		
done


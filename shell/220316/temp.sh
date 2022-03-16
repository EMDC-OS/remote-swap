#!/bin/bash



for var in `adb shell ps -ef |awk '{print $2}'`

do
	tgid=`adb shell cat /proc/$var/status | grep Tgid | awk '{print $2}'`

	if [ $var != $tgid ]
	then
		echo -n $var " "
		echo $tgid
	fi

done


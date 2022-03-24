#!/bin/bash
num=${1}

echo "PID TGID CMD TOTAL SWAP NUM"



for var in `adb shell ps -ef |awk '{print $2}'`

do

	anon=`adb shell cat /proc/$var/status | grep RssAnon | awk '{print $2}'`
	file=`adb shell cat /proc/$var/status | grep RssFile | awk '{print $2}'`
	swap=`adb shell cat /proc/$var/status | grep VmSwap | awk '{print $2}'`

	if [ -n "$anon" ] ; then
		echo -n $var " "
		adb shell ps | awk "\$2==${var} {printf \"%s \",\$9}"
		echo $anon $file $swap
	fi
		
done


#!/bin/bash

sleep 10


for var in `adb shell ps -ef |awk '{print $2}'`
do


	adb shell "echo anon > /proc/$var/reclaim"
	adb shell "echo file > /proc/$var/reclaim"
	#adb shell "echo $var > /proc/sys/kernel/swapcache_flush"

	sleep 1
done

sleep 10

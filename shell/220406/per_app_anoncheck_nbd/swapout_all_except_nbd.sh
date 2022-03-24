#!/bin/bash


adb reboot
sleep 60
adb root
sleep 5

for var in `adb shell ps -ef | grep -v nbd-client |awk '{print $2}'`
do



	adb shell "echo anon > /proc/$var/reclaim"
	adb shell "echo $var > /proc/sys/kernel/swapcache_flush"

	adb shell sleep 1
done


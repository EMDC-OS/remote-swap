#!/bin/bash
for i in {1..2}
do 
	adb shell input swipe 800 1750 100 1750 200; 
	sleep 1; 
	adb shell input swipe 800 1000 100 1000 200; 
	sleep 1; 
	adb shell input swipe 100 1000 100 500 200; 
	sleep 2; 
done

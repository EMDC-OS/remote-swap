#!/bin/bash
for i in {1..55}
do 
	adb shell input swipe 100 1750 800 1750 300; 
	sleep 2; 
	sleep 1; 
	adb shell input swipe 100 500 100 1450 300; 
	sleep 2; 
	sleep 1; 
done

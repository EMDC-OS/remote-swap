#!/bin/bash
for i in {1..200}
do 
	adb shell input swipe 100 1450 100 500 200; 
	sleep 1; 
done
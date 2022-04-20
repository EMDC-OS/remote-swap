#!/bin/bash
STR0=`adb shell ps -ef | grep system_server |awk 'NR == 1 { print $2; exit }'`
	STR1=`adb shell ps -ef | grep android.apps.maps |awk 'NR == 1 { print $2; exit }'`
	STR2=`adb shell ps -ef | grep com.google.android.youtube |awk 'NR == 1 { print $2; exit }'`
	STR3=`adb shell ps -ef | grep com.king.candycrushsaga |awk 'NR == 1 { print $2; exit }'`
	STR4=`adb shell ps -ef | grep com.android.chrome |awk 'NR == 1 { print $2; exit }'`
	STR5=`adb shell ps -ef | grep com.twitter.android |awk 'NR == 1 { print $2; exit }'`
	STR6=`adb shell ps -ef | grep rovio.baba |awk 'NR == 1 { print $2; exit }'`
	STR7=`adb shell ps -ef | grep com.google.android.gm | grep -v gms|awk 'NR == 1 { print $2; exit }'`
	STR8=`adb shell ps -ef | grep com.instagram.android | grep -v mqtt |awk 'NR == 1 { print $2; exit }'`
	STR9=`adb shell ps -ef | grep com.supercell.clashroyale |awk 'NR == 1 { print $2; exit }'`




for var in `adb shell ps|awk '{print $2}'| grep -v $STR0 | grep -v $STR1 |grep -v $STR2 |grep -v $STR3 |grep -v $STR4 |grep -v $STR5 |grep -v $STR6 |grep -v $STR7 |grep -v $STR8 |grep -v $STR9 `
do
	
	adb shell dumpsys meminfo $var | grep TOTAL | grep -v SWAP | awk '$2 != 0'
		
done


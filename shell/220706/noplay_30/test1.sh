num=${1}

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


	echo -n $STR0 " "
	echo -n $STR1 " "
	adb shell ps -ef | grep android.apps.maps |awk 'NR == 1 { print $8; exit }'
	echo -n $STR2 " "
	adb shell ps -ef | grep com.google.android.youtube |awk 'NR == 1 { print $8; exit }'
	echo -n $STR3 " "
	adb shell ps -ef | grep com.king.candycrushsaga |awk 'NR == 1 { print $8; exit }'
	echo -n $STR4 " "
	adb shell ps -ef | grep com.android.chrome |awk 'NR == 1 { print $8; exit }'
	echo -n $STR5 " "
	adb shell ps -ef | grep com.twitter.android |awk 'NR == 1 { print $8; exit }'
	echo -n $STR6 " "
	adb shell ps -ef | grep rovio.baba |awk 'NR == 1 { print $8; exit }'
	echo -n $STR7 " "
	adb shell ps -ef | grep com.google.android.gm |grep -v gms |awk 'NR == 1 { print $8; exit }'
	echo -n $STR8 " "
	adb shell ps -ef | grep com.instagram.android | grep -v mqtt |awk 'NR == 1 { print $8; exit }'
	echo -n $STR9 " "
	adb shell ps -ef | grep com.supercell.clashroyale |awk 'NR == 1 { print $8; exit }'




adb shell dumpsys batterystats --reset
	
	adb shell ps -ef > ps_${num}.txt
adb shell free -m
adb shell cat /proc/swaps
adb shell /data/screen_unlock.sh
adb shell cd /data/launch/
adb shell /data/launch/with_sysctl_launch_app.sh googlemaps
sleep 10
adb shell free -m
adb shell cat /proc/swaps


echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
adb shell cat /proc/$STR6/status | grep RssAnon
adb shell cat /proc/$STR7/status | grep RssAnon
adb shell cat /proc/$STR8/status | grep RssAnon
adb shell cat /proc/$STR9/status | grep RssAnon
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================

echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================




adb shell /data/launch/with_sysctl_launch_app.sh youtube
sleep 10
adb shell free -m
adb shell cat /proc/swaps


echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
adb shell cat /proc/$STR6/status | grep RssAnon
adb shell cat /proc/$STR7/status | grep RssAnon
adb shell cat /proc/$STR8/status | grep RssAnon
adb shell cat /proc/$STR9/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
adb shell cat /proc/$STR5/status | grep RssFile
adb shell cat /proc/$STR6/status | grep RssFile
adb shell cat /proc/$STR7/status | grep RssFile
adb shell cat /proc/$STR8/status | grep RssFile
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================

echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================


adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 10

adb shell free -m
adb shell cat /proc/swaps

echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
adb shell cat /proc/$STR6/status | grep RssAnon
adb shell cat /proc/$STR7/status | grep RssAnon
adb shell cat /proc/$STR8/status | grep RssAnon
adb shell cat /proc/$STR9/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
adb shell cat /proc/$STR5/status | grep RssFile
adb shell cat /proc/$STR6/status | grep RssFile
adb shell cat /proc/$STR7/status | grep RssFile
adb shell cat /proc/$STR8/status | grep RssFile
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================
echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================


	adb shell /data/launch/with_sysctl_launch_app.sh chrome
sleep 10
adb shell free -m
adb shell cat /proc/swaps


echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
adb shell cat /proc/$STR6/status | grep RssAnon
adb shell cat /proc/$STR7/status | grep RssAnon
adb shell cat /proc/$STR8/status | grep RssAnon
adb shell cat /proc/$STR9/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
adb shell cat /proc/$STR5/status | grep RssFile
adb shell cat /proc/$STR6/status | grep RssFile
adb shell cat /proc/$STR7/status | grep RssFile
adb shell cat /proc/$STR8/status | grep RssFile
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================
echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================


adb shell /data/launch/with_sysctl_launch_app.sh twitter
sleep 10
adb shell free -m
adb shell cat /proc/swaps



echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
adb shell cat /proc/$STR6/status | grep RssAnon
adb shell cat /proc/$STR7/status | grep RssAnon
adb shell cat /proc/$STR8/status | grep RssAnon
adb shell cat /proc/$STR9/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
adb shell cat /proc/$STR5/status | grep RssFile
adb shell cat /proc/$STR6/status | grep RssFile
adb shell cat /proc/$STR7/status | grep RssFile
adb shell cat /proc/$STR8/status | grep RssFile
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================
echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================



adb shell cat /proc/vmstat | grep pg.*fault
adb shell cat /proc/vmstat | grep pswp


adb shell /data/launch/with_sysctl_launch_app.sh angrybirds
sleep 30

adb shell free -m
adb shell cat /proc/swaps
	
	
adb shell cat /proc/vmstat | grep pg.*fault
adb shell cat /proc/vmstat | grep pswp



echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
adb shell cat /proc/$STR6/status | grep RssAnon
adb shell cat /proc/$STR7/status | grep RssAnon
adb shell cat /proc/$STR8/status | grep RssAnon
adb shell cat /proc/$STR9/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
adb shell cat /proc/$STR5/status | grep RssFile
adb shell cat /proc/$STR6/status | grep RssFile
adb shell cat /proc/$STR7/status | grep RssFile
adb shell cat /proc/$STR8/status | grep RssFile
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================
echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================



	adb shell /data/launch/with_sysctl_launch_app.sh gmail
sleep 10 
adb shell free -m
adb shell cat /proc/swaps


echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
adb shell cat /proc/$STR6/status | grep RssAnon
adb shell cat /proc/$STR7/status | grep RssAnon
adb shell cat /proc/$STR8/status | grep RssAnon
adb shell cat /proc/$STR9/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
adb shell cat /proc/$STR5/status | grep RssFile
adb shell cat /proc/$STR6/status | grep RssFile
adb shell cat /proc/$STR7/status | grep RssFile
adb shell cat /proc/$STR8/status | grep RssFile
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================
echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================



	adb shell /data/launch/with_sysctl_launch_app.sh instagram
sleep 10
adb shell free -m
adb shell cat /proc/swaps

echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
adb shell cat /proc/$STR6/status | grep RssAnon
adb shell cat /proc/$STR7/status | grep RssAnon
adb shell cat /proc/$STR8/status | grep RssAnon
adb shell cat /proc/$STR9/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
adb shell cat /proc/$STR5/status | grep RssFile
adb shell cat /proc/$STR6/status | grep RssFile
adb shell cat /proc/$STR7/status | grep RssFile
adb shell cat /proc/$STR8/status | grep RssFile
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================
echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================


	adb shell /data/launch/with_sysctl_launch_app.sh clashroyale
	sleep 10
#sleep 100
adb shell free -m
adb shell cat /proc/swaps


echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
adb shell cat /proc/$STR6/status | grep RssAnon
adb shell cat /proc/$STR7/status | grep RssAnon
adb shell cat /proc/$STR8/status | grep RssAnon
adb shell cat /proc/$STR9/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
adb shell cat /proc/$STR5/status | grep RssFile
adb shell cat /proc/$STR6/status | grep RssFile
adb shell cat /proc/$STR7/status | grep RssFile
adb shell cat /proc/$STR8/status | grep RssFile
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================
echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================



adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR2 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR3 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR4 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR5 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR6 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR7 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR8 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR9 > /proc/sys/kernel/swap_counter_dump"

sleep 10
adb shell cat /sys/kernel/debug/tracing/trace > ./trace/trace_$num.txt
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 10


adb shell dmesg > dmesg_${num}.txt

adb shell dumpsys batterystats > ./trace/battery_$num.txt

#sleep 10


app=${1}
adb reboot
sleep 30

adb root
sleep 1
adb shell /data/nbdroid/initialize_zram_launch.sh
sleep 1
adb shell /data/screen_unlock.sh
sleep 1
adb shell cd /data/launch/
sleep 1
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"
#adb shell "echo 0 > /proc/sys/kernel/randomize_va_space"

if [ "${app}" = "angrybirds" ]; then
	STR0="10122"
elif [ "${app}" = "googlemaps" ]; then
	STR0="10135"
elif [ "${app}" = "youtube" ]; then
	STR0="10126"
elif [ "${app}" = "instagram" ]; then
	STR0="10127"
elif [ "${app}" = "twitter" ]; then
	STR0="10133"
elif [ "${app}" = "facebook" ]; then
	STR0="10137"
elif [ "${app}" = "candycrush" ]; then
	STR0="10128"
elif [ "${app}" = "gmail" ]; then
	STR0="10136"
elif [ "${app}" = "clashroyale" ]; then
	STR0="10159"
fi


adb shell "echo $STR0"
adb shell "echo $STR0 > /proc/sys/kernel/foreground_uid"

adb shell /data/launch/launch_app_track_switch.sh ${app}
sleep 60 

if [ "${app}" = "angrybirds" ]; then
	/home/user/hdd/kernel_flame/private/shell/play/angrybirds_play.sh
elif [ "${app}" = "googlemaps" ]; then
	/home/user/swipe100times.sh
elif [ "${app}" = "youtube" ]; then
	/home/user/youtube_play10minutes.sh
elif [ "${app}" = "instagram" ]; then
	/home/user/swipe100times.sh
elif [ "${app}" = "twitter" ]; then
	sleep 20
elif [ "${app}" = "chrome" ]; then
	/home/user/chrome_swipe100times.sh
elif [ "${app}" = "facebook" ]; then
	/home/user/swipe100times.sh
elif [ "${app}" = "candycrush" ]; then
	/home/user/hdd/kernel_flame/private/shell/play/candycrush_play.sh
elif [ "${app}" = "gmail" ]; then
	sleep 20
elif [ "${app}" = "clashroyale" ]; then
	/home/user/hdd/kernel_flame/private/shell/play/clash_play.sh
fi

sleep 10
adb shell /data/launch/launch_app.sh webview
sleep 60
#adb shell ps -ef
#sleep 1
if [ "${app}" = "angrybirds" ]; then
	STR1=`adb shell ps -ef | grep rovio.baba |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "googlemaps" ]; then
	STR1=`adb shell ps -ef | grep android.apps.maps |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "youtube" ]; then
	STR1=`adb shell ps -ef | grep com.google.android.youtube |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "instagram" ]; then
	STR1=`adb shell ps -ef | grep instagram.android | grep -v mqtt |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "twitter" ]; then
	STR1=`adb shell ps -ef | grep com.twitter.android |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "chrome" ]; then
	STR1=`adb shell ps -ef | grep com.android.chrome |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "facebook" ]; then
	STR1=`adb shell ps -ef | grep facebook.katana |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "candycrush" ]; then
	STR1=`adb shell ps -ef | grep com.king.candycrushsaga |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "gmail" ]; then
	STR1=`adb shell ps -ef | grep com.google.android.gm | grep -v gms |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "clashroyale" ]; then
	STR1=`adb shell ps -ef | grep com.supercell.clashroyale |awk 'NR == 1 { print $2; exit }'`
fi

adb shell echo $STR1
sleep 5
adb shell "echo anon > /proc/$STR1/reclaim"
sleep 5
adb shell "echo $STR1 > /proc/sys/kernel/swapcache_flush"
sleep 5 
adb shell cat /proc/meminfo | grep SwapCached
sleep 5
adb shell cat /proc/vmstat* | grep swp
adb shell cat /proc/$STR1/status | awk 'NR==19 || NR==20'
sleep 5
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/launch_app_track_switch.sh ${app}
sleep 30
adb shell cat /proc/$STR1/status | awk 'NR==19 || NR==20'
adb shell cat /proc/vmstat* | grep swp
echo "=====================play!!========================="
sleep 300

adb shell cat /proc/$STR1/status | awk 'NR==19 || NR==20'
adb shell cat /proc/vmstat* | grep swp
sleep 5
adb shell dmesg > ${app}_dmesg1.txt
sleep 5
adb shell dmesg -C
sleep 30
cat ${app}_dmesg1.txt | grep vma | grep "swapin tgid" > cut_${app}_dmesg1.txt
sleep 10
adb shell cat /proc/$STR1/maps > ${app}_maps.txt
sleep 10
adb shell cat /proc/$STR1/smaps > ${app}_smaps.txt
sleep 10
adb shell /data/launch/launch_app.sh webview

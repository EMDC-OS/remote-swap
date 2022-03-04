app=${1}

adb reboot
sleep 30
adb root
sleep 1
adb shell /data/launch/force_stop_apps.sh
sleep 1
adb shell /data/dropcache.sh
sleep 10

STR1=`adb shell ps -ef | grep system_server |awk 'NR == 1 { print $2; exit }'`

adb shell free -m
adb shell cat /proc/meminfo
echo "system server"
echo ===========================
adb shell cat /proc/$STR1/status | grep Rss
adb shell cat /proc/$STR1/status | grep RSS
adb shell cat /proc/$STR1/status | grep VmSwap
echo ===========================




	adb shell /data/launch/launch_app.sh ${app}
	sleep 100
adb shell free -m
adb shell cat /proc/meminfo

if [ "${app}" = "googlemaps" ]; then
	STR0=`adb shell ps -ef | grep android.apps.maps |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "youtube" ]; then
	STR0=`adb shell ps -ef | grep com.google.android.youtube |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "candycrush" ]; then
	STR0=`adb shell ps -ef | grep com.king.candycrushsaga |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "chrome" ]; then
	STR0=`adb shell ps -ef | grep com.android.chrome |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "twitter" ]; then
	STR0=`adb shell ps -ef | grep com.twitter.android |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "angrybirds" ]; then
	STR0=`adb shell ps -ef | grep rovio.baba |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "gmail" ]; then
	STR0=`adb shell ps -ef | grep com.google.android.gm | grep -v gms|awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "instagram" ]; then
	STR0=`adb shell ps -ef | grep com.instagram.android | grep -v mqtt |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "clashroyale" ]; then
	STR0=`adb shell ps -ef | grep com.supercell.clashroyale |awk 'NR == 1 { print $2; exit }'`
fi

echo "system server"
echo ===========================
adb shell cat /proc/$STR1/status | grep Rss
adb shell cat /proc/$STR1/status | grep RSS
adb shell cat /proc/$STR1/status | grep VmSwap
echo ===========================
echo ${app}
echo ===========================
adb shell cat /proc/$STR0/status | grep Rss
adb shell cat /proc/$STR0/status | grep RSS
adb shell cat /proc/$STR0/status | grep VmSwap
echo ===========================



if [ "${app}" = "angrybirds" ]; then
	/home/user/hdd/kernel_flame/private/shell/play/angrybirds_play.sh
elif [ "${app}" = "googlemaps" ]; then
	/home/user/hdd/kernel_flame/private/shell/play/swipe100times.sh
elif [ "${app}" = "youtube" ]; then
	/home/user/hdd/kernel_flame/private/shell/play/youtube_play10minutes.sh
elif [ "${app}" = "instagram" ]; then
	/home/user/hdd/kernel_flame/private/shell/play/swipe100times.sh
elif [ "${app}" = "twitter" ]; then
	sleep 20
elif [ "${app}" = "chrome" ]; then
	/home/user/hdd/kernel_flame/private/shell/play/chrome_swipe100times.sh
elif [ "${app}" = "facebook" ]; then
	/home/user/hdd/kernel_flame/private/shell/play/swipe100times.sh
elif [ "${app}" = "candycrush" ]; then
	/home/user/hdd/kernel_flame/private/shell/play/candycrush_play.sh
elif [ "${app}" = "gmail" ]; then
	sleep 20
elif [ "${app}" = "clashroyale" ]; then
	/home/user/hdd/kernel_flame/private/shell/play/clash_play.sh
fi


adb shell free -m
adb shell cat /proc/meminfo

echo "system server"
echo ===========================
adb shell cat /proc/$STR1/status | grep Rss
adb shell cat /proc/$STR1/status | grep RSS
adb shell cat /proc/$STR1/status | grep VmSwap
echo ===========================
echo ${app}
echo ===========================
adb shell cat /proc/$STR0/status | grep Rss
adb shell cat /proc/$STR0/status | grep RSS
adb shell cat /proc/$STR0/status | grep VmSwap
echo ===========================


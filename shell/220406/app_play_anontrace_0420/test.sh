app=${1}


adb reboot
sleep 120
adb root
sleep 1
adb shell /data/nbdroid/initialize_flash_launch.sh
sleep 1
adb shell /data/dropcache.sh
sleep 1


adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"
adb shell "echo 1 > /sys/kernel/debug/tracing/tracing_on"
adb shell "echo 5000 > /sys/kernel/debug/tracing/buffer_size_kb"


adb shell free -m
adb shell /data/screen_unlock.sh
sleep 10

adb shell cd /data/launch/
adb shell /data/launch/launch_app.sh ${app}
sleep 60 






if [ "${app}" = "angrybirds" ]; then
	STR0=`adb shell ps -ef | grep rovio.baba |awk 'NR == 1 { print $2; exit }'`
	/home/user/hdd/kernel_flame/private/shell/play/angrybirds_play.sh
elif [ "${app}" = "googlemaps" ]; then
	STR0=`adb shell ps -ef | grep android.apps.maps |awk 'NR == 1 { print $2; exit }'`
	/home/user/swipe100times.sh
elif [ "${app}" = "youtube" ]; then
	/home/user/youtube_play10minutes.sh
	STR0=`adb shell ps -ef | grep com.google.android.youtube |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "instagram" ]; then
	/home/user/swipe100times.sh
	STR0=`adb shell ps -ef | grep com.instagram.android | grep -v mqtt |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "twitter" ]; then
	STR0=`adb shell ps -ef | grep com.twitter.android |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "candycrush" ]; then
	/home/user/hdd/kernel_flame/private/shell/play/candycrush_play.sh
	STR0=`adb shell ps -ef | grep com.king.candycrushsaga |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "gmail" ]; then
	STR0=`adb shell ps -ef | grep com.google.android.gm | grep -v gms|awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "clashroyale" ]; then
	/home/user/hdd/kernel_flame/private/shell/play/clash_play.sh
	STR0=`adb shell ps -ef | grep com.supercell.clashroyale |awk 'NR == 1 { print $2; exit }'`
elif [ "${app}" = "chrome" ]; then
	/home/user/chrome_swipe100times.sh
	STR0=`adb shell ps -ef | grep com.android.chrome |awk 'NR == 1 { print $2; exit }'`
fi


./smaps.sh ${app}
adb shell cat /proc/$STR0/smaps > ${app}_smaps/app_smaps.txt



adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 5
sleep 5
sleep 60
./swapout_all.sh
sleep 60

adb shell stop mpdecision
sleep 1
adb shell "echo 0 > /sys/devices/system/cpu/cpu0/online"
sleep 1
adb shell "echo 0 > /sys/devices/system/cpu/cpu1/online"
sleep 1
adb shell "echo 0 > /sys/devices/system/cpu/cpu2/online"
sleep 1
adb shell "echo 0 > /sys/devices/system/cpu/cpu3/online"
sleep 1


adb shell "echo 0 > /sys/devices/system/cpu/cpu5/online"
sleep 1
adb shell "echo 0 > /sys/devices/system/cpu/cpu6/online"
sleep 1
adb shell "echo 0 > /sys/devices/system/cpu/cpu7/online"
sleep 10
adb shell "echo 1 > /proc/sys/kernel/swapin_vma_tracking"
sleep 20
adb shell /data/screen_unlock.sh
sleep 10
adb shell /data/launch/launch_app.sh ${app}
sleep 80

adb shell cat /sys/kernel/debug/tracing/trace > ./trace/${app}_0.txt
sleep 5
adb shell "echo > /sys/kernel/debug/tracing/trace"
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"




sleep 60
adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 10
./swapout_all.sh
sleep 60
adb shell "echo 1 > /proc/sys/kernel/swapin_vma_tracking"
sleep 20
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/screen_unlock.sh
sleep 10
adb shell /data/launch/launch_app.sh ${app}
sleep 30
adb shell cat /sys/kernel/debug/tracing/trace > ./trace/${app}_1.txt
sleep 5
adb shell "echo > /sys/kernel/debug/tracing/trace"
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"



sleep 60
adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 10
./swapout_all.sh
sleep 60
adb shell "echo 1 > /proc/sys/kernel/swapin_vma_tracking"
sleep 20
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/screen_unlock.sh
sleep 10
adb shell /data/launch/launch_app.sh ${app}
sleep 30
adb shell cat /sys/kernel/debug/tracing/trace > ./trace/${app}_2.txt
sleep 5
adb shell "echo > /sys/kernel/debug/tracing/trace"
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"


sleep 60
adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 10
./swapout_all.sh
sleep 60
adb shell "echo 1 > /proc/sys/kernel/swapin_vma_tracking"
sleep 20
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/screen_unlock.sh
sleep 10
adb shell /data/launch/launch_app.sh ${app}
sleep 30
adb shell cat /sys/kernel/debug/tracing/trace > ./trace/${app}_3.txt
sleep 5
adb shell "echo > /sys/kernel/debug/tracing/trace"
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"




sleep 60
adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 10
./swapout_all.sh
sleep 60
adb shell "echo 1 > /proc/sys/kernel/swapin_vma_tracking"
sleep 20
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/screen_unlock.sh
sleep 10
adb shell /data/launch/launch_app.sh ${app}
sleep 30
adb shell cat /sys/kernel/debug/tracing/trace > ./trace/${app}_4.txt
sleep 5
adb shell "echo > /sys/kernel/debug/tracing/trace"
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"





sleep 60
adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 10
./swapout_all.sh
sleep 60
adb shell "echo 1 > /proc/sys/kernel/swapin_vma_tracking"
sleep 20
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/screen_unlock.sh
sleep 10
adb shell /data/launch/launch_app.sh ${app}
sleep 30
adb shell cat /sys/kernel/debug/tracing/trace > ./trace/${app}_5.txt
sleep 5
adb shell "echo > /sys/kernel/debug/tracing/trace"
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"




sleep 60
adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 10
./swapout_all.sh
sleep 60
adb shell "echo 1 > /proc/sys/kernel/swapin_vma_tracking"
sleep 20
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/screen_unlock.sh
sleep 10
adb shell /data/launch/launch_app.sh ${app}
sleep 30
adb shell cat /sys/kernel/debug/tracing/trace > ./trace/${app}_6.txt
sleep 5
adb shell "echo > /sys/kernel/debug/tracing/trace"
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"





sleep 60
adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 10
./swapout_all.sh
sleep 60
adb shell "echo 1 > /proc/sys/kernel/swapin_vma_tracking"
sleep 20
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/screen_unlock.sh
sleep 10
adb shell /data/launch/launch_app.sh ${app}
sleep 30
adb shell cat /sys/kernel/debug/tracing/trace > ./trace/${app}_7.txt
sleep 5
adb shell "echo > /sys/kernel/debug/tracing/trace"
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"





sleep 60
adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 10
./swapout_all.sh
sleep 60
adb shell "echo 1 > /proc/sys/kernel/swapin_vma_tracking"
sleep 20
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/screen_unlock.sh
sleep 10
adb shell /data/launch/launch_app.sh ${app}
sleep 30
adb shell cat /sys/kernel/debug/tracing/trace > ./trace/${app}_8.txt
sleep 5
adb shell "echo > /sys/kernel/debug/tracing/trace"
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"


adb shell cat /sys/devices/system/cpu/cpu0/online
adb shell cat /sys/devices/system/cpu/cpu1/online
adb shell cat /sys/devices/system/cpu/cpu2/online
adb shell cat /sys/devices/system/cpu/cpu3/online
adb shell cat /sys/devices/system/cpu/cpu4/online
adb shell cat /sys/devices/system/cpu/cpu5/online
adb shell cat /sys/devices/system/cpu/cpu6/online
adb shell cat /sys/devices/system/cpu/cpu7/online



sleep 60
adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 10
./swapout_all.sh
sleep 60
adb shell "echo 1 > /proc/sys/kernel/swapin_vma_tracking"
sleep 20
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/screen_unlock.sh
sleep 10
adb shell /data/launch/launch_app.sh ${app}
sleep 30
adb shell cat /sys/kernel/debug/tracing/trace > ./trace/${app}_9.txt
sleep 5
adb shell "echo > /sys/kernel/debug/tracing/trace"
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"


adb shell ps -ef > ps_${app}.txt

adb root
sleep 1
adb shell /data/dropcache.sh
sleep 1
adb shell /data/nbdroid/nbd_mkswap.sh
sleep 1


adb shell "echo 1 > /sys/kernel/debug/tracing/tracing_on"
sleep 1
adb shell "echo 1 > /proc/sys/kernel/prefetch_on"
sleep 1
adb shell "echo 50000 > /sys/kernel/debug/tracing/buffer_size_kb"
sleep 1


adb shell free -m
adb shell /data/screen_unlock.sh
sleep 5

adb shell cd /data/launch/
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 50
STR1=`adb shell ps -ef | grep com.king.candycrushsaga |awk 'NR == 1 { print $2; exit }'`
sleep 5

echo $STR1
sleep 5 

adb reboot
sleep 30
adb root
sleep 1
adb shell /data/dropcache.sh
sleep 1


adb shell "echo 1 > /sys/kernel/debug/tracing/tracing_on"
adb shell "echo 20000 > /sys/kernel/debug/tracing/buffer_size_kb"


adb shell free -m
adb shell /data/screen_unlock.sh
sleep 10

adb shell cd /data/launch/
adb shell /data/launch/launch_app.sh candycrush
sleep 10 
adb shell /data/launch/launch_app.sh home


STR1=`adb shell ps -ef | grep com.king.candycrushsaga |awk 'NR == 1 { print $2; exit }'`

adb shell "echo anon > /proc/$STR1/reclaim"
sleep 5
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 10
adb shell cat /sys/kernel/debug/tracing/trace > trace.txt
sleep 5

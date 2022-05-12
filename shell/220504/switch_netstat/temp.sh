app=${1}

adb root

sleep 1
adb shell /data/nbdroid/initialize_zram_launch.sh
sleep 1
adb shell /data/dropcache.sh
sleep 1




adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"
adb shell "echo 1 > /sys/kernel/debug/tracing/tracing_on"
adb shell "echo 5000 > /sys/kernel/debug/tracing/buffer_size_kb"


adb shell free -m
adb shell /data/screen_unlock.sh
sleep 10
adb shell /data/screen_unlock.sh
sleep 10

adb shell cd /data/launch/

echo ==cold==
echo "cold ${app} start" >> result_${app}
adb shell /data/launch/launch_app.sh ${app}
echo "cold ${app} end" >> result_${app}
sleep 60 




adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
./swapout_all.sh
sleep 60
adb shell /data/screen_unlock.sh
sleep 10
echo ==hot==
echo "hot ${app} start" >> result_${app}
adb shell /data/launch/launch_app.sh ${app}
echo "hot ${app} end" >> result_${app}
sleep 80





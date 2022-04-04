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




adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 5
adb shell ps -ef
sleep 5
sleep 60
./swapout_all.sh
sleep 60

adb shell stop mpdecision
sleep 1
adb shell "echo 0 > /sys/devices/system/cpu/cpu1/online"
sleep 1
adb shell "echo 0 > /sys/devices/system/cpu/cpu2/online"
sleep 1
adb shell "echo 0 > /sys/devices/system/cpu/cpu3/online"
sleep 1
adb shell "echo 0 > /sys/devices/system/cpu/cpu4/online"
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

adb shell cat /sys/kernel/debug/tracing/trace > ./trace/${app}_1.txt
sleep 5
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"




sleep 60
adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 60
./swapout_all.sh
sleep 60
adb shell "echo 1 > /proc/sys/kernel/swapin_vma_tracking"
sleep 20
adb shell /data/screen_unlock.sh
sleep 10
adb shell /data/launch/launch_app.sh ${app}
sleep 80
adb shell cat /sys/kernel/debug/tracing/trace > ./trace/${app}_2.txt
sleep 5
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"



sleep 60
adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME
sleep 60
./swapout_all.sh
sleep 60
adb shell "echo 1 > /proc/sys/kernel/swapin_vma_tracking"
sleep 20
adb shell /data/screen_unlock.sh
sleep 10
adb shell /data/launch/launch_app.sh ${app}
sleep 80
adb shell cat /sys/kernel/debug/tracing/trace > ./trace/${app}_3.txt
sleep 5
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"






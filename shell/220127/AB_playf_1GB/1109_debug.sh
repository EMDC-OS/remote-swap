adb reboot
sleep 30
adb root
sleep 1
adb shell /data/nbdroid/initialize_flash_1GB_launch.sh
sleep 1
adb shell /data/dropcache.sh
sleep 1
adb shell /data/lock_mem/lock_memory &
adb shell /data/lock_mem/lock_memory &
sleep 1
sleep 1
adb shell "echo 2 > /proc/sys/kernel/printk"
adb shell "echo 10122 > /proc/sys/kernel/foreground_uid"
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"

./test1.sh 0 > 0.txt
./test1.sh 1 > 1.txt
./test1.sh 2 > 2.txt
adb root
sleep 100
adb logcat -d > logcatd.txt
sleep 100
adb logcat > logcat.txt

adb root
sleep 5

adb pull /sys/fs/pstore/
sleep 5

adb shell reboot

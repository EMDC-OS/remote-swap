adb reboot
sleep 30
adb root
sleep 1
adb shell /data/nbdroid/initialize_flash_launch.sh
sleep 1
adb shell /data/dropcache.sh
sleep 1
adb shell /data/lock_mem/lock_memory &
adb shell /data/lock_mem/lock_memory &
sleep 1
sleep 1
adb shell "echo 2 > /proc/sys/kernel/printk"
adb shell "echo 10127 > /proc/sys/kernel/foreground_uid"
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"

./test1.sh 0 > 0.txt
echo ========
adb shell dumpsys meminfo
adb shell cat /proc/swaps
echo ========
./test1.sh 1 > 1.txt
adb shell dumpsys meminfo
adb shell cat /proc/swaps
echo ========
./test1.sh 2 > 2.txt
adb shell dumpsys meminfo
adb shell cat /proc/swaps
echo ========
./test1.sh 3 > 3.txt
adb shell dumpsys meminfo
adb shell cat /proc/swaps
echo ========
./test1.sh 4 > 4.txt
adb shell dumpsys meminfo
adb shell cat /proc/swaps
echo ========
./test1.sh 5 > 5.txt
adb shell dumpsys meminfo
adb shell cat /proc/swaps
echo ========
./test1.sh 6 > 6.txt
adb shell dumpsys meminfo
adb shell cat /proc/swaps
echo ========
./test1.sh 7 > 7.txt
adb shell dumpsys meminfo
adb shell cat /proc/swaps
echo ========
./test1.sh 8 > 8.txt
adb shell dumpsys meminfo
adb shell cat /proc/swaps
echo ========
./test1.sh 9 > 9.txt
adb shell dumpsys meminfo
adb shell cat /proc/swaps
echo ========
adb shell reboot

adb reboot
sleep 30
adb root
sleep 1
adb shell /data/nbdroid/nbd_mkswap.sh
sleep 1
adb shell /data/dropcache.sh
sleep 1
#adb shell /data/lock_mem/lock_memory &
adb shell /data/lock_mem/lock_memory &
adb shell /data/lock_mem/750K_lock_memory &
adb shell "echo 30 > /proc/sys/kernel/target_percentage"
sleep 1
sleep 1
adb shell "echo 2 > /proc/sys/kernel/printk"
adb shell "echo 0 > /proc/sys/kernel/foreground_uid"
adb shell "echo 1 > /sys/kernel/debug/tracing/tracing_on"
adb shell "echo 1 > /proc/sys/kernel/prefetch_on"
adb shell "echo 30000 > /sys/kernel/debug/tracing/buffer_size_kb"


rm proc_info.txt

./test1.sh 0 > 0.txt
./test1.sh 1 > 1.txt
./test1.sh 2 > 2.txt
./test1.sh 3 > 3.txt
./test1.sh 4 > 4.txt
./test1.sh 5 > 5.txt
./test1.sh 6 > 6.txt
./test1.sh 7 > 7.txt
./test1.sh 8 > 8.txt

adb root
sleep 5
adb pull /sys/fs/pstore/
sleep 5

adb shell reboot

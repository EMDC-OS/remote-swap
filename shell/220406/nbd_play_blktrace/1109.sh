adb reboot
sleep 30
adb root
sleep 1
adb shell /data/nbdroid/initialize_nbd_launch.sh
sleep 10
adb shell "/data/blktrace/blktrace -d /dev/nbd0 -o - | /data/blktrace/blkparse -i - -o /data/blktrace/nbd_blktrace_play" &
sleep 10
adb shell /data/dropcache.sh
sleep 1
adb shell /data/lock_mem/lock_memory &
adb shell /data/lock_mem/lock_memory &
sleep 1
sleep 1
adb shell "echo 2 > /proc/sys/kernel/printk"
adb shell "echo 0 > /proc/sys/kernel/foreground_uid"
adb shell "echo 0 > /proc/sys/kernel/swapin_vma_tracking"

rm proc_info.txt

./test1.sh 0 > 0.txt
./test1.sh 1 > 1.txt
./test1.sh 2 > 2.txt
./test1.sh 3 > 3.txt
./test1.sh 4 > 4.txt

adb root
sleep 5
adb pull /sys/fs/pstore/
sleep 5

adb shell reboot

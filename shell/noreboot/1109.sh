adb reboot
sleep 30
adb root
sleep 1
adb shell /data/nbdroid/initialize_zram_launch.sh
sleep 1
adb shell /data/dropcache.sh
sleep 1
adb shell /data/lock_mem/lock_memory &
adb shell /data/lock_mem/lock_memory &
sleep 1
sleep 1
adb shell "echo 2 > /proc/sys/kernel/printk"
adb shell "echo 10127 > /proc/sys/kernel/foreground_uid"

./refault_test_IG.sh 0 > 0.txt
./refault_test_IG.sh 1 > 1.txt
./refault_test_IG.sh 2 > 2.txt
./refault_test_IG.sh 3 > 3.txt
./refault_test_IG.sh 4 > 4.txt
./refault_test_IG.sh 5 > 5.txt
./refault_test_IG.sh 6 > 6.txt
./refault_test_IG.sh 7 > 7.txt
./refault_test_IG.sh 8 > 8.txt
./refault_test_IG.sh 9 > 9.txt

adb shell reboot

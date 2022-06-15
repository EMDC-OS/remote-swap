adb reboot
sleep 60
adb root
sleep 1
adb shell /data/dropcache.sh
sleep 1
adb shell /data/nbdroid/nbd_mkswap.sh
sleep 1

adb shell dmesg > init_dmesg.txt

adb shell "echo 1 > /sys/kernel/debug/tracing/tracing_on"
adb shell "echo 50000 > /sys/kernel/debug/tracing/buffer_size_kb"


adb shell free -m
adb shell /data/screen_unlock.sh
sleep 5

adb shell cd /data/launch/
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 50
STR1=`adb shell ps -ef | grep com.king.candycrushsaga |awk 'NR == 1 { print $2; exit }'`
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh home

sleep 5

./swapout_all.sh
sleep 100
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > no_flagset_trace1.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 


adb shell /data/launch/with_sysctl_launch_app.sh home
sleep 5
./swapout_all.sh
sleep 100
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > no_flagset_trace2.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 


adb shell /data/launch/with_sysctl_launch_app.sh home
sleep 5
./swapout_all.sh
sleep 100
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > no_flagset_trace3.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 


adb shell /data/launch/with_sysctl_launch_app.sh home
sleep 5
./swapout_all.sh
sleep 100
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > no_flagset_trace4.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 



adb shell /data/launch/with_sysctl_launch_app.sh home
sleep 5
./swapout_all.sh
sleep 100
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > no_flagset_trace5.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 



adb shell /data/launch/with_sysctl_launch_app.sh home
sleep 5
./swapout_all.sh
sleep 100
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > no_flagset_trace6.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 



adb shell /data/launch/with_sysctl_launch_app.sh home
sleep 5
./swapout_all.sh
sleep 100
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > no_flagset_trace7.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 


adb shell /data/launch/with_sysctl_launch_app.sh home
sleep 5
./swapout_all.sh
sleep 100
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > no_flagset_trace8.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 






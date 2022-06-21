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
adb shell "echo 1 > /proc/sys/kernel/prefetch_on"
adb shell "echo 1 > /proc/sys/kernel/random_nbd_entry"
adb shell "echo 50000 > /sys/kernel/debug/tracing/buffer_size_kb"


adb shell free -m
adb shell /data/screen_unlock.sh
sleep 5

adb shell cd /data/launch/
adb shell /data/launch/with_sysctl_launch_app.sh angrybirds
sleep 50
STR1=`adb shell ps -ef | grep rovio.baba |awk 'NR == 1 { print $2; exit }'`
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 5
STR2=`adb shell ps -ef | grep com.king.candycrushsaga |awk 'NR == 1 { print $2; exit }'`


sleep 5

adb shell "echo anon > /proc/$STR1/reclaim"
sleep 10
sleep 50
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh angrybirds
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR2 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > yes_flagset_trace1.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 

sleep 10
adb shell "echo anon > /proc/$STR2/reclaim"
sleep 50

adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 5

adb shell "echo anon > /proc/$STR1/reclaim"
sleep 10
sleep 50
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh angrybirds
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR2 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > yes_flagset_trace2.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 

sleep 10
adb shell "echo anon > /proc/$STR2/reclaim"
sleep 50


adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 5

adb shell "echo anon > /proc/$STR1/reclaim"
sleep 10
sleep 50
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh angrybirds
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR2 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > yes_flagset_trace3.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 

sleep 10
adb shell "echo anon > /proc/$STR2/reclaim"
sleep 50


adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 5

adb shell "echo anon > /proc/$STR1/reclaim"
sleep 10
sleep 50
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh angrybirds
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR2 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > yes_flagset_trace4.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 

sleep 10
adb shell "echo anon > /proc/$STR2/reclaim"
sleep 50



adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 5

adb shell "echo anon > /proc/$STR1/reclaim"
sleep 10
sleep 50
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh angrybirds
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR2 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > yes_flagset_trace5.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 

sleep 10
adb shell "echo anon > /proc/$STR2/reclaim"
sleep 50



adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 5

adb shell "echo anon > /proc/$STR1/reclaim"
sleep 10
sleep 50
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh angrybirds
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR2 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > yes_flagset_trace6.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 

sleep 10
adb shell "echo anon > /proc/$STR2/reclaim"
sleep 50



adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 5

adb shell "echo anon > /proc/$STR1/reclaim"
sleep 10
sleep 50
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh angrybirds
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR2 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > yes_flagset_trace7.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 


sleep 10
adb shell "echo anon > /proc/$STR2/reclaim"
sleep 50

adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 5

adb shell "echo anon > /proc/$STR1/reclaim"
sleep 10
sleep 50
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh angrybirds
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR2 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > yes_flagset_trace8.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 
sleep 10
adb shell "echo anon > /proc/$STR2/reclaim"
sleep 50


adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 5

adb shell "echo anon > /proc/$STR1/reclaim"
sleep 10
sleep 50
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh angrybirds
sleep 50 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
adb shell "echo $STR2 > /proc/sys/kernel/swap_counter_dump"
sleep 5
adb shell cat /sys/kernel/debug/tracing/trace > yes_flagset_trace9.txt
sleep 5 
adb shell "echo > /sys/kernel/debug/tracing/trace"
sleep 5 









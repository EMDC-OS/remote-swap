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
sleep 10

adb shell cd /data/launch/
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 20
STR1=`adb shell ps -ef | grep com.king.candycrushsaga |awk 'NR == 1 { print $2; exit }'`
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh home

sleep 5

adb shell "echo anon > /proc/$STR1/reclaim"
sleep 5
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 20 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 10
adb shell cat /sys/kernel/debug/tracing/trace > flagset_trace1.txt
sleep 10 

cat flagset_trace1.txt | grep do_swap | awk -F "\|\| " '{print $2}' > parse1.txt

adb shell /data/launch/with_sysctl_launch_app.sh home
sleep 5
adb shell "echo anon > /proc/$STR1/reclaim"
sleep 5
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 20 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 10
adb shell cat /sys/kernel/debug/tracing/trace > flagset_trace2.txt
sleep 10 

cat flagset_trace2.txt | grep do_swap | awk -F "\|\| " '{print $2}' > parse2.txt

adb shell /data/launch/with_sysctl_launch_app.sh home
sleep 5
adb shell "echo anon > /proc/$STR1/reclaim"
sleep 5
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 20 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 10
adb shell cat /sys/kernel/debug/tracing/trace > flagset_trace3.txt
sleep 10 

cat flagset_trace3.txt | grep do_swap | awk -F "\|\| " '{print $2}' > parse3.txt

adb shell /data/launch/with_sysctl_launch_app.sh home
sleep 5
adb shell "echo anon > /proc/$STR1/reclaim"
sleep 5
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 20 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 10
adb shell cat /sys/kernel/debug/tracing/trace > flagset_trace4.txt
sleep 10 

cat flagset_trace4.txt | grep do_swap | awk -F "\|\| " '{print $2}' > parse4.txt


adb shell /data/launch/with_sysctl_launch_app.sh home
sleep 5
adb shell "echo anon > /proc/$STR1/reclaim"
sleep 5
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 20 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 10
adb shell cat /sys/kernel/debug/tracing/trace > flagset_trace5.txt
sleep 10 

cat flagset_trace4.txt | grep do_swap | awk -F "\|\| " '{print $2}' > parse5.txt


adb shell /data/launch/with_sysctl_launch_app.sh home
sleep 5
adb shell "echo anon > /proc/$STR1/reclaim"
sleep 5
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 20 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 10
adb shell cat /sys/kernel/debug/tracing/trace > flagset_trace6.txt
sleep 10 

cat flagset_trace4.txt | grep do_swap | awk -F "\|\| " '{print $2}' > parse6.txt


adb shell /data/launch/with_sysctl_launch_app.sh home
sleep 5
adb shell "echo anon > /proc/$STR1/reclaim"
sleep 5
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 20 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 10
adb shell cat /sys/kernel/debug/tracing/trace > flagset_trace7.txt
sleep 10 

cat flagset_trace4.txt | grep do_swap | awk -F "\|\| " '{print $2}' > parse7.txt

adb shell /data/launch/with_sysctl_launch_app.sh home
sleep 5
adb shell "echo anon > /proc/$STR1/reclaim"
sleep 5
adb shell /data/screen_unlock.sh
sleep 5
adb shell /data/launch/with_sysctl_launch_app.sh candycrush
sleep 20 
adb shell "echo $STR1 > /proc/sys/kernel/swap_counter_dump"
sleep 10
adb shell cat /sys/kernel/debug/tracing/trace > flagset_trace8.txt
sleep 10 

cat flagset_trace4.txt | grep do_swap | awk -F "\|\| " '{print $2}' > parse8.txt





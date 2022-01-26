num=${1}

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
adb shell "echo 1 > /proc/sys/kernel/swapin_vma_tracking"
adb shell "echo 0 > /proc/sys/kernel/randomize_va_space"

adb shell free -m
adb shell /data/screen_unlock.sh
adb shell cd /data/launch/
adb shell /data/launch/launch_app.sh googlemaps
sleep 20
/home/user/swipe100times.sh
#./anonpage_freemem.sh
adb shell free -m

	STR0=`adb shell ps -ef | grep system_server |awk 'NR == 1 { print $2; exit }'`

	STR1=`adb shell ps -ef | grep android.apps.maps |awk 'NR == 1 { print $2; exit }'`

adb shell "echo $STR0 > /proc/sys/kernel/anon_uid_scan"
adb shell "echo $STR1 > /proc/sys/kernel/anon_uid_scan"
echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
echo ===========================
adb shell /data/launch/launch_app.sh youtube
sleep 20
/home/user/swipe100times.sh
adb shell free -m
#./anonpage_freemem.sh
	STR2=`adb shell ps -ef | grep com.google.android.youtube |awk 'NR == 1 { print $2; exit }'`
adb shell "echo $STR2 > /proc/sys/kernel/anon_uid_scan"
echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
echo ===========================

adb shell "echo 1 > /proc/sys/kernel/workingset_status"
adb shell /data/launch/launch_app.sh instagram
sleep 20
/home/user/swipe100times.sh
adb shell free -m
#./anonpage_freemem.sh
	STR3=`adb shell ps -ef | grep instagram.android |awk 'NR == 1 { print $2; exit }'`
adb shell "echo $STR5 > /proc/sys/kernel/anon_uid_scan"




echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
echo ===========================

	adb shell /data/launch/launch_app.sh candycrush
sleep 20
#./anonpage_freemem.sh
adb shell free -m
	STR4=`adb shell ps -ef | grep com.king.candycrushsaga |awk 'NR == 1 { print $2; exit }'`




echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
echo ===========================

	
	adb shell /data/launch/launch_app.sh chrome
sleep 20
/home/user/chrome_swipe100times.sh
adb shell free -m
#./anonpage_freemem.sh
	STR5=`adb shell ps -ef | grep com.android.chrome |awk 'NR == 1 { print $2; exit }'`
adb shell "echo $STR4 > /proc/sys/kernel/anon_uid_scan"



echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
adb shell cat /proc/$STR5/status | grep RssFile
echo ===========================


adb shell /data/launch/launch_app.sh twitter
sleep 20
/home/user/swipe100times.sh
adb shell free -m
#./anonpage_freemem.sh
	STR6=`adb shell ps -ef | grep com.twitter.android |awk 'NR == 1 { print $2; exit }'`
adb shell "echo $STR5 > /proc/sys/kernel/anon_uid_scan"


echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
adb shell cat /proc/$STR6/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
adb shell cat /proc/$STR5/status | grep RssFile
adb shell cat /proc/$STR6/status | grep RssFile
echo ===========================

adb shell /data/launch/launch_app.sh camera
sleep 20
adb shell free -m
#./anonpage_freemem.sh
	STR7=`adb shell ps -ef | grep com.android.camera2 |awk 'NR == 1 { print $2; exit }'`
adb shell "echo $STR5 > /proc/sys/kernel/anon_uid_scan"
	
echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
adb shell cat /proc/$STR6/status | grep RssAnon
adb shell cat /proc/$STR7/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
adb shell cat /proc/$STR5/status | grep RssFile
adb shell cat /proc/$STR6/status | grep RssFile
adb shell cat /proc/$STR7/status | grep RssFile
echo ===========================

sleep 2
adb shell "echo $STR0 > /proc/sys/kernel/anon_uid_scan"
sleep 2
adb shell "echo $STR1 > /proc/sys/kernel/anon_uid_scan"
sleep 2
adb shell "echo $STR2 > /proc/sys/kernel/anon_uid_scan"
sleep 2
adb shell "echo $STR3 > /proc/sys/kernel/anon_uid_scan"
sleep 2
adb shell "echo $STR4 > /proc/sys/kernel/anon_uid_scan"
sleep 2
adb shell "echo $STR5 > /proc/sys/kernel/anon_uid_scan"
sleep 2
adb shell "echo $STR6 > /proc/sys/kernel/anon_uid_scan"
sleep 2


adb shell "echo 1 > /proc/sys/kernel/workingset_status"

	adb shell /data/launch/launch_app.sh gmail
sleep 60 
adb shell free -m
#./anonpage_freemem.sh
	STR8=`adb shell ps -ef | grep com.google.android.gm |awk 'NR == 1 { print $2; exit }'`
adb shell "echo $STR6 > /proc/sys/kernel/anon_uid_scan"
echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
adb shell cat /proc/$STR6/status | grep RssAnon
adb shell cat /proc/$STR7/status | grep RssAnon
adb shell cat /proc/$STR8/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
adb shell cat /proc/$STR5/status | grep RssFile
adb shell cat /proc/$STR6/status | grep RssFile
adb shell cat /proc/$STR7/status | grep RssFile
adb shell cat /proc/$STR8/status | grep RssFile
echo ===========================
#adb shell ps -ef
#sleep 1

adb shell "echo 1 > /proc/sys/kernel/workingset_status"

sleep 2
sleep 10
adb shell cat /proc/$STR3/maps > 8_IG_maps_${num}.txt
sleep 10
adb shell pmap -x $STR3 > 8_IG_pmap_${num}.txt
sleep 10
adb shell dmesg > 8_IG_dmesgb_${num}.txt
sleep 30
cat 8_IG_dmesgb_${num}.txt | grep vma | grep tgid > 8_cut_IG_dmesgb_${num}.txt
sleep 10
adb shell dmesg -C


sleep 10
adb shell cat /proc/vmstat | grep pg.*fault
adb shell cat /proc/vmstat | grep pswp
	adb shell /data/launch/launch_app.sh instagram
sleep 100
adb shell cat /proc/vmstat | grep pg.*fault
adb shell cat /proc/vmstat | grep pswp

sleep 10
adb shell dmesg > 8_IG_dmesga_${num}.txt
sleep 30
cat 8_IG_dmesga_${num}.txt | grep vma | grep tgid > 8_cut_IG_dmesga_${num}.txt
sleep 10



sleep 5

adb shell "echo 1 > /proc/sys/kernel/workingset_status"

sleep 5


echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
adb shell cat /proc/$STR6/status | grep RssAnon
adb shell cat /proc/$STR7/status | grep RssAnon
adb shell cat /proc/$STR8/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
adb shell cat /proc/$STR5/status | grep RssFile
adb shell cat /proc/$STR6/status | grep RssFile
adb shell cat /proc/$STR7/status | grep RssFile
adb shell cat /proc/$STR8/status | grep RssFile
echo ===========================

adb shell dmesg -C
sleep 5
/home/user/swipe100times.sh
sleep 20
sleep 10
adb shell dmesg > 8_IG_dmesgl_${num}.txt
sleep 30
cat 8_IG_dmesga_${num}.txt | grep vma | grep tgid > 8_cut_IG_dmesgl_${num}.txt
sleep 10

echo ===========================
adb shell cat /proc/$STR0/status | grep RssAnon
adb shell cat /proc/$STR1/status | grep RssAnon
adb shell cat /proc/$STR2/status | grep RssAnon
adb shell cat /proc/$STR3/status | grep RssAnon
adb shell cat /proc/$STR4/status | grep RssAnon
adb shell cat /proc/$STR5/status | grep RssAnon
adb shell cat /proc/$STR6/status | grep RssAnon
adb shell cat /proc/$STR7/status | grep RssAnon
adb shell cat /proc/$STR8/status | grep RssAnon
echo ===========================
echo ===========================
adb shell cat /proc/$STR0/status | grep RssFile
adb shell cat /proc/$STR1/status | grep RssFile
adb shell cat /proc/$STR2/status | grep RssFile
adb shell cat /proc/$STR3/status | grep RssFile
adb shell cat /proc/$STR4/status | grep RssFile
adb shell cat /proc/$STR5/status | grep RssFile
adb shell cat /proc/$STR6/status | grep RssFile
adb shell cat /proc/$STR7/status | grep RssFile
adb shell cat /proc/$STR8/status | grep RssFile
echo ===========================


adb shell cat /proc/vmstat | grep pg.*fault
adb shell cat /proc/vmstat | grep pswp

adb shell "echo 1 > /proc/sys/kernel/workingset_status"
sleep 100
adb shell dmesg > dmesg_${num}.txt

#sleep 10

adb shell reboot

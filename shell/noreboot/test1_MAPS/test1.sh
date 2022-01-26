num=${1}

	STR0=`adb shell ps -ef | grep system_server |awk 'NR == 1 { print $2; exit }'`
	STR1=`adb shell ps -ef | grep android.apps.maps |awk 'NR == 1 { print $2; exit }'`
	STR2=`adb shell ps -ef | grep com.google.android.youtube |awk 'NR == 1 { print $2; exit }'`
	STR3=`adb shell ps -ef | grep com.king.candycrushsaga |awk 'NR == 1 { print $2; exit }'`
	STR4=`adb shell ps -ef | grep com.android.chrome |awk 'NR == 1 { print $2; exit }'`
	STR5=`adb shell ps -ef | grep com.twitter.android |awk 'NR == 1 { print $2; exit }'`
	STR6=`adb shell ps -ef | grep rovio.baba |awk 'NR == 1 { print $2; exit }'`
	STR7=`adb shell ps -ef | grep com.google.android.gm |awk 'NR == 1 { print $2; exit }'`
	STR8=`adb shell ps -ef | grep instagram.android |awk 'NR == 1 { print $2; exit }'`
adb shell ps -ef > ps_${num}.txt
adb shell free -m
adb shell /data/screen_unlock.sh



adb shell cd /data/launch/


sleep 10

sleep 10
adb shell cat /proc/$STR1/maps > MAPS_maps_${num}.txt
sleep 10
adb shell pmap -x $STR1 > MAPS_pmap_${num}.txt
sleep 10
adb shell dmesg > MAPS_dmesgb_${num}.txt
sleep 30
cat MAPS_dmesgb_${num}.txt | grep vma | grep tgid > cut_MAPS_dmesgb_${num}.txt
sleep 10
adb shell dmesg -C





adb shell /data/launch/launch_app.sh googlemaps
sleep 100

	adb shell cat /proc/vmstat | grep pg.*fault
adb shell cat /proc/vmstat | grep pswp

sleep 10
adb shell dmesg > MAPS_dmesga_${num}.txt
sleep 30
cat MAPS_dmesga_${num}.txt | grep vma | grep tgid > cut_MAPS_dmesga_${num}.txt
sleep 10
adb shell dmesg -C



/home/user/swipe100times.sh
adb shell free -m


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

sleep 10
adb shell cat /proc/vmstat | grep pg.*fault
adb shell cat /proc/vmstat | grep pswp

adb shell /data/launch/launch_app.sh youtube
sleep 20
/home/user/youtube_play10minutes.sh
adb shell free -m



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

	adb shell /data/launch/launch_app.sh candycrush
sleep 20
adb shell free -m
	

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

	adb shell /data/launch/launch_app.sh chrome
sleep 20
/home/user/chrome_swipe100times.sh
adb shell free -m


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

adb shell /data/launch/launch_app.sh twitter
sleep 20
/home/user/swipe100times.sh
adb shell free -m



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
sleep 2

adb shell /data/launch/launch_app.sh angrybirds
sleep 60
adb shell free -m

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

adb shell "echo 1 > /proc/sys/kernel/workingset_status"

	adb shell /data/launch/launch_app.sh gmail
sleep 60 
adb shell free -m


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

adb shell "echo 1 > /proc/sys/kernel/workingset_status"

	adb shell /data/launch/launch_app.sh instagram
sleep 100


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

/home/user/swipe100times.sh

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


num=${1}

	STR0=`adb shell ps -ef | grep system_server |awk 'NR == 1 { print $2; exit }'`
	STR1=`adb shell ps -ef | grep android.apps.maps |awk 'NR == 1 { print $2; exit }'`
	STR2=`adb shell ps -ef | grep com.google.android.youtube |awk 'NR == 1 { print $2; exit }'`
	STR3=`adb shell ps -ef | grep com.king.candycrushsaga |awk 'NR == 1 { print $2; exit }'`
	STR4=`adb shell ps -ef | grep com.android.chrome |awk 'NR == 1 { print $2; exit }'`
	STR5=`adb shell ps -ef | grep com.twitter.android |awk 'NR == 1 { print $2; exit }'`
	STR6=`adb shell ps -ef | grep rovio.baba |awk 'NR == 1 { print $2; exit }'`
	STR7=`adb shell ps -ef | grep com.google.android.gm | grep -v gms|awk 'NR == 1 { print $2; exit }'`
	STR8=`adb shell ps -ef | grep com.instagram.android | grep -v mqtt |awk 'NR == 1 { print $2; exit }'`
	STR9=`adb shell ps -ef | grep com.supercell.clashroyale |awk 'NR == 1 { print $2; exit }'`


	echo -n $STR0 " "
	echo -n $STR1 " "
	adb shell ps -ef | grep android.apps.maps |awk 'NR == 1 { print $8; exit }'
	echo -n $STR2 " "
	adb shell ps -ef | grep com.google.android.youtube |awk 'NR == 1 { print $8; exit }'
	echo -n $STR3 " "
	adb shell ps -ef | grep com.king.candycrushsaga |awk 'NR == 1 { print $8; exit }'
	echo -n $STR4 " "
	adb shell ps -ef | grep com.android.chrome |awk 'NR == 1 { print $8; exit }'
	echo -n $STR5 " "
	adb shell ps -ef | grep com.twitter.android |awk 'NR == 1 { print $8; exit }'
	echo -n $STR6 " "
	adb shell ps -ef | grep rovio.baba |awk 'NR == 1 { print $8; exit }'
	echo -n $STR7 " "
	adb shell ps -ef | grep com.google.android.gm |awk 'NR == 1 { print $8; exit }'
	echo -n $STR8 " "
	adb shell ps -ef | grep com.instagram.android | grep -v mqtt |awk 'NR == 1 { print $8; exit }'
	echo -n $STR9 " "
	adb shell ps -ef | grep com.supercell.clashroyale |awk 'NR == 1 { print $8; exit }'



	
	adb shell ps -ef > ps_${num}.txt
adb shell free -m
adb shell /data/screen_unlock.sh
adb shell cd /data/launch/
adb shell /data/launch/launch_app.sh googlemaps
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
adb shell cat /proc/$STR9/status | grep RssAnon
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
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================

echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
echo -n "else: "
/home/user/hdd/kernel_flame/private/shell/220316/AB_z_all/tempshell.sh | awk '{sumt+=$2} {sum+=$5} END {print sumt " " sum}'
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================
sleep 60
./proc_info.sh $num-0 >> proc_info.txt
sleep 30

adb shell /data/launch/launch_app.sh youtube
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
adb shell cat /proc/$STR9/status | grep RssAnon
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
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================

echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
echo -n "else: "
/home/user/hdd/kernel_flame/private/shell/220316/AB_z_all/tempshell.sh | awk '{sumt+=$2} {sum+=$5} END {print sumt " " sum}'
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================
sleep 60
./proc_info.sh $num-1 >> proc_info.txt
sleep 30

adb shell /data/launch/launch_app.sh candycrush
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
adb shell cat /proc/$STR9/status | grep RssAnon
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
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================
echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
echo -n "else: "
/home/user/hdd/kernel_flame/private/shell/220316/AB_z_all/tempshell.sh | awk '{sumt+=$2} {sum+=$5} END {print sumt " " sum}'
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================
sleep 60
./proc_info.sh $num-2 >> proc_info.txt
sleep 30

	adb shell /data/launch/launch_app.sh chrome
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
adb shell cat /proc/$STR9/status | grep RssAnon
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
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================
echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
echo -n "else: "
/home/user/hdd/kernel_flame/private/shell/220316/AB_z_all/tempshell.sh | awk '{sumt+=$2} {sum+=$5} END {print sumt " " sum}'
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================
sleep 60
./proc_info.sh $num-3 >> proc_info.txt
sleep 30

adb shell /data/launch/launch_app.sh twitter
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
adb shell cat /proc/$STR9/status | grep RssAnon
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
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================
echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
echo -n "else: "
/home/user/hdd/kernel_flame/private/shell/220316/AB_z_all/tempshell.sh | awk '{sumt+=$2} {sum+=$5} END {print sumt " " sum}'
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================
sleep 60
./proc_info.sh $num-4 >> proc_info.txt
sleep 30

sleep 2
sleep 10
adb shell cat /proc/$STR6/maps > AB_maps_${num}.txt
sleep 10
adb shell pmap -x $STR6 > AB_pmap_${num}.txt
sleep 10
adb shell dmesg > AB_dmesgb_${num}.txt
sleep 5
adb shell dmesg -C
sleep 5
cat AB_dmesgb_${num}.txt | grep vma | grep "swapin tgid" > cut_AB_dmesgb_${num}.txt
sleep 10
cat AB_dmesgb_${num}.txt | grep vma | grep "swapout tgid" > out_b_${num}.txt
sleep 10
sleep 10


sleep 10
adb shell cat /proc/vmstat | grep pg.*fault
adb shell cat /proc/vmstat | grep pswp


adb shell /data/launch/launch_app_track_switch.sh angrybirds
sleep 60

adb shell free -m
	
	
adb shell cat /proc/vmstat | grep pg.*fault
adb shell cat /proc/vmstat | grep pswp

sleep 10
adb shell dmesg > AB_dmesga_${num}.txt
sleep 5
adb shell dmesg -C
sleep 5

cat AB_dmesga_${num}.txt | grep vma | grep "swapin tgid" > cut_AB_dmesga_${num}.txt
sleep 10
cat AB_dmesga_${num}.txt | grep vma | grep "swapout tgid" > out_a_${num}.txt
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
adb shell cat /proc/$STR9/status | grep RssAnon
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
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================
echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
echo -n "else: "
/home/user/hdd/kernel_flame/private/shell/220316/AB_z_all/tempshell.sh | awk '{sumt+=$2} {sum+=$5} END {print sumt " " sum}'
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================
sleep 60
./proc_info.sh $num-5 >> proc_info.txt
sleep 30


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
adb shell cat /proc/$STR9/status | grep RssAnon
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
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================
echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
echo -n "else: "
/home/user/hdd/kernel_flame/private/shell/220316/AB_z_all/tempshell.sh | awk '{sumt+=$2} {sum+=$5} END {print sumt " " sum}'
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================
sleep 60
./proc_info.sh $num-6 >> proc_info.txt
sleep 30


	adb shell /data/launch/launch_app.sh instagram
sleep 20
adb shell free -m

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
adb shell cat /proc/$STR9/status | grep RssAnon
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
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================
echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
echo -n "else: "
/home/user/hdd/kernel_flame/private/shell/220316/AB_z_all/tempshell.sh | awk '{sumt+=$2} {sum+=$5} END {print sumt " " sum}'
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================
sleep 60
./proc_info.sh $num-7 >> proc_info.txt
sleep 30

	adb shell /data/launch/launch_app_track_switch.sh clashroyale
	sleep 50
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
adb shell cat /proc/$STR9/status | grep RssAnon
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
adb shell cat /proc/$STR9/status | grep RssFile
echo ===========================
echo ===========================
adb shell dumpsys meminfo $STR0 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR1 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR2 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR3 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR4 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR5 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR6 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR7 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR8 | grep TOTAL | grep -v SWAP
adb shell dumpsys meminfo $STR9 | grep TOTAL | grep -v SWAP
echo ===========================
echo -n "else: "
/home/user/hdd/kernel_flame/private/shell/220316/AB_z_all/tempshell.sh | awk '{sumt+=$2} {sum+=$5} END {print sumt " " sum}'
echo ===========================
adb shell cat /proc/meminfo | grep Mem
adb shell cat /proc/meminfo | grep Cached
echo ===========================

sleep 60
./proc_info.sh $num-8 >> proc_info.txt
sleep 30


sleep 100
adb shell dmesg > dmesg_${num}.txt

#sleep 10


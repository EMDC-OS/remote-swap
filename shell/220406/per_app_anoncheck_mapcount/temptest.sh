app=${1}


adb root
sleep 1
adb shell /data/nbdroid/initialize_flash_launch.sh
sleep 1
adb shell /data/dropcache.sh
sleep 1




adb shell free -m
adb shell /data/screen_unlock.sh
sleep 4

adb shell cd /data/launch/
adb shell /data/launch/launch_app.sh ${app}
sleep 1



adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME


adb shell free -m
./swapout_all.sh


./proc_info.sh > proc_info_${app}_b.txt
./rss_info.sh > rss_info_${app}_b.txt
sleep 60


echo ===========================
adb shell cat /proc/meminfo
echo ===========================


adb shell /data/screen_unlock.sh
sleep 10
adb shell /data/launch/launch_app.sh ${app}
sleep 60


adb shell free -m
./proc_info.sh > proc_info_${app}_a.txt
sleep 60
./rss_info.sh > rss_info_${app}_a.txt
sleep 60

echo ===========================
adb shell cat /proc/meminfo
echo ===========================
sleep 30

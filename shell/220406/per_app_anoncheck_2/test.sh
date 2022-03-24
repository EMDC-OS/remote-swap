app=${1}


adb reboot
sleep 30
adb root
sleep 1
adb shell /data/nbdroid/initialize_flash_launch.sh
sleep 1
adb shell /data/dropcache.sh
sleep 1




adb shell free -m
adb shell /data/screen_unlock.sh
sleep 10

adb shell cd /data/launch/
adb shell /data/launch/launch_app.sh googlemaps
sleep 60 

adb shell /data/launch/launch_app.sh youtube
sleep 60 

adb shell /data/launch/launch_app.sh candycrush
sleep 60

adb shell /data/launch/launch_app.sh chrome
sleep 60 

adb shell /data/launch/launch_app.sh twitter
sleep 60 

adb shell /data/launch/launch_app.sh angrybirds
sleep 60

adb shell /data/launch/launch_app.sh gmail
sleep 60 

adb shell /data/launch/launch_app.sh instagram
sleep 60 

adb shell /data/launch/launch_app.sh clashroyale
sleep 60 


adb shell am start -a android.intent.action.MAIN -c android.intent.category.HOME


adb shell free -m
sleep 60
./swapout_all.sh
sleep 60
adb shell free -m
./proc_info.sh > proc_info_${app}_b.txt
sleep 60
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

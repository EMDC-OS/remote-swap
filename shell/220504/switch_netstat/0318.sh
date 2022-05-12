#should do with watch command 
#ex) adb shell "watch -n 0.1 'ifconfig | head -n 9 | grep bytes'" | grep bytes | grep -v Every > result 

# adb shell "watch -n 0.1 'ifconfig | grep wlan0 -A 7 | grep bytes'" | grep bytes | grep -v Every >> result_${app} &

./test.sh googlemaps > googlemaps.txt
./test.sh youtube > youtube.txt
./test.sh candycrush > candycrush.txt
./test.sh chrome > chrome.txt
./test.sh twitter > twitter.txt
./test.sh angrybirds > angrybirds.txt
./test.sh gmail > gmail.txt
./test.sh instagram > instagram.txt
./test.sh clashroyale > clashroyale.txt


adb reboot
sleep 60
adb root
sleep 1
adb shell /data/nbdroid/initialize_zram_launch.sh
adb shell /data/dropcache.sh


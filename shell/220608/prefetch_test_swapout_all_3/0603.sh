./without_prefetch_test.sh > prefetch_off

adb shell reboot

sleep 600


./with_prefetch_test.sh > prefetch_on

sleep 20

adb shell reboot

sleep 600

adb root

sleep 2

adb shell shutdown

sleep 2

adb reboot -p

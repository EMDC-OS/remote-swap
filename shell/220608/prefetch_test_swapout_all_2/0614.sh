./with_prefetch_test.sh > prefetch_on

sleep 20

adb shell shutdown

sleep 2

adb reboot -p

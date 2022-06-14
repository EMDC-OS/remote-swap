./without_prefetch_test.sh > prefetch_off

adb reboot
sleep 600
adb root
sleep 5

./with_prefetch_test.sh > prefetch_on

sleep 20

adb reboot

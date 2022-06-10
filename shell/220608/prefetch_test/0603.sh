./without_prefetch_test.sh > prefetch_off

sleep 600

./with_prefetch_test.sh > prefetch_on

sleep 20

adb reboot


/data/launch/force_stop_apps.sh

echo 3 > /proc/sys/vm/drop_caches && sync
echo 0 > /sys/module/lowmemorykiller/parameters/enable_lmk
echo "--lowmemorykiller driver disabled--"

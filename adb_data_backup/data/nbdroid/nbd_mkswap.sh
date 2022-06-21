sleep 1

insmod /vendor/lib/modules/nbd.ko

sleep 1

/data/busybox/mknod /dev/nbd0 b 43 0 

sleep 1

setenforce 0

sleep 1

/data/nbdroid/nbd-client 192.168.0.4 -N export1 /dev/nbd0

sleep 1

mkswap /dev/nbd0

sleep 1

swapon /dev/nbd0

sleep 1

echo "--nbdmount finished--"



sleep 1

/data/launch/force_stop_apps.sh

echo 3 > /proc/sys/vm/drop_caches && sync
echo 0 > /sys/module/lowmemorykiller/parameters/enable_lmk
echo "--lowmemorykiller driver disabled--"


#/data/nbdroid/nbd-client 192.168.0.4 -N export2 /dev/nbd1 

#sleep 1


#mount -r -w -t tmpfs /dev/nbd1 /data/nbdroid/nbd-mount-ram

sleep 1


swapoff /dev/block/zram0

sleep 1

mkswap /data/swapspace_1GB

sleep 1

swapon /data/swapspace_1GB



sleep 1

/data/launch/force_stop_apps.sh

echo 3 > /proc/sys/vm/drop_caches && sync
echo 0 > /sys/module/lowmemorykiller/parameters/enable_lmk
echo "--lowmemorykiller driver disabled--"

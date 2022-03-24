sleep 1

insmod /vendor/lib/modules/nbd.ko

sleep 1

/data/busybox/mknod /dev/nbd0 b 43 0 

sleep 1

/data/busybox/mknod /dev/nbd1 b 43 0 

sleep 1

setenforce 0

sleep 1

#/data/nbdroid/nbd-client 192.168.0.4 -N export1 /dev/nbd0

sleep 1

/data/nbdroid/nbd-client 192.168.0.4 -N export2 /dev/nbd1 

#sleep 1

#mount -r -w -t ext4 /dev/nbd0 /data/nbdroid/nbd-mount

sleep 1

mount -r -w -t ext4 /dev/nbd1 /data/nbdroid/nbd-mount-ram

sleep 1

echo "--nbdmount finished--"

swapoff /dev/block/zram0

sleep 1

mkfs.ext4 /dev/block/zram0


mount -r -w -t ext4 /dev/block/zram0 /data/nbdroid/zram-mount/

sleep 1

echo "--zram0mount finished--"

export PATH=/data/busybox:$PATH


echo 3 > /proc/sys/vm/drop_caches
sync

./mobibench -p /data/nbdroid/nbd-mount-ram/ -f 1048576 -a 1 -r 64 -y 0 -t 1 > ./output/output_nbd_ram_64KB_1t.txt


echo 3 > /proc/sys/vm/drop_caches
sync

./mobibench -p /data/nbdroid/nbd-mount-ram/ -f 1048576 -a 1 -r 64 -y 0 -t 2 > ./output/output_nbd_ram_64KB_2t.txt


echo 3 > /proc/sys/vm/drop_caches
sync


./mobibench -p /data/nbdroid/nbd-mount-ram/ -f 1048576 -a 1 -r 64 -y 0 -t 4 > ./output/output_nbd_ram_64KB_4t.txt


echo 3 > /proc/sys/vm/drop_caches
sync

./mobibench -p /data/nbdroid/nbd-mount-ram/ -f 1048576 -a 1 -r 64 -y 0 -t 8 > ./output/output_nbd_ram_64KB_8t.txt




echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 1 -r 64 -y 3 -t 1 > ./output/output_nbd_flash_64KB_1t.txt


echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 1 -r 64 -y 3 -t 2 > ./output/output_nbd_flash_64KB_2t.txt



echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 1 -r 64 -y 3 -t 4 > ./output/output_nbd_flash_64KB_4t.txt


echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 1 -r 64 -y 3 -t 8 > ./output/output_nbd_flash_64KB_8t.txt




echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 1 -r 256 -y 3 -t 1 > ./output/output_nbd_flash_256KB_1t.txt


echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 1 -r 256 -y 3 -t 2 > ./output/output_nbd_flash_256KB_2t.txt


echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 1 -r 256 -y 3 -t 4 > ./output/output_nbd_flash_256KB_4t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 1 -r 256 -y 3 -t 8 > ./output/output_nbd_flash_256KB_8t.txt


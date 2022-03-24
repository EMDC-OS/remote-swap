export PATH=/data/busybox:$PATH

echo 3 > /proc/sys/vm/drop_caches
sync


./mobibench -p ./tmp -f 1048576 -a 1 -y 3 -t 1 > ./output/output_flash_4KB_1t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 1 -y 3 -t 1 > ./output/output_nbd_flash_4KB_1t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/zram-mount/ -f 1048576 -a 1 -y 0 -t 1 > ./output/output_zram_4KB_1t.txt

echo 3 > /proc/sys/vm/drop_caches
sync

./mobibench -p ./tmp -f 1048576 -a 1 -y 3 -t 2 > ./output/output_flash_4KB_2t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 1 -y 3 -t 2 > ./output/output_nbd_flash_4KB_2t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/zram-mount/ -f 1048576 -a 1 -y 0 -t 2 > ./output/output_zram_4KB_2t.txt

echo 3 > /proc/sys/vm/drop_caches
sync

./mobibench -p ./tmp -f 1048576 -a 1 -y 3 -t 4 > ./output/output_flash_4KB_4t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 1 -y 3 -t 4 > ./output/output_nbd_flash_4KB_4t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/zram-mount/ -f 1048576 -a 1 -y 0 -t 4 > ./output/output_zram_4KB_4t.txt

echo 3 > /proc/sys/vm/drop_caches
sync

./mobibench -p ./tmp -f 1048576 -a 1 -y 3 -t 8 > ./output/output_flash_4KB_8t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 1 -y 3 -t 8 > ./output/output_nbd_flash_4KB_8t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/zram-mount/ -f 1048576 -a 1 -y 0 -t 8 > ./output/output_zram_4KB_8t.txt


echo 3 > /proc/sys/vm/drop_caches
sync

export PATH=/data/busybox:$PATH

echo 3 > /proc/sys/vm/drop_caches
sync

./mobibench -p ./tmp -f 1048576 -a 3 -r 256 -y 3 -t 1 > ./read_output/output_flash_256KB_1t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 3 -r 256 -y 3 -t 1 > ./read_output/output_nbd_flash_256KB_1t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/zram-mount/ -f 1048576 -a 3 -r 256 -y 0 -t 1 > ./read_output/output_zram_256KB_1t.txt


echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p ./tmp -f 1048576 -a 3 -r 256 -y 3 -t 2 > ./read_output/output_flash_256KB_2t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 3 -r 256 -y 3 -t 2 > ./read_output/output_nbd_flash_256KB_2t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/zram-mount/ -f 1048576 -a 3 -r 256 -y 0 -t 2 > ./read_output/output_zram_256KB_2t.txt

echo 3 > /proc/sys/vm/drop_caches
sync

./mobibench -p ./tmp -f 1048576 -a 3 -r 256 -y 3 -t 4 > ./read_output/output_flash_256KB_4t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 3 -r 256 -y 3 -t 4 > ./read_output/output_nbd_flash_256KB_4t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/zram-mount/ -f 1048576 -a 3 -r 256 -y 0 -t 4 > ./read_output/output_zram_256KB_4t.txt

echo 3 > /proc/sys/vm/drop_caches
sync

./mobibench -p ./tmp -f 1048576 -a 3 -r 256 -y 3 -t 8 > ./read_output/output_flash_256KB_8t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/nbdroid/nbd-mount/ -f 1048576 -a 3 -r 256 -y 3 -t 8 > ./read_output/output_nbd_flash_256KB_8t.txt

echo 3 > /proc/sys/vm/drop_caches
sync
./mobibench -p /data/zram-mount/ -f 1048576 -a 3 -r 256 -y 0 -t 8 > ./read_output/output_zram_256KB_8t.txt


echo 3 > /proc/sys/vm/drop_caches
sync

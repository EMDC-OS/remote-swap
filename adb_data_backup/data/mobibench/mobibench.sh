export PATH=/data/busybox:$PATH


./mobibench -p ./tmp -a 1 -y 3 -t 1 > ./output/output_flash.txt

./mobibench -p /data/nbdroid/nbd-mount/ -a 1 -y 0 -t 1 > ./output/output_nbd.txt

./mobibench -p /data/zram-mount/ -a 1 -y 0 -t 1 > ./output/output_zram.txt

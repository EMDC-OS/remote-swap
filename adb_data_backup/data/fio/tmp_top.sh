
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

echo "4K_8T_1Q start---------------------" >> qdepth_top.txt

/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=1 --size=128M --ioengine=libaio --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_4K_8t_1Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
echo "4K_8T_16Q start---------------------" >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=16 --size=128M --ioengine=libaio --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_4K_8t_16Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
echo "4K_8T_64Q start---------------------" >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=64 --size=128M --ioengine=libaio --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_4K_8t_64Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
echo "4K_8T_256Q start---------------------" >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=128 --size=128M --ioengine=libaio --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_4K_8t_128Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

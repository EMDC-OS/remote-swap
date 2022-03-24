

rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/flash-mount --name fio_test_file --direct=1 --ioengine=libaio --rw=randwrite --bs=4K --iodepth=1 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/output/flash_1t_4K

rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/flash-mount --name fio_test_file --direct=1 --ioengine=libaio --rw=randwrite --bs=4K --iodepth=1 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/output/flash_2t_4K
rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/flash-mount --name fio_test_file --direct=1 --ioengine=libaio --rw=randwrite --bs=4K --iodepth=1 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/output/flash_4t_4K
rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


/data/fio/fio --directory=/data/nbdroid/flash-mount --name fio_test_file --direct=1 --ioengine=libaio --rw=randwrite --bs=4K --iodepth=1 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/output/flash_8t_4K
rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync



rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --ioengine=libaio --rw=randwrite --bs=4K --iodepth=1 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/output/zram_1t_4K

rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --ioengine=libaio --rw=randwrite --bs=4K --iodepth=1 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/output/zram_2t_4K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --ioengine=libaio --rw=randwrite --bs=4K --iodepth=1 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/output/zram_4t_4K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --ioengine=libaio --rw=randwrite --bs=4K --iodepth=1 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/output/zram_8t_4K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --ioengine=libaio --rw=randwrite --bs=4K --iodepth=1 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/output/nbd_1t_4K

rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --ioengine=libaio --rw=randwrite --bs=4K --iodepth=1 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/output/nbd_2t_4K
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --ioengine=libaio --rw=randwrite --bs=4K --iodepth=1 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/output/nbd_4t_4K
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --ioengine=libaio --rw=randwrite --bs=4K --iodepth=1 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_8t_4K
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync



rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
cd /data/nbdroid/flash-mount
sleep 1
#/data/fio/mv_split_1.sh
/data/fio/fio --directory=/data/nbdroid/flash-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/read_output/flash_1t_64K

rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

#/data/fio/mv_split_2.sh
/data/fio/fio --directory=/data/nbdroid/flash-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/read_output/flash_2t_64K
rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

#/data/fio/mv_split_4.sh
/data/fio/fio --directory=/data/nbdroid/flash-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/read_output/flash_4t_64K
rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


#/data/fio/mv_split_8.sh
/data/fio/fio --directory=/data/nbdroid/flash-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/read_output/flash_8t_64K
rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

echo "flash finished"

rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

cd /data/nbdroid/zram-mount
sleep 1
#/data/fio/mv_split_1.sh
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/read_output/zram_1t_64K

rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

#/data/fio/mv_split_2.sh
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/read_output/zram_2t_64K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

#/data/fio/mv_split_4.sh
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/read_output/zram_4t_64K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


#/data/fio/mv_split_8.sh
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/read_output/zram_8t_64K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

echo "zram finished"

rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

cd /data/nbdroid/nbd-mount
sleep 1
#/data/fio/mv_split_1.sh
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/read_output/nbd_1t_64K

rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

#/data/fio/mv_split_2.sh
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/read_output/nbd_2t_64K
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

#/data/fio/mv_split_4.sh
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/read_output/nbd_4t_64K
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


#/data/fio/mv_split_8.sh
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/read_output/nbd_8t_64K
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


echo "nbd finished"

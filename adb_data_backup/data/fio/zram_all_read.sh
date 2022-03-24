
cd /data/nbdroid/zram-mount
sleep 1
/data/fio/mv_split_1.sh
sleep 5
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=4K --iodepth=1 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/read_output/zram_1t_4K

rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/mv_split_2.sh
sleep 5
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=4K --iodepth=1 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/read_output/zram_2t_4K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/mv_split_4.sh
sleep 5
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=4K --iodepth=1 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/read_output/zram_4t_4K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


/data/fio/mv_split_8.sh
sleep 5
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=4K --iodepth=1 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/read_output/zram_8t_4K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

echo "4KB finished"


cd /data/nbdroid/zram-mount
sleep 1
/data/fio/mv_split_1.sh
sleep 5
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/read_output/zram_1t_64K

rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/mv_split_2.sh
sleep 5
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/read_output/zram_2t_64K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/mv_split_4.sh
sleep 5
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/read_output/zram_4t_64K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


/data/fio/mv_split_8.sh
sleep 5
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=64K --iodepth=1 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/read_output/zram_8t_64K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

echo "64KB finished"

cd /data/nbdroid/zram-mount
sleep 1
/data/fio/mv_split_1.sh
sleep 5
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=256K --iodepth=1 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/read_output/zram_1t_256K

rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/mv_split_2.sh
sleep 5
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=256K --iodepth=1 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/read_output/zram_2t_256K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/mv_split_4.sh
sleep 5
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=256K --iodepth=1 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/read_output/zram_4t_256K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


/data/fio/mv_split_8.sh
sleep 5
/data/fio/fio --directory=/data/nbdroid/zram-mount --name fio_test_file --direct=1 --rw=randread --bs=256K --iodepth=1 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/read_output/zram_8t_256K
rm /data/nbdroid/zram-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

echo "256KB finished"


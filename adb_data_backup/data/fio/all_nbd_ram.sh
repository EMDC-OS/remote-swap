rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=1 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/output/nbd_ram_1t_4K

rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=1 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/output/nbd_ram_2t_4K
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=1 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/output/nbd_ram_4t_4K
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync


/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=1 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_ram_8t_4K
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync



rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=64K --iodepth=1 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/output/nbd_ram_1t_64K

rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=64K --iodepth=1 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/output/nbd_ram_2t_64K
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=64K --iodepth=1 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/output/nbd_ram_4t_64K
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync


/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=64K --iodepth=1 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_ram_8t_64K
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync



rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=1 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/output/nbd_ram_1t_256K

rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=1 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/output/nbd_ram_2t_256K
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=1 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/output/nbd_ram_4t_256K
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

#-----------------------------------
#----------------------------------

/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=1 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_ram_8t_256K
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=1 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/output/nbd_ram_1t_1Q

rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=16 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/output/nbd_ram_1t_16Q
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=64 --size=1G --numjobs=1 --group_reporting --norandommap > /data/fio/output/nbd_ram_1t_64Q
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync

/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=1 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/output/nbd_ram_2t_1Q
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync
/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=16 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/output/nbd_ram_2t_16Q
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync
/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=64 --size=512M --numjobs=2 --group_reporting --norandommap > /data/fio/output/nbd_ram_2t_64Q
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync



/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=1 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/output/nbd_ram_4t_1Q
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync
/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=16 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/output/nbd_ram_4t_16Q
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync
/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=64 --size=256M --numjobs=4 --group_reporting --norandommap > /data/fio/output/nbd_ram_4t_64Q
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync



/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=1 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_ram_8t_1Q
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync
/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=16 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_ram_8t_16Q
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync
/data/fio/fio --directory=/data/nbdroid/nbd-mount-ram --name fio_test_file --direct=1 --rw=randwrite --bs=4K --iodepth=64 --size=128M --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_ram_8t_64Q
rm /data/nbdroid/nbd-mount-ram/*
echo 3 > /proc/sys/vm/drop_caches
sync







/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randread --bs=256K --iodepth=1 --size=128M --numjobs=8 --group_reporting --norandommap 
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randread --bs=256K --iodepth=1 --size=256M --numjobs=4 --group_reporting --norandommap
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randread --bs=256K --iodepth=1 --size=512M --numjobs=2 --group_reporting --norandommap
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randread --bs=256K --iodepth=1 --size=1G --numjobs=1 --group_reporting --norandommap

rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync





echo "nbd finished"

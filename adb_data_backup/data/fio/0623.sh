
rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

sleep 10
/data/fio/fio --directory=/data/nbdroid/flash-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=1 --size=128M --ioengine=libaio --time_based --runtime=30 --numjobs=8 --group_reporting --norandommap --output=/data/fio/output/flash_256K_8t_1Q
rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
sleep 10

/data/fio/fio --directory=/data/nbdroid/flash-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=16 --size=128M --ioengine=libaio --time_based --runtime=30 --numjobs=8 --group_reporting --norandommap --output=/data/fio/output/flash_256K_8t_16Q
rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
sleep 10

/data/fio/fio --directory=/data/nbdroid/flash-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=64 --size=128M --ioengine=libaio --time_based --runtime=30 --numjobs=8 --group_reporting --norandommap --output=/data/fio/output/flash_256K_8t_64Q
rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
sleep 10

/data/fio/fio --directory=/data/nbdroid/flash-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=128 --size=128M --ioengine=libaio --time_based --runtime=30 --numjobs=8 --group_reporting --norandommap --output=/data/fio/output/flash_256K_8t_128Q
rm /data/nbdroid/flash-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

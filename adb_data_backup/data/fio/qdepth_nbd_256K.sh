
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

echo " " >> qdepth_top.txt
echo "256K_1T_1Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt

/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=1 --size=1G --ioengine=libaio --numjobs=1 --group_reporting --norandommap > /data/fio/output/nbd_256K_1t_1Q

rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

echo " " >> qdepth_top.txt
echo "256K_1T_16Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=16 --size=1G --ioengine=libaio --numjobs=1 --group_reporting --norandommap > /data/fio/output/nbd_256K_1t_16Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

echo " " >> qdepth_top.txt
echo "256K_1T_64Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=64 --size=1G --ioengine=libaio --numjobs=1 --group_reporting --norandommap > /data/fio/output/nbd_256K_1t_64Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

echo " " >> qdepth_top.txt
echo "256K_1T_128Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=128 --size=1G --ioengine=libaio --numjobs=1 --group_reporting --norandommap > /data/fio/output/nbd_256K_1t_128Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


echo " " >> qdepth_top.txt
echo "256K_2T_1Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=1 --size=512M --ioengine=libaio --numjobs=2 --group_reporting --norandommap > /data/fio/output/nbd_256K_2t_1Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
echo " " >> qdepth_top.txt
echo "256K_2T_16Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=16 --size=512M --ioengine=libaio --numjobs=2 --group_reporting --norandommap > /data/fio/output/nbd_256K_2t_16Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
echo " " >> qdepth_top.txt
echo "256K_2T_64Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=64 --size=512M --ioengine=libaio --numjobs=2 --group_reporting --norandommap > /data/fio/output/nbd_256K_2t_64Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

echo " " >> qdepth_top.txt
echo "256K_2T_128Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=128 --size=512M --ioengine=libaio --numjobs=2 --group_reporting --norandommap > /data/fio/output/nbd_256K_2t_128Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync


echo " " >> qdepth_top.txt
echo "256K_4T_1Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=1 --size=256M --ioengine=libaio --numjobs=4 --group_reporting --norandommap > /data/fio/output/nbd_256K_4t_1Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
echo " " >> qdepth_top.txt
echo "256K_4T_16Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=16 --size=256M --ioengine=libaio --numjobs=4 --group_reporting --norandommap > /data/fio/output/nbd_256K_4t_16Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
echo " " >> qdepth_top.txt
echo "256K_4T_64Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=64 --size=256M --ioengine=libaio --numjobs=4 --group_reporting --norandommap > /data/fio/output/nbd_256K_4t_64Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
echo " " >> qdepth_top.txt
echo "256K_4T_128Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=128 --size=256M --ioengine=libaio --numjobs=4 --group_reporting --norandommap > /data/fio/output/nbd_256K_4t_128Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync



echo " " >> qdepth_top.txt
echo "256K_8T_1Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=1 --size=128M --ioengine=libaio --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_256K_8t_1Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
echo " " >> qdepth_top.txt
echo "256K_8T_16Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=16 --size=128M --ioengine=libaio --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_256K_8t_16Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
echo " " >> qdepth_top.txt
echo "256K_8T_64Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=64 --size=128M --ioengine=libaio --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_256K_8t_64Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync
echo " " >> qdepth_top.txt
echo "256K_8T_128Q start" >> qdepth_top.txt
echo " " >> qdepth_top.txt
/data/fio/fio --directory=/data/nbdroid/nbd-mount --name fio_test_file --direct=1 --rw=randwrite --bs=256K --iodepth=128 --size=128M --ioengine=libaio --numjobs=8 --group_reporting --norandommap > /data/fio/output/nbd_256K_8t_128Q
rm /data/nbdroid/nbd-mount/*
echo 3 > /proc/sys/vm/drop_caches
sync

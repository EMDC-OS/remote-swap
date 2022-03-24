/data/nbdroid/initialize.sh


cp /data/swapfile /data/sysbench/test_file.0
cp /data/swapfile /data/nbdroid/zram-mount/test_file.0
cp /data/swapfile /data/nbdroid/nbd-mount/test_file.0

cd /data/nbdroid/nbd-mount

/data/sysbench/sysbench --test=fileio --file-total-size=1G --file-num=1 --file-block-size=4K --file-fsync-freq=0 --file-test-mode=rndwr --max-requests=105  --file-extra-flags=direct  run > /data/sysbench/output/nbd_4KB
/data/sysbench/sysbench --test=fileio --file-total-size=1G --file-num=1 --file-block-size=64K --file-fsync-freq=0 --file-test-mode=rndwr --max-requests=105  --file-extra-flags=direct  run > /data/sysbench/output/nbd_64KB
/data/sysbench/sysbench --test=fileio --file-total-size=1G --file-num=1 --file-block-size=256K --file-fsync-freq=0 --file-test-mode=rndwr --max-requests=105  --file-extra-flags=direct  run > /data/sysbench/output/nbd_256KB

cd /data/nbdroid/zram-mount

/data/sysbench/sysbench --test=fileio --file-total-size=1G --file-num=1 --file-block-size=4K --file-fsync-freq=0 --file-test-mode=rndwr --max-requests=105  --file-extra-flags=direct  run > /data/sysbench/output/zram_4KB
/data/sysbench/sysbench --test=fileio --file-total-size=1G --file-num=1 --file-block-size=64K --file-fsync-freq=0 --file-test-mode=rndwr --max-requests=105  --file-extra-flags=direct  run > /data/sysbench/output/zram_64KB
/data/sysbench/sysbench --test=fileio --file-total-size=1G --file-num=1 --file-block-size=256K --file-fsync-freq=0 --file-test-mode=rndwr --max-requests=105  --file-extra-flags=direct  run > /data/sysbench/output/zram_256KB

cd /data/sysbench

/data/sysbench/sysbench --test=fileio --file-total-size=1G --file-num=1 --file-block-size=4K --file-fsync-freq=0 --file-test-mode=rndwr --max-requests=105  --file-extra-flags=direct  run > /data/sysbench/output/flash_4KB
/data/sysbench/sysbench --test=fileio --file-total-size=1G --file-num=1 --file-block-size=64K --file-fsync-freq=0 --file-test-mode=rndwr --max-requests=105  --file-extra-flags=direct  run > /data/sysbench/output/flash_64KB
/data/sysbench/sysbench --test=fileio --file-total-size=1G --file-num=1 --file-block-size=256K --file-fsync-freq=0 --file-test-mode=rndwr --max-requests=105  --file-extra-flags=direct  run > /data/sysbench/output/flash_256KB

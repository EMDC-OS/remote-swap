/data/nbdroid/initialize_nbd_launch.sh
/data/screen_unlock.sh
cd /data/launch/
./launch_app.sh angrybirds
sleep 30 
./launch_app.sh candycrush
ps -ef
STR1=`ps -ef | grep rovio.baba |awk 'NR == 1 { print $2; exit }'`
echo $STR1
echo anon > /proc/$STR1/reclaim
sleep 1
echo $STR1 > /proc/sys/kernel/evict_anon
sleep 1 
cat /proc/meminfo
sleep 1
./launch_app.sh angrybirds
sleep 1
cat result_angrybirds/vm* | grep swp

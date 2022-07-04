id=5
file_before="trace_3.txt"
file="trace_4.txt"
cat $file_before | sed -n "/prefetch_handler.*$id,*/,\$p" > temp1
cat $file | sed -n "1,/prefetch_handler.*$id,*/p" > temp2
#cat $file_before | sed -n "1,\$p"
echo $target1

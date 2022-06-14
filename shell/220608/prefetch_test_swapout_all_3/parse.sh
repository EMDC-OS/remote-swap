#!/bin/bash


for file in yes*.txt
do
	cat $file | grep "target sent" | awk -F "send_zram_to_nbd:" '{print $2}' | awk '!x[$0]++ {print $0}'   > target_$file
	cat $file | grep "prefetch hit"  | awk -F "lookup_swap_cache:" '{print $2}' | awk '!x[$0]++ {print $0}'    > hit_$file
	cat $file | grep "prefetch miss" | awk -F "do_swap_page:" '{print $2}' | awk '!x[$0]++ {print $0}' > miss_$file
done

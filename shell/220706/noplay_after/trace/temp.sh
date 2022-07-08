num=${1}
num_1=$(($num - 1))
while read line
do
	echo ========$num==========
	cat trace_$num.txt | grep $line$
	echo ========$num_1==========
	cat trace_$num_1.txt | grep $line$
	echo ===================
done < unknown_1

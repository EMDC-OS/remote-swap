
STR1=`ps -ef | awk '$1 != "UID" {print $1}'`

for i in $STR1; do
	su $i
	id
	exit
done

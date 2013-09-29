arg=`ifconfig eth0 | grep "inet addr"| cut -f 2 -d ":"|cut -f 1 -d " "`
ipaddr=$arg
echo $ipaddr

Pid=`ps -u root | grep 'iperf' | grep -v grep | grep -v vi | grep -v dbx | grep -v tail | grep -v start | grep -v stop | sed -n 1p | awk '{print $1}'`
echo $PID

for node in ceph01 ceph02 ceph03 ceph04
do
	#ssh $node dstat -cdmnrtgs --output /tmp/dstat_$node.csv 
#	ssh $node rm /tmp/iostat_$node.log
#	ssh $node iostat -dzmxt 1 >> $node:/tmp/iostat_$node.log
        ssh $node "rm /tmp/iostat_$node.log;iostat -dzmxt 1 >> /tmp/iostat_$node.log"
	ssh $node "Pid=`ps -u root | grep 'dstat' | grep -v grep | grep -v vi | grep -v dbx | grep -v tail | grep -v start | grep -v stop | sed -n 1p | awk '{print $1}'`"
	echo $PID
        ssh $node "kill $Pid"
	#ssh $node "kill -9 `ps -u root | grep 'dstat' | grep -v grep | grep -v vi | grep -v dbx | grep -v tail | grep -v start | grep -v stop | sed -n 1p | awk '{print $1}'`"
	echo $PID
	echo "pid = " $PID "killed"
done



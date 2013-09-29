
for node in ceph01 ceph02 ceph03 ceph04
do
	#ssh $node "kill `ps -u root | grep 'dstat' | grep -v grep | grep -v vi | grep -v dbx | grep -v tail | grep -v start | grep -v stop | sed -n 1p | awk '{print $1}'`"
	#ssh $node "echo `ps -u root | grep 'dstat' | grep -v grep | grep -v vi | grep -v dbx | grep -v tail | grep -v start | grep -v stop | sed -n 1p | awk '{print $1}'`"
	ssh $node "killall python; killall iostat"
	echo $node "killed"
	for pg in fortest_25pg fortest_50pg fortest_75pg fortest_100pg fortest_125pg fortest_150pg
	do
	       #scp $node:/tmp/dstat_$pg"_"$node.csv /root/osd/
               #scp $node:/tmp/iostat_$pg"_"$node.log /root/osd/
	       scp $node:/tmp/dstat_rados"_"$node.csv /root/osd/
               scp $node:/tmp/iostat"_"$node.log /root/osd/
	done
         
done


